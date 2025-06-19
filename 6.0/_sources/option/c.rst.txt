-c 选项
=======

**-c** 选项用于控制绘图命令在哪一个子图中进行绘制，该选项仅可在
:doc:`子图模式 </module/subplot>` 下才能使用。所有绘图模块均可以使用该选项。
该选项使得当前及之后的一系列绘图命令均在指定的子图中绘制，直到某个绘图命令再次
使用该选项为止。

**-c** 选项的语法为：

    **-c**\ [*row*\ ,\ *col* \|\ *index*]

其主要有三种用法:

- 使用 **-c** 则GMT会自动激活“下一个”子图面板
- **-c**\ *row*,\ *col* 表示当前及接下来的绘图命令在第 *row* 行、第 *col* 列子图中绘制
- **-c**\ *index* 当前及接下来的绘图命名在第 *index* 个子图内进行

需要注意，\ *row*\ 、\ *col*\ 、\ *index* 均从0开始起算。

以下示例展示了该选项的基本用法，其等效于在绘图命令前使用 **gmt subplot set** 命令。

.. gmtplot::

   gmt begin subplot pdf,png
   gmt set FONT_TAG 15p,1

   gmt subplot begin 2x2 -Fs5c/3c -A'(a)'+JTL+o0.2c/0.4c -M0.5c/0.2c -R0/5/0/5
   gmt basemap -Ba -BWSen -c

   gmt basemap -Ba -BWSen -c

   gmt basemap -Ba -BWSen -c
   # 下面的命令未使用 -c 选项，但依然在2行1列子图中绘制
   echo 2 2 | gmt plot -Sc0.5c -Gred -W1p

   gmt basemap -Ba -BWSen -c

   gmt subplot end
   gmt end

关于子图模式的更多细节，见 :doc:`子图模式 </module/subplot>` 一节。
