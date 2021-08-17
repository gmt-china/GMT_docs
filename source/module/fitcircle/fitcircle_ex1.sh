#!/usr/bin/env bash
# test/fitcircle/circles.sh
#
# Tests gmt fitcircle on spherical data points

ps=fitcircle_ex1.ps

# Fit great circle to red points and small circle to green points
# Plot the best-fitting great and small circles as well as the
# location of the mean locations and pole locations for both
# the -L1 and -L2 options (i.e., -L3).

gmt fitcircle gcircle.txt -L3 > g.txt
gmt fitcircle scircle.txt -L3 -S > s.txt
gpole1=`grep "L1 N Hemisphere" g.txt | gawk '{printf "%s/%s\n", $1, $2}'`
gpole2=`grep "L2 N Hemisphere" g.txt | gawk '{printf "%s/%s\n", $1, $2}'`
spole1=`grep "L1 Small Circle Pole" s.txt | gawk '{printf "%s/%s\n", $1, $2}'`
spole2=`grep "L2 Small Circle Pole" s.txt | gawk '{printf "%s/%s\n", $1, $2}'`
slat1=`grep "L1 Small Circle" s.txt | gawk '{print 90-$NF}'`
slat2=`grep "L2 Small Circle" s.txt | gawk '{print 90-$NF}'`
gmt psxy -Rg -JG-30/40/7i -P -Bg -K gcircle.txt -Sc0.04i -Gred -Xc -Yc > $ps
gmt psxy -R -J -O -K scircle.txt -Sc0.04i -Ggreen >> $ps
gmt project -G1 -T$gpole1 -L-180/180 | gmt psxy -R -J -O -K -W3p >> $ps
gmt project -G1 -T$gpole2 -L-180/180 | gmt psxy -R -J -O -K -W1p,- >> $ps
gmt project -G1/$slat1 -T$spole1 -L-180/180 | gmt psxy -R -J -O -K -W3p >> $ps
gmt project -G1/$slat2 -T$spole2 -L-180/180 | gmt psxy -R -J -O -K -W1p,- >> $ps
grep "Great Circle Pole" g.txt | gmt psxy -R -J -O -K -Sa0.2i -Gred -W0.25p >> $ps
grep "Small Circle Pole" s.txt | gmt psxy -R -J -O -K -Sa0.2i -Ggreen -W0.25p >> $ps
grep "L1 Average" g.txt | gmt psxy -R -J -O -K -Sa0.2i -Gyellow -W0.25p >> $ps
grep "L2 Average" g.txt | gmt psxy -R -J -O -K -Sa0.2i -Gyellow -W0.25p >> $ps
grep "L1 Average" s.txt | gmt psxy -R -J -O -K -Sa0.2i -Gyellow -W0.25p >> $ps
grep "L2 Average" s.txt | gmt psxy -R -J -O -K -Sa0.2i -Gyellow -W0.25p >> $ps
gmt psxy -R -J -O -T >> $ps
rm g.txt s.txt gmt.*
