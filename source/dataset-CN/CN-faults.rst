CN-faults: 中国断层数据
=======================

CN-faults 数据来自邓起东院士的中国活动构造图(1:400万)，由 `国家地震科学数据中心——地震地质与地震动力学数据共享分中心 <http://datashare.igl.earthquake.cn/datashare>`__ 提供，包含了中国区域内主要断层的地理位置、断层名称、长度、走向、倾向、倾角、断层性质、最晚活动年代等信息。

数据文件
--------

CN-faults 提供了一个数据文件 :file:`CN-faults.gmt`\ ：中国区域主要断层

具体的下载地址和使用方式请见：\ :doc:`/dataset-CN/index`\ 。

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

GMT中可以直接使用 :doc:`/module/plot` 模块的 **-Sq** 选项标注断层名。

.. note::

   由于中文手册服务器上未设置GMT中文支持，故而下图中断层名显示乱码。
   对于用户而言，若已经正确设置GMT中文支持，则应可正常显示中文。

.. gmtplot::
   :show-code: true
   :width: 50%

    gmt begin CN-faults-labeling png,pdf
        gmt coast -JM10c -RTW -Baf -W0.5p,black
        # convert命令的-aL选项提取源文件中"断层名称"字段作为头记录的-L标签
        # plot命令-Sq的+Lh子选项从当前段头中获取该标签值，作为该线段的文字标注
        gmt convert CN-faults.gmt -aL="断层名称" | gmt plot -Sqn1:+Lh+f11,STHeiti-Regular--GB-EUC-H
    gmt end show

根据属性信息提取数据
++++++++++++++++++++++

.. gmtplot::
   :show-code: true
   :width: 50%
   
    gmt begin CN-single-fault png
        # convert -S根据属性筛选某一条/类断层数据 
        gmt convert CN-faults.gmt -S"断层名称=阿巴宫断裂"  -aL="断层名称" | gmt plot -R87/90/46/49 -Ba -Sqn1:+Lh+f11,STHeiti-Regular--GB-EUC-H 
    gmt end show

根据空间范围提取数据
++++++++++++++++++++++

.. note::

    :doc:`/module/gmtselect`模块，可实现矩形范围、缓冲区范围和多边形范围内空间数据的提取。此处仅举其中一个例子。

.. gmtplot::
   :show-code: true
   :width: 50%
   
    gmt begin CN-buffer-fault png
        # 圆心
        echo 111 35.5 >center
        # 半径100km的圆域
        echo 111 35.5 200k| gmt plot -R109/113/34/37 -JM15c -SE- -Wblue -fg
        # 筛选半径为100km内的断层
        gmt select CN-faults.gmt -Ccenter+d100k -fg -aL="断层名称" | gmt plot -Ba -Sqd3c:+Lh+f11,STHeiti-Regular--GB-EUC-H
        rm center
    gmt end show

数据来源及处理
--------------
1.  从 `中国大陆1：400万活动断层数据库 <http://datashare.igl.earthquake.cn/map/ActiveFault/introFault.html>`__ 下载 ``Active_fault.zip`` 压缩包

2. 使用 :doc:`ogr2ogr </table/ogr2ogr>` 将 Shapefile 格式转换为 GMT 可识别的 OGR/GMT 格式（若不关注属性信息，GMT也可以直接读取Shapefile格式源数据绘图）::

    ogr2ogr -f GMT CN-faults.gmt 中国断层_邓起东Line_Project.shp --config SHAPE_ENCODING "UTF-8"

社区最终提供的:file:`CN-faults.gmt`\参考了《最新1/400万中国活动构造空间数据库的建立》（屈春燕，2008）对属性字段名称的缺失和错误部分进行了订正。

数据引用
--------

- 中文引用1:: 邓起东. 中国活动构造图(1:400万)(附光盘)[M]. 地震出版社, 2007.
- 中文引用2:: 屈春燕. 最新1/400万中国活动构造空间数据库的建立[J]. 地震地质, 2008, 30(1):298-304.
- 英文引用:: Deng, Q. D., Zhang, P. Z., Ran, Y. K., Yang, X. P., Min, W., Chen, L. C., 2003. Active tectonics and earthquake activities in China. Earth Science Frontiers, 10(S1): 66-73.