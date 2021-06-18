data=geo3al.gmt
cpt=geoage.cpt
rocksize=500
lengsize=0.381c

gmt begin geo3al png,pdf
    gmt set FONT_ANNOT_PRIMARY 10
    gmt set MAP_FRAME_WIDTH 0.08
    gmt set MAP_TICK_LENGTH_PRIMARY 0.08

    gmt coast -R70/150/13/55 -JM21.844c -Baf -Df -G255 -BWsNe
    gmt plot $data -C$cpt -L

    gmt gmtconvert $data -S"|v|" > tmp
    awk '!/^($|B|F|#)/{print $1,"p'$rocksize'/28:F100B"$2}' $cpt > tmp.cpt
    gmt plot tmp -Ctmp.cpt -L

    gmt gmtconvert $data -S"|i|" > tmp
    awk '!/^($|B|F|#)/{print $1,"p'$rocksize'/29:F100B"$2}' $cpt > tmp.cpt
    gmt plot tmp -Ctmp.cpt -L

    gmt gmtconvert $data -S"|w|" > tmp
    awk '!/^($|B|F|#)/{print $1,"p'$rocksize'/44:F100B"$2}' $cpt > tmp.cpt
    gmt plot tmp -Ctmp.cpt -L

    gmt coast -SCADETBLUE1

    gmt set FONT_ANNOT_PRIMARY 7p
    cat > tmp << EOF
H 10 3 Age of rock units
G 1p
N 3
EOF
    awk '!/^($|B|F|#)/{print $0}' $cpt | while read label color period
    do
        if [ $label == "N" ]; then period=Neogene; fi
        if [ $label == "MZT" ]; then continue; fi
        echo "S 0.3c r $lengsize $color 0.3p 0.7c $period" >> tmp
    done
    gmt legend tmp -DJBR+w300p/157p+jBR+o0c/-100p+l1.3 -F+p0.7p+g255 -C3p/3p

    gmt legend -DJBR+w150p/50p+jBR+o0c/57p+l1.9 -F+p0.7p+g255 -C3p/1p <<EOF
H 10 3 Rock type

N 2
S 0.3c r 0.508c p400/28:B255 0.3p 0.7c Volcanic rocks
S 0.3c r 0.508c p400/29:B255 0.3p 0.7c Intrusive rocks
S 0.3c r 0.508c p400/44:B255 0.3p 0.7c Ultrabasic igneous rock or ophiolites 
EOF

    rm tmp  tmp.cpt
gmt end show