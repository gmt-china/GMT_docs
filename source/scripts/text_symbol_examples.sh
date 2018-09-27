#!/bin/bash

gmt begin text_symbol_examples pdf,png

gmt text -JX12c/-5c -R0/3/-1/4 -Bg1 -Bwsen -F+j+f -N  << EOF
0.5  -0.5 CM 10p,5,black Input
1.5  -0.5 CM 10p,5,black Font
2.5  -0.5 CM 10p,5,black Output

0.5  0.5 CM 10p,8,black abcd
1.5  0.5 CM 10p,8,black 10p,12,black
2.5  0.5 CM 10p,12,black abcd

0.5  1.5 CM 10p,8,black \134141\134142\134143\134144
1.5  1.5 CM 10p,8,black 10p,12,black
2.5  1.5 CM 10p,12,black \141\142\143\144

0.5  2.5 CM 10p,8,black \134141\134142\134143\134144
1.5  2.5 CM 10p,8,black 15p,34,red
2.5  2.5 CM 15p,34,red \141\142\143\144

0.5  3.5 CM 10p,8,black \134243\134251\134256\134303
1.5  3.5 CM 10p,8,black 15p,34,blue
2.5  3.5 CM 15p,34,blue \243\251\256\303
EOF
gmt end