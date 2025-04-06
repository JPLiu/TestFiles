chcp 65001 >nul
@echo off

set aria2=aria2c.exe
set vim=vim.exe

del /s /q Liu's-Vivaldi*.list
type Liu's-Block-List.list Liu's-Static-List.list Liu's-Static-Desktop-Ext-List.list >> Liu's-Vivaldi-Desktop.list
type Liu's-Block-List.list Liu's-Static-List.list >> Liu's-Vivaldi-Mobile.list

for %%i in (Liu's-Vivaldi*.list) do (
    %vim% %%~ni.list -e -c "source More-Rule-VimScript\%%~ni.vim | wq"
)

set hour=%time:~,2%
if "%time:~,1%"==" " set hour=0%time:~1,1%
set UpdateTime=%date:~3,4%%date:~8,2%%date:~11,2%%hour%%time:~3,2%%time:~6,2%

for %%i in (*.list) do (
    %vim% %%~ni.list -e -c "1,5s/Version: .*/Version: "%UpdateTime%"/ge | wq"
)

exit
