#!/bin/bash
# Showing map directional roses
gmt begin basemap_ex3 pdf,png
gmt set FONT_LABEL 10p FONT_TITLE 12p MAP_ANNOT_OBLIQUE 34 MAP_TITLE_OFFSET 5p \
	MAP_FRAME_WIDTH 3p FORMAT_GEO_MAP dddF FONT_ANNOT_PRIMARY 10p
gmt basemap -R-5/5/-5/5 -Jm0.15i -Ba5f -BWSne+t'-Tdg0/0+w1i+l' -Tdg0/0+w1i+l -X1i
gmt basemap -Ba5f -BwSne+t'-Tdg0/0+w1i+l+f1' -Tdg0/0+w1i+l+f1 -X2i
gmt basemap -R-7/7/-5/5 -Ba5f -BwSnE+t'-Tdg0/0+w1i+l+f3' -Tdg0/0+w1i+l+f3 -X2i
gmt end show
