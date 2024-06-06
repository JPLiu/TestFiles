vim9script

silent! g/^#/d
silent! g/IP-CIDR/d

silent! v/^[DIP]/d
:1,$s///ge
sort u

silent! g/^PROCESS/normal ddGp
silent! g/^DOMAIN-KEYWORD,/normal ddGp
silent! g/^DOMAIN-SUFFIX,/normal ddGp
silent! g/^DOMAIN,/normal ddGp
silent! g/^IP/normal ddGp

