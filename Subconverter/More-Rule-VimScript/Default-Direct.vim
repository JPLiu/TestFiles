vim9script

:%s/# .*//ge
silent! g/^#/d

:%s/USER-AGENT,/\rUSER-AGENT,/ge

silent! v/^[DIP]/d
:%s///ge
sort u

silent! g/^PROCESS/normal ddGp
silent! g/^DOMAIN-KEYWORD,/normal ddGp
silent! g/^DOMAIN-SUFFIX,/normal ddGp
silent! g/^DOMAIN,/normal ddGp
silent! g/^IP/normal ddGp

