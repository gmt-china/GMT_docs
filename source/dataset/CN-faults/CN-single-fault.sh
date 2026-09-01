gmt begin CN-single-fault
    gmt basemap -R98/105/22/27 -JM15c -Ba
    #
    gmt convert CN-faults.gmt -S"FN_Ch=红河断裂" | gmt plot
gmt end show