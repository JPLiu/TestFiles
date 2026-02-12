vim9script
silent! :1,$g/^!/d
silent! :1,$g/^\[/d
silent! :1,$g/^$/d

:1s@^@\[Adblock Plus 2.0\]\r\! Title\: Liu's Brave RuleSet\r\! Version\: 1.0\r\! Expires\: 1 days\r\! Homepage\: https\:\/\/github.com\/JPLiu\/TestFiles\/tree\/main\/Browser\/uBlock-Origin\r\r
