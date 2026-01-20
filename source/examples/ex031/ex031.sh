#!/usr/bin/env bash
#
# 绘制三维速度模型的任意垂直切片

# 下载示例模型文件
# wget "https://ds.iris.edu/files/products/emc/emc-files/S362ANI_percent.nc"

gmt begin 3d_vert_slice
    # 构建底图
    gmt basemap -Rg -JQ10c -Baf
    # 绘制地形
    gmt grdimage @earth_relief_05m_g

    # 创建测线，点距为1度
    D1=0
    D2=180
    dD=1
    gmt project -C110/20 -A90 -L$D1/$D2 -G$dD > prof
    # 绘制测线
    gmt plot prof -W1.5p,red

    # 定义沿深度方向的插值
    T1=25
    T2=2890
    dT=10
    T="-T$T1/$T2/$dT"

    # 计算该测线下的垂直切片
    gmt grdinterpolate S362ANI_percent.nc?dvs -Sprof $T > samp
    # 在 GMT 6.5 以及更低版本中，grdinterpolate -S 和 -T 同时使用存在 bug。
    # 以上命令可暂时替换为下方命令来回避此 bug
    # gmt grdinterpolate S362ANI_percent.nc?dvs -Sprof | gmt sample1d $T -N2 > samp

    # 将表数据转为网格文件
    gmt xyz2grd samp -Gvs_slice.nc -i3,2,4 -R$D1/$D2/$T1/$T2 -I$dD+e/$dT+e

    # 创建色标
    gmt makecpt -Cseis -D -T-2/2

    # 构建底图，横坐标的距离为角度，故可使用极坐标投影
    gmt basemap -Rvs_slice.nc -JP10c+fp+a+t90 -Baf -Y-7c
    # 绘制切片
    gmt grdimage vs_slice.nc
    # 绘制色标棒
    gmt colorbar -Bxa1+l"dVs (%)"

gmt end show