#!/usr/bin/env bash

gmt begin global_gprv
    gmt basemap -JD105/35/36/42/10c -R70/140/3/60 -Baf
    gmt coast -Gwhite -S167/194/223

    # 提取出所有克拉通、地盾、被动板块边缘的边界数据，并填充颜色，设置30%透明度
    gmt convert global_gprv.gmt -S"prov_type=craton" | gmt plot -G168/171/210 -t30 -l"craton"
    gmt convert global_gprv.gmt -S"prov_type=shield" | gmt plot -G217/205/228 -t30 -l"shield"
    gmt convert global_gprv.gmt -S"prov_type=passive margin" | gmt plot -G196/233/236 -t30 -l"passive margin"

    # 提取出所有和阿尔卑斯-喜马拉雅造山事件相关的地质区域边界数据，并填充红色，设置30%透明度
    gmt convert global_gprv.gmt -S"lastorogen=Alpine-Himalayan" | gmt plot -Gred -t30 -l"Alpine-Himalayan"

    # 提取出南海盆地的边界数据，绘制出黑色轮廓；提取出鄂尔多斯地块的边界数据，绘制出橘黄色轮廓
    gmt convert global_gprv.gmt -S"prov_name=South China Sea Basins" | gmt plot -W1.5p -l"South China Sea Basins"
    gmt convert global_gprv.gmt -S"prov_name=Ordos Block" | gmt plot -W1.5p,orange -l"Ordos Block"
gmt end show