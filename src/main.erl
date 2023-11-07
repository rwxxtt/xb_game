%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. 9月 2023 19:50
%%%-------------------------------------------------------------------
-module(main).
-author("Administrator").

-include("common.hrl").

%% API
-export([
    start/0
    ,stop/0
    ,stop_done/0
]).


start() ->

    %%
    ok = application:start(crypto),
    ok = application:start(asn1),
    ok = application:start(public_key),
    ok = application:start(ssl),

    lager:start(),

    inets:start(),

    ok = application:start(mysql),
    ok = application:start(poolboy),
    ok = application:start(mysql_poolboy),

    start_cowboy(),
    ok = application:start(?APP),
    ok.

start_cowboy() ->
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    ok.

stop_cowboy() ->
    ok = application:stop(ranch),
    ok = application:stop(cowlib),
    ok = application:stop(cowboy),
    ok.

%% @doc 给 erl_call 方式停止节点
stop() ->
    do_stop(),
    timer:apply_after(500, erlang, halt, [0]),
    ok.

do_stop() ->
    case api_node:is_center() of
        false ->
%%            enet_acceptor:set_net_open_falg(false),
            util:sleep(1000),
            stop_cowboy(),
            inets:stop(),
            stop(role, init, {stop_fast, <<>>}),
            ok;
        _ ->
            case api_node:is_slave() of
                true ->
                    ok;
                false ->
                    stop_cowboy(),
                    ok
            end
    end,
    application:stop(?APP),
    case api_node:is_slave() of
        true ->
            ok;
        false ->
            application:stop(mysql_poolboy),
            application:stop(poolboy),
            application:stop(mysql),
            ok
    end,
    ok.

%% @doc rpc 调用方式关闭节点
stop_done() ->
    ok = init:stop(),

    io:format("ok~n",[]),
    erlang:halt().

stop(InitMod, InitFun, Msg) ->
    AllProcs = erlang:processes(),
    [begin
         case erlang:process_info(P, dictionary) of
             {dictionary, L} ->
                 case lists:keyfind('$initial_call',1, L) of
                     {'$initial_call', {InitMod, InitFun, _}} ->
                         P ! Msg;
                     _ ->
                         skip
                 end;
             _ -> skip
         end
     end || P <- AllProcs ],
    all_pid_is_closed(AllProcs, InitMod, InitFun),
    ok.

all_pid_is_closed(L, InitMod, InitFun) ->
    L1 = lists:map(fun(P) -> process_info(P, dictionary) end, L),
    case loop_check(L1, L, InitMod, InitFun) of
        true ->
            true;
        _ ->
            util:sleep(500),
            all_pid_is_closed(L, InitMod, InitFun)
    end.

loop_check([], _L, _M, _F) -> true;
loop_check([{dictionary, L} | T], [P | L2], M, F) ->
    case lists:keyfind('$initial_call', 1, L) of
        {'$initial_call', {M, F, _}} ->
            ?INFO("还有进程没关闭，等待....:~w",[erlang:process_info(P)]),
            false;
        _ ->
            loop_check(T, L2, M, F)
    end.
