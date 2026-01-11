.. index:: ! grdproject

grdproject
==========

:官方文档: :doc:`gmt:grdproject`
:简介: 对网格数据做地图变换和逆变换

该命令可以将地理坐标下的网格数据投影到一个矩形网格中，也可以将一个矩形坐标系下的
网格数据反投影到地理坐标下。

必选选项
--------

``<in_grdfile>``
    要进行变换的2D网格数据

``-G<out_grdfile>``
    输出的网格文件名

可选选项
--------

``-C[<dx>/<dy>]``
    默认投影后的坐标是相对于区域的左下角，该选项使得投影后的坐标相对于投影的中心。
    ``<dx>/<dy>`` 是要加到投影后坐标的偏移量。

``-D<xinc>[<unit>][+e|n][/<yinc>[<unit>][+e|n]]``
    指定新网格的网格间隔。

``-E<dpi>``
    设置新网格的分辨率，即每英寸的点数。

``-F[c|i|p|e|f|k|M|n|u]``
    强制1:1比例，即输出数据的单位是真实的投影长度，默认单位为m。也可以指定为
    其他单位。

``-I``
    逆变换，将矩形区域变换成地理区域。

``-Mc|i|p``
    指定投影后的测量单位，默认值由参数 ``PROJ_LENGTH_UNIT`` 决定。

示例
----

将地理网格数据变换成Mercator网格，分辨率为300dpi::

    gmt grdproject dbdb5.nc -R20/50/12/25 -Jm0.25i -E300 -r -Gdbdb5_merc.nc

将网格数据逆变换为地理网格::

    gmt grdproject topo_tm.nc -R-80/-70/20/40 -Jt-75/1:500000 -I -D5m -V -Gtopo.nc

将UTM（以米为单位）下的网格数据逆变换为地理网格::

    gmt grdproject topo_utm.nc -R203/205/60/65 -Ju5/1:1 -I -Mm -Gtopo.nc -V
