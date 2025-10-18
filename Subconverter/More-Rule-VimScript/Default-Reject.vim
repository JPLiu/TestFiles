vim9script

:%s/,reject//ge

:%s/^127.0.0.1 /DOMAIN-SUFFIX,/ge
:%s/^0.0.0.0 /DOMAIN,/ge
:%s/#/\r#/ge
:%s/\/32$/\/32,no-resolve/ge
:%s/\/128$/\/128,no-resolve/ge
silent! g/^#/d
silent! g/\*/d

silent! v/^[DIP]/d
:%s///ge
sort u

silent! g/^PROCESS/normal ddGp
silent! g/^DOMAIN-KEYWORD,/normal ddGp
silent! g/^DOMAIN-SUFFIX,/normal ddGp
silent! g/^DOMAIN,/normal ddGp
silent! g/^IP/normal ddGp

