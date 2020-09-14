CN_faults: 中国断层数据
==============================


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
   gmt plot CN_faults.gmt -Sqn1:+Lh+tfaultname.dat -aL=断层名称 -t100
   gmt plot CN_faults.gmt -W1p,red
   gmt text faultname.dat -F+f15p,46,red+a
   rm faultname.dat
   gmt end show