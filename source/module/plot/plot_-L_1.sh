#!/usr/bin/env bash
cat << EOF > t.txt
1 1
2 3
3 2
4 4
EOF
cmd='t.txt -R0/5/0/5 -JX4c -W1p -Ba1f1'
gmt begin plot_-L_1
gmt plot $cmd -BWStr+t'No -G or -L'
gmt plot $cmd -BWStr+t'-G Only' -Gorange -X5c
# -L选项中的+p子选项对画笔的外观设置一律无效
# 没有-G选项时，使用-L选项必须使用+p子选项，但相关设置无效
gmt plot $cmd -BWStr+t'-L Only' -L+p10p,blue -X5c
gmt plot $cmd -BWStr+t'both -G and -L' -Gorange -L+p10p,blue -X5c
gmt end show
rm t.txt
