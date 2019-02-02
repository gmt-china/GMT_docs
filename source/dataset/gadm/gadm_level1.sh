#!/bin/bash
PS=gadm_level1.ps

gmt psxy -JM15c -R72/136/15/54 -T -K -P > $PS
gmt psxy -J -R gadm36_CHN_1.gmt -K -O >> $PS
gmt psxy -J -R gadm36_HKG_0.gmt -K -O >> $PS
gmt psxy -J -R gadm36_MAC_0.gmt -K -O >> $PS
gmt psxy -J -R gadm36_TWN_0.gmt -K -O >> $PS
gmt psxy -J -R -T -O >> $PS
