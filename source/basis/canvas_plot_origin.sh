gmt begin canvas_plot_origin png
    gmt set PS_MEDIA 30cx30c  # pretend that the canvas is 11.6m X 11.6m
    # plot the main basemap
    gmt basemap -R0/10/0/10 -Jx1c -Bwsen --MAP_FRAME_PEN=2p
    echo 0 0 180 2.54c | gmt plot -Sv0.4c+b+e+gblack -W1p -N
    echo 0 0 270 2.54c | gmt plot -Sv0.4c+b+e+gblack -W1p -N
    echo 0 0 | gmt plot -Sc0.4c -Gred -N
    echo 0 0 12.7 cm | gmt text -F+f15p,1,red -N -D-1.25c/0.4c
    echo 0 0 12.7 cm | gmt text -F+f15p,1,red+a270 -N -D0.4c/-1.25c

    # plot the canvas
    gmt basemap -R0/30/0/30 -Jx1c -Bg1 -Xf0c -Yf0 --MAP_GRID_PEN=0.2p,gray20
    echo 0 29.5 30 29.5 | gmt plot -Sv0.8c+s+b+e+gblack -N -W2p
    echo 15 29 "Paper Width = 11.6 m" | gmt text -F+f25p,1,red
    echo 29.5 0 29.5 30 | gmt plot -Sv0.8c+s+b+e+gblack -N -W2p
    echo 29 15 "Paper Height = 11.6 m" | gmt text -F+f25p,1,red+a270
gmt end show
