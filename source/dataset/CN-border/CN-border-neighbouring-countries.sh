gmt begin CN-border-neighbouring-countries
    gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2
    gmt coast -JD105/35/36/42/10c -R70/140/3/60 -G244/243/239 -S167/194/223 -Ba10f5g10 -Lg85/11+c11+w900k+f+u

    # 使用 clip 命令和 CN-border-L1.gmt 数据将中国区域裁剪出来
    gmt clip CN-border-L1.gmt -N
        # 绘制中国邻国国界，AF 至 VN 是中国的 14 个邻国的国界代码
        gmt coast -EAF,BT,IN,KZ,KG,LA,MN,MM,NP,KP,PK,RU,TJ,VN+p0.1p
    gmt clip -C

    # 绘制中国国界
    gmt plot CN-border-La.gmt -W0.1p
gmt end show