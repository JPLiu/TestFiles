#SingleInstance Force
DestPath := A_Args[1]
A_Args[1] := StrReplace(A_Args[1], '"')
DestPath := A_Args[1]

MyGui := Gui(, "AHK-NewFolders")
MyGui.OnEvent("Escape", GuiClose)
MyGui.Add("Text",, "New Folders Name:")
MyGui.Add("Edit", "r9 vNewFoldersName w512 -WantReturn")
MyGui.Add("Button", "Default w80", "OK").OnEvent("Click", ProcessUserInput)
MyGui.Show()

ProcessUserInput(*)
{
    FileContents := MyGui.Submit().NewFoldersName
    Loop parse, FileContents, "`n", "`r"
    {
        Try DirCreate DestPath . "\" . A_LoopField
    }
}

GuiClose(*)
{
    Exitapp
}
