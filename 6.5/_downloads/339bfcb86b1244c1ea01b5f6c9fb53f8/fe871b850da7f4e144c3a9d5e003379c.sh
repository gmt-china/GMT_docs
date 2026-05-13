gmt begin arrows
# 笛卡尔矢量
echo 0.5 1.5 4.5 1.5 | gmt plot -R0/5/0/5 -JX1.75i -Sv0.2i+s+b+e -W1.5p -Gred
# 地理矢量
echo 10 -35 90 8000 | gmt plot -R0/90/-41.17/41.17 -JM1.75i -S=0.2i+b+e -W1.5p -Gred -X2i
# 弧形矢量
echo 0.5 0.5 0.9i 0 90 | gmt plot -R0/5/0/5 -JX1.75i -Sm0.2i+b+e -W1.5p -Gred -X2i
gmt end show