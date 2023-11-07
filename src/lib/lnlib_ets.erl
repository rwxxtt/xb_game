%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. 11月 2023 11:48
%%%-------------------------------------------------------------------
-module(lnlib_ets).
-author("Administrator").

%% API
-export([
  foldl/3
]).


foldl(Fun, AccIn, Tab) ->
  foldl(ets:first(Tab), Tab, Fun, AccIn).

foldl('$end_of_table', _Tab, _Fun, AccOut) ->
  AccOut;
foldl(Key, Tab, Fun, AccIn) ->
  [Data] = ets:lookup(Tab, Key),
  AccOut = Fun(Data, AccIn),
  foldl(ets:next(Tab, Key), Tab, Fun, AccOut).
