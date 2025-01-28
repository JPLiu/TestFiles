#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "ShareX"
ZipFileName := "ShareX-*-portable.zip"
SoftPath := DefaultPath . "\ShareX\ShareX"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName
LnkName := "ShareX"
LnkPath := DefaultPath . "\ShareX"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    Try ProcessClose "sharex.exe"
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    FileDelete ExtPath . "\ffmpeg.exe"
    SetWorkingDir ExtPath
    Try FileCopy  ExtPath . "\*.*", SoftPath . "\", 1
    Loop Files ExtPath . "\*.*", "D"
    {
        Try DirMove A_LoopFilePath , SoftPath "\" A_LoopFileName, 1
    }
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
