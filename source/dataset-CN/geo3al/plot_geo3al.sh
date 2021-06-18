#!/bin/bash
data=geo3al.gmt
cpt=geoage.cpt
lengsize=0.381c

gmt begin geo3al png,pdf
    gmt set FONT_ANNOT_PRIMARY 10 MAP_TICK_LENGTH_PRIMARY 0.08
    # plot coastlines
    gmt coast -R70/150/13/55 -JM22c -Baf -Df -G255 -BWsNe
    # plot the geology map
    # -aZ="GLG": using the "GLG" property as the Z value
    # -G+z -C$cpt: the color is determined by the Z value and the CPT file
    gmt plot $data -C$cpt -aZ="GLG" -G+z

    # plot rock types using diffenrent patterns
    # -aI="TYPE": using the "TYPE" properties as ID
    # -S"-Iv": only keep data segments that matches "-Iv"
    # v means XXX rocks, i means XXX rocks, w means XXX rocks
    # -Gp28+r500+f100+b-: fill the region with pattern 28, dpi=500, foregroud color=100 (gray), backgroud color=- (transparency)
    gmt convert $data -aI="TYPE" -S"-Iv" | gmt plot -Gp28+r500+f100+b-
    gmt convert $data -aI="TYPE" -S"-Ii" | gmt plot -Gp29+r500+f100+b-
    gmt convert $data -aI="TYPE" -S"-Iw" | gmt plot -Gp44+r500+f100+b-

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
S 0.3c r 0.508c p28+r500+f100+b255 0.3p 0.7c Volcanic rocks
S 0.3c r 0.508c p29+r500+f100+b255 0.3p 0.7c Intrusive rocks
S 0.3c r 0.508c p44+r500+f100+b255 0.3p 0.7c Ultrabasic igneous rock or ophiolites 
EOF

    rm tmp
gmt end show
