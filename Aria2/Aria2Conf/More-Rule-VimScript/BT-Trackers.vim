vim9script

g/^$/d
:1,$s/\n/,/g
:1,$s/^\(.*\),$/\1/g
