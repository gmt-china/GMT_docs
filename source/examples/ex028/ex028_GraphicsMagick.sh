#!/bin/bash
gnss1=./gnss_b1_hlf_allppk.txt
R=-R32400/119700/-0.565631/0.828242

export GMT_SESSION_NAME=$$
 
# 最外层的for循环
for((i=1;i<=23;i++));  
do   
	((name = $i + 100))
	r=$(($RANDOM%255))
	g=$(($RANDOM%255))
	b=$(($RANDOM%255))

	((max =  $i * 3600))
	((min = ($i-1) * 3600))

	# 每个循环内部绘制一帧图像
	gmt begin a00$name png
		gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm
		gmt basemap -R2019-03-31T09:00:00/2019-04-01T09:00:00/-0.565631/0.828242 -Bpxa4Hf1h -Bsxa1Df1D -Bpya0.4g0.2f0.2+l"WSSE(HPF)/m" -JX10c/4c -BWSne
		gmt basemap -R2/20/1e-4/1e0 -JX-10cl/10cl -Bxa2f3g3+l"period:second" -Bya-1pg+l"power spectrum:m@+2@+/cycle/s" -BWNse -Y2.7i
		
		awk 'NR<'"$max"' && NR>'"$min"'  {print $1,$2}' $gnss1 | gmt spectrum1d -S256 -W --GMT_FFT=brenner -N -i1 -D1 > pow5.txt
		awk ' NR<'"$max"'   {print $1,$2}' $gnss1 | gmt plot $R -JX10c/4c -W0.5p,lightgray -Y-2.7i
		awk 'NR<'"$max"' && NR>'"$min"'  {print $1,$2}' $gnss1 | gmt plot -W0.5p,$r/$g/$b
		gmt plot -R2/20/1e-4/1e0 -JX-10cl/10cl pow5.txt -W2.25p,$r/$g/$b -Y2.7i -i0,1

		gmt basemap -R0.05/0.5/1e-4/0.5 -JX10cl/10cl -Bxa2f3g3+l"Frequency:cycle/second" -BS
	gmt end
	rm pow5.txt
done
gm convert -delay 64 -loop 0 *.png wave_spectrum.gif
rm a00*.png