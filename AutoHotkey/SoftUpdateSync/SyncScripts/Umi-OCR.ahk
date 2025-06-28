#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "Umi-OCR"
ZipFileName := "Umi-OCR_Rapid_*.7z.exe"
SoftPath := DefaultPath . "\1-64Bit\Umi-OCR"
SoftNameZip := SoftName . ".7z.exe"
ExtPath := DownloadPath . SoftName
LnkName := "Umi-OCR"
LnkPath := DefaultPath . "\1-64Bit\Umi-OCR"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    FileMove ZipFileName, SoftNameZip, 0
    RunWait SoftNameZip . " x " . SoftNameZip . " -o" . ExtPath . " -y"
    SetWorkingDir ExtPath
    Loop Files  ExtPath . "\Umi-OCR_*", "D"
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
