@echo off

:ForcePush
git push
git repack -a -d --depth=250 --window=250
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
