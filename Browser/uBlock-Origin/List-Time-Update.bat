chcp 65001 >nul
@echo off

set aria2=aria2c.exe
set vim=vim.exe

set hour=%time:~,2%
if "%time:~,1%"==" " set hour=0%time:~1,1%
set UpdateTime=%date:~0,4%%date:~5,2%%date:~8,2%%hour%%time:~3,2%%time:~6,2%

for %%i in (*.list) do (
    %vim% %%~ni.list -e -c "1,5s/Version: .*/Version: "%UpdateTime%"/ge | wq"
)

exit
