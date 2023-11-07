%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. 10月 2023 19:31
%%%-------------------------------------------------------------------
-module(role_behaviour).
-author("Administrator").

-record(role, {}).

%% @doc 初始化数据
-callback init(#role{}) -> ok | {ok, #role{}}.

%% @doc 登录调用
-callback login(#role{}) -> ok | {ok, #role{}}.

%% @doc 前端准备好了，发送数据
-callback ready(#role{}) -> ok | {ok, #role{}}.


-optional_callbacks(
    [
        init/1
        ,login/1
        ,ready/1
    ]).