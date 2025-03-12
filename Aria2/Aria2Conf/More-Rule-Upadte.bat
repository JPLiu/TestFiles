chcp 65001
@echo off

set aria2=aria2c.exe
set aria2path=D:\1-Program\0-CommandLineTools\Aria2
set vim=vim.exe

copy /y %aria2path%\Data\dht.dat dht.dat

del /s /q More-Rule-Temp\*

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
