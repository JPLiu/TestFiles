#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "Text-Grab"
ZipFileName := "Text-Grab-Self-Contained-*.zip"
SoftPath := DefaultPath . "\1-64Bit\Text-Grab"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName
LnkName := "Text-Grab"
LnkPath := DefaultPath . "\1-64Bit\Text-Grab"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    SetWorkingDir ExtPath
    Loop Files  ExtPath . "\Text-Grab-Self-Contained", "D"
    {
        Try FileCopy  A_LoopFilePath . "\*.*", SoftPath, 1
        Loop Files A_LoopFilePath . "\*.*", "D"
        {
            Try DirMove A_LoopFilePath , SoftPath "\" A_LoopFileName, 1
        }
    }
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
