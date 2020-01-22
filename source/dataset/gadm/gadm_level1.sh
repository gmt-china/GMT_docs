#!/bin/bash
gmt begin gadm_level1 pdf,png
gmt plot -JM15c -R-132/-64/23/51 gadm36_USA_1.gmt
gmt end
