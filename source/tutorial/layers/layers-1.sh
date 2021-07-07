#!/usr/bin/env bash
gmt begin layers png,pdf

# Plot basemap and Earth relief
gmt basemap -JH180/15c -Rg -B0
gmt grdimage @earth_relief_30m -Cetopo1 -I+d
gmt colorbar -Bxa2000f+l"Elevation (m)"
gmt end show
