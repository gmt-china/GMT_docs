#!/bin/bash

J=H110/24c
R=g
PS=GMT_tutor2_1.ps
gmt psbasemap -J$J -R$R -Bg30 -K >> $PS
gmt pscoast -J -R -Glightgreen -SCADETBLUE1 -A1000 -Dc -Bg30 -K -O >> $PS
gmt psxy -J -R -T -O >> $PS
rm gmt.*
