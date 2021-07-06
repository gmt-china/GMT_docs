#!/usr/bin/env bash
gmt begin text_-M png,pdf
gmt text -R0/3/0/5 -JX3i -F+f+a+j -B1 -M -N << EOF
> 0 -0.5 12p,black 0 LT 13p 3i j
@%5%Figure 1.@%% This illustration shows nothing useful, but it still needs
a figure caption. Highlighted in @;255/0/0;red@;; you can see the locations
of cities where it is @_impossible@_ to get any good Thai food; these are to be avoided.
EOF
gmt end
