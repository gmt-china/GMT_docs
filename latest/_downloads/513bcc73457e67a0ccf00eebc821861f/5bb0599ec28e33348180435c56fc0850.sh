R="-2/2/-2/2"
gmt grdmath -R$R -I0.25 X Y R2 NEG EXP X MUL = z.nc
gmt grdmath z.nc DDX = dzdx.nc
gmt grdmath z.nc DDY = dzdy.nc
gmt begin vector png
    gmt set FONT_TITLE 15p,1
    gmt grdvector -R$R -JX10c/10c -Baf -BWSen+t"\053n1c/0" dzdx.nc dzdy.nc -S1 -Q+e+n1c/0+g0
    gmt grdvector -R$R -JX10c/10c -Baf -BWSen+t"no \053n" dzdx.nc dzdy.nc -S1 -Q+e+g0 -X+w+2c
gmt end show