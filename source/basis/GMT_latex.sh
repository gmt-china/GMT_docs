#!/usr/bin/env bash
gmt begin GMT_latex pdf,png
    gmt basemap -R-200/200/0/50 -JX15c/4c \
        -BSwen+t"Use <math>\Delta g = 2\pi\rho Gh</math>" \
        -Bxaf+l"@[\nabla^4 \psi - \Delta \sigma_{xx}^2@[ (MPa)"
    gmt text -F+f15p << EOF
0 15 Newton's integral: <math>V = \int_{v} \frac{\mathrm{d}m}{l}</math>
0 30 Euler's formula: @[e^{ix} = \cos x + i \sin x@[
EOF
gmt end show
