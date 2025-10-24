#!/usr/bin/env bash
#
#带岛屿的湖泊填充示例
#
DEM_FILE="taihu_highres.nc"    # 高精度数字高程模型（DEM）文件
SHADE_FILE="shade.nc"          # DEM 阴影增强文件（hillshade）
LAKE_FILE="taihu.gmt"          # 太湖湖泊边界的 GMT 格式文件

# 下载高精度 DEM（3 秒分辨率）
# -R 指定太湖区域：经度 119-121, 纬度 30-32
# -G 输出文件
gmt grdcut @earth_relief_03s -R119/121/30/32 -G"$DEM_FILE"

# 生成阴影增强文件
# -A45 指定光源方向 45 度，-Ne0.7 设置高程增强系数
gmt grdgradient "$DEM_FILE" -A45 -Ne0.7 -G"$SHADE_FILE"

# 将 GeoJSON 湖泊边界文件转换为 GMT 格式
ogr2ogr -f "GMT" "$LAKE_FILE" taihu.geojson


# 绘制子图（左图：轮廓，右图：填充）
gmt begin taihu png

    # -Fs6i/6i: 每个子图固定为 6 英寸 x 6 英寸，-A: 自动编号
    # -M0.5i: 子图间距为 0.5 英寸，-R: 坐标区域
    # -JX6i/6i: 投影方式为线性投影，子图长宽比固定
    gmt subplot begin 1x2 -Fs6i/6i -A -M0.5i -R119/121/30/32 -JX6i/6i

        # 左图：绘制湖泊轮廓
        gmt subplot set 0                 
        gmt grdimage "$DEM_FILE" -Cgeo -I"$SHADE_FILE" -Baf
        gmt plot "$LAKE_FILE" -W0.4p,red    # 绘制红色湖泊轮廓线

        # 右图：绘制湖泊填充
        gmt subplot set 1
        gmt grdimage "$DEM_FILE" -Cgeo -I"$SHADE_FILE" -Baf 
        gmt plot "$LAKE_FILE" -Gdeepskyblue  # 填充湖泊为深蓝色

    gmt subplot end  
gmt end show        
