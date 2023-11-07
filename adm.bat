@echo off

rem ------------------------------------------------
rem
rem ��werl��erl_call��rebar���뻷������������дȫ·��  
rem ----------------------------------------------


title %~dp0 Server����̨
set ERL_DIR =
set ERL=%ERL_DIR%werl
set ERL_CALL=erl_call
set ERLC=%ERL_DIR%erlc
set REBAR=rebar
set MYSQL=mysql
set ESCRIPT=%ERL_DIR%escript
set DIALYZER=dialyzer


set COOKIE=h5_game1_1
set COOKIE=h5_game2_2
set HOST=127.0.0.1
set DB_USER =root
set DB_PASS=123456
set NAME=game@%HOST%
set CONFIG=config/app.config

rem erlang ��̬�����ļ�
set DIALYZER_PLT=.dialyzer_plt

set inp=%1
if "%inp" == "" goto fun_wait_input
goto fun_dispatch

:fun_wait_input
    set inp=
    echo.
    echo ================================
    echo make:                         �������������
    echo run:                          �����߼������ȡ����������
    echo debug:                        Debug�������������
    echo -------------------------------------
    set /p inp= ����ָ�
    echo -----------------------------------
    goto fun_dispatch

:main_loop
    echo end_time:%time%
    rem �����Ƿ���������в���
    if [%1]== [] goto fun_wait_input
    goto end

:fun_dispatch
    echo start_time:%time%
    if [%inp%]==[make] goto fun_make
    if [%inp%]==[run] goto fun_run
    if [%inp%]==[debug] goto fun_stop_all
    goto main_loop

:fun_make
    rem ��������
    set arg=
    echo ����ǰ�ű�ִ��
    echo ...
    echo ��ʼ����ȫ��Ӧ��
    echo ...
    call %REBAR% co
    rem if %errorlevel%==0 call %REBAR% xref
    rem ��ȡ���е���������

    goto main_loop

:fun_run
    start %ERL% -name %NANE% -setcookie %COOKIE% -hidden +p 20000 -config %CONFIG% -boot start_sasl -pa ebin -s main


