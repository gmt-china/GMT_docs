#!/usr/bin/env bash
gmt begin coupe_ex1
    gmt coupe data.txt -JX15c/-5c -Sa0.9c -Aa78.43/41.26/78.70/41.05+d90+w4 -W0.4p -GLIGHTSEAGREEN -Q
    gmt basemap -BWSen -Byaf+l"Depth (km)" -Bxaf+l"Distance (km)"
gmt end show