%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. 9月 2023 20:59
%%%-------------------------------------------------------------------
-module(game_app).
-author("Administrator").

-behavior(application).

%% API
-export([
    start/2
    ,stop/1
]).

start(_StartType, _StartArgs) ->
%%    ok = lnlogger:init(),
    {ok, Pid} = game_sup:start_link(),
    {ok, Pid}.

stop(_State) ->
    ok.