-JO: Oblique Mercator
=====================

维基链接：https://en.wikipedia.org/wiki/Space-oblique_Mercator_projection

Oblique Mercator（倾斜 Mercator 投影）常用于绘制沿着倾斜方向横向范围较大的地图，其经线和纬线都是复杂曲线。

其有多种定义方式：

- **-JO**\ [**a**\|\ **A**]\ *lon*/*lat*/*azi*/*width*
- **-Jo**\ [**a**\|\ **A**]\ *lon*/*lat*/*azi*/*scale*
- **-JO**\ [**b**\|\ **B**]\ *lon*/*lat*/*lon2*/*lat2*/*width*
- **-Jo**\ [**b**\|\ **B**]\ *lon*/*lat*/*lon2*/*lat2*/*scale*
- **-JO**\ [**c**\|\ **C**]\ *lon*/*lat*/*lonp*/*latp*/*width*
- **-Jo**\ [**c**\|\ **C**]\ *lon*/*lat*/*lonp*/*latp*/*scale*

- *lon*/*lat* 投影中心的经纬度
- *azi* 倾斜赤道的方位角
- *lon2*/*lat2* 倾斜赤道上另一个点的经纬度
- *lonp*/*latp* 投影极点的经纬度

在三种定义中，大写的 **A**\|\ **B**\|\ **C** 表示允许投影极点位于南半球。

.. gmtplot::
    :caption: 使用 **-Joc** 倾斜 Mercator 投影
    :width: 80%

    gmt coast -R270/20/305/25+r -JOc280/25.5/22/69/12c -Bag -Di -A250 -Gburlywood -Wthinnest \
        -TdjTR+w1c+f2+l+o0.4c -Sazure --FONT_TITLE=8p --MAP_TITLE_OFFSET=4p -png GMT_obl_merc

在使用倾斜投影时，直接指定整个区域相对地图中心的相对投影坐标更为方便，
下面的示例中使用了 **-R-1000/1000/-500/500+uk** 来指定相对投影坐标。
这里 **k** 表示km。GMT 将自动确定对角顶点的地理坐标。

.. gmtplot:: GMT_obl_nz.sh
   :show-code: false
   :width: 85%

   使用 **-JOa** 倾斜 Mercator 投影

上图中，左图使用了 **-JOa173:17:02E/41:16:15S/35/3i**。图的尺寸为 2000 km X 1000 km。
图中黑色轴表示投影后的笛卡尔坐标系。图中蓝点的地理坐标为 40S,180E，投影后坐标为
(426.2, -399.7)。右图使用了 **-JOA173:17:02E/41:16:15S/215/3i**。与左图相比，
其它参数相同，但方位角为 215°，生成了一个投影极点位于南半球的地图（因而这里使用
**-JOA** 来覆盖这一限制）。投影后的坐标系依然像左图那样，但整个地球旋转了 180°。
蓝色点投影后的坐标为 (-426.2,399.7)。

倾斜 Mercator 投影默认使得倾斜的赤道成为新的 X 轴。若想要使倾斜赤道变为垂直方向，
即成为新的 Y 轴，可以在投影参数后加上 **+v** 选项。
需要注意的是，如果在指定绘图区域 **-R** 时没有使用子选项 **+r**，则 **-R** 后的
参数会被认为是相对于投影中心的倾斜角度，而非经纬度范围。

.. gmtplot::
    :caption: 使用 **-Joc** 倾斜 Mercator 投影
    :width: 25%

    gmt begin GMT_obl_baja png,pdf
    gmt set MAP_ANNOT_OBLIQUE lon_horizontal,lat_horizontal,tick_extend
    gmt coast -R122W/35N/107W/22N+r -JOa120W/25N/-30/6c+v -Gsienna -Ba5g5 -B+f \
        -N1/1p -EUS+gburlywood -Smintcream -TdjBL+w0.5i+l
    gmt end
