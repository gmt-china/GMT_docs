#!/bin/bash
gmt begin GMT_-U pdf,png
gmt basemap -R0/8/0/3 -Jx1c -Bx1 -By1 -UBL/-1.5c/-1.5c/"This is a GMT logo"
gmt end
