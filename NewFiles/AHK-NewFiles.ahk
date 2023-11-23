#SingleInstance Force
TemplatesPath := IniRead("AHK-NewFiles.ini", "Setting", "TemplatesPath")
A_Args[1] := StrReplace(A_Args[1], '"')
DestPath := A_Args[1]

MyGui := Gui(, "AHK-NewFiles")
MyGui.Add("Text",, "New Files Name:")
MyGui.Add("Edit", "r9 vNewFilesName w512 -WantReturn")
MyGui.Add("Button", "Default w80", "OK").OnEvent("Click", ProcessUserInput)
MyGui.Show()

Esc::Exitapp

ProcessUserInput(*)
{
    FileContents := MyGui.Submit().NewFilesName
    Loop parse, FileContents, "`n", "`r"
    {
        SplitPath A_LoopField, &OutFileName, &OutDir, &OutExtension, &OutNameNoExt, &OutDrive
        If FileExist(TemplatesPath . "\%." . OutExtension)
        {
            Try FileCopy TemplatesPath . "\%." . OutExtension, DestPath . "\" . OutFileName, True
        } Else {
            Try FileAppend "" , DestPath . "\" . OutFileName
        }

    }
}
