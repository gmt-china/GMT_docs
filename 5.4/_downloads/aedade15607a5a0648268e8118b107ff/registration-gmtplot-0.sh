#!/bin/bash
J=X2.5i/1.25i
R=0/3/0/3
PS=GMT_grid_registration.ps

# Gridline registration
gmt psxy -R$R -J$J -B1g1 -Bwesn -P -K -Wthinner -L -Glightred << EOF > $PS
0.5	1.5
1.5	1.5
1.5	2.5
0.5	2.5
EOF
gmt grdmath -R$R -I1 0 = tt.nc
gmt grd2xyz tt.nc | gmt psxy -R$R -J$J -Sc0.12i -N -G0 -O -K >> $PS

# Pixel registration
gmt psxy -R$R -J$J -B1g1 -Bwesn -O -K -W0p -L -Glightred -X2.75i << EOF >> $PS
1	1
2	1
2	2
1	2
EOF
gmt grdmath -R$R -I1 -r 0 = tt.nc
gmt grd2xyz tt.nc | gmt psxy -R$R -J$J -Sc0.12i -Gblack -O >> $PS

rm gmt.* tt.nc
