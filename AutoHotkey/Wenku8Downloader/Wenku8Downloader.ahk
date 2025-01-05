#SingleInstance force
Persistent

Setworkingdir A_ScriptDir

; 读取 Wenku8Downloader.ini 的配置
Global Aria2 := IniRead("Wenku8Downloader.ini", "Setting", "Aria2")
Global Aria2Proxy:= IniRead("Wenku8Downloader.ini", "Setting", "Aria2Proxy")
Global BaseList := IniRead("Wenku8Downloader.ini", "Setting", "BaseList")
Global TempPath := IniRead("Wenku8Downloader.ini", "Setting", "TempPath")

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
        Global BookName := IniRead("Wenku8Downloader.ini", "BookList", A_LoopField, CTime)
        Global BookUrl := "https://dl.wenku8.com/down.php?type=utf8&node=2&id=" . A_LoopField
        RunWait Aria2 . " --all-proxy " . Aria2Proxy . " --out `"" TempPath . "\" . BookName . "`".txt" . " " . BookUrl
        Sleep 4000
    }
    Exitapp
}

; GUI 界面 Esc 退出
GuiClose(*)
{
    WinClose "Wenku8Downloader"
    Exitapp
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
