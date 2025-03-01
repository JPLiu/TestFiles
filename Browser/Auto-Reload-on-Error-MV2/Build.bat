@echo off

set zipper=D:\2-Extension\Installer\7-Zip\7za.exe

del /s /q Auto-Reload-on-Error.zip

cd SourceCode

"%zipper%" a -r -mx=0 -mcu=on "..\Auto-Reload-on-Error.zip" "*"

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
