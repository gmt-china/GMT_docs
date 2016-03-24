#!/bin/bash
gmt psbasemap -R0/10/0/5 -JX10c/3c -Bx1 -By1 -P -UBL/-1.5c/-1.5c/"This is a GMT logo" > GMT_-U.ps
rm gmt.*
