#SingleInstance Force

ComputerName = %A_ComputerName%

If ComputerName = ThinkBook14
    GSName = TB14

If ComputerName = XiaoXinPro14
    GSName = XX14

IfExist, %A_ScriptDir%\ini\GeneralSettings_%GSName%.ini
    FileCopy, %A_ScriptDir%\ini\GeneralSettings_%GSName%.ini, %A_ScriptDir%\ini\GeneralSettings.ini , 1

Run %A_ScriptDir%\Candy.exe

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
