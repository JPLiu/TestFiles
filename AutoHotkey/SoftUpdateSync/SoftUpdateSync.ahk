#SingleInstance force

Try Global SoftUpdateSyncAhkExe := IniRead("SyncScripts\SyncScripts.ini", "Setting", "SoftUpdateSyncAhkExe")
Try Global Ahkexe := IniRead("SyncScripts\SyncScripts.ini", "Setting", "AutoHotkeyPath")
Try FileCopy Ahkexe, SoftUpdateSyncAhkExe, 1

Loop Files, A_ScriptDir . "\SyncScripts\*.ahk", "R"
{
    Run A_LoopFilePath
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
