1,$s/# .*//g
1,$g/^#/d

1,$v/^[DIP]/d
1,$s///g
1,$sort u

1,$g/^PROCESS/normal ddGp
1,$g/^DOMAIN-KEYWORD,/normal ddGp
1,$g/^DOMAIN-SUFFIX,/normal ddGp
1,$g/^DOMAIN,/normal ddGp
1,$g/^IP/normal ddGp

