:author: 田冬冬, 陈箫翰, 何星辰, 王亮
:date: 2026-01-15

.. index:: ! velo
.. program:: velo

velo
====

:官方文档: :doc:`gmt:supplements/geodesy/velo`
:简介: 在地图上绘制速度矢量、各向异性矢量、应变十字和旋转楔形图

从文件或标准输入读取数据值，并在地图上绘制所选的大地测量符号。
可以选择速度矢量及其不确定度、旋转楔形及其不确定度、各向异性矢量或应变十字。
符号的填充或其轮廓可以基于固定参数或通过颜色查找表 CPT 进行着色。

.. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT_velo.png
   :width: 600 px
   :align: center

   四种不同的测量符号：旋转楔形、带有矢量的速度误差椭圆、各向异性矢量和应变十字。前两种符号可以为主符号及其误差部分分别选择颜色和画笔属性。

语法
-------

**gmt velo**
[ *table* ]
:option:`-S`\ *format*\ [*scale*][/*args*][**+f**\ *font*]
[ :option:`-A`\ *parameters* ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *cpt*]
[ :option:`-D`\ *scale* ]
[ :option:`-E`\ *fill* ]
[ :option:`-G`\ *fill* ]
[ :option:`-H`\ [*scale*] ]
[ :option:`-I`\ [*intens*] ]
[ :option:`-J`\ *parameters* ]
[ :option:`-L`\ [*pen*\ [**+c**\ [**f**\|\ **l**]]] ]
[ :option:`-N` ]
[ :option:`-R`\ *west*/*east*/*south*/*north*\ [**+r**][**+u**\ *unit*] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [*pen*][**+c**\ [**f**\|\ **l**]] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-Z`\ [**m**\|\ **e**\|\ **n**\|\ **u**\ ][**+e**] ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
------------------

.. include:: explain_intables.rst_

必须选项
------------

.. option:: -S

**-S**
    决定要绘制哪一种符号，及其输入数据的格式。
    缩放比例的单位均为“每长度单位的数据单位”，尺寸则以长度单位表示，默认长度单位受 :term:`PROJ_LENGTH_UNIT` 控制。
    可以自行指定单位为 **c** 、 **i** 或 **p** 。

    **-Se**\ [*velscale*/]\ *confidence*\ [**+f**\ *font*]
        速度矢量，以椭圆表示不确定度。 *velscale* 设置速度箭头的缩放比例。如果未给出 *velscale* ，则数据文件中必须有 *velscale* 列。
        *confidence* 设置椭圆的二维置信区间的极限，例如 0.95 代表 95% 置信椭圆。
        使用 **+f** 设置标注文本的字体和大小 [默认值 9p,Helvetica,black]。给定 **+f**\ 0 则禁用标注文本。
        箭头将使用 :option:`-W` 选项指定的画笔属性绘制，箭头头部通过 :option:`-G` 填充。
        椭圆使用 :option:`-E` 选项填充 [默认透明]，如果使用 :option:`-L` ，则使用选定的画笔绘制其轮廓（若 :option:`-L` 未指定，则使用 :option:`-W` ）。
        **注意**：如果 *confidence* 不为零且既未设置 :option:`-L` 也未设置 :option:`-E` ，则使用 :option:`-W` （或默认值）绘制椭圆轮廓。
        输入数据中每列的含义为：

            #. 起点的经度
            #. 起点的纬度
            #. 矢量的东向分量
            #. 矢量的北向分量
            #. 东向分量的不确定度（1-sigma）
            #. 北向分量的不确定度（1-sigma）
            #. 东向分量和北向分量的 correlation
            #. 标注文本（可选）
    
    **-Sn**\ [*barscale*]
        绘制各向异性矢量。 *barscale* 设置缩放比例。如果未给出 *barscale* ，则数据文件中必须有 *barscale* 列。
        矢量头参数 *shape* 默认为 0.1,可以使用 :option:`-A` 的附加参数 **+h**\ *shape* 进行修改。
        输入数据中每列的含义为：

            #. 经度
            #. 纬度
            #. 各向异性矢量的东向分量
            #. 各向异性矢量的北向分量

    **-Sr**\ [*velscale*/]\ *confidence*\ [**+f**\ *font*]
        与 **-Se** 类似，区别在于输入文件不同：

            #. 起点的经度
            #. 起点的纬度
            #. 矢量的东向分量
            #. 矢量的北向分量
            #. 椭圆的半长轴
            #. 椭圆的半短轴
            #. 椭圆的长轴相对于水平方向逆时针旋转的角度
            #. 标注文本（可选）

    **-Sw**\ [*wedgescale*/]\ *wedgemag*
        旋转楔形图，由两个同心扇形组成。一个扇形是旋转楔形图本身，另一个扇形则表示不确定度。
        *wedgescale* 设置旋转楔形的半径。不确定度扇形的半径固定为旋转楔形的半径的三分之二。
        如果未给出 *wedgescale* ，则数据文件中必须有 *wedgescale* 列。
        使用 :option:`-G` 设置楔形的填充色，使用 :option:`-E` 设置不确定度扇形的填充色。输入数据中每列的含义为：

            #. 经度
            #. 纬度
            #. 楔形表示的年旋转率，单位 rad/yr
            #. 不确定度(1-sigma)，单位 rad/yr

        楔形的扇形角度为年旋转率乘以 *wedgemag* ，不确定度的扇形角度为不确定度乘以 *wedgemag* 再乘以 2（即 2-sigma）。
        绘制时，固定从正北开始，顺时针绘制楔形对应的扇形。再以楔形的结束角度为中心，向顺时针和逆时针两个方向绘制不确定度扇形(2-sigma)。

    **-Sx**\ [*cross_scale*]
        绘制应变十字线。 *cross_scale* 控制十字线的大小。如果未给出 *cross_scale* ，则数据文件中必须有 *cross_scale* 列。输入文件中每列的含义为：

            #. 经度
            #. 纬度
            #. eps1：应变张量的最大本征值，扩张为正，压缩为负
            #. eps2：应变张量的最小本征值，扩张为正，压缩为负
            #. eps2的方位角（北方向顺时针旋转的角度）

可选选项
----------------

.. option:: -A

**-A**\ *parameters*
    修改矢量的属性。例如令 *parameters* = 0.3c 设置矢量头的大小。注意默认情况下，矢量头的大小不随着矢量线的长度变化而变化。
    当矢量线过短时，会出现矢量箭头不绘制的情况。此时可以添加 **+n**\ *norm* 属性让箭头大小随矢量成比例变化。
    更多设置和详细说明见 :doc:`/basis/vector` 一节。

.. include:: explain_-B.rst_

.. option:: -C

**-C**\ *cpt*
    提供一个 CPT 文件，符号填充色根据 :option:`-Z` 设置的数值从 CPT 中查找。不要和 :option:`-G` 一起使用。

.. option:: -D

**-D**\ *scale*
    控制 **-Se** 和 **-Sr** 以及 **-Sw** 中不确定度的缩放。

.. option:: -E

**-E**\ *fill* 
    设置 **-Se** 和 **-Sr** 中速度误差椭圆的填充色，或 **-Sw** 中不确定度扇形的填充色。不设置本项则为透明。
    **注意：** 使用 :option:`-C` 和 :option:`-Z`\ **+e** 将会根据 :option:`-Z` 设置的数值从 CPT 中查找填充色。此时本选项无效。

.. option:: -G

**-G**\ *fill* 
    设置符号的填充色。
    **注意：** 使用 :option:`-C` 和 :option:`-Z` 会覆盖本选项。

.. option:: -H

**-H**\ [*scale*]
    使用 *scale* 作为缩放比例对符号大小和画笔宽度进行缩放。如果不指定 *scale* 则输入数据中必须要提供一列 *scale* 数据列，位置在 *z* 和 *size* 列之后。

.. option:: -I

**-I**\ *intens*
    提供光照强度 *intens* （范围 ±1 之间），通过模拟光照来调节符号的填充颜色 [默认无]。
    如果未提供光照强度值，将从输入数据中读取 *intens* 列。

.. include:: explain_-J.rst_

.. option:: -L

**-L**\ [*pen*\ [**+c**\ [**f**\|\ **l**]]]
    绘制椭圆和旋转楔形的轮廓。不指定画笔属性 *pen* 则默认使用 :option:`-W` 设置的画笔属性。

    - 附加 **+cl** 则 :option:`-C` 设置的 CPT 将控制画笔的颜色。
    - 附加 **+cf** 则 CPT 文件的颜色仅应用于误差填充 [默认]。
    - 附加 **+c** 则会将 CPT 设置同时应用于画笔和填充的颜色。

.. option:: -N

**-N**
    不跳过区域范围外的符号

.. include:: explain_-R.rst_

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [*pen*][**+c**\ [**f**\|\ **l**]]
    设置速度箭头、椭圆轮廓和断层面边缘的画笔属性 [默认值：宽度 = 0.25p，颜色 = 黑色，样式 = 实线]。

    - 附加 **+cl** 则 :option:`-C` 设置的 CPT 将控制画笔的颜色。
    - 附加 **+cf** 则 CPT 文件的颜色仅应用于误差填充 [默认]。
    - 附加 **+c** 则会将 CPT 设置同时应用于画笔和填充的颜色。

.. include:: explain_-XY.rst_

.. option:: -Z

**-Z**\ [**m**\|\ **e**\|\ **n**\|\ **u**\ ][**+e**]
    选择与 :option:`-C` 配合使用设置填充颜色的物理量。可选择：

	- **m** ：矢量长度或楔形的旋转率
	- **e** ：东西方向速度
	- **n** ：南北方向速度
	- **u** ：用户提供的数据列（位于必需列之后提供）

    若要改用相应的不确定度估计值（即矢量不确定度或楔形的不确定度）来查询颜色并为误差椭圆或楔形着色，请附加 **+e** 。

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-t.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

数据列顺序
----------------

:option:`-S` 选项决定了输入数据需要多少个数据列。
此外，使用 :option:`-H` 、 :option:`-I` 和 :option:`-t` 选项，
以及不带 *size* 的 :option:`-S` 选项或通过 :option:`-Z`\ **u** 选择用于颜色查询的用户列，都需要额外的数据列。
数据列的顺序是固定的，与选项出现的顺序无关。数据列要求按以下顺序排列::

    lon lat symbol-columns [usercol] [size] [scale] [intens] [transp [transp2]] [trailing-text]

其中 *symbol-columns* 代表 :option:`-S` 选项通常需要的列。方括号中的项是可选的，受对应选项的控制。尾部文本始终是可选的。
**注意**：可以使用 :option:`-i` 来重新排列数据记录以匹配预期的格式。

示例
----

生成带有绿色椭圆的大红色箭头，并带有红色轮廓。请注意，39% 的置信度缩放将生成一个正好嵌入在尺寸为 **Esig** 乘以 **Nsig** 的矩形内的椭圆：

.. gmtplot:: velo/velo_ex1.sh
    :width: 60%

    velo示例图1

绘制加利福尼亚州西横向山脉（Western Transverse Ranges）的一些残余旋转速率。楔形将呈现为深灰色，并使用浅灰色楔形表示 2-sigma 不确定度：

.. gmtplot:: velo/velo_ex2.sh
    :width: 60%

    velo示例图2

`Kurt L. Feigl <https://geoscience.wisc.edu/people/feigl-kurt-l/>`_, Department of Geology and
Geophysics at University of Wisconsin-Madison, Madison, Wisconsin, USA

相关模块
--------

:doc:`basemap`,
:doc:`plot`