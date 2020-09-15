CN_faults: 中国断层数据
==============================

GMT中文社区提供的中国断层数据覆盖了中国大陆和主要岛屿。
数据引用方式见其官方链接：http://www.earthsciencefrontiers.net.cn/CN/abstract/abstract856.shtml

绘制全国断层：

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN_faults png,pdf
   gmt coast -JM10c -RCN -Baf -W0.5p,black
   gmt plot CN_faults.gmt -W1p,red
   gmt end show

绘制四川省断层：

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN_faults png,pdf
   gmt coast -JM10c -RCN.51 -Baf -W0.5p,black
   gmt plot CN_faults.gmt -W1p,red
   gmt end show

绘制台湾省断层，并显示断层名：

.. gmtplot::
   :show-code: true
   :width: 75%

   gmt begin CN_faults png,pdf
   gmt coast -JM10c -RTW -Baf -W0.5p,black
   # gmt在此处添加中文的断层名称有bug，所以绘制100%透明的一个涂层，并把断层名称输出到文件faultname.dat，而后再绘制
   gmt plot CN_faults.gmt -Sqn1:+Lh+tfaultname.dat -aL=断层名称 -t100
   gmt plot CN_faults.gmt -W1p,red
   gmt text faultname.dat -F+f15p,46,red+a
   rm faultname.dat
   gmt end show