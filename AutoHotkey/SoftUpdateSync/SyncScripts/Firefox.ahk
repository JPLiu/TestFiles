#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "Firefox"
ZipFileName := "Firefox Setup*.exe"
SoftPath := DefaultPath . "\Firefox"
SoftNameZip := SoftName . ".exe"
ExtPath := DownloadPath . SoftName
LnkName := "Firefox"
LnkPath := DefaultPath . "\Firefox"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath . " -y"
    SetWorkingDir ExtPath
    Loop Files ExtPath . "\Core", "D"
    {
        Try FileCopy  A_LoopFilePath . "\*.*", SoftPath . "\Core", 1
        Loop Files A_LoopFilePath . "\*.*", "D"
        {
            Try DirMove A_LoopFilePath , SoftPath . "\Core\" . A_LoopFileName, 1
        }
    }
    SetWorkingDir SoftPath
    Run SoftPath . "\PortableBin.bat"
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
