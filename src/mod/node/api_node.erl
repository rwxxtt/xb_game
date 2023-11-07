%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 9月 2023 16:38
%%%-------------------------------------------------------------------
-module(api_node).
-author("Administrator").

-include("common.hrl").

%% API
-export([
    is_center/0
    ,is_master/0
    ,is_slave/0
    ,is_global_master/0
]).


%% @doc 是否中央服
is_center() ->
    case application:get_env(?APP, is_center) of
        {ok, true} ->
            true;
        _ ->
            false
    end.

%% @doc 是否中心机
is_master() ->
    case application:get_env(?APP, is_master) of
        {ok, true} ->
            true;
        _ ->
            false
    end.

%% @doc
is_slave() ->
    case api_node:is_center() == true andalso api_node:is_master() == false of
        true ->
            true;
        false ->
            false
    end.

%% @doc 是否全局中心机
is_global_master() ->
    case application:get_env(?APP, is_global_master) of
        {ok, true} ->
            true;
        false ->
            false
    end.