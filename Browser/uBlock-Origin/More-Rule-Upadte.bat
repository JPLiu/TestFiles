@echo off

set aria2=aria2c.exe
set vim=vim.exe

:: copy /y "%ubopath%"\my-ublock-backup.txt my-ublock-backup.txt

del /s /q More-Rule-Temp\*

for %%i in (More-Rule/*.list) do (
    %aria2% --all-proxy 127.0.0.1:7890 --dir=More-Rule-Temp --input-file=More-Rule-UrlList\%%~ni.urllist
    type More-Rule-Temp\* >> %%~ni.listtemp
    del /s /q More-Rule-Temp\*
    %vim% %%~ni.listtemp -e -c "source More-Rule-VimScript\%%~ni.vim | wq"
)

move *.listtemp More-Rule\

:: cd More-Rule\
:: del *.list
:: ren *.listtemp *.list
:: copy /y *.list ..\..\AdGuard\*.txt

:: cd ..
:: copy /y *.list ..\AdGuard\*.txt
:: del /s /q ..\AdGuard\Liu's-Rule-Group.txt
:: del /s /q ..\AdGuard\Liu's-Trust-List.txt

exit
