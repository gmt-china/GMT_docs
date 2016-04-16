#!/bin/bash
gmt psbasemap -R1/10000/1e20/1e25 -JX15cl/10cl  -Bxa2+l"Wavelength (m)" -Bya1pf3+l"Power (W)" -BWS > GMT_tutor1_2.ps
rm gmt.*
