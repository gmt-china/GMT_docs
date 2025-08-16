#!/usr/bin/env bash
gmt begin pens pdf,png
for pen in 0.5p green thin,red,- fat,. 0.1c,120-1-1 faint,0/0/255,..- 4p,red,9_4_2_4:2p; do
    gmt plot $line -R-0.25/16/-0.5/1.5 -JX15c/2c -Y0.8c -W$pen <<- EOF
    0 0
    10 0
	EOF
    echo 10.5 0 $pen | gmt text -F+jML+f12p,8
done
gmt end
