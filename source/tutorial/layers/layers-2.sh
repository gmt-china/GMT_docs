#!/usr/bin/env bash
gmt begin layers png,pdf

# Plot basemap and Earth relief
gmt basemap -JH180/15c -Rg -B0
gmt grdimage @earth_relief_30m -Cetopo1 -I+d
gmt colorbar -Bxa2000f+l"Elevation (m)"

# Plot epicenter
gmt plot -Sa0.5c -W0.5p,black,solid -Gyellow << EOF
130.72 32.78
EOF

# Plot station locations
gmt plot -St0.2c -W0.5p,black,solid -Gblack << EOF
104.39 29.90
13.14 52.50
19.99 -34.52
-77.15 38.89
-52.47 -31.62
150.36 -33.79
76.22 -69.22
EOF

gmt end show
