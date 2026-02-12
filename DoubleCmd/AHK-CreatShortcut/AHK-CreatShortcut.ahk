FileEncoding "UTF-8"
TempFilelist := A_Args[1]
WorkingPath := A_Args[2]

Loop Read TempFilelist
{
        Line := A_LoopReadLine
        SplitPath Line, , , , &OutNameNoExt

;        下行为路径文本处理示例，如无需要可忽略。
;        Line := StrReplace(Line, "\\Gx1-TestDrive", "\\124.98.1.104", "Off")

        FileCreateShortcut Line, WorkingPath . "\" . OutNameNoExt . ".lnk"
}

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
