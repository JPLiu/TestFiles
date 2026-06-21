chcp 65001 >nul
@echo off

set HTTP_PROXY=http://127.0.0.1:7890
set HTTPS_PROXY=http://127.0.0.1:7890

:pull
git pull git@github.com:JPLiu/TestFiles.git
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
