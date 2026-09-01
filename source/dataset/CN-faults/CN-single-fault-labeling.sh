gmt begin CN-single-fault-labeling
    gmt basemap -R98/105/22/27 -JM15c -Ba
    # -Sqn1/3c 只能在长度大于3厘米的断层上进行标注，避免断层名标注数量过多过密
    # +n0/0.5c 偏移标注文字的位置，向断层法方向偏移0.5厘米
    gmt convert CN-faults.gmt -S"FN_Ch=红河断裂" -aL="FN_En" | gmt plot -Sqn1/3c:+Lh+f16p+n0/0.5c
    # 作为对比，右图是不进行任何调整的作图效果
    gmt convert CN-faults.gmt -S"FN_Ch=红河断裂" -aL="FN_En" | gmt plot -Sqn1:+Lh+f16p -X16.2c -Ba
gmt end
