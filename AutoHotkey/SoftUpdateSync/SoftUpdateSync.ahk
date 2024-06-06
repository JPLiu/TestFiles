#SingleInstance force

Loop Files, A_ScriptDir . "\SyncScripts\*.ahk", "R"
{
    Run A_LoopFilePath
}
; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
