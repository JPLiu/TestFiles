chcp 65001 >nul
@echo off

:GitClean
git gc --aggressive --prune=now
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
