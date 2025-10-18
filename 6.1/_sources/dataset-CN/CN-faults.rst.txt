CN-faults: 中国断层数据
=======================

中国断层数据 :file:`CN-faults.gmt` 包含了中国区域的主要断层，
具体的下载地址和使用方式请见：\ :doc:`/dataset-CN/index`\ 。

绘制全国断层
------------

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN-faults png,pdf
   gmt coast -JM15c -RCN -Baf -W0.5p,black -A10000
   gmt plot CN-faults.gmt -W1p,red
   gmt end show

绘制区域断层
------------

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN-faults png,pdf
   gmt coast -JM15c -RCN.51 -Baf -W0.5p,black
   gmt plot CN-faults.gmt -W1p,red
   gmt end show

标注断层名
----------

对于英文断层名，GMT中可以直接使用 :doc:`/module/plot` 模块的 **-Sq** 选项标注断层名。
**-Sq** 选项功能强大，可以灵活地设置断层名的位置、字体等属性。

对于中文断层名，由于 **plot -Sq** 目前存在BUG，导致即便在正确设置中文字体的情况下，
依然无法显示中文断层名。因而下面的示例中，使用 **plot -Sq** 绘制了一个全透明的图层，
同时将断层名文本输出到文件faultname.dat中，并使用 **plot** 和 **text** 模块分别
绘制断层线和标注断层名。

.. note::

   由于中文手册服务器上未设置GMT中文支持，故而下图中断层名显示乱码。
   对于用户而言，若已经正确设置GMT中文支持，则应可正常显示中文。

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN-faults png,pdf
   gmt coast -JM10c -RTW -Baf -W0.5p,black
   # 由于 -Sq 无法支持中文，该命令将断层名称输出到文件faultname.dat中，并绘制了一个全透明的图层
   # 实际上，当执行脚本获得faultname.dat 后，可将该命令注释掉
   gmt plot CN-faults.gmt -Sqn1:+Lh+tfaultname.dat -aL=断层名称 -t100
   # 使用 plot 绘制断层
   gmt plot CN-faults.gmt -W1p,red
   # 标注断层名
   gmt text faultname.dat -F+f15p,46,red+a
   rm faultname.dat
   gmt end show

数据来源及引用
--------------

- 中文引用: 邓起东, 张培震, 冉勇康, 杨晓平, 闵伟, 陈立春, 2003. 中国活动构造与地震活动, 地学前缘, 10(S1), 66-73.
- 英文引用: Deng, Q. D., Zhang, P. Z., Ran, Y. K., Yang, X. P., Min, W., Chen, L. C., 2003. Active tectonics and earthquake activities in China. Earth Science Frontiers, 10(S1): 66-73.
