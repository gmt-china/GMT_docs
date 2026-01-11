:author: 田冬冬, 陈箫翰
:date: 2026-01-11

.. index:: ! rose
.. program:: rose

rose
====

:官方文档: :doc:`gmt:rose`
:简介: 绘制极坐标直方图（玫瑰图、扇形图、风向玫瑰图）

**rose** 从输入数据中读取 (长度, 方位角) 格式的数据，并绘制风向玫瑰图。如果输入数据仅包含方位角数值，需要使用 :option:`-i`\ 0。
如果使用 :option:`-A` 选项可以绘制极坐标直方图（扇形图或玫瑰图）。可以选择全圆和半圆绘图。风向玫瑰图的轮廓颜色与 :term:`MAP_DEFAULT_PEN` 相同。

语法
---------

**gmt rose**
[ *table* ]
[ :option:`-A`\ *sector_width*\ [**+r**] ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *cpt* ]
[ :option:`-D` ]
[ :option:`-E`\ **m**\|\ [**+w**]\ *mode_file* ]
[ :option:`-F` ]
[ :option:`-G`\ *fill* ]
[ :option:`-I` ]
[ :option:`-J`\ **X**\ *diameter* ]
[ :option:`-L`\ [*wlabel*\ ,\ *elabel*\ ,\ *slabel*\ ,\ *nlabel*] ]
[ :option:`-M`\ *parameters* ]
[ :option:`-N`\ *mode*\ [**+p**\ *pen*] ]
[ :option:`-Q`\ *alpha* ]
[ :option:`-R`\ *r0*/*r1*/*az0*/*az1* ]
[ :option:`-S`\ [**+a**] ]
[ :option:`-T` ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [**v**]\ *pen* ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-Z`\ **u**\|\ *scale* ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-w`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

*table*
    输入文件，数据格式为::

        length  azimuth

    此时绘制的是风向玫瑰图。若输入文件中只有 *azimuth* 数据，则需要使用 :option:`-i` 选项指定包含方位角的单列。
    此时所有长度都将被设置为 1（使用 :option:`-Z`\ **u** 可以将实际长度也设置为 1）。
    如果使用 :option:`-A` 选项可以绘制极坐标直方图（扇形图或玫瑰图）。

可选选项
--------

.. option:: -A

**-A**\ *sector_width*\ [**+r**]
    指定扇形图和玫瑰图的扇区宽度，单位为度

    - 默认扇页宽度为 0，即绘制风向玫瑰图
    - 若扇页宽度不为 0，则表示绘制扇形图
    - 若扇页宽度不为 0 且使用了 **+r**，则表示绘制玫瑰图

.. include:: explain_-B.rst_
..

    此模块中，X 表示径向距离，Y 表示方位角。Y 轴的标签是图片的标题，比例尺长度由径向网格间隔决定。

    默认情况下，如果选择绘制比例尺，则在右下角绘制。
    :term:`MAP_TICK_PEN_PRIMARY` 控制比例尺画笔属性， :term:`FONT_ANNOT_PRIMARY` 控制标注字体。

.. option:: -C

**-C**\ *cpt*
    提供一个 CPT 文件。每个扇区的 *r* 值将用于查找对应的扇区颜色。该选项不能与玫瑰图同时使用。
    在现代模式下，如果未给定参数则选择当前的 CPT。

.. option:: -D

**-D**
    对扇页对偏移，使得其位于每个间隔的中间，即第一个扇页的中心在 0 度处

.. option:: -E

**-E**\ **m**\|\ [**+w**]\ *mode_file*
    绘制 *mode_file* 文件中给出的主方向向量。指定 **-Em** 计算并绘制平均方向。使用 :option:`-M` 控制向量属性。
    若要保存计算出的平均方向和其他统计数据，使用 [**m**]\ **+w**\ *mode_file*。保存在单条记录中的八个项目分别是::

        mean_az  mean_r  mean_resultant  max_r  scaled_mean_r  length_sum  n  sign@alpha

    其中最后一项为 0 或 1，取决于平均合向量在通过 :option:`-Q` 设置的置信水平下是否显著。

.. option:: -F

**-F**
   不绘制比例尺。

.. option:: -G

**-G**\ *fill*
    绘制扇页的填充色

.. option:: -I

**-I**
    不绘制图形，只计算 :option:`-R` 选项所需要的参数。以下统计信息会输出到标准输出::

        n  mean_az  mean_r  mean_resultant_length  max_bin_sum  scaled_mean  linear_length_sum
    
    使用 :option:`-o` 选项可以选择只输出其中几列。

.. option:: -J

**-JX**\ *diameter*
    设置玫瑰图的直径。本模块只能使用这种投影方式。如果不设置，直径默认为7.5cm。

.. option:: -L

**-L**\ [*wlabel*\ ,\ *elabel*\ ,\ *slabel*\ ,\ *nlabel*]
    指定0、90、180、270度处的标签。

    - 对于全圆绘图，默认值为 *WEST,EAST,SOUTH,NORTH*
    - 对于半圆绘图，默认值为 *90W,90E,-,0* ，其中 **-** 表示不显示标签
    - 使用不带参数的 **-L** 禁用所有四个标签

.. option:: -M

**-M**\ *parameters*
    与 :option:`-E` 选项一起使用修改矢量的属性 *parameters* ，具体属性设置见 :doc:`/basis/vector` 一节。
    如果要绘制向量头，请附加向量头 *size* [默认值为 0，即只绘制一条直线]。
    如果不使用 :option:`-E` 且当前绘图模式为绘制风向玫瑰图，则单独使用 :option:`-M` 将为所有单个方向添加向量头。

.. option:: -N

**-N**\ *mode*\ [**+p**\ *pen*]
    绘制等效的圆周正态分布，即 *von Mises* 分布。附加 **+p** 设置画笔属性 *pen* [默认 0.25p, 黑色]。
    *mode* 用于选择所使用的中心位置和刻度：

    * **0** = 平均值和标准差
    * **1** = 中位数和 L1 刻度（1.4826 \* 中位数绝对偏差；MAD）
    * **2** = LMS（最小平方中位数）众数和刻度

    **注意**：目前仅支持 *mode* == 0。

.. option:: -Q

**-Q**\ [*alpha*]
    设置用于确定平均合向量是否显著（即用于均匀性检验的 Rayleigh 检验）的置信水平 [默认 0.05]。
    **注意**：临界值是近似计算的 [*Berens*, 2009]，且要求至少有 10 个点。临界合向量至少在 3 位有效数字内是准确的。对于更小的数据集，应该查阅精确的统计表。

.. option:: -R

**-R**\ *r0*/*r1*/*az0*/*az1*
    指定绘图的半径和方位角范围。

    - *r0* 取 0
    - *r1* 取最大长度
    - 方位角范围取 *-90/90* 或 *0/180* 进行半圆绘图
    - 方位角范围取 *0/360* 进行全圆绘图

.. option:: -S

**-S**\ [**+a**]
    使用最大值对输入半径（如果使用了 :option:`-A` 则为各组计数）进行归一化，使得所有半径（或计数）范围在 0 到 1 之间。
    使用 **+a** 进一步对玫瑰图进行面积归一化（即在绘图前取 :math:`\sqrt{r}`）[默认不进行归一化]。

.. option:: -T

**-T**
    指定输入数据为两个方向的方位向数据（即无法区分 *azimuth* 和 *azimuth + 180* ），而非单方向的 0-360 度方向数据。
    每条数据会被统计两次：第一次统计为 *azimuth* ，第二次统计为 *azimuth + 180* 。
    如果提供的数据范围确定是 -90/90 或 0/180，则不要使用此选项。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *pen*
    设置扇区边框的画笔属性，默认不绘制边框。
    使用 **-Wv**\ *pen* 可用于设置绘制矢量时所需的画笔属性，此时需要设置 :option:`-E` 选项。默认情况下矢量画笔属性和边框画笔属性相同。

.. include:: explain_-XY.rst_

.. option:: -Z

**-Z**\ **u**\|\ *scale*
    将数据半径乘以 *scale* 。例如，使用 **-Z**\ 0.001 将数据从米 (m) 转换为千米 (km)。
    若不考虑半径，使用 **-Zu** 将它们全部设为 1 [默认不进行比例缩放]。

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-s.rst_

.. include:: explain_-t.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_
..

    使用 **-:** 表示输入数据为 *azimuth radus* 而不是 *radius azimuth*

.. include:: explain_help.rst_

示例
--------

绘制远程数据文件 @azimuth_lengths.txt（数据为 azimuth length，单位是米）的半圆玫瑰图，使用 5 度的条柱扇区宽度，圆直径为 10 cm，并使用浅蓝色阴影填充::

    gmt rose @azimuth_lengths.txt -: -A5 -JX10c -F -L -Glightblue -R0/1/0/180 -Bxaf+l"Fault length" -Byg30 -S -pdf half_rose

在直径为 10 cm 的圆上绘制文件 lines.az_r 中数据的全圆风向玫瑰图，网格半径延伸至 500 单位（步长为 100），扇区间隔为 45 度，使用实线画笔（宽度为 0.5 磅），并在横向 [默认] 方位下带有时间戳和命令行信息::

    gmt rose lines.az_r -R0/500/0/360 -JX10c -Bxg100 -Byg45 -B+t"Windrose diagram" -W0.5p -U+c -pdf rose

重新绘制上述图表，但这次为每个方向添加橙色向量头（标称头大小为 0.5 cm，但对于长度小于 1 cm 的向量其头部大小将线性减小）并保存图表，请使用::

    gmt rose lines.az_r -R0/500/0/360 -JX10c -Bxg100 -Byg45 -B+t"Windrose diagram" -M0.5c+e+gorange+n1c -W0.5p -U+c -pdf rose

Bugs
----

极坐标直方图没有默认的径向比例尺和网格设置。用户必须先使用 :option:`-I` ，以查找分箱数据集中的最大长度。

参考文献
----------

Berens, P., 2009, CircStat: A MATLAB Toolbox for Circular Statistics, *J. Stat. Software, 31(10)*\ , 1-21.

相关模块
--------

:doc:`histogram`
