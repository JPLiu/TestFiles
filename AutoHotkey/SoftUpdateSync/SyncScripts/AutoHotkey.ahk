#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "Ahk2Exe"
ZipFileName := "Ahk2Exe*.zip"
SoftPath := DefaultPath . "\AutoHotkey\Ahk2Exe"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName
LnkName := "AutoHotkey"
LnkPath := DefaultPath . "\AutoHotkey"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    SetWorkingDir ExtPath
    Try FileCopy  ExtPath . "\*.*", SoftPath, 1
    Loop Files ExtPath . "\*.*", "D"
    {
        Try DirMove A_LoopFilePath , SoftPath, 1
    }
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}

SoftName := "AutoHotkeyV1"
ZipFileName := "AutoHotkey_1*.zip"
SoftPath := DefaultPath . "\AutoHotkey\AutoHotkeyV1"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . "AutoHotkey"
LnkName := "AutoHotkey"
LnkPath := DefaultPath . "\AutoHotkey"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    Try ProcessClose "AutoHotkeyA32.exe"
    Try ProcessClose "AutoHotkeyU32.exe"
    Try ProcessClose "AutoHotkeyU64.exe"
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    SetWorkingDir ExtPath
    Try FileCopy  ExtPath . "\*.*", SoftPath, 1
    Loop Files ExtPath . "\*.*", "D"
    {
        Try DirMove A_LoopFilePath , SoftPath "\" A_LoopFileName, 1
    }
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
}

SoftName := "AutoHotkeyV2"
ZipFileName := "AutoHotkey_2*.zip"
SoftPath := DefaultPath . "\AutoHotkey\AutoHotkeyV2"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . "AutoHotkey"
LnkName := "AutoHotkey"
LnkPath := DefaultPath . "\AutoHotkey"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    Try ProcessClose "AutoHotkey32.exe"
    Try ProcessClose "AutoHotkey64.exe"
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    SetWorkingDir ExtPath
    Try FileCopy  ExtPath . "\*.*", SoftPath, 1
    Loop Files ExtPath . "\*.*", "D"
    {
        Try DirMove A_LoopFilePath , SoftPath "\" A_LoopFileName, 1
    }
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
    Run Zipper . " u " . UpdateLnkPath . "\" . LnkName . ".7z -uq0r2x2y2z1 -ms=off -myv=1900 -mx=1 " . LnkPath . "\"
    Run AhkExe . " " . LnkPath . "\00-Scripts\Private-Scripts\Essentials\Essentials.ahk"
    Run AhkExe . " " . LnkPath . "\00-Scripts\Private-Scripts\Dark-Light-Switch\Dark-Light-Switch.ahk"
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
