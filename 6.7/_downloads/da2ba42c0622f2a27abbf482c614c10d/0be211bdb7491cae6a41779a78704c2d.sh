touch loc.xy
for X in $(seq 30 60 330); do
    for Y in $(seq -60 30 60); do
        echo "$X $Y" >> loc.xy
    done
done
gmt begin distortion
gmt coast -Glightgreen -Slightblue -R0/360/-85/85 -JM6i -Bxa30fg30 -Bya30fg30 -W0.1p
gmt plot loc.xy -SE0/2000k/2000k -Gred@70
gmt end show