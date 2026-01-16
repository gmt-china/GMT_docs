#!/usr/bin/env bash
#
# Demonstrate a few arrows
gmt begin GMT_base_symbols5
# Cartesian straight arrows
	gmt plot -R0/5/0/5 -JX1.75i -Sv0.3i+s+e+bi -W2p -Gred --MAP_VECTOR_SHAPE=0.5 << EOF
0.5	1.0	4.5	2.5
EOF
# Circular arrows
	gmt plot -Sm0.3i+bt+e -W2p -Gred --MAP_VECTOR_SHAPE=0.5 -X2i << EOF
1	0.3	2c	0	90
EOF
# Geo arrows
	gmt plot -R0/90/-41.17/41.17 -JM1.75i -S=0.3i+b+er -W2p -Gred --MAP_VECTOR_SHAPE=0.5 -X2i --MAP_FRAME_TYPE=plain << EOF
10	-35	80	8000
EOF
gmt end show