#SingleInstance force
Persistent

Setworkingdir A_ScriptDir

; 读取 Wenku8Downloader.ini 的配置
Global Aria2 := IniRead("Wenku8Downloader.ini", "Setting", "Aria2")
Global Aria2Proxy := IniRead("Wenku8Downloader.ini", "Setting", "Aria2Proxy")
Global BaseList := IniRead("Wenku8Downloader.ini", "Setting", "BaseList")
Global TempPath := IniRead("Wenku8Downloader.ini", "Setting", "TempPath")
Global AutoMove := IniRead("Wenku8Downloader.ini", "Setting", "AutoMove")
Global AutoMoveTarget := IniRead("Wenku8Downloader.ini", "Setting", "AutoMoveTarget")
Global AutoMoveEndTarget := IniRead("Wenku8Downloader.ini", "Setting", "AutoMoveEndTarget")
Global IntervalTime := IniRead("Wenku8Downloader.ini", "Setting", "IntervalTime")

if not FileExist(TempPath)
    DirCreate TempPath

MyGui := Gui(, "Wenku8Downloader")
MyGui.OnEvent("Escape", GuiClose)
MyGui.SetFont("s11")
MyGui.Add("Text",, "请输入文本数字：")
MyGui.Add("Edit", "r9 vBaseList w512 -WantReturn", BaseList)
MyGui.Add("Button", "Default w80", "确定").OnEvent("Click", ProcessUserInput)
MyGui.Show()
Return


ProcessUserInput(*)
{
    Global BaseList := MyGui.Submit().BaseList
    Loop Parse, BaseList, ","
    {
        CTime := A_YYYY . "-" . A_MM . "-" . A_DD . "_" . A_Hour . "-" . A_Min . "-" . A_Sec
        Global BookName := IniRead("Wenku8Downloader.ini", "BookList", A_LoopField, "NoName")
        Global TargetPath := AutoMoveTarget
        If BookName = "NoName"
        {
            Global BookName := IniRead("Wenku8Downloader.ini", "EndBookList", A_LoopField, "NoEndName")
            Global TargetPath := AutoMoveEndTarget
        }
        If BookName = "NoEndName"
            BookName := CTime
        Global BookUrl := "https://dl.wenku8.com/down.php?type=utf8&node=2&id=" . A_LoopField
        RunWait Aria2 . " --all-proxy " . Aria2Proxy . " --out `"" TempPath . "\" . BookName . "`".txt" . " " . BookUrl
        Sleep IntervalTime
    }
    If AutoMove = 1
        Loop Files TempPath . "\*.txt"
        {
            If Not InStr(A_LoopFileName, A_YYYY . "-")
                Try FileMove A_LoopFilePath, TargetPath, 1
        }
    Exitapp
}

; GUI 界面 Esc 退出
GuiClose(*)
{
    WinClose "Wenku8Downloader"
    Exitapp
}

#HotIf WinActive("Wenku8Downloader")
F1::Run "Wenku8Downloader.ini"
#HotIf

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
