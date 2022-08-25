#!/usr/bin/env bash

gmt begin map
    # 设置绘图时以“度:分:秒”的格式显示坐标
    gmt set FORMAT_GEO_MAP ddd:mm:ss.xF
    # 设置标注、标题格式
    gmt set FONT_ANNOT 5p
    gmt set FONT_TITLE 8p
    gmt set MAP_TITLE_OFFSET 0p
    
    # 指定作图区域为东经118度4分9.1秒到118度12分36秒，北纬24度25分12.6秒到24度33分23秒
    # -Bxa5mf 设置经度标注间隔5分，-Bya4mf 设置纬度标注间隔4分
    gmt basemap -R118:04:09.1/118:12:36.0/24:25:12.6/24:33:23.0 -JM4c -Bxa5mf -Bya4mf -B+t"Amap (GCJ-02 to WGS84)"
    # 加载高德地图
    gmt grdimage amap.tif -Ve
    # 以最高精度绘制 GMT 自带的海岸线数据，并绘制比例尺
    gmt coast -W0.5p -Lg118:11:00/24:27:00+c118:11:00/24:27:00+w2k+u -Df

    # -X5.5c 将绘图原点右移5.5厘米
    gmt basemap -R118:04:09.1/118:12:36.0/24:25:12.6/24:33:23.0 -JM4c -Bxa5mf -Bya4mf -B+t"Amap Satellite (GCJ-02 to WGS84)" -X5.5c
    # 加载高德卫星图
    gmt grdimage amap_sat.tif -Ve
    gmt coast -W0.5p -Df

    # -X-5.5c 将绘图原点左移5.5厘米，-Y-5.5c 将绘图原点下移5.5厘米
    gmt basemap -R118:04:09.1/118:12:36.0/24:25:12.6/24:33:23.0 -JM4c -Bxa5mf -Bya4mf -B+t"Google Maps (GCJ-02 to WGS84)" -X-5.5c -Y-5.5c
    # 加载谷歌地图
    gmt grdimage google.tif -Ve
    gmt coast -W0.5p -Df

    gmt basemap -R118:04:09.1/118:12:36.0/24:25:12.6/24:33:23.0 -JM4c -Bxa5mf -Bya4mf -B+t"Google Satellite WGS84" -X5.5c
    # 加载谷歌卫星图
    gmt grdimage google_sat.tif -Ve
    gmt coast -W0.5p -Df
gmt end show