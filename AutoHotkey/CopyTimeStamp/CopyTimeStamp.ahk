FileEncoding "UTF-8"

SourceFile := A_Args[1]
TargetFile := A_Args[2]

TimestampM := FileGetTime(SourceFile, "M")
FileSetTime TimestampM, TargetFile, "M"

ExitApp

; vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
