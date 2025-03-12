chcp 65001
@echo off

set vim=vim.exe

del /s /q gkd-custom-nofast.json

%vim% gkd-custom.json -e -c "source More-Rule-VimScript\gkd-custom-nofast.vim | wq! gkd-custom-nofast.json"

move *.listtemp More-Rule\

cd More-Rule\
del *.list
ren *.listtemp *.list

exit
