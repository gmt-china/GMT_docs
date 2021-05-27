#!/bin/bash
# 1. Create the background map
export GMT_SESSION_NAME=$$
cat << EOF > pre.sh
gmt begin
    gmt basemap -R2019-03-31T09:00:00/2019-04-01T09:00:00/-0.565631/0.828242 -Bpxa4Hf1h -Bsxa1Df1D -Bpya0.4g0.2f0.2+l"WSSE(HPF)/m" -JX10c/4c -BWSne
    gmt basemap -R2/20/1e-4/1e0 -JX-10cl/10cl -Bxa2f3g3+l"period:second" -Bya-1pg+l"power spectrum:m@+2@+/cycle/s" -BWNse -Y2.7i
    gmt basemap -R0.05/0.5/1e-4/0.5 -JX10cl/10cl -Bxa2f3g3+l"Frequency:cycle/second" -BS
gmt end
EOF
# 2.  Set up the main frame script
cat << EOF > main.sh
max=\$(gmt math -Q \$MOVIE_FRAME 3600 MUL =)
min=\$(gmt math -Q 3600 \$MOVIE_FRAME 1 SUB MUL =)
r=\$((\$RANDOM%255))
g=\$((\$RANDOM%255))
b=\$((\$RANDOM%255))
gmt begin
    gmt convert gnss_b1_hlf_allppk.txt -Z\$min:\$max |gmt spectrum1d -S256 -W --GMT_FFT=brenner -N -i1 -D1 > pow5.txt
    gmt convert gnss_b1_hlf_allppk.txt -Z0:\$max | gmt plot -R32400/119700/-0.565631/0.828242 -JX10c/4c -W0.5p,lightgray
    gmt convert gnss_b1_hlf_allppk.txt -Z\$min:\$max | gmt plot -W0.5p,\$r/\$g/\$b
    gmt plot -R2/20/1e-4/1e0 -JX-10cl/10cl pow5.txt -W2.25p,\$r/\$g/\$b -Y2.7i 
gmt end
EOF
# 3. Run the movie
gmt movie main.sh -Sbpre.sh -C20cx20cx125 -Nex028 -D5  -Agif+l -T23 -Z
# 4. clear
rm pre.sh main.sh