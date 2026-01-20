gmt begin grdshake-example
    gmt basemap -R95/110/20/35 -JM10c -Baf
    # global_vs30.grd是USGS计算好的全球Vs30速度模型网格文件
    # 具体可以参考 https://earthquake.usgs.gov/data/vs30/ 自行下载，并获取更多信息
    gmt grdcut global_vs30.grd -R95/110/20/35 -Gvs30.grd
    # 提取红河断裂的数据，保存在line.dat文件中
    gmt convert CN-faults.gmt -S"FN_Ch=红河断裂" -o0,1 > line.dat
    # 计算地表峰值烈度
    gmt grdshake vs30.grd -Gintensity.grd -Lline.dat -Ci -M9
    # 绘制地表峰值烈度
    gmt grd2cpt -Cseis -I -Z -D intensity.grd
    gmt grdimage intensity.grd -C
    gmt colorbar -C -Ba1+lintensity
    # 绘制省界，断层
    gmt plot CN-border-La.gmt -W0.5p
    gmt plot CN-faults.gmt -W1p,gray
    gmt plot line.dat -W4p,white

    rm vs30.grd line.dat intensity.grd
gmt end show