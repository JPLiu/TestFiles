#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "Cimbar"
SoftNameExe := "cimbar_js.html"
ExeFileName := "cimbar_js.html"
SoftPath := DefaultPath . "\2-Html\" . SoftName . "\"

SetWorkingDir DownloadPath

If FileExist( ExeFileName )
{
    FileMove SoftNameExe, SoftPath, 1
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
