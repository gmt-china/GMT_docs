CN-faults: 中国断层数据
=======================

:贡献者: |刘珠妹|, |田冬冬|, |陈箫翰|

----

CN-faults 数据来自于邓起东院士编制的《中国活动构造图（1:400 万）》，
由\ `国家地震科学数据中心 <http://datashare.igl.earthquake.cn/datashare>`__\ 提供原始数据。
数据包含了中国区域内主要断层的地理位置以及断层属性，
如断层名称、长度、走向、倾向、倾角、断层性质、最晚活动年代等。

数据文件
--------

CN-faults 提供了一个数据文件 :file:`CN-faults.gmt`：中国区域主要断层

具体的下载地址和使用方式请见：:doc:`/dataset-CN/index`。

示例图
------

绘制全国断层
++++++++++++

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt begin CN-faults png,pdf
        gmt coast -JM15c -RCN -Baf -W0.5p,black -A10000
        gmt plot CN-faults.gmt -W1p,red
    gmt end show

绘制区域断层
++++++++++++

.. gmtplot::
   :show-code: true
   :width: 50%

    gmt begin CN-regional-faults png,pdf
        gmt basemap -JM15c -R95/105/25/35 -Baf
        gmt plot CN-faults.gmt -W1p,red
    gmt end show

标注断层名
++++++++++

可以使用 :doc:`/module/plot` 模块的 **-Sq** 选项标注断层名。

.. note::

   由于中文手册服务器上未设置 GMT 中文支持，故而下图中断层名显示乱码。
   对于用户而言，若已经正确设置 GMT 中文支持，则应可正常显示中文。

.. gmtplot::
   :show-code: true
   :width: 50%

    gmt begin CN-faults-labeling png,pdf
        gmt coast -JM10c -RTW -Baf -W0.5p,black
        # -aL="断层名称": set the "L" value (i.e., label) in segment headers using "断层名称"
        # :+Lh: take the label text from the "L" value in the segment header
        gmt convert CN-faults.gmt -aL="断层名称" | gmt plot -Sqn1:+Lh+f11p,39
    gmt end show

根据属性信息提取数据
++++++++++++++++++++

可以使用 **convert** 模块的 **-S** 选项提取指定属性的数据。
例如，下例中提取出“断层名称”为“红河断裂”的断层数据。

.. gmtplot::
   :show-code: true
   :width: 50%

    gmt begin CN-single-fault png
        gmt basemap -R98/105/22/27 -JM15c -Ba
        # -S: output record contains specified field attribute
        gmt convert CN-faults.gmt -S"断层名称=红河断裂" | gmt plot
    gmt end show

根据空间范围提取数据
++++++++++++++++++++++

:doc:`/module/gmtselect` 模块，可实现矩形范围、缓冲区范围和多边形范围内空间数据的提取。
此处仅以缓冲区范围为例。

.. gmtplot::
   :show-code: true
   :width: 50%

    gmt begin CN-buffer-fault png,pdf
        gmt basemap -R109/113/34/37 -JM15c -Ba
        # draw a circle with a radius of 100 km
        echo 111 35.5 200k | gmt plot -SE- -Wblue -fg
        # extract faults within the circle
        gmt select CN-faults.gmt -C111/35.5+d100k -fg | gmt plot
    gmt end show

数据来源与处理
--------------

1.  下载 :file:`Active_fault.zip` 压缩包：`中国大陆地区 1:400 万活动断层数据库
    <http://datashare.igl.earthquake.cn/map/ActiveFault/introFault.html>`__

2.  格式转换

    使用 GDAL 的 :ref:`ogr2ogr <ogr2ogr>` 命令
    将 Shapefile 格式转换为 GMT 可识别的 OGR/GMT 格式::

        ogr2ogr -f GMT CN-faults.gmt 中国断层_邓起东Line_Project.shp

    若不关注属性信息，也可以直接使用 GMT 读取 Shapefile 格式的源数据进行绘图。

社区提供的 :file:`CN-faults.gmt` 文件还参考了《最新 1/400 万中国活动构造空间数据库的建立》，
对部分属性字段名称的缺失和错误进行了修正。

数据引用
--------

- 邓起东. 2007.
  中国活动构造图 (1:400 万).
  地震出版社.
- 屈春燕. 2008.
  最新 1/400 万中国活动构造空间数据库的建立.
  地震地质, 30(1):298-304.
  http://dx.chinadoi.cn/10.3969/j.issn.0253-4967.2008.01.022
- Deng, Q. D., Zhang, P. Z., Ran, Y. K., Yang, X. P., Min, W., Chen, L. C., 2003.
  Active tectonics and earthquake activities in China.
  Earth Science Frontiers, 10(S1): 66-73.
  https://en.cnki.com.cn/Article_en/CJFDTotal-DXQY2003S1011.htm.
