#SingleInstance force
Persistent

Setworkingdir A_ScriptDir

; 读取 WinOCRAHK.ini 的配置
Global IrfanViewExe := IniRead("WinOCRAHK.ini", "Setting", "IrfanViewExe")
Global WindowsMediaOcrCliexe := IniRead("WinOCRAHK.ini", "Setting", "WindowsMediaOcrCliexe")
Global TempPath := IniRead("WinOCRAHK.ini", "Setting", "TempPath")

if not FileExist(TempPath)
    DirCreate TempPath

; 图标和托盘配置
A_IconTip := "WinOCRAHK"
If A_IsCompiled = 0
    TraySetIcon("WinOCRAHK.png", 1, 1)
WinOCRAHKTray := A_TrayMenu
WinOCRAHKTray.Delete
WinOCRAHKTray.Add("截图 OCR", StartCaptureOCR)
WinOCRAHKTray.Add("批量 OCR", StartBatchOCR)
WinOCRAHKTray.Add("打开保存路径", OpenTempFolder)
WinOCRAHKTray.Add
WinOCRAHKTray.Add("退出", ExitWinOCRAHK)

; 托盘菜单 截图 OCR
StartCaptureOCR(ItemName, ItemPos, MyMenu)
{
    CaptureOCR()
}

; 托盘菜单 批量 OCR
StartBatchOCR(ItemName, ItemPos, MyMenu)
{
    Run A_ScriptDir . "\BatchOCRAHK.exe"
}

; 托盘菜单 打开保存路径
OpenTempFolder(ItemName, ItemPos, MyMenu)
{
    Run TempPath
}

; 托盘菜单 退出
ExitWinOCRAHK(ItemName, ItemPos, MyMenu)
{
    Exitapp
}

; 删除 7 天之前的临时文件。
Loop Files, TempPath . "\*.*"
{
    FileTimeM := FileGetTime(A_LoopFileFullPath, "M")
    DateDiffN := DateDiff(A_Now, FileTimeM, "days")
    if (DateDiffN > 7)
        FileDelete A_LoopFileFullPath
}

; 热键配置
^PrintScreen::CaptureOCR()

; OCR 主体
CaptureOCR()
{
    CTime := A_YYYY . "-" . A_MM . "-" . A_DD . "_" . A_Hour . "-" . A_Min . "-" . A_Sec
    TempFile := TempPath . "\" . CTime
    Try RunWait (IrfanViewExe " /capture=4 /convert=" . TempFile . ".jpg")
    Sleep 500
    if FileExist(TempFile . ".jpg")
    {
        RunWait A_ComSpec " /c " WindowsMediaOcrCliexe " " TempFile ".jpg >" TempFile ".txt", , "hide"
        Sleep 500
        OCRTextReSult := FileRead(TempFile ".txt")
        MyGui := Gui(, "WinOCRAHK")
        MyGui.OnEvent("Escape", GuiClose)
        MyGui.SetFont("s11")
        MyGui.Add("Text",, "OCR 结果：")
        MyGui.Add("Edit", "r9 vOCRText w512", OCRTextReSult)
        MyGui.Show()
    }
    Return
}

; GUI 界面 Esc 退出
GuiClose(*)
{
    WinClose "WinOCRAHK"
}


; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
