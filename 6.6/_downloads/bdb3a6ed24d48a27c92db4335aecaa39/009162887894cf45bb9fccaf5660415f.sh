# 脚本参考自官方源码 test/grdvector/cartvec.sh，改编为现代模式
gmt xyz2grd -R-1/1/-2/2 -I1 -Gr.nc << EOF
0       0       1
0       -1      0.5
EOF
gmt xyz2grd -R-1/1/-2/2 -I1 -Gaz.nc << EOF
0       0       60
0       -1      -100
EOF
gmt begin grdvector-T png
gmt subplot begin 2x2 -Fs2.5i/2.5i -M0.3i -Bafg -BWSne -A+JTC+o0/0.1i -Rr.nc
    gmt subplot set 0 -A"(a) ORIG"
    gmt basemap -JX? -Bx+l"X" -By+l"Y"
    gmt grdvector r.nc az.nc -A -Q0.3i+e  -W3p,red -Gred -Si1i
    gmt grdvector r.nc az.nc -A -Q0.1i+ec -W1p,blue -Gblue -Si1i -T
    gmt subplot set 1 -A"(b) NEG X"
    gmt basemap -JX-2.5i/2.5i -Bx+l"\035X" -By+l"Y"
    gmt grdvector r.nc az.nc -A -Q0.3i+e  -W3p,red -Gred -Si1i
    gmt grdvector r.nc az.nc -A -Q0.1i+ec -W1p,blue -Gblue -Si1i -T
    gmt subplot set 2 -A"(c) NEG Y"
    gmt basemap -JX2.5i/-2.5i -Bx+l"X" -By+l"\035Y"
    gmt grdvector r.nc az.nc -A -Q0.3i+e  -W3p,red -Gred -Si1i
    gmt grdvector r.nc az.nc -A -Q0.1i+ec -W1p,blue -Gblue -Si1i -T
    gmt subplot set 3 -A"(d) NEG X,Y"
    gmt basemap -JX-2.5i/-2.5i -Bx+l"\035X" -By+l"\035Y"
    gmt grdvector r.nc az.nc -A -Q0.3i+e  -W3p,red -Gred -Si1i
    gmt grdvector r.nc az.nc -A -Q0.1i+ec -W1p,blue -Gblue -Si1i -T
gmt subplot end
gmt end show