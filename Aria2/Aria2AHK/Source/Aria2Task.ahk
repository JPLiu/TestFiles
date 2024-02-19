#SingleInstance force
#NoTrayIcon
FileEncoding "UTF-8"

; 检查 Aria2 是否已运行。
Global Aria2ExeName := IniRead("Aria2AHK.ini", "Setting", "Aria2ExeName")
If ProcessExist(Aria2ExeName) = 0
    Run A_ScriptDir . "\Aria2AHK.exe"

; 载入配置信息
Global Aria2Proxy := IniRead("Aria2AHK.ini", "Setting", "Aria2Proxy")
Global Aria2RpcUrl := IniRead("Aria2AHK.ini", "Setting", "Aria2RpcUrl")

Global ConfigName1 := IniRead("Aria2AHK.ini", "Config", "ConfigName1")
Global ConfigPath1 := IniRead("Aria2AHK.ini", "Config", "ConfigPath1")
Global ConfigName2 := IniRead("Aria2AHK.ini", "Config", "ConfigName2")
Global ConfigPath2 := IniRead("Aria2AHK.ini", "Config", "ConfigPath2")
Global ConfigName3 := IniRead("Aria2AHK.ini", "Config", "ConfigName3")
Global ConfigPath3 := IniRead("Aria2AHK.ini", "Config", "ConfigPath3")

Global SelectConfig := IniRead("Aria2AHK.ini", "Config", "SelectConfig")

; 处理添加任务参数
Global AddTaskNumber := SelectConfig
Global AddTaskProxy := 0
If A_Args.Has(2) = True
    Global AddTaskNumber := A_Args[2]
If A_Args.Has(3) = True
    Global AddTaskProxy := A_Args[3]
Global TaskPath := IniRead("Aria2AHK.ini", "Config", "ConfigPath" . AddTaskNumber)

; 处理添加 Url
; 命令行调用添加时，支持添加一个 Url；界面添加时，支持多行 Url。
If (A_Args.Has(1) = True and A_Args[1] != "")
{
    Global AddTaskUrls := A_Args[1]
    AddUrlData(AddTaskUrls)

} Else {
;    GUI 界面设置
    MyGui := Gui(, "Aria2AHK")
    MyGui.OnEvent("Escape", GuiClose)
    MyGui.Add("Text",, "新建 HTTP / HTTPS / FTP / SFTP / Magnet 任务:")
    MyGui.Add("Edit", "r9 vAddTaskUrls w512 -WantReturn")
    MyGui.Add("Button", "Default w80", "确定").OnEvent("Click", ProcessUserInput)
    MyGui.Show()
}

; GUI 界面添加 Urls 处理
ProcessUserInput(*)
{
    AddTaskUrls := MyGui.Submit().AddTaskUrls
    Loop parse, AddTaskUrls, "`n", "`r"
    {
        AddUrlData(A_LoopField)
    }
}

; GUI 界面 Esc 退出
GuiClose(*)
{
    Exitapp
}

; 添加任务 json 格式化
AddUrlData(AData)
{
    Global
    If (AddTaskProxy != 0)
    {
        Aria2AddTaskData := '`{"jsonrpc":"2.0","id":"1","method":"aria2.addUri","params":[["' . AData . '"],`{"dir":"' . TaskPath . '","all-proxy":"' . Aria2Proxy . '"}]}'
    } Else {
        Aria2AddTaskData := "`{`"jsonrpc`":`"2.0`",`"id`":`"1`",`"method`":`"aria2.addUri`",`"params`":[[`"" . AData . "`"],`{`"dir`":`"" . TaskPath . "`"`}]`}"
    }
    HttpPost(Aria2RpcUrl, Aria2AddTaskData)
}


; HttpPost 数据创建任务
HttpPost(URL, PData)
{
	Static WebRequest := ComObject("WinHttp.WinHttpRequest.5.1")
	WebRequest.Open("POST", URL, True)
	WebRequest.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	WebRequest.Send(PData)
	WebRequest.WaitForResponse(-1)
}
