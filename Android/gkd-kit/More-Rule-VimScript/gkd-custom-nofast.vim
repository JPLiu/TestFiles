vim9script

g/"fastQuery"/d
:%s/-FastQuery/-NoFast/ge
:%s/订阅/ NoFast/ge

:%s/"id": 1/"id": 2/ge

# vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
