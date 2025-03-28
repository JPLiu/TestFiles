#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "QQ"
SoftNameExe := SoftName . "-x64.exe"
ExeFileName := "QQ*_x64*.exe"
ExePath := InstallerBakPath . "\"

SetWorkingDir DownloadPath

If FileExist( ExeFileName )
{
    FileMove ExeFileName, SoftNameExe, 0
    FileMove SoftNameExe, ExePath . "*.*", 1
}

SoftName := "TIM"
SoftNameExe := SoftName . ".exe"
ExeFileName := "TIM*.exe"
ExePath := InstallerBakPath . "\"

SetWorkingDir DownloadPath

If FileExist( ExeFileName )
{
    FileMove ExeFileName, SoftNameExe, 0
    FileMove SoftNameExe, ExePath . "*.*", 1
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
