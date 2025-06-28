#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "VisualCppRedist"
ZipFileName := "VisualCppRedist_AIO_*.zip"
SoftPath := InstallerBakPath . "\Runtimes"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    FileCopy ExtPath . "\*.exe", SoftPath, 1
    DirDelete ExtPath, True
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
