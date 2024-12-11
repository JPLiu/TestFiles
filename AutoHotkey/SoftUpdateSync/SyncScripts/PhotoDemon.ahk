#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "PhotoDemon"
ZipFileName := "PhotoDemon-*.zip"
SoftPath := DefaultPath . "\PhotoDemon"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName
LnkName := "PhotoDemon"
LnkPath := DefaultPath . "\PhotoDemon"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    MovePath := ExtPath
    If DirExist(ExtPath . "\PhotoDemon")
        MovePath := ExtPath . "\PhotoDemon"
    SetWorkingDir MovePath
    Try FileCopy  MovePath . "\*.*", SoftPath, 1
    Loop Files MovePath . "\*.*", "D"
    {
        Try DirMove A_LoopFilePath , SoftPath "\" A_LoopFileName, 1
    }
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
