vim9script

silent! v/^127.0.0.1/d
:1,$s/127.0.0.1 /DOMAIN,/ge
