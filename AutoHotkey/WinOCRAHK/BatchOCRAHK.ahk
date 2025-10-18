#SingleInstance force
Persistent
#NoTrayIcon

Setworkingdir A_ScriptDir

; 读取 WinOCRAHK.ini 的配置
Global WindowsMediaOcrCliexe := IniRead("WinOCRAHK.ini", "Setting", "WindowsMediaOcrCliexe")
Global TempPath := IniRead("WinOCRAHK.ini", "Setting", "TempPath")

if not FileExist(TempPath)
{
    DirCreate TempPath
    Msgbox "请将所有需要识别的图片（JPG，PNG）放入 " . TempPath . " 内"
}

Loop Files TempPath . "\*.*"
{
    SplitPath A_LoopFilePath, &OutFileName, &OutDir, &OutExtension, &OutNameNoExt, &OutDrive
    If (OutExtension = "jpg" or OutExtension = "png")
        RunWait A_ComSpec " /c " WindowsMediaOcrCliexe " " A_LoopFilePath " >" OutDir "\" OutNameNoExt OutExtension ".txt", , "hide"
}

RunWait A_ComSpec " /c copy " TempPath "\*.txt " TempPath "\OCRResult.txt", , "hide"

Msgbox "已完成 OCR，按任意键退出"

Exitapp

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
