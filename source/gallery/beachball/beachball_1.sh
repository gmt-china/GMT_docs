#!/bin/bash
gmt psmeca -JQ104/15c -R102.5/105.5/30.5/32.5 -Ba -Sa1c > beachball_2.ps << EOF
# 经度 纬度 深度(km) strike dip rake 震级 newX newY ID
104.33 31.91 39.8 32 64 85 7 0 0 A
104.11 31.52 27.1 22 53 57 6 0 0 B
EOF
rm gmt.*
