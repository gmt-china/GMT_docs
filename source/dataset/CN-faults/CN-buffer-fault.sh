gmt begin CN-buffer-fault
    gmt basemap -R109/113/34/37 -JM15c -Ba
    # draw a circle with a radius of 100 km
    echo 111 35.5 200k | gmt plot -SE- -Wblue -fg
    # extract faults within the circle
    gmt select CN-faults.gmt -C111/35.5+d100k -fg | gmt plot
gmt end show