vim9script

sort u
:%s///ge
silent! g/livew\.l\.qq\.com/d
silent! g/t7z\.cupid\.iqiyi\.com/d
silent! g/广告/d
:%s/\(\a\)127.0.0.1/\1\r127.0.0.1/ge
silent! v/^127.0.0.1/d
silent! g/# /d
sort u
