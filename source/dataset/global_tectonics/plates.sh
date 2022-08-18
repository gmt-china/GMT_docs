#!/usr/bin/env bash

gmt begin plates
    gmt basemap -JN15c -Rg -Ba60
    gmt coast -Gwhite -S167/194/223

    # 从crust_type头段中提取出所有大陆地壳板块，并填充橘黄色，设置透明度80%
    gmt convert plates.gmt -S"crust_type=continental" | gmt plot -Gorange@80 -l"continental crust plates"

    # 从plate_type头段中提取出所有变形带板块，并填充红色，设置透明度50%
    gmt convert plates.gmt -S"plate_type=deformation zone" | gmt plot -W0p -Gred@50 -L -l"deformation zone"

    # 从poly_name头段中提取出青藏高原板块、华北板块，并分别填充蓝色和淡绿色
    gmt convert plates.gmt -S"poly_name=Tibet" | gmt plot -W0.5p -L -Gblue -l"Tibet plate"
    gmt convert plates.gmt -S"poly_name=North China" | gmt plot -W0.5p -Glightgreen -l"North China plate"
gmt end show