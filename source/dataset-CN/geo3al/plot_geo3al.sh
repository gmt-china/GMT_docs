#!/bin/bash
data=geo3al.gmt
cpt=geoage.cpt
rocksize=400
lengsize=0.15i

gmt begin geo3al png,pdf
    gmt set FONT_ANNOT_PRIMARY 10
    gmt set MAP_FRAME_WIDTH 0.08
    gmt set MAP_TICK_LENGTH_PRIMARY 0.08

    gmt coast -R70/150/15/55 -JM8i -Baf -Df -G255 -BWSne
    gmt plot $data -C$cpt -L

    gmt gmtconvert $data -S"|v|" > tmp
    awk '/^[0-9]/{print $1,"p'$rocksize'/28:F100B"$2,$3,"p'$rocksize'/28:F100B"$4}' $cpt > tmp.cpt
    gmt plot tmp -Ctmp.cpt -L

    gmt gmtconvert $data -S"|i|" > tmp
    awk '/^[0-9]/{print $1,"p'$rocksize'/29:F100B"$2,$3,"p'$rocksize'/29:F100B"$4}' $cpt > tmp.cpt
    gmt plot tmp -Ctmp.cpt -L
    
    gmt gmtconvert $data -S"|w|" > tmp
    awk '/^[0-9]/{print $1,"p'$rocksize'/44:F100B"$2,$3,"p'$rocksize'/44:F100B"$4}' $cpt > tmp.cpt
    gmt plot tmp -Ctmp.cpt -L

    gmt coast -SCADETBLUE1

    gmt set FONT_ANNOT_PRIMARY 7p
    gmt legend -DJBR+w200p/57p+jBR+l1.3 -F+p0.7p+g255 -C3p/3p <<EOF
H 10 3 Age of rock units
G 1p
N 3
S 0.3c r $lengsize 229/204/132 0.3p 0.7c Cambrian
S 0.3c r $lengsize 102/192/146 0.3p 0.7c Ordovician
S 0.3c r $lengsize 179/225/194 0.3p 0.7c Silurian
S 0.3c r $lengsize 241/213/118 0.3p 0.7c Devonian
S 0.3c r $lengsize 153/194/181 0.3p 0.7c Carboniferous
S 0.3c r $lengsize 251/141/118 0.3p 0.7c Permian
S 0.3c r $lengsize 227/185/219 0.3p 0.7c Triassic
S 0.3c r $lengsize 166/221/224 0.3p 0.7c Jurassic
S 0.3c r $lengsize 191/227/93 0.3p 0.7c Cretaceous
S 0.3c r $lengsize 253/192/145 0.3p 0.7c Paleogene
S 0.3c r $lengsize 255/255/115 0.3p 0.7c Neogene
EOF

    gmt legend -DJBR+w75p/57p+jBR+l1.3+o200p/0p -F+p0.7p+g255 -C3p/3p <<EOF
H 10 3 Rock type
G 5p
S 0.3c r 0.2i p400/28:B255 0.3p 0.7c Volcanic rocks
G 5p
S 0.3c r 0.2i p400/29:B255 0.3p 0.7c Intrusive rocks
EOF

    rm tmp tmp.cpt 
gmt end show