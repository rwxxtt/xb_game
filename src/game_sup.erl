%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. 9月 2023 21:04
%%%-------------------------------------------------------------------
-module(game_sup).
-author("Administrator").

-include("common.hrl").

%% API
-export([
    start_link/0
]).


-define(CHILD(I, Type), {I, {I, start_link, []}, temporary, 30000, Type, [I]}).
-define(CHILD_LONG_WAIT(I, Type, ShutDownTimeout), {I, {I, start_link, []}, temporary, ShutDownTimeout, Type, [I]}).


start_link() ->
    supervisor:start_link({local ?MODULE}, ?MODULE, []).

init([]) ->
    Children =
        case init:get_plain_arguments() of
            [] ->
                {PoolOptions, MySqlOptions} = parse_db_options(db_config),
                [
                    mysql_poolboy:child_spec(?POOL, PoolOptions, MySqlOptions)
                ];
            ["master"] ->
                []

        end,
    {ok, {{one_for_one, 5, 10}, Children}}.


%% 数据库配置
parse_db_options(Flag) ->
    {pool_options(Flag), mysql_options(Flag)}.


