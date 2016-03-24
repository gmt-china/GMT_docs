#!/bin/bash
PS=GMT_octal_examples.ps
R=0/3/-1/4
J=X12c/-5c

gmt psxy -R$R -J$J -P -K -T > $PS

gmt pstext -R -J -Bg1 -Bwsen -F+j+f -K -O -N >> $PS << EOF
0.5  -0.5 CM 10p,5,black Input
1.5  -0.5 CM 10p,5,black Font
2.5  -0.5 CM 10p,5,black Output

0.5  0.5 CM 10p,8,black abcd
1.5  0.5 CM 10p,8,black 10p,8,black
2.5  0.5 CM 10p,0,black abcd

0.5  1.5 CM 10p,8,black \134141\134142\134143\134144
1.5  1.5 CM 10p,8,black 10p,8,black
2.5  1.5 CM 10p,0,black \141\142\143\144

0.5  2.5 CM 10p,8,black \134141\134142\134143\134144
1.5  2.5 CM 10p,8,black 15p,1,red
2.5  2.5 CM 15p,1,red \141\142\143\144

0.5  3.5 CM 10p,8,black \134243\134251\134256\134303
1.5  3.5 CM 10p,8,black 15p,25,blue
2.5  3.5 CM 15p,25,blue \243\251\256\303
EOF
gmt psxy -R -J -O -T >> $PS

rm gmt.history
