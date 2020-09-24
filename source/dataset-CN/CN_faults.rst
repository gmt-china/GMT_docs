CN_faults: 中国断层数据
=======================

中国断层数据 ``CN_faults.gmt`` 中包含了中国区域的主要断层。

数据下载地址: https://raw.githubusercontent.com/gmt-china/china-geospatial-data/master/CN_faults.gmt

绘制全国断层
------------

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN_faults png,pdf
   gmt coast -JM15c -RCN -Baf -W0.5p,black -A10000
   gmt plot CN_faults.gmt -W1p,red
   gmt end show

绘制区域断层
------------

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN_faults png,pdf
   gmt coast -JM15c -RCN.51 -Baf -W0.5p,black
   gmt plot CN_faults.gmt -W1p,red
   gmt end show

显示断层名
----------

绘制台湾省断层，并显示断层名：

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN_faults png,pdf
   gmt coast -JM10c -RTW -Baf -W0.5p,black
   # gmt在此处添加中文的断层名称有bug，所以先绘制一个100%透明的图层，并把断层名称输出到文件faultname.dat，而后再标注
   gmt plot CN_faults.gmt -Sqn1:+Lh+tfaultname.dat -aL=断层名称 -t100
   gmt plot CN_faults.gmt -W1p,red
   #标注断层名
   gmt text faultname.dat -F+f15p,46,red+a
   rm faultname.dat
   gmt end show

数据来源及引用
--------------

- 中文引用: 邓起东, 张培震, 冉勇康, 杨晓平, 闵伟, 陈立春, 2003. 中国活动构造与地震活动, 地学前缘, 10(S1), 66-73.
- 英文引用: Deng, Q. D., Zhang, P. Z., Ran, Y. K., Yang, X. P., Min, W., Chen, L. C., 2003. Active tectonics and earthquake activities in China. Earth Science Frontiers, 10(S1): 66-73.
