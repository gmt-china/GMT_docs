#!/bin/bash
gmt begin GMT_tutor1_2 pdf,png
gmt basemap -R1/10000/1e20/1e25 -JX15cl/10cl  -Bxa2+l"Wavelength (m)" -Bya1pf3+l"Power (W)" -BWS
gmt end
