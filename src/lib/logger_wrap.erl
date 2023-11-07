%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 9月 2023 17:14
%%%-------------------------------------------------------------------
-module(logger_wrap).
-author("Administrator").

%% API
-export([
    debug/6
    ,info/6
    ,error/6
    ,notice/6
    ,warning/6
]).


-ifdef(product).
debug(_F, _Mod, _FunName, _FunArity, _Line, _Args) -> ok.
-else
debug(F, Mod, FunName, FunArity, Line, Args) ->
    case get(dictory_role_id) of
        undefined ->
            lager:log_unsafe(debug, [], "~w [~w,~w/~w:~w]" ++ F, [node(), Mod, FunName, FunArity, Line | Args]);
        RoleId ->
            lager:log_unsafe(debug, [], "~w Role:~w [~w,~w/~w:~w]" ++ F, [node(), RoleId, Mod, FunName, FunArity, Line | Args])
    end.


info(F, Mod, FunName, FunArity, Line, Args) ->
    case get(dictory_role_id) of
        undefined ->
            lager:log_unsafe(info, [], "~w [~w,~w/~w:~w]" ++ F, [node(), Mod, FunName, FunArity, Line | Args]);
        RoleId ->
            lager:log_unsafe(info, [], "~w Role:~w [~w,~w/~w:~w]" ++ F, [node(), RoleId, Mod, FunName, FunArity, Line | Args])
    end.

error(F, Mod, FunName, FunArity, Line, Args) ->
    case get(dictory_role_id) of
        undefined ->
            Log = io:format("~w [~w,~w/~w:~w]" ++ F, [node(), Mod, FunName, FunArity, Line | Args]),
            lager:log_unsafe(info, [], Log, []);
        RoleId ->
            Log = io:format("~w Role:~w [~w,~w/~w:~w]" ++ F, [node(), RoleId, Mod, FunName, FunArity, Line | Args]),
            lager:log_unsafe(info, [], Log, [])
    end.


notice(F, Mod, FunName, FunArity, Line, Args) ->
    info(F, Mod, FunName, FunArity, Line, Args).


warning(F, Mod, FunName, FunArity, Line, Args) ->
    info(F, Mod, FunName, FunArity, Line, Args).
