#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "Syncthing"
ZipFileName := "syncthing-windows-386*.zip"
SoftPath := DefaultPath . "\0-CommandLineTools\Syncthing"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName
LnkName := "Syncthing"
LnkPath := DefaultPath . "\0-CommandLineTools\Syncthing"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    Try ProcessClose "Syncthing.exe"
    FileMove DownloadPath . ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    SetWorkingDir ExtPath
    Loop Files  ExtPath . "\syncthing-windows-*", "D"
    {
        Try FileCopy  A_LoopFilePath . "\*.*", SoftPath, 1
        Loop Files A_LoopFilePath . "\*.*", "D"
        {
            Try DirMove A_LoopFilePath , SoftPath "\" A_LoopFileName, 1
        }
    }
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    Try DirDelete SoftPath . "*.old", True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
