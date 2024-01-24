#SingleInstance force
#NoTrayIcon
FileEncoding "UTF-8"

; 载入配置信息 {{{2
Global Aria2RpcUrl := IniRead("Aria2AHK.ini", "Setting", "Aria2RpcUrl")
Global Aria2ExeName := IniRead("Aria2AHK.ini", "Setting", "Aria2ExeName")

; 检查 Aria2 是否已运行
If ProcessExist(Aria2ExeName) = 0
    Run A_ScriptDir . "\Aria2AHK.exe"

; 处理添加任务参数 {{{2
If (A_Args.Has(1) = True)
{
    Global TorrentPN := A_Args[1]
} Else {
    Global TorrentPN := FileSelect( , , "选择 Torrent 文件", "Torrent 文件 (*.torrent)")
    If TorrentPN = ""
    Exitapp
}

RunWait A_ComSpec " /c certutil.exe -encode " . TorrentPN . " Temp.txt", ,"Hide"
TorrentText := FileRead("Temp.txt")
TorrentText := StrReplace(TorrentText, "-----BEGIN CERTIFICATE-----" , "")
TorrentText := StrReplace(TorrentText, "-----END CERTIFICATE-----" , "")
TorrentText := StrReplace(TorrentText, "`n" , "")
Aria2AddTorrnetData := '`{"jsonrpc":"2.0","id":"1","method":"aria2.addTorrent","params":["' . TorrentText . '"]}'
HttpPost(Aria2RpcUrl, Aria2AddTorrnetData)

FileDelete "Temp.txt"
Exitapp
Return

HttpPost(URL, PData) {
	Static WebRequest := ComObject("WinHttp.WinHttpRequest.5.1")
	WebRequest.Open("POST", URL, True)
	WebRequest.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	WebRequest.Send(PData)
	WebRequest.WaitForResponse(-1)
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
