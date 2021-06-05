%g/^#/d
%g/IP-CIDR/d
%g/\.cn$/d
%v/^[D]/d
1,$s///g

1,$sort u
1,$g/^DOMAIN,/normal ddGp
1,$g/^IP/normal ddGp

