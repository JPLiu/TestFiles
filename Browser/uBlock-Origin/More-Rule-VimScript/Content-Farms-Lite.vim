vim9script

:1s@^@\[Adblock Plus 2.0\]\r\! Title\: Content Farms Lite\r\! Version\: 1.0\r\! Expires\: 4 days\r\! Homepage\: https\:\/\/github.com\/JPLiu\/TestFiles\/tree\/main\/Browser\/uBlock-Origin\r\r

:7,$sort u
:7,$s/\/$//ge
silent! :7,$g/\/\^/d
silent! :7,$g/ .*$/s//
silent! :7,$g/\*/d
silent! :7,$g/18comic/d
silent! :7,$g/careerengine/d
silent! :7,$g/cartoonmad/d
silent! :7,$g/blog\.fc2\.com/d
silent! :7,$g/wordpress\.com/d
silent! :7,$g/pixnet\.net/d
silent! :7,$g/^\d\d*\.\d\d*\.\d\d*\.\d\d*$/d
silent! :7,$v/\./d
:7,$s///ge
:7,$s/^\(.*\)$/||\1^/ge
:7,$sort u
