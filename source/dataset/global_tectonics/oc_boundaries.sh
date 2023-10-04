#!/usr/bin/env bash

gmt begin oc_boundaries
	gmt basemap -JN15c -Rg -Ba60
	gmt coast -G244/243/239 -S167/194/223
	gmt plot oc_boundaries.gmt -W0.5p,red
gmt end show
