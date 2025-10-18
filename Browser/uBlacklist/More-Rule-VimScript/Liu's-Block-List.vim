vim9script

sort u
:%s/\/$//ge
:%s///ge
silent! g/\/\^/d
silent! g/ .*$/s//
silent! g/\*/d
silent! g/careerengine/d
silent! g/cartoonmad/d
silent! g/blog\.fc2\.com/d
silent! g/wordpress\.com/d
silent! g/pixnet\.net/d
silent! g/^\d\d*\.\d\d*\.\d\d*\.\d\d*$/d
silent! v/\./d
:%s/\/.*//ge
:%s/\^//ge
:%s/||//ge
sort u
:%s@\(.*\)@*://*.\1/*
