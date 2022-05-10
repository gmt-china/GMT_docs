#!/usr/bin/env bash

mkdir -p cpt
gmt begin
gmt set MAP_FRAME_PEN thinner MAP_TICK_LENGTH_PRIMARY 0.2c
gmt set FONT_TITLE 10p,1 MAP_TITLE_OFFSET 5p

GMT_SHAREDIR=$(gmt --show-sharedir)
# Loop over all CPT file in the GMT share/cpt directory
for cpt in $(ls ${GMT_SHAREDIR}/cpt/*.cpt); do
	cpt=$(basename ${cpt%".cpt"})
    echo "Plotting CPT $cpt"
    gmt figure cpt/$cpt PNG,pdf
    gmt plot -R0/6/0/2 -JX6c/1c -T
    gmt makecpt -C$cpt
    gmt colorbar -Dx0c/0.5c+w6c/0.4c+h+jBL -C -B0
    gmt makecpt -C$cpt -T-1/1/0.25
    gmt colorbar -Dx0c/0.0c+w6c/0.4c+h+jBL -C -Bf0.25
    if [ $(grep -c HARD_HINGE ${GMT_SHAREDIR}/cpt/${cpt}.cpt) -eq 1 ]; then # Plot hard hinge symbol
        echo 3 0 | gmt plot -St0.2c -Gblack -Wfaint -D0/-0.2c -N
    elif [ $(grep -c SOFT_HINGE ${GMT_SHAREDIR}/cpt/${cpt}.cpt) -eq 1 ]; then # Plot soft hinge symbol
        echo 3 0 | gmt plot -St0.2c -Gwhite -Wfaint -D0/-0.2c -N
    fi
done
gmt end show
