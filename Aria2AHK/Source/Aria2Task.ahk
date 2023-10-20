#SingleInstance force
#NoTrayIcon
FileEncoding "UTF-8"

; 检查 Aria2 是否已运行
Global Aria2ExeName := IniRead("Aria2AHK.ini", "Setting", "Aria2ExeName")
If ProcessExist(Aria2ExeName) = 0
    Run A_ScriptDir . "\Aria2AHK.exe"

; 载入配置信息 {{{2
Global Aria2Proxy := IniRead("Aria2AHK.ini", "Setting", "Aria2Proxy")
Global Aria2RpcUrl := IniRead("Aria2AHK.ini", "Setting", "Aria2RpcUrl")

Global ConfigName1 := IniRead("Aria2AHK.ini", "Config", "ConfigName1")
Global ConfigPath1 := IniRead("Aria2AHK.ini", "Config", "ConfigPath1")
Global ConfigName2 := IniRead("Aria2AHK.ini", "Config", "ConfigName2")
Global ConfigPath2 := IniRead("Aria2AHK.ini", "Config", "ConfigPath2")
Global ConfigName3 := IniRead("Aria2AHK.ini", "Config", "ConfigName3")
Global ConfigPath3 := IniRead("Aria2AHK.ini", "Config", "ConfigPath3")

Global SelectConfig := IniRead("Aria2AHK.ini", "Config", "SelectConfig")

; 处理添加任务参数 {{{2
Global AddTaskNumber := SelectConfig
Global AddTaskProxy := 0
If A_Args.Has(2) = True
    Global AddTaskNumber := A_Args[2]
If A_Args.Has(3) = True
    Global AddTaskProxy := A_Args[3]
If (A_Args.Has(1) = True and A_Args[1] != "")
{
    Global DownloadUrl := A_Args[1]
} Else {
    DownloadUrl := InputBox("新建 HTTP / HTTPS / FTP / SFTP / Magnet 任务:", "添加任务", "w320 h240").Value
    If DownloadUrl = ""
    Exitapp
}

Global TaskPath := IniRead("Aria2AHK.ini", "Config", "ConfigPath" . AddTaskNumber)

If (AddTaskProxy != 0)
{
    Aria2AddTaskData := '`{"jsonrpc":"2.0","id":"1","method":"aria2.addUri","params":[["' . DownloadUrl . '"],`{"dir":"' . TaskPath . '","all-proxy":"' . Aria2Proxy . '"}]}'
} Else {
    Aria2AddTaskData := "`{`"jsonrpc`":`"2.0`",`"id`":`"1`",`"method`":`"aria2.addUri`",`"params`":[[`"" . DownloadUrl . "`"],`{`"dir`":`"" . TaskPath . "`"`}]`}"
}

HttpPost(Aria2RpcUrl, Aria2AddTaskData)
Exitapp
Return

HttpPost(URL, PData) {
	Static WebRequest := ComObject("WinHttp.WinHttpRequest.5.1")
	WebRequest.Open("POST", URL, True)
	WebRequest.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	WebRequest.Send(PData)
	WebRequest.WaitForResponse(-1)
}

; Vim-FileSetting vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
