@echo off

cd /d Aria2
start "" cmd /k call More-Rule-Upadte.bat
cd ..
cd /d Content-Farm-Terminator
start "" cmd /k call More-Rule-Upadte.bat
cd ..
cd /d MiWifi
start "" cmd /k call More-Rule-Upadte.bat
cd ..
cd /d Subconverter
start "" cmd /k call More-Rule-Upadte.bat
cd ..
cd /d uBlacklist
start "" cmd /k call More-Rule-Upadte.bat
cd ..
cd /d uBlock-Origin
start "" cmd /k call More-Rule-Upadte.bat
cd ..

cd /d Android

cd /d BitTorrent
start "" cmd /k call More-Rule-Upadte.bat
cd ..

cd ..

:: Vim-FileSetting vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
