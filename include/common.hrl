%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. 9月 2023 19:51
%%%-------------------------------------------------------------------
-author("Administrator").


-define(APP, game).

-define(POOL, mypool).

-define(DEBUG(F, Args), logger_wrap:debug(F, ?MODULE, ?FUNCTION_NAME, ?FUNCTION_ARITY, ?LINE, Args)).
-define(DEBUG(F), ?DEBUG(F, [])).
-define(INFO(F, Args), logger_wrap:info(F, ?MODULE, ?FUNCTION_NAME, ?FUNCTION_ARITY, ?LINE, Args)).
-define(INFO(F), ?INFO(F, [])).
-define(ERR(F, Args), logger_wrap:error(F, ?MODULE, ?FUNCTION_NAME, ?FUNCTION_ARITY, ?LINE, Args)).
-define(ERR(F), ?ERR(F, [])).


-ifndef(DO_HANDLE).
-define(HANDLE_INFO(Info, State),
    case catch do_handle(Info, State) of
        {'EXIT', Reason} ->
            ?ERR("handle_info :~w, ~w",[Info, Reason]),
            {noreply, State};
        RETURN ->
            RETURN
    end
).
-define(HANDLE_CAST(Info, State),
    case catch do_handle(Info, State) of
        {'EXIT', Reason} ->
            ?ERR("handle_info :~w, ~w",[Info, Reason]),
            {noreply, State};
        RETURN ->
            RETURN
    end
).
-define(HANDLE_CALL(Info, State),
    case catch do_handle(Info, State) of
        {'EXIT', Reason} ->
            {reply, {false, 1, []}, State};
        RETURN ->
            RETURN
    end
).
-endif.