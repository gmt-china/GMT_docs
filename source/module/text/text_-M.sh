#!/usr/bin/env bash
gmt begin text_-M png,pdf
gmt text -R0/3/0/5 -JX8c/3c -F+f+a+j -Baf -M -N << EOF
> 0 -1 12p,black 0 LT 13p 8c j
@%5%Figure 1.@%% This illustration shows nothing useful, but it still needs
a figure caption. Highlighted in @;255/0/0;red@;; you can see the locations
of cities where it is @_impossible@_ to get any good Thai food; these are to be avoided.
EOF
gmt end show
