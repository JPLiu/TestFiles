#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "Aria2"
ZipFileName := "aria2-*.zip"
SoftPath := DefaultPath . "\0-CommandLineTools\Aria2"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName
LnkName := "Aria2"
LnkPath := DefaultPath . "\0-CommandLineTools\Aria2"

Aria2AHK := DefaultPath . "\0-CommandLineTools\Aria2\Aria2AHK.exe"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    Try ProcessClose "aria2c.exe"
    Try ProcessClose "Aria2AHK.exe"
    FileMove DownloadPath . ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    SetWorkingDir ExtPath
    Loop Files  ExtPath . "\aria2-*", "D"
    {
        FileCopy  A_LoopFilePath . "\*.exe", SoftPath, 1
    }
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Aria2AHK
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
