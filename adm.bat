@echo off

rem ------------------------------------------------
rem
rem 将werl、erl_call、rebar加入环境变量，否则写全路径  
rem ----------------------------------------------


title %~dp0 Server控制台
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

rem erlang 静态分析文件
set DIALYZER_PLT=.dialyzer_plt

set inp=%1
if "%inp" == "" goto fun_wait_input
goto fun_dispatch

:fun_wait_input
    set inp=
    echo.
    echo ================================
    echo make:                         编译服务器端码
    echo run:                          启动逻辑、调度、网络服务器
    echo debug:                        Debug进入网络服务器
    echo -------------------------------------
    set /p inp= 输入指令：
    echo -----------------------------------
    goto fun_dispatch

:main_loop
    echo end_time:%time%
    rem 区分是否待遇命令行参数
    if [%1]== [] goto fun_wait_input
    goto end

:fun_dispatch
    echo start_time:%time%
    if [%inp%]==[make] goto fun_make
    if [%inp%]==[run] goto fun_run
    if [%inp%]==[debug] goto fun_stop_all
    goto main_loop

:fun_make
    rem 编译命令
    set arg=
    echo 编译前脚本执行
    echo ...
    echo 开始编译全部应用
    echo ...
    call %REBAR% co
    rem if %errorlevel%==0 call %REBAR% xref
    rem 获取所有的依赖名称

    goto main_loop

:fun_run
    start %ERL% -name %NANE% -setcookie %COOKIE% -hidden +p 20000 -config %CONFIG% -boot start_sasl -pa ebin -s main


