%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 9月 2023 16:20
%%%-------------------------------------------------------------------
-module(util).
-author("Administrator").

%% API
-export([
    sleep/1
    ,rand/2
]).


sleep(T) ->
    receive
        after T ->
            true
    end.

rand(Min, Min) -> Min;
rand(Min, Max) ->
    case get("rand_seed") of
        undefined ->
            Seed = os:timestamp(),
            rand:seed(exs1024, Seed),
            put("rand_seed", Seed);
        _ -> ignore
    end,
    M = Min - 1,
    rand:uniform(Max - M) + M.