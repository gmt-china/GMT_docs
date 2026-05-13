earth_mask: 地球掩膜数据
========================

.. gmtplot::
    :show-code: false
    :width: 80%
    :caption: 地球掩膜数据

    gmt begin GMT_earthmask png,pdf
    gmt makecpt -Clightblue,burlywood,blue,red,white -T-0.5/4.5/1 -N
    gmt grdimage @earth_mask_05m_p.grd -JQ0/15c -Baf -BWsNe
    gmt legend -DJBC+w15c+o0/0.5c -F+p1p << EOF
    N 5
    S - s 0.5c lightblue 0.25p - Ocean [0]
    S - s 0.5c burlywood 0.25p - Land [1]
    S - s 0.5c blue 0.25p - Lake [2]
    S - s 0.5c red 0.25p - Island [3]
    S - s 0.5c white 0.25p - Pond [4]
    EOF
    gmt end show

数据介绍
--------

地球掩膜数据指明了地表的水陆地理特征。该网格数据的Z值只有5个值。
这5个值从0到4依次指代海洋（ocean）、陆地（land）、湖泊（lake）、
湖中岛（island-in-lake）和岛中湖（pond-in-island-in-lake）。

该数据的主要作用是对网格数据进行掩膜操作，以孤立出仅位于陆地或海洋的
数据。该掩膜数据可以用 **grdlandmask** 模块生成，但对于高分辨率、全精度
GSHHG数据而言，这一过程通常非常耗时。因而GMT官方提供了计算好的掩膜数据
供用户使用。该数据也分不同的分辨率，从15弧秒到1弧度不等。

下表列出了GMT提供的地球掩膜数据 **earth_mask** 的代码、配准方式、分辨率以及文件大小。

==== ========= ========= =========
代码 配准方式  分辨率      大小
==== ========= ========= =========
01d  g,p        1 弧度      20 KB
30m  g,p        30 弧分     24 KB
20m  g,p        20 弧分     30 KB
15m  g,p        15 弧分     35 KB
10m  g,p        10 弧分     57 KB
06m  g,p        6 弧分      106 KB
05m  g,p        5 弧分      117 KB
04m  g,p        4 弧分      149 KB
03m  g,p        3 弧分      209 KB
02m  g,p        2 弧分      393 KB
01m  g,p        1 弧分      998 KB
30s  g,p        30 弧秒     2.6 MB
15s  g,p        15 弧秒     7.5 MB
==== ========= ========= =========

- 代码中 **d**\ 、\ **m**\ 和 **s** 表示弧度、弧分和弧秒
- 配准方式中 **g** 和 **p** 分别表示网格线配准和像素配准

使用方法
--------

当需要使用地球掩膜数据时，可以通过 **@earth_mask_**\ *rru*\[_\ *reg*] 的形式调用。
其中 *rru* 是网格文件的分辨率代码（上表第一列），\ *reg* 是要使用的配准方式代码（上表第二列）。
配准方式代码是可选的，若不指定，则默认返回像素配准的网格数据。
如果命令中使用了 **-R** 选项，则只会读取该区域内的掩膜数据。

查看30弧分的地球掩膜数据的信息::

    gmt grdinfo @earth_mask_30m

如果用户希望仅仅获得海洋或者水陆的掩膜，需要使用 **grdmath** 模块对掩膜数据进行调整。
下面给出一些例子。

利用 **grdmath** 将掩膜数据 **earth_mask_01m_g** 中大于（GT）0 的为 1, 其余为 0。
这就意味着海洋部分改为0，其余均为1::

    gmt grdmath @earth_mask_01m_g 0 GT = ocean_land.grd

生成一个像素配准的掩膜数据，其陆地上为NaN，海洋中为1，可以用::

    gmt grdmath @earth_mask_01m_p 0 LE 0 NAN = land_NaN.grd

生成一个像素配准的掩膜数据，其湖泊中值为1，其余地方均为NaN::

    gmt grdmath @earth_mask_01m 2 EQ 0 NAN = lakes_and_NaN.grd

技术细节
--------

-   数据会自动下载并保存到 **~/.gmt/server/earth/earth_mask** 目录下
