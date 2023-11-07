%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 9月 2023 17:01
%%%-------------------------------------------------------------------
-module(mgr_template).
-author("Administrator").

%% API
-export([
    start_link/0
]).


start_link() ->
    gen_server:start_link({local, get_name()}, ?MODULE, [], []).


get_name() ->
    ?MODULE.