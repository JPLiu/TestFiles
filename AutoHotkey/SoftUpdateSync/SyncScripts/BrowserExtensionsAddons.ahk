#SingleInstance force


; 读取 SoftUpdateSync.ini 的配置 {{{1
Global Zipper := IniRead("SyncScripts.ini", "Setting", "ZipperPath")
Global Ahkexe := IniRead("SyncScripts.ini", "Setting", "AutoHotkeyPath")
Global DownloadPath := IniRead("SyncScripts.ini", "Setting", "DownloadPath")
Global UpdateLnkPath := IniRead("SyncScripts.ini", "Setting", "UpdateLnkPath")
Global DefaultPath := IniRead("SyncScripts.ini", "Setting", "DefaultPath")
Global InstallerBakPath := IniRead("SyncScripts.ini", "Setting", "InstallerBakPath")
Global SettingBakPath := IniRead("SyncScripts.ini", "Setting", "SettingBakPath")

BrowserEABakPath := SettingBakPath . "\Browser\000ExtensionsAddons"
BrowserEASyncPath := SettingBakPath . "\Android\Setting\Firefox"

; Tempermonkey 篡改猴
EAName := "Tempermonkey"
EAFormatName := EAName . ".zip"
EAConfName := "tampermonkey-backup-*.zip"
EAConfPathName := "000UserScript"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; 文件同步至 Android Setting
; Try DirCopy BrowserEABakPath . "\" . EAConfPathName, BrowserEASyncPath . "\" . EAConfPathName , 1

; ViolentMoneky 暴力猴
EAName := "Violentmonkey"
EAFormatName := EAName . ".zip"
EAConfName := "violentmonkey_*.zip"
EAConfPathName := "000UserScript"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

EAName := "Bilibili"
EAFormatName := "Bilibili-Setting.json"
EAConfName := "settings.json"
EAConfPathName := "000UserScript"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

EAName := "YAWF"
EAFormatName := "YAWF-JP.json"
EAConfName := "JP*.json"
EAConfPathName := "000UserScript"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; 文件同步至 Android Setting
; Try DirCopy BrowserEABakPath . "\" . EAConfPathName, BrowserEASyncPath . "\" . EAConfPathName , 1

; SalaDict 沙拉查词
EAName := "SalaDict"
EAFormatName := "config.saladict"
EAConfName := "config-*.saladict"
EAConfPathName := "SalaDict 沙拉查词"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Downwitharia2 通过 Aria2 下载
EAName := "Downwitharia2"
EAFormatName := "downwitharia2_options.json"
EAConfName := "downwitharia2-*.json"
EAConfPathName := "Downwitharia2 通过 Aria2 下载"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Auto Tab Discard
EAName := "Auto Tab Discard"
EAFormatName := "auto-tab-discard-preferences.json"
EAConfName := "auto-tab-discard-preferences.json"
EAConfPathName := "Auto Tab Discard"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; ClearURLs
EAName := "ClearURLs"
EAFormatName := "ClearURLs.conf"
EAConfName := "ClearURLs.conf"
EAConfPathName := "ClearURLs"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Cat-catch 猫抓
EAName := "Cat-catch 猫抓"
EAFormatName := "cat-catch.txt"
EAConfName := "cat-catch*.txt"
EAConfPathName := "Cat-catch 猫抓"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Floccus
EAName := "Floccus"
EAFormatName := "floccus.export.json"
EAConfName := "floccus.export.json"
EAConfPathName := "Floccus"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Global Speed
EAName := "Global Speed"
EAFormatName := "Global Speed.json"
EAConfName := "Global Speed*.json"
EAConfPathName := "Global Speed"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Header Editor
EAName := "Header Editor"
EAConfName := "HE_*.json"
EAConfPathName := "Header Editor"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove "HE_*Z.json", "HeaderEditor.json", 0
    Try FileMove "HE_*Mine-Redirect.json", "HeaderEditor-Mine-Redirect.json", 0
    Try FileMove "HE_*Mine-Request.json", "HeaderEditor-Mine-Request.json", 0
    Try FileMove "HE_*Mine-Response.json", "HeaderEditor-Mine-Response.json", 0
    Try FileMove "HE_*Mine-Redirect-移动端.json", "HeaderEditor-Mine-Redirect-移动端.json", 0
    Try FileMove "HE_*Mine-Redirect-外链.json", "HeaderEditor-Mine-Redirect-外链.json", 0
    Try FileMove "HE_*Work-Request.json", "HeaderEditor-Work-Request.json", 0
    FileMove "*.json", BrowserEABakPath . "\" . EAConfPathName, 1


}

; History Cleaner
EAName := "History Cleaner"
EAFormatName := "HistoryCleaner.json"
EAConfName := "HistoryCleaner.json"
EAConfPathName := "History Cleaner"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; LocalCDN
EAName := "LocalCDN"
EAFormatName := "localcdn_backup.txt"
EAConfName := "*localcdn_backup.txt"
EAConfPathName := "LocalCDN"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; 文件同步至 Android Setting
; Try DirCopy BrowserEABakPath . "\" . EAConfPathName, BrowserEASyncPath . "\" . EAConfPathName , 1

; Text Link
EAName := "Text Link"
EAFormatName := "configs-textlink.json"
EAConfName := "configs-{*}.json"
EAConfPathName := "Text Link"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Vimium
EAName := "Vimium"
EAFormatName := "vimium-options.json"
EAConfName := "vimium-options.json"
EAConfPathName := "Vimium"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Vimium-C
EAName := "Vimium-C"
EAFormatName := "vimium-c-options.json"
EAConfName := "vimium_c-*.json"
EAConfPathName := "Vimium"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Foxy Gestures
EAName := "Foxy Gestures"
EAFormatName := "foxyGestures.json"
EAConfName := "foxyGestures*.json"
EAConfPathName := "Foxy Gestures"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; Gesturefy
EAName := "Gesturefy"
EAFormatName := "Gesturefy.json"
EAConfName := "Gesturefy*.json"
EAConfPathName := "Gesturefy"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; uBlacklist
EAName := "uBlacklist"
EAFormatName := "ublacklist-settings.json"
EAConfName := "ublacklist-settings.json"
EAConfPathName := "uBlacklist"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; uBlock Origin
EAName := "uBlock Origin"
EAFormatName := "my-ublock-backup.txt"
EAConfName := "my-ublock-backup_*.txt"
EAConfPathName := "uBlock Origin"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; 文件同步至 Android Setting
; Try DirCopy BrowserEABakPath . "\" . EAConfPathName, BrowserEASyncPath . "\" . EAConfPathName , 1

; AdGuard
EAName := "AdGuard"
EAFormatName := "adguard-ext-settings.json"
EAConfName := "adg_ext_settings_*.json"
EAConfPathName := "AdGuard"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; 文件同步至 Android Setting
; Try DirCopy BrowserEABakPath . "\" . EAConfPathName, BrowserEASyncPath . "\" . EAConfPathName , 1

; B站空降助手
EAName := "B站空降助手"
EAFormatName := "BilibiliSponsorBlockConfig.json"
EAConfName := "BilibiliSponsorBlockConfig_*.json"
EAConfPathName := "B站空降助手"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

EAFormatName := "BilibiliSponsorBlockOtherData.json"
EAConfName := "BilibiliSponsorBlockOtherData_*.json"
SetWorkingDir DownloadPath
If FileExist( EAConfName )
{
    Try FileMove EAConfName, EAFormatName, 0
    FileMove EAFormatName, BrowserEABakPath . "\" . EAConfPathName, 1
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:

