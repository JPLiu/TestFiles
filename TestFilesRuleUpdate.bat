@echo off
cd /d Content-Farm-Terminator
start "" cmd /k call More-Rule-Upadte.bat
cd ..
cd /d MiWifi
start "" cmd /k call More-Rule-Upadte.bat
cd ..
cd /d Subconverter
start "" cmd /k call More-Rule-Upadte.bat
cd ..
cd /d uBlock-Origin
start "" cmd /k call More-Rule-Upadte.bat
cd ..

:: Vim-FileSetting {{{1
:: Vim-FileSetting vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
