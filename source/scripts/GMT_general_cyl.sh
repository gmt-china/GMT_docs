#!/bin/bash
gmt begin GMT_general_cyl pdf,png
gmt coast -R-145/215/-90/90 -JY35/30/4.5i -B45g45 -Dc -A10000 -Sdodgerblue -Wthinnest \
	--MAP_FRAME_TYPE=fancy+ 
gmt end
