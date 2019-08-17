#!/usr/bin/env bash
gmt begin inset-map png,pdf
    gmt coast -R139.2/140.5/34.8/36 -JM12c -Baf -BWSne -W2p -A1000 -Glightbrown -Sazure1 --FORMAT_GEO_MAP=dddF
    gmt inset begin -DjBL+w3c/3.6c+o0.1c -F+gwhite+p1p
        gmt coast -R129/146/30/46 -JM? -EJP+glightbrown+p0.2p -A10000
        # 使用 -Sr+s 绘制矩形区域
        echo 139.2 34.8 140.5 36 | gmt plot -Sr+s -W1p,blue
    gmt inset end
gmt end
