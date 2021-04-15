earth_relief: 全球地形起伏数据
==============================

.. gmtplot::
   :show-code: false
   :width: 75%

   gmt grdimage @earth_relief_20m -png,pdf earth_relief

数据简介
--------

**earth_relief** 数据是GMT提供的全球地形起伏数据，其包含了全球陆地和洋底的高程数据。
原始数据来源于公开数据，GMT经过了一些预处理，提供了不同分辨率和不同配准方式的网格数据，
以满足用户的不同需求。\ **earth_relief** 数据默认使用GMT内置的 *geo* CPT文件。

下表列出了GMT提供的 **earth_relief** 数据的代码、配准方式、分辨率以及文件大小。

======= ========= ========= ========
代码    配准方式  分辨率     大小
======= ========= ========= ========
01d     g,p       1 弧度     112 KB
30m     g,p       30 弧分    377 KB
20m     g,p       20 弧分    783 KB
15m     g,p       15 弧分    1.4 MB
10m     g,p       10 弧分    2.9 MB
06m     g,p       6 弧分     7.5 MB
05m     g,p       5 弧分     11 MB
04m     g,p       4 弧分     16 MB
03m     g,p       3 弧分     28 MB
02m     g,p       2 弧分     58 MB
01m     g,p       1 弧分     214 MB
30s     g,p       30 弧秒    778 MB
15s     p         15 弧秒    2.6 GB
03s     g         3 弧秒     6.8 GB
01s     g         1 弧秒     41 GB
======= ========= ========= ========

- 代码中 **d**\ 、\ **m**\ 和 **s** 表示弧度、弧分和弧秒
- 配准方式中 **g** 和 **p** 分别表示网格线配准和像素配准

.. warning::

    如果没有正确安装GDAL的话，使用高精度的数据会报错。低精度的数据是直接以netCDF格式保存，
    而高精度的地形数据是以jp2格式保存，下载下来之后需要通过GDAL转换成netCDF格式。
    如果系统里安装的GDAL不支持jp2格式，就会导致jp2数据可以下载，但是转换netCDF格式的时候出错。
    出现这种报错的情况，请卸载GDAL，再按照本手册给出的步骤正确安装符合要求的GDAL。

使用方法
--------

当需要使用地形数据时，可以直接通过 **@earth_relief_**\ *rru*\[_\ *reg*] 的形式调用这些
地形起伏数据，其中 *rru* 是网格文件的分辨率代码（上表第一列），\ *reg* 是要使用的
配准方式代码（上表第二列）。配准方式代码是可选的，若不指定，则默认返回像素配准的
网格数据（若不存在，则返回网格线配准的数据）。如果命令中使用了 **-R** 选项，
则只会读取该区域内的地形起伏数据。例如：

查看1弧度分辨率（像素配准）的地形数据的信息::

    gmt grdinfo @earth_relief_01d

查看30弧分分辨率、网格线配准的地形数据的信息::

    gmt grdinfo @earth_relief_30m_g

使用15弧分地形起伏数据绘制全球地形图::

    gmt grdimage -JH15c @earth_relief_15m -pdf map

使用2弧分地形起伏数据绘制一个区域的地形图::

    gmt grdimage -JH15c -R90/120/20/60 @earth_relief_02m -pdf map

技术细节
--------

-   数据会自动下载并保存到 **~/.gmt/server/earth/earth_relief** 目录下
-   15弧秒的数据来源于 SRTM15+ [http://dx.doi.org/10.1029/2019EA000658]
-   30弧秒及更低分辨率的全球地形数据均是SRTM15+ 的衍生产品。
    GMT利用笛卡尔高斯滤波对其进行重采样以防止混叠现象，并保留了原始15弧秒数据的
    纬度依赖的分辨率信息。
    可以使用 :doc:`/module/grdinfo` 查看生成网格文件所使用的滤波命令。
-   3弧秒和1弧秒的数据来自于NASA提供的SRTM数据。数据被划为为1度x1度的区块。
    在使用时，GMT会根据 **-R** 选项指定的区域范围只下载区域内的地形数据。
-   原始的SRTM3和SRTM1数据只在北纬60度到南纬60度的陆地上有数据。
    当使用 **@earth_relief_01s** 或 **@earth_relief_03s** 时，GMT会自动对
    **@earth_relief_15s** 数据对增采样以填充缺失的海洋部分。
-   如果想使用最原始的只包含陆地的SRTM地形数据，则可以使用 **@srtm_relief_03s**
    或 **srtm_relief_01s**\ 。
-   大部分分辨率的数据都提供了网格线配准和像素配准两种方式的文件。

数据来源及引用
--------------

#. SRTM15+ [http://dx.doi.org/10.1029/2019EA000658]
#. SRTMGL3数据: https://lpdaac.usgs.gov/products/srtmgl3v003/
#. SRTMGL1数据: https://lpdaac.usgs.gov/products/srtmgl1v003/

其它地形起伏数据
----------------

其它机构或单位也提供了不同格式、不同分辨率的地形起伏数据。此处仅列出部分，
供需要的用户参考与使用：

- ETOPO1 (1弧分): https://www.ngdc.noaa.gov/mgg/global/
- GEBCO (30弧秒): https://www.gebco.net/
- SRTM30+ (30弧秒): https://topex.ucsd.edu/WWW_html/srtm30_plus.html
- SRTM3 (3弧秒，仅陆地): http://srtm.csi.cgiar.org
- ASTER GDEM (1弧秒，仅陆地): https://asterweb.jpl.nasa.gov/gdem.asp
