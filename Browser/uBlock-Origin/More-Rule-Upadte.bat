chcp 65001 >nul
@echo off

set aria2=aria2c.exe
set vim=vim.exe

del /s /q More-Rule-Temp\*

set hour=%time:~,2%
if "%time:~,1%"==" " set hour=0%time:~1,1%
set UpdateTime=%date:~0,4%%date:~5,2%%date:~8,2%%hour%%time:~3,2%%time:~6,2%

for %%i in (More-Rule/*.list) do (
    %aria2% --all-proxy 127.0.0.1:7890 --dir=More-Rule-Temp --input-file=More-Rule-UrlList\%%~ni.urllist
    type More-Rule-Temp\* >> %%~ni.listtemp
    del /s /q More-Rule-Temp\*
    %vim% %%~ni.listtemp -e -c "source More-Rule-VimScript\%%~ni.vim | wq"
)

move *.listtemp More-Rule\
cd More-Rule\
del *.list
ren *.listtemp *.list

exit
