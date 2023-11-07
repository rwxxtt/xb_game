%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. 11月 2023 11:53
%%%-------------------------------------------------------------------
-module(test_ets).
-author("Administrator").

%%-include("common.hrl").
-include_lib("stdlib/include/ms_transform.hrl").

%% API
-export([
    test_1/0
    ,test_2/0
    ,test/0
    ,init_ets/0
]).

-record(ets_data, {
    id = 0
    , name
    , score
}).

-define(ets_tab_score, ets_tab_score).


init_ets() ->
    ets:new(ets_tab_score, [named_table, {keypos, 1}]),
    List = lists:seq(1, 100),
    Fun = fun(Id) ->
        Score = util:rand(1, 10),
        ets:insert(?ets_tab_score, #ets_data{id = Id, score = Score})
          end,
    lists:foreach(Fun, List).
    
    

test_1() ->
%%    FunMs = fun(T = #ets_data{score = Score}) when Score > 5 -> T end,
    Ms = ets:fun2ms(fun(T = #ets_data{score = Score}) when Score > 5 -> T end),
    Res = ets:match(?ets_tab_score, Ms),
    io:format("~w", [Res]),
    ok.

test_2() ->
    Fun = fun(T = #ets_data{score = Score}, Acc) ->
        case Score > 5 of
            true ->
                [T | Acc];
            false ->
                Acc
        end end,
    Res = lnlib_ets:foldl(Fun, [], ?ets_tab_score),
    io:format("~w",[Res]),
    ok.

test() ->
    init_ets(),
    spawn(test_1()),
    spawn(test_2()),
    ok.
    