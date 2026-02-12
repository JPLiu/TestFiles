#SingleInstance force
Persistent

Setworkingdir A_ScriptDir

; 读取 Aria2AHK.ini 的配置 {{{1
Global Aria2ExeName := IniRead("Aria2AHK.ini", "Setting", "Aria2ExeName")
Global Aria2Config := IniRead("Aria2AHK.ini", "Setting", "Aria2Config")
Global FrontendFolder := IniRead("Aria2AHK.ini", "Setting", "FrontendFolder")
Global FrontendHtml := IniRead("Aria2AHK.ini", "Setting", "FrontendHtml")
Global Aria2Proxy := IniRead("Aria2AHK.ini", "Setting", "Aria2Proxy")
Global BTTrakcersList := IniRead("Aria2AHK.ini", "Setting", "BTTrakcersList")
Global BTTracker := IniRead("Aria2AHK.ini", "Config", "bt-tracker")

; 载入配置文件信息 {{{2
Global ConfigName1 := IniRead("Aria2AHK.ini", "Config", "ConfigName1")
Global ConfigPath1 := IniRead("Aria2AHK.ini", "Config", "ConfigPath1")
Global ConfigName2 := IniRead("Aria2AHK.ini", "Config", "ConfigName2")
Global ConfigPath2 := IniRead("Aria2AHK.ini", "Config", "ConfigPath2")
Global ConfigName3 := IniRead("Aria2AHK.ini", "Config", "ConfigName3")
Global ConfigPath3 := IniRead("Aria2AHK.ini", "Config", "ConfigPath3")

Global SpeedLimitName1 := IniRead("Aria2AHK.ini", "Config", "SpeedLimitName1")
Global SpeedLimit1 := IniRead("Aria2AHK.ini", "Config", "SpeedLimit1")
Global SpeedLimitSSID1 := IniRead("Aria2AHK.ini", "Config", "SpeedLimitSSID1")
Global SpeedLimitName2 := IniRead("Aria2AHK.ini", "Config", "SpeedLimitName2")
Global SpeedLimit2 := IniRead("Aria2AHK.ini", "Config", "SpeedLimit2")
Global SpeedLimitSSID2 := IniRead("Aria2AHK.ini", "Config", "SpeedLimitSSID2")
Global SpeedLimitName3 := IniRead("Aria2AHK.ini", "Config", "SpeedLimitName3")
Global SpeedLimit3 := IniRead("Aria2AHK.ini", "Config", "SpeedLimit3")
Global SpeedLimitSSID3 := IniRead("Aria2AHK.ini", "Config", "SpeedLimitSSID3")

; 判断默认配置信息 {{{2
Global SelectConfig := IniRead("Aria2AHK.ini", "Config", "SelectConfig")
Global SelectSpeedLimit := IniRead("Aria2AHK.ini", "Config", "SelectSpeedLimit")

Global CurrentConfig := IniRead("Aria2AHK.ini", "Config", "ConfigName" . SelectConfig)
Global CurrentConfigPath := IniRead("Aria2AHK.ini", "Config", "ConfigPath" . SelectConfig)

GetCurrentSSIDSpeed()

; 托盘菜单配置 {{{1
A_IconTip := "Aria2AHK"
If A_IsCompiled = 0
    TraySetIcon("Aria2AHK.ico", 1, 1)
Aria2AHKTray := A_TrayMenu
Global SubMenuAddTask := Menu()
Global SubMenuProflie := Menu()
Global SubMenuSpeedLimit:= Menu()

Aria2AHKTray.Delete
Aria2AHKTray.Add("打开 Web 前端", Frontend)
Aria2AHKTray.Add
Aria2AHKTray.Add("添加下载任务", SubMenuAddTask)
Aria2AHKTray.Add("默认下载路径", SubMenuProflie)

SubMenuAddTask.Add("添加 Torrent 至 " . CurrentConfig, Aria2AddTorrent)
SubMenuAddTask.Add
If (ConfigName1 !="")
{
    SubMenuAddTask.Add("下载至" . ConfigName1, Aria2AddTask10)
    SubMenuAddTask.Add("下载至" . ConfigName1 . "（代理）", Aria2AddTask11)
    SubMenuProflie.Add(ConfigName1, CurrentConfig1)
}
If (ConfigName2 !="")
{
    SubMenuAddTask.Add
    SubMenuAddTask.Add("下载至" . ConfigName2, Aria2AddTask20)
    SubMenuAddTask.Add("下载至" . ConfigName2 . "（代理）", Aria2AddTask21)
    SubMenuProflie.Add(ConfigName2, CurrentConfig2)
}
If (ConfigName3 !="")
{
    SubMenuAddTask.Add
    SubMenuAddTask.Add("下载至" . ConfigName3, Aria2AddTask30)
    SubMenuAddTask.Add("下载至" . ConfigName3 . "（代理）", Aria2AddTask31)
    SubMenuProflie.Add(ConfigName3, CurrentConfig3)
}
SubMenuAddTask.Add
SubMenuAddTask.Add("代理参数：" . Aria2Proxy, NReturn)

Aria2AHKTray.Add("清理下载路径", CleanUnfinishDownload)
Aria2AHKTray.Add("更新 BT-Trackers", UpdateBTTracker)
Aria2AHKTray.Add
Aria2AHKTray.Add("限速：" . CurrentSpeedLimitName , NReturn)
Aria2AHKTray.Add("重启 Aria2", ReStartAria2)
Aria2AHKTray.Add
Aria2AHKTray.Add("退出", ExitAria2AHK)

SubMenuProflie.ToggleCheck(CurrentConfig)

ReStartAria2()
Return

; 打开网页前端 {{{1
Frontend(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Run A_ScriptDir . "\" . FrontendFolder . "\" . FrontendHtml
}

; 添加下载任务 {{{1
Aria2AddTorrent(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Run A_ScriptDir . "\Aria2Torrent.exe"
}

Aria2AddTask10(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Run A_ScriptDir . "\Aria2Task.exe `"`" 1 0"
}

Aria2AddTask11(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Run A_ScriptDir . "\Aria2Task.exe `"`" 1 1"
}

Aria2AddTask20(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Run A_ScriptDir . "\Aria2Task.exe `"`" 2 0"
}

Aria2AddTask21(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Run A_ScriptDir . "\Aria2Task.exe `"`" 2 1"
}

Aria2AddTask30(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Run A_ScriptDir . "\Aria2Task.exe `"`" 3 0"
}

Aria2AddTask31(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Run A_ScriptDir . "\Aria2Task.exe `"`" 3 1"
}

NReturn(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Return
}

; 切换默认下载路径 {{{1

; 切换至配置1 {{{2
CurrentConfig1(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    SwitchConfig(1)
    Reload
}

; 切换至配置2 {{{2
CurrentConfig2(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    SwitchConfig(2)
    Reload
}

; 切换至配置3 {{{2
CurrentConfig3(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    SwitchConfig(3)
    Reload
}

; 清理下载路径 {{{1
CleanUnfinishDownload(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Global
    CurrentConfigPath := IniRead("Aria2AHK.ini", "Config", "ConfigPath" . SelectConfig)
    Loop Files, CurrentConfigPath . "\*.aria2"
    {
        SplitPath A_LoopFileName, , , , &OutNameNoExt
        Try FileDelete CurrentConfigPath . "\" . OutNameNoExt
        Try FileDelete CurrentConfigPath . "\" . A_LoopFileName
    }
    Reload
}

; 更新 BT Tracker {{{1
UpdateBTTracker(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    Download BTTrakcersList, A_ScriptDir . "\TrackersLists.list"
    Trackers := FileOpen(A_ScriptDir . "\TrackersLists.list", "r").ReadLine()
    IniWrite Trackers, "Aria2AHK.ini", "Config", "bt-tracker"
    FileDelete A_ScriptDir . "\TrackersLists.list"
    Reload
}

; 重启 Aria2 {{{1
ReStartAria2(ItemName:=0, ItemPos:=0, MyMenu:=0)
{
    CheckKillAria2()
    Run A_ScriptDir . "\" . Aria2ExeName . " --conf-path=" . A_ScriptDir . "\" . Aria2Config . " --max-overall-download-limit=" . CurrentSpeedLimit . " --max-download-limit=" . CurrentSpeedLimit . " --dir=" . CurrentConfigPath . " --bt-tracker=" . BTTracker, , "Hide"
}

; 退出 {{{1
ExitAria2AHK(ItemName, ItemPos, MyMenu)
{
    CheckKillAria2()
    Exitapp
}

; 终止 Aria2 进程 {{{2
CheckKillAria2()
{
    If ProcessExist(Aria2ExeName) != 0
        ProcessClose Aria2ExeName
}

; 获取当前热点 SSID 并判断限速 {{{2
GetCurrentSSIDSpeed()
{
    Runwait A_ComSpec ' /c netsh wlan show interface | findstr /i "SSID" > SSID.info', ,"Hide"
    SSIDInfo := FileRead("SSID.info", "UTF-8")
    FileDelete A_ScriptDir . "\SSID.info"
    Global SSIDName := RegExReplace(SSIDInfo, "mi)^\s*SSID\s*:\s*([^\r]+)$\r\n.*" , "$1")
    Global SSIDName := StrReplace(SSIDName, "`r`n", "",)
    Global SelectSpeedLimit := ""
    If (SelectSpeedLimit = "" and SSIDName !="")
        SpeedLimitCheck(SpeedLimitSSID1, 1)
    If (SelectSpeedLimit = "" and SSIDName !="")
        SpeedLimitCheck(SpeedLimitSSID2, 2)
    If (SelectSpeedLimit = "" and SSIDName !="")
        SpeedLimitCheck(SpeedLimitSSID3, 3)
    If SelectSpeedLimit = ""
        Global SelectSpeedLimit := IniRead("Aria2AHK.ini", "Config", "SelectSpeedLimit")
    Global CurrentSpeedLimitName := IniRead("Aria2AHK.ini", "Config", "SpeedLimitName" . SelectSpeedLimit)
    Global CurrentSpeedLimit := IniRead("Aria2AHK.ini", "Config", "SpeedLimit" . SelectSpeedLimit)
}

; 限速判断函数 {{{2
SpeedLimitCheck(FSSID1Array,FSelectSpeed)
{
    Global
    {
        SpeedLimitSSIDArray := StrSplit(FSSID1Array, ",")
        Loop SpeedLimitSSIDArray.Length
        {
        	If (SpeedLimitSSIDArray[A_Index] = SSIDName)
            {
                Global SelectSpeedLimit := FSelectSpeed
                Break
            }
        Continue
        }
    }
}

; 配置切换函数 {{{2
SwitchConfig(Number)
{
    Global
    SubMenuProflie.ToggleCheck(CurrentConfig)
	IniWrite Number, "Aria2AHK.ini", "Config", "SelectConfig"
    SelectConfig := IniRead("Aria2AHK.ini", "Config", "SelectConfig")
    CurrentConfig := IniRead("Aria2AHK.ini", "Config", "ConfigName" . SelectConfig)
    CurrentConfigUrl := IniRead("Aria2AHK.ini", "Config", "ConfigPath" . SelectConfig)
    SubMenuProflie.ToggleCheck(CurrentConfig)
    Return
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
