chcp 65001 >nul
@echo off

set UpdateTime=%date% %time%

git checkout --orphan newBranch
git add -A
git commit -am "%UpdateTime%"
git branch -D main
git branch -m main
git push -f origin main
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
