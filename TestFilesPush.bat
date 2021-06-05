@echo off

set hour=%time:~,2%
if "%time:~,1%"==" " set hour=0%time:~1,1%
set UpdateTime=%date:~0,4%%date:~5,2%%date:~8,2% %hour%%time:~3,2%%time:~6,2%

:Push
git add *
git commit -m "%UpdateTime%"
git push origin main
git repack -a -d --depth=250 --window=250
exit

:: Vim-FileSetting {{{1
:: Vim-FileSetting vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
