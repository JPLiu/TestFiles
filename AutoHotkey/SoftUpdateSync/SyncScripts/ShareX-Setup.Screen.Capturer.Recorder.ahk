#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "Setup.Screen.Capturer.Recorder"
SoftNameExe := SoftName . ".exe"
ExeFileName := "Setup.Screen.Capturer.Recorder.v*.exe"
ExePath := DefaultPath . "\ShareX\"

SetWorkingDir DownloadPath

If FileExist( ExeFileName )
{
    FileMove ExeFileName, SoftNameExe, 0
    FileMove SoftNameExe, ExePath . "*.*", 1
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
