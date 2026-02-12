#SingleInstance force

; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")

SoftName := "搜狗输入法官方版"
SoftNameExe := SoftName . ".exe"
ExeFileName := "sogou_pinyin*.exe"
ExePath := InstallerBakPath . "\输入法\"

SetWorkingDir DownloadPath

If FileExist( ExeFileName )
{
    FileMove ExeFileName, SoftNameExe, 0
    FileMove SoftNameExe, ExePath . "*.*", 1
}


SoftName := "搜狗拼音词库"
SoftNameBin := SoftName . ".bin"
BinFileName := "搜狗词库备份_*.bin"
ExePath := InstallerBakPath . "\输入法\"

SetWorkingDir DownloadPath

If FileExist( BinFileName )
{
    FileMove BinFileName, SoftNameBin, 0
    FileMove SoftNameBin, ExePath . "*.*", 1
}

SoftName := "Sogou-PhraseEdit"
SoftNameTxt := SoftName . ".txt"
TxtFileName := "PhraseEdit.txt"
ExePath := InstallerBakPath . "\输入法\"

SetWorkingDir DownloadPath

If FileExist( TxtFileName )
{
    FileMove TxtFileName, SoftNameTxt, 0
    FileMove SoftNameTxt, ExePath . "*.*", 1
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
