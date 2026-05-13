-Jo：倾斜Mercator投影
=====================

维基链接：https://en.wikipedia.org/wiki/Space-oblique_Mercator_projection

倾斜Mercator投影常用于绘制沿着倾斜方向横向范围较大的地图，其经线和纬线都是复杂曲线。

其有多种定义方式::

    -JO[a|A]<lon>/<lat>/<azi>/<width>
    -Jo[a|A]<lon>/<lat>/<azi>/<scale>

    -JO[b|B]<lon>/<lat>/<lon2>/<lat2>/<width>
    -Jo[b|B]<lon>/<lat>/<lon2>/<lat2>/<scale>

    -JO[c|C]<lon>/<lat>/<lonp>/<latp>/<width>
    -Jo[c|C]<lon>/<lat>/<lonp>/<latp>/<scale>

- ``<lon>/<lat>`` 投影中心的经纬度
- ``<azi>`` 倾斜赤道的方位角
- ``<lon2>/<lat2>`` 倾斜赤道另一个点的经纬度
- ``<lonp>/<latp>`` 投影极点的经纬度

在三种定义中， 大写的 ``A|B|C`` 表示允许投影极点位于南半球。

.. gmtplot::
    :caption: 使用 ``-Joc`` 倾斜Mercator投影

    gmt pscoast -R270/20/305/25r -JOc280/25.5/22/69/4.8i -Bag -Di -A250 -Gburlywood \
                -Wthinnest -P -TdjTR+w0.4i+f2+l+o0.15i -Sazure --FONT_TITLE=8p \
                --MAP_TITLE_OFFSET=0.05i > GMT_obl_merc.ps

在使用倾斜投影时，直接指定整个区域相对地图中心的相对投影坐标更为方便，
下面的示例中使用了 ``-Rk-1000/1000/-500/500`` 来指定相对投影坐标。

.. gmtplot:: /scripts/GMT_obl_nz.sh
   :show-code: false

   使用 ``-JOa`` 倾斜Mercator投影

   (左) ``-JOa173:17:02E/41:16:15S/35/3i``
   (右) ``-JOA173:17:02E/41:16:15S/215/3i``
