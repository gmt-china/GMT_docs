#!/usr/bin/env bash
# GMT modern mode bash template
# Date:    2019-09-10T00:44:39
# User:    seisman
# Purpose: Purpose of this script
export GMT_SESSION_NAME=$$  # Set a unique session name
gmt begin figurename
    gmt coast -Rg -JH15c -Gpurple -Baf -B+t"My First Plot"
gmt end show