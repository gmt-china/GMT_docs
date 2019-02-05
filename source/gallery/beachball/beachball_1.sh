#!/bin/bash

gmt psmeca -JQ104/15c -R102.5/105.5/30.5/32.5 -Ba -CP5p -Sa1c -M > beachball_1.ps << EOF
# 经度 纬度 深度(km) strike dip rake 震级 newX newY ID
104.33 31.9 39.8 32 64 85 7 0 0 A
EOF
