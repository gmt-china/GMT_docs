#!/usr/bin/env bash
gmt begin cpt_3
gmt makecpt -Cglobe -T-8000/3000
gmt colorbar -C -Baf -Dx0/0+w4.5i/0.1i+h
gmt colorbar -Cglobe -Baf -Dx0/0+w4.5i/0.1i+h -Y0.5i
gmt end show
