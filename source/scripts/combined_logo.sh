#!/usr/bin/env bash

gmt begin gmt-china-logo eps
gmt coast -Rd -JI110/10c -Dc -A10000 -G230/230/230 -S160/175/217
gmt coast -ECN+g204/204/204 -EHK+g204/204/204 -ETW+g204/204/204 -EMO+g204/204/204
echo 110 -20 GMT/China | gmt text -F+f35p,19,0/0/100
gmt end

gmt begin combined_logo png,pdf
gmt basemap -R0/16/0/4 -Jx1c -B+n
gmt logo -DjTL+w8c
echo 8.8 2.5 + | gmt text -F+f50p,1,lightred
gmt image gmt-china-logo.eps -DjTR+w6.25c
gmt end
rm gmt-china-logo.eps
