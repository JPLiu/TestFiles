@echo off

set hour=%time:~,2%
if "%time:~,1%"==" " set hour=0%time:~1,1%
set UpdateTime=%date:~0,4%%date:~5,2%%date:~8,2% %hour%%time:~3,2%%time:~6,2%

git checkout --orphan newBranch
git add -A
git commit -am "%UpdateTime%"
git branch -D main
git branch -m main
git push -f origin main
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
