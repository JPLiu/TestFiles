vim9script
silent! :1,$s/^!#if\(.*\n\)\{-}!#endif//ge
silent! :1,$g/^$/d
silent! :1,$g/^!/d

:1s@^@\[Adblock Plus 2.0\]\r\! title\: AdGuard Cookies Lite\r\! Version\: 1.0\r\! Expires\: 4 days\r\! Homepage\: https\:\/\/github.com\/JPLiu\/TestFiles\/tree\/main\/uBlock-Origin\r\r
