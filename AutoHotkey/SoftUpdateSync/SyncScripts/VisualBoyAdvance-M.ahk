#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")
Global SettingBakPath := IniRead("SyncScripts.ini", "Setting", "SettingBakPath")

SoftName := "VisualBoyAdvance-M"
ZipFileName := "visualboyadvance-m-Win-x86_32.zip"
SoftPath := SettingBakPath . "\Android\Setting\GBA\Emulator\VisualBoyAdvance-M"
SoftNameZip := SoftName . ".zip"
ExtPath := DownloadPath . SoftName
LnkName := "VisualBoyAdvance-M"
LnkPath := SettingBakPath . "\Android\Setting\GBA\Emulator\VisualBoyAdvance-M"

SetWorkingDir DownloadPath

If FileExist( ZipFileName )
{
    FileMove ZipFileName, SoftNameZip, 0
    RunWait Zipper . " x " . SoftNameZip . " -o" . ExtPath
    SetWorkingDir ExtPath
    Try FileCopy  ExtPath . "\*.*", SoftPath, 1
    SetWorkingDir DownloadPath
    DirDelete ExtPath, True
    FileCreateShortcut LnkPath, UpdateLnkPath . "\" . LnkName . ".lnk"
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
