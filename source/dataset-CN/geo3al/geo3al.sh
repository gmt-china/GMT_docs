#!/usr/bin/env bash
data=geo3al.gmt
cpt=geoage.cpt

gmt begin geo3al pdf,png
    gmt coast -R70/150/13/55 -JM22c -Baf -G255 -BWsNe

    # Plot the geological map by geologic ages
    # -aZ="GEN_GLG": use the "GEN_GLG" metadata as the Z value
    # -G+z -C$cpt: the fill color is determined by the Z value and the CPT file
    gmt plot $data -C$cpt -aZ="GEN_GLG" -G+z

	# Plot rock types using diffenrent patterns (28, 29 and 44)
    # -aI="TYPE": using the "TYPE" metadata as ID
    # -S"-Iv": only keep data segments that matches "-Iv" (v means "Volcanic rocks")
    # -S"-Ii": only keep data segments that matches "-Ii" (i means "Intrusive rocks")
    # -S"-Iw": only keep data segments that matches "-Iw" (w means "Ultrabasic igneous rock or ophiolites")
    # -Gp28+r500+f100+b-: fill with pattern 28, dpi=500, foreground color=100 (gray), background color=- (transparency)
    gmt convert $data -aI="TYPE" -S"-Iv" | gmt plot -Gp28+r500+f100+b-
    gmt convert $data -aI="TYPE" -S"-Ii" | gmt plot -Gp29+r500+f100+b-
    gmt convert $data -aI="TYPE" -S"-Iw" | gmt plot -Gp44+r500+f100+b-

    gmt coast -SCADETBLUE1

    # Plot geologic age legend
    gmt set FONT_ANNOT_PRIMARY 7p  # font for legend labels
    cat > age_legend.txt << EOF
H 10 3 Age of rock units
N 3
EOF
    gawk '!/^($|B|F|N|#)/' $cpt | while read label color period
    do
        echo "S 0.3c r 0.38c $color 0.3p 0.7c $period" >> age_legend.txt
    done
    gmt legend age_legend.txt -DJBR+w10.5c+jTR+o0c/-2c+l1.3 -F+p0.7p+g255 -C3p/3p
    rm age_legend.txt

	# Plot rock type legend
    gmt legend -DJBR+w5.0c+jBR+o0c/2c+l1.9 -F+p0.7p+g255 -C3p/1p <<EOF
H 10 3 Rock type
N 2
S 0.3c r 0.5c p28+r500+f100+b255 0.3p 0.7c Volcanic rocks
S 0.3c r 0.5c p29+r500+f100+b255 0.3p 0.7c Intrusive rocks
S 0.3c r 0.5c p44+r500+f100+b255 0.3p 0.7c Ultrabasic igneous rock or ophiolites
EOF
gmt end show
