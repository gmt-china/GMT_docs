gmt begin Custom_Symbol_Stress
    gmt basemap -JX10c/10c -R-5/5/-5/5 -Ba
    # 应力解除
    echo -3 3 0 | gmt plot -Skstress_relief/2 -W1p
    # 水压致裂
    echo 3 3 0 | gmt plot -Skhydra_fract/2 -W1p
    # 钻孔崩落
    echo -3 0 0 | gmt plot -Skborehole_collapse/2 -W1p
    # 断层滑动
    echo 0 0 0 | gmt plot -Skfault_slip/2 -W1p
    # 震源机制
    echo 3 0 0 | gmt plot -Skfocal_mec/2 -W1p
    # 钻孔槽(BS)
    echo -3 -3 0 | gmt plot -SkBS/2 -W1p
    # 钻孔诱发张裂隙(DIF)
    echo 3 -3 0 | gmt plot -SkDIF/2 -W1p
gmt end show