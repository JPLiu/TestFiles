chcp 65001 >nul
@echo off

pushd Aria2

pushd Aria2Conf
start "" cmd /k call More-Rule-Upadte.bat
popd

popd

pushd Android

pushd BitTorrent
start "" cmd /k call More-Rule-Upadte.bat
popd

popd

pushd Browser

pushd uBlock-Origin
:: start "" cmd /k call More-Rule-Upadte.bat
start "" cmd /k call List-Time-Update.bat
popd

popd

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
