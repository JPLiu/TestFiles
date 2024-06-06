#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "AriaNg"
ZipFileName := "AriaNg-*-AllInOne.zip"
SoftPath := DefaultPath . "\0-CommandLineTools\Aria2\AriaNg"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName
LnkName := "Aria2"
LnkPath := DefaultPath . "\0-CommandLineTools\Aria2"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    FileMove DownloadPath . ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    FileCopy ExtPath . "\*.html", SoftPath, 1
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
