%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. 5月 2023 19:09
%%%-------------------------------------------------------------------
-module(bentch).
-author("Administrator").

%% API
-export([
    cprof_start/0
    , cprof_stop/0
    , eprof_start/0
    , eprof_stop/0
    , memory_diff/2
]).


cprof_start() ->
    cprof:stop(),
    cprof:start(),
    io:format("Function profile start:----------------------~n"),
    ok.

cprof_stop() ->
    cprof:pause(),
    {_, ModAnalysisList} = cprof:analyse(),
    cprof:stop(),
    io:format("Result:~n~p~n", [ModAnalysisList]),
    ok.


eprof_start() ->
    case eprof:start_profiling(processes()) of
        profiling ->
           io:format("eprof start:~n");
        {error, Reason} ->
            io:format("epfor start error:~w",[Reason])
    end.

eprof_stop() ->
    process_profile_stop(total).
process_profile_stop(procs) ->
    eprof:analyze(procs, [{sort,time}, {filter, [{time, 1500}]}]),
    eprof:stop();
process_profile_stop(total) ->
    eprof:stop_profiling(),
    eprof:analyze(total, [{sort,time}, {filter, [{time, 1500}]}]),
    eprof:stop().

memory_diff(L1, L2) ->
    Fun = fun({K, V}, Acc) ->
        {_, V2} = lists:keyfind(K, 1, L2),
        [{K, V2 -V} |Acc]
          end,
    L = lists:foldr(Fun, [], L1),
    L.


