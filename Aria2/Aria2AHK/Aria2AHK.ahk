#SingleInstance Force
Persistent

SourceINI := "Aria2AHK.ini"
TargetINI := "Aria2AHK.ini.cp936"
SyncSetting(SourceINI, TargetINI, "UTF-8", "CP936")

Aria2ExeName := IniRead(TargetINI, "Setting", "Aria2ExeName", "aria2c.exe")
SplitPath Aria2ExeName, &Aria2Exe

Aria2Config := IniRead(TargetINI, "Setting", "Aria2Config", "aria2.conf")
FrontendFolder := IniRead(TargetINI, "Setting", "FrontendFolder", "web")
FrontendHtml := IniRead(TargetINI, "Setting", "FrontendHtml", "index.html")
Aria2Proxy := IniRead(TargetINI, "Setting", "Aria2Proxy", "")
BTTrakcersList := IniRead(TargetINI, "Setting", "BTTrakcersList", "")
BTTracker := IniRead(TargetINI, "Config", "bt-tracker", "")
Aria2RpcUrl := IniRead(TargetINI, "Setting", "Aria2RpcUrl", "http://127.0.0.1:6800/jsonrpc")

Configs := []
Loop 3 {
    CName := IniRead(TargetINI, "Config", "ConfigName" . A_Index, "")
    CPath := IniRead(TargetINI, "Config", "ConfigPath" . A_Index, "")
    If (CName != "")
        Configs.Push({Name: CName, Path: CPath, Index: A_Index})
}

SpeedLimits := []
Loop 3 {
    SpeedLimits.Push({
        Name: IniRead(TargetINI, "Config", "SpeedLimitName" . A_Index, "无限制"),
        Limit: IniRead(TargetINI, "Config", "SpeedLimit" . A_Index, "0"),
        SSID: IniRead(TargetINI, "Config", "SpeedLimitSSID" . A_Index, "")
    })
}

Global SelectConfig := IniRead(TargetINI, "Config", "SelectConfig", 1)
Global CurrentConfig := Configs[SelectConfig].Name
Global CurrentConfigPath := Configs[SelectConfig].Path

SetWorkingDir(A_ScriptDir)
GetCurrentSSIDSpeed()
StartAria2Core(False)

If A_Args.Length >= 1 {
    InputTarget := A_Args[1]
    SplitPath(InputTarget, , , &Ext)
    If (Ext = "torrent")
        AddTorrentData(InputTarget)
}

A_IconTip := "Aria2AHK"
If FileExist("Aria2AHK.ico")
    TraySetIcon("Aria2AHK.ico")

Aria2AHKTray := A_TrayMenu
SubMenuAddTask := Menu()
SubMenuProflie := Menu()

Aria2AHKTray.Delete()
Aria2AHKTray.Add("打开 Web 前端", (*) => Run(A_ScriptDir . "\" . FrontendFolder . "\" . FrontendHtml))
Aria2AHKTray.Add()
Aria2AHKTray.Add("添加下载任务", SubMenuAddTask)
Aria2AHKTray.Add("默认下载路径", SubMenuProflie)

SubMenuAddTask.Add("添加 Torrent 文件", SelectAndAddTorrent)
SubMenuAddTask.Add("手动输入 URL", (*) => ShowUrlGui())
SubMenuAddTask.Add()

For Conf In Configs {
    SubMenuAddTask.Add("下载至 " . Conf.Name, CreateUrlTaskClosure(Conf.Index, False))
    SubMenuAddTask.Add("下载至 " . Conf.Name . " (代理)", CreateUrlTaskClosure(Conf.Index, True))
    SubMenuProflie.Add(Conf.Name, SwitchConfigAction)
}

Aria2AHKTray.Add("清理下载路径", CleanUnfinishDownload)
Aria2AHKTray.Add("更新 BT-Trackers", UpdateBTTracker)
Aria2AHKTray.Add()
Aria2AHKTray.Add("当前限速：" . CurrentSpeedLimitName , (*) => 0)
Aria2AHKTray.Add("强制重启 Aria2", (*) => StartAria2Core(True))
Aria2AHKTray.Add()
Aria2AHKTray.Add("退出并关闭核心", (*) => CheckKillAria2("Exit"))

SubMenuProflie.Check(CurrentConfig)

CreateUrlTaskClosure(idx, proxy) {
    Return (ItemName, *) => ShowUrlGui(idx, proxy)
}

SelectAndAddTorrent(*) {
    SelectedFile := FileSelect(3, , "选择 Torrent 文件", "Torrent 文件 (*.torrent)")
    If (SelectedFile != "")
        AddTorrentData(SelectedFile)
}

AddTorrentData(FilePath) {
    TempFile := A_Temp . "\aria2_base64.tmp"
    RunWait(A_ComSpec ' /c certutil.exe -encode "' . FilePath . '" "' . TempFile . '"', , "Hide")
    RawText := FileRead(TempFile)
    FileDelete(TempFile)
    Base64Text := RegExReplace(RawText, "m-s)---.*---|`r|`n", "")
    Payload := '{"jsonrpc":"2.0","id":"AHK","method":"aria2.addTorrent","params":["' . Base64Text . '"]}'
    HttpPost(Aria2RpcUrl, Payload)
}

ShowUrlGui(Idx := 0, UseProxy := False, *) {
    TargetIdx := Idx ? Idx : SelectConfig
    TargetPath := StrReplace(Configs[TargetIdx].Path, "\", "\\")
    AddGui := Gui("+AlwaysOnTop", "Aria2AHK - 新建任务")
    AddGui.SetFont("s10", "Microsoft YaHei")
    AddGui.OnEvent("Escape", (g) => g.Destroy())
    AddGui.Add("Text",, "输入链接 (支持多行): " . (UseProxy ? "【代理开启】" : ""))
    EditBox := AddGui.Add("Edit", "r9 vUrls w500")
    SubmitBtn := AddGui.Add("Button", "Default w80", "确定")
    SubmitBtn.OnEvent("Click", ProcessSubmit)
    ProcessSubmit(btn, *) {
        Data := btn.Gui.Submit()
        Loop Parse, Data.Urls, "`n", "`r" {
            Url := Trim(A_LoopField)
            If (Url != "") {
                ProxyStr := UseProxy ? ',"all-proxy":"' . Aria2Proxy . '"' : ''
                Payload := '{"jsonrpc":"2.0","id":"AHK","method":"aria2.addUri","params":[["' . Url . '"], {"dir":"' . TargetPath . '"' . ProxyStr . '}]}'
                HttpPost(Aria2RpcUrl, Payload)
            }
        }
    }
    AddGui.Show()
}

HttpPost(URL, PData) {
    Try {
        WebRequest := ComObject("WinHttp.WinHttpRequest.5.1")
        WebRequest.Open("POST", URL, True)
        WebRequest.SetRequestHeader("Content-Type", "application/json")
        WebRequest.Send(PData)
        WebRequest.WaitForResponse(-1)
    }
}

SwitchConfigAction(ItemName, *) {
    Global CurrentConfig, CurrentConfigPath, SelectConfig
    For Conf In Configs {
        If (Conf.Name = ItemName) {
            SubMenuProflie.Uncheck(CurrentConfig)
            SelectConfig := Conf.Index
            CurrentConfig := Conf.Name
            CurrentConfigPath := Conf.Path
            IniWrite(SelectConfig, TargetINI, "Config", "SelectConfig")
            SyncSetting(TargetINI, SourceINI, "CP936", "UTF-8")
            SubMenuProflie.Check(CurrentConfig)
            StartAria2Core(True)
            Break
        }
    }
}

CleanUnfinishDownload(*) {
    Loop Files, CurrentConfigPath . "\*.aria2" {
        SplitPath(A_LoopFileName, , , , &OutNameNoExt)
        Try FileDelete(CurrentConfigPath . "\" . OutNameNoExt)
        Try FileDelete(CurrentConfigPath . "\" . A_LoopFileName)
    }
    Sleep(300)
    StartAria2Core(True)
}

UpdateBTTracker(*) {
    Try {
        Download(BTTrakcersList, A_ScriptDir . "\TrackersLists.list")
        Trackers := FileRead(A_ScriptDir . "\TrackersLists.list")
        Trackers := RegExReplace(Trim(Trackers), "\s+", ",")
        IniWrite(Trackers, TargetINI, "Config", "bt-tracker")
        SyncSetting(TargetINI, SourceINI, "CP936", "UTF-8")
        FileDelete(A_ScriptDir . "\TrackersLists.list")
        CheckKillAria2("Reload")
    }
}

StartAria2Core(ForceRestart := False) {
    If (ForceRestart) {
        CheckKillAria2("None")
    } Else If ProcessExist(Aria2ExeName) {
        Return
    }
    Args := " --conf-path=`"" . A_ScriptDir . "\" . Aria2Config . "`""
          . " --max-overall-download-limit=" . CurrentSpeedLimit 
          . " --max-download-limit=" . CurrentSpeedLimit 
          . " --dir=`"" . CurrentConfigPath . "`""
          . " --bt-tracker=`"" . BTTracker . "`""
    Try {
        Run(A_ScriptDir . "\" . Aria2ExeName . Args, , "Hide")
    } Catch {
        MsgBox("无法启动 Aria2 核心，请检查路径。")
    }
}

CheckKillAria2(Mode := "None") {
    While ProcessExist(Aria2Exe)
        ProcessClose(Aria2Exe)
    If (Mode = "Exit")
        ExitApp()
    Else If (Mode = "Reload")
        Reload()
}

GetCurrentSSIDSpeed() {
    Global CurrentSpeedLimitName, CurrentSpeedLimit
    SSIDName := ""
    RunWait(A_ComSpec ' /c netsh wlan show interface | findstr /i "SSID" > SSID.info', , "Hide")
    If FileExist("SSID.info") {
        SSIDRaw := FileRead("SSID.info", "UTF-8")
        FileDelete("SSID.info")
        If RegExMatch(SSIDRaw, "i)SSID\s*:\s*(.*)", &match)
            SSIDName := Trim(match[1])
    }
    MatchedIdx := 0
    If (SSIDName != "") {
        For Index, Item In SpeedLimits {
            Loop Parse, Item.SSID, "," {
                If (Trim(A_LoopField) = SSIDName) {
                    MatchedIdx := Index
                    Break 2
                }
            }
        }
    }
    FinalIdx := (MatchedIdx > 0) ? MatchedIdx : IniRead(TargetINI, "Config", "SelectSpeedLimit", 1)
    If (FinalIdx > SpeedLimits.Length)
        FinalIdx := 1
    CurrentSpeedLimitName := SpeedLimits[FinalIdx].Name
    CurrentSpeedLimit := SpeedLimits[FinalIdx].Limit
}

SyncSetting(SourceFile, TargetFile, SourceEnc, TargetEnc)
{
    If !FileExist(SourceFile)
        Return
    Content := FileRead(SourceFile, SourceEnc)
    Temp := FileOpen(TargetFile, "w", TargetEnc)
    Temp.Write(Content)
    Temp.Close()
}
