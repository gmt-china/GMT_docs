# 从 ISC 官网下载 ISF 格式的地震目录
# wget https://download.isc.ac.uk/isf/catalogue/2020/202001.gz
# gzip -dkN 202001.gz

# 在网页服务器上存在路径查找问题，用户在本机运行时可以直接使用 gmt isf 202001.isf 进行绘图
isf_file=$(gmt which 202001.isf)

gmt begin testisf
    gmt grdimage @earth_relief_30m -Rd -JQ12c -B60f30g30
    # 限制空间范围、时间范围
    gmt isf $isf_file -R-60/60/-80/80 -D2020-01-01/2020-01-15 > seismicity.dat
    gmt plot seismicity.dat -Sc0.1c -Gpink -W0.1p
gmt end show