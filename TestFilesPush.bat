chcp 65001 >nul
@echo off

set HTTP_PROXY=http://127.0.0.1:7890
set HTTPS_PROXY=http://127.0.0.1:7890
set UpdateTime=%date% %time%

set /p CommitTitle=请输入 Commit 内容：

:Push
git add *
git commit -m "%UpdateTime% %CommitTitle%"
git push origin main

git repack -a -d --depth=250 --window=250
git gc --aggressive --prune=now
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
