#!/usr/bin/env bash
gmt begin ex010
    R=$(gmt info data.txt -I2/2 -i7,6 | tr -d '\n')
gmt end show