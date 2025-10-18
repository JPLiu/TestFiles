#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "WinPython"
SoftNameExe32 := "WinPython32-Dot.exe"
SoftNameExe64 := "WinPython64-Slim.exe"
ExeFileName32 := "Winpython32-*.exe"
ExeFileName64 := "Winpython64-*.exe"
ExePath := InstallerBakPath . "\WinPython\"

SetWorkingDir DownloadPath

If FileExist( ExeFileName32 )
{
    FileMove ExeFileName32, SoftNameExe32, 0
    FileMove SoftNameExe32, ExePath . "*.*", 1
}

If FileExist( ExeFileName64 )
{
    FileMove ExeFileName64, SoftNameExe64, 0
    FileMove SoftNameExe64, ExePath . "*.*", 1
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
