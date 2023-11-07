%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 9月 2023 16:54
%%%-------------------------------------------------------------------
-module(role).
-author("Administrator").

-include("common.hrl").
-include("role.hrl").

%% API
-export([
    start/3
    ,init/3
]).


start(Id, Link, DeviceId) ->
    Role = #role{},
    gen_server:start({global, {role, Id}}, ?MODULE, [Role, Link, DeviceId], []).

init(Role, _Link, _DeviceId) ->
    {ok, Role}.