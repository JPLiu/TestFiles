chcp 65001
@echo off

:GitClean
git gc --prune=now
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
