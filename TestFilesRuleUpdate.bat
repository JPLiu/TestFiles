chcp 65001 >nul
@echo off

cd /d Aria2

cd /d Aria2Conf
start "" cmd /k call More-Rule-Upadte.bat
cd ..

cd ..

:: cd /d MiWifi
:: start "" cmd /k call More-Rule-Upadte.bat
:: cd ..

:: cd /d Subconverter
:: start "" cmd /k call More-Rule-Upadte.bat
:: cd ..

cd /d Android

cd /d BitTorrent
start "" cmd /k call More-Rule-Upadte.bat
cd ..

::cd /d gkd-kit
::start "" cmd /k call More-Rule-Upadte.bat
::cd ..

cd ..

cd /d Browser

:: cd /d Content-Farm-Terminator
:: start "" cmd /k call More-Rule-Upadte.bat
:: cd ..
:: cd /d uBlacklist
:: start "" cmd /k call More-Rule-Upadte.bat
:: cd ..
cd /d uBlock-Origin
:: start "" cmd /k call More-Rule-Upadte.bat
start "" cmd /k call List-Time-Update.bat
cd ..

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
