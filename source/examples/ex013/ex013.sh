#!/usr/bin/env bash
#
# Earth relief in Anhui, China
#

gmt begin ex013
	# Clip the Anhui province
	gmt coast -ECN.AH+c -RCN.AH -JM10c
	# Plot the earth relief
	gmt grdimage @earth_relief_15s -I+d
	# Add rivers and lakes
	gmt coast -Ia/1p,lightblue -Slightblue
	# Undo the clipping
	gmt clip -C
gmt end show
