-c 选项
=======

该选项用于控制绘图命令在哪一个子图中进行绘制，该选项仅可在
:ref:`子图模式 <subplot-mode>` 下才能使用。所有绘图模块均可以使用该选项。
该选项使得当前及之后的一系列绘图命令均在指定的子图中绘制，直到某个绘图命令再次
使用该选项为止。

其语法为::

    -c<row>,<col>

表示当前及接下来的绘图命令在第 ``<row>`` 行、第 ``<col>`` 列子图中绘制。

以下示例展示了该选项的基本用法，其等效于在绘图命令前使用 ``subplot set`` 命令。

.. gmt-plot::

   #!/bin/bash
   R=0/5/0/3

   gmt begin subplot pdf,png
   gmt set FONT_TAG 15p,1

   gmt subplot begin 2x2 -Fs5c/3c -A'(a)'+JTL+o0.2c/0.4c -M0.5c/0.2c
   gmt basemap -R$R -Ba -BWSen -c1,1

   gmt basemap -R$R -Ba -BWSen -c1,2

   gmt basemap -R$R -Ba -BWSen -c2,1
   # 下面的命令未使用 -c 选项，但依然在2行1列子图中绘制
   echo 2 2 | gmt plot -Sc0.5c -Gred -W1p

   gmt basemap -R$R -Ba -BWSen -c2,2

   gmt subplot end
   gmt end
