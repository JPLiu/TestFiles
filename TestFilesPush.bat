chcp 65001 >nul
@echo off

set UpdateTime=%date% %time%

set /p CommitTitle=请输入 Commit 内容：

:Push
git add *
git commit -m "%UpdateTime% %CommitTitle%"
git push origin main
git repack -a -d --depth=250 --window=250
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
