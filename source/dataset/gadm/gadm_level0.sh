#!/bin/bash
gmt begin gadm_level0 pdf,png
gmt plot -JM15c -R72/136/15/54 gadm36_CHN_0.gmt
gmt plot gadm36_HKG_0.gmt
gmt plot gadm36_MAC_0.gmt
gmt plot gadm36_TWN_0.gmt
gmt end
