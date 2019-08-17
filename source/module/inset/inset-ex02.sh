#!/usr/bin/env bash
gmt begin inset-example png,pdf
    gmt coast -R110E/170E/44S/9S -JM6i -B -BWSne -Wfaint -N2/1p -Gbrown -EAU+gbisque
    gmt inset begin -DjTR+w1.5i+o0.15i/0.1i -F+gwhite+p1p+c0.1c
        gmt coast -JG120/30S/? -Rg -Bg -Wfaint -Gbrown -EAU+gbisque -A5000
    gmt inset end
gmt end
