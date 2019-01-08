#!/bin/bash
dy=-0.2222
y0=4.3
ps=GMT_fonts.ps

cat > tt.d << EOF
Helvetica
Helvetica-Bold
Helvetica-Oblique
Helvetica-BoldOblique
Times-Roman
Times-Bold
Times-Italic
Times-BoldItalic
Courier
Courier-Bold
Courier-Oblique
Courier-BoldOblique
Symbol
AvantGarde-Book
AvantGarde-BookOblique
AvantGarde-Demi
AvantGarde-DemiOblique
Bookman-Demi
Bookman-DemiItalic
Bookman-Light
Bookman-LightItalic
Helvetica-Narrow
Helvetica-Narrow-Bold
Helvetica-Narrow-Oblique
Helvetica-Narrow-BoldOblique
NewCenturySchlbk-Roman
NewCenturySchlbk-Italic
NewCenturySchlbk-Bold
NewCenturySchlbk-BoldItalic
Palatino-Roman
Palatino-Italic
Palatino-Bold
Palatino-BoldItalic
ZapfChancery-MediumItalic
ZapfDingbats
EOF

gmt gmtset MAP_FRAME_PEN thinner
gmt psxy -R0/5.4/0/$y0 -Jx1i -P -K -B0 <<EOF > $ps
>
0.3	0
0.3	$y0
>
2.7	0
2.7	$y0
>
3	0
3	$y0
EOF
gmt psxy -R -J -O -K -Y${y0}i -T >> $ps
gmt pstext -R -J -O -K -Y${dy}i -F+f10p+jBC <<EOF >> $ps
0.15	0.05	\\043
1.55	0.05	Font Name
2.85	0.05	\\043
4.15	0.05	Font Name
EOF
gmt psxy -R -J -O -K <<EOF >> $ps
0	0
5.4	0
EOF

i=1
while [ $i -le 17 ]
do
	i1=`echo "$i - 1" | bc`
	i2=`echo "$i1 + 17" | bc`
	k1=$i
	k2=`echo "$i + 17" | bc`

	f1=`sed -n ${k1}p tt.d`
	f2=`sed -n ${k2}p tt.d`

	if [ $i1 -eq "12" ]; then
		f1="Symbol @%0%(Symbol)@%%"
	fi
	fn2=$i2
	gmt pstext -R -J -O -K -Y${dy}i -F+f+j <<EOF >> $ps
0.15	0.03	10p,$i1		BC	$i1
0.4	0.03	10p,$i1		BL	$f1
2.85	0.03	10p,$fn2	BC	$i2
3.1	0.03	10p,$i2		BL	$f2
EOF
	i=`echo "$i + 1" | bc`
done

gmt pstext -R -J -O -K -Y${dy}i -F+f+j <<EOF >> $ps
2.85	0.03	10p,Helvetica		BC	34
3.1	0.03	10p,ZapfDingbats	BL	ZapfDingbats @%0%(ZapfDingbats)@%%
EOF

gmt psxy -R -J -O -T >> $ps

rm tt.d gmt.conf gmt.history
