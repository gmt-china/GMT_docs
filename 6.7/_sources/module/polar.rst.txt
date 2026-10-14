:author: 田冬冬, 朱邓达, 王亮, 陈箫翰
:date: 2026-01-09

.. index:: ! polar
.. program:: polar

polar
=====

:官方文档: :doc:`gmt:supplements/seis/polar`
:简介: 将台站的极性信息画在震源球上

通常可以使用 :doc:`meca` 模块绘制震源球下半球，再使用 :doc:`polar` 模块绘制每个台站的震相极性信息。
震源球通常绘制在由 :option:`-D` 指定的地震发生位置处。

语法
----

**gmt polar**
[ *table* ]
:option:`-D`\ *lon/lat*
:option:`-J`\ *parameters*
:option:`-R`\ *region*
:option:`-M`\ *size*\ [**+m**\ *mag*]
:option:`-S`\ **a**\|\ **c**\|\ **d**\|\ **h**\|\ **i**\|\ **p**\|\ **s**\|\ **t**\|\ **x**\ *size*
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-E`\ *fill* ]
[ :option:`-F`\ *fill* ]
[ :option:`-G`\ *fill* ]
[ :option:`-N` ]
[ :option:`-Q`\ *mode*\ [*args*] ]
[ :option:`-T`\ [**+a**\ *angle*][**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\[/*dy*]] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *pen* ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-------------

.. include:: explain_intables.rst_
..

    输入数据的格式为::

        station_code  azimuth  take-off-angle  polarity

    - *station_code* ：台站名或其它任意字符串
    - *azimuth* ：震相从源到台站的方位角
    - *take-off-angle* ：震相从源出发时的出射角
    - *polarity* ：震相极性

       - 压缩部分（正极性）可以用 **c**, **C**, **u**, **U**, **+** 表示
       - 拉伸部分（负极性）可以取 **d**, **D**, **r**, **R**, **-** 表示
       - 未定义：其他字符

必须选项
--------

.. option:: -D

**-D**\ *lon/lat*
    震源球的位置，需要与 :doc:`meca` 模块输入数据中震源球的位置相同

.. include:: explain_-J.rst_

.. option:: -M

**-M**\ *size*\ [**+m**\ *mag*]
    震源球尺寸，需要与 :doc:`meca` 模块中 **-S** 选项的参数保持一致。

    **+m**\ *mag* 可以用于指定当前地震的震级，此时 *size* 表示5级地震震源球的
    大小，当前地震的实际大小为 *mag* / 5.0 * *size*。

.. include:: explain_-R.rst_

.. option:: -S

**-S**\ **a**\|\ **c**\|\ **d**\|\ **h**\|\ **i**\|\ **p**\|\ **s**\|\ **t**\|\ **x**\ *size*
    选择符号以及符号的大小。符号的具体含义见 :doc:`plot` 模块的 **-S** 选项。

可选选项
--------

.. include:: explain_-B.rst_

.. option:: -E

**-E**\ *fill*
    拉伸象限内台站的符号填充色 [默认为250]。
    如果 :option:`-E`\ *fill* 与 :option:`-F`\ *fill* 相同，可以使用 :option:`-Q`\ **e** 来绘制轮廓。

.. option:: -F

**-F**\ *fill*
    设置震源球的背景色 [默认不填充]

.. option:: -G

**-G**\ *color*
    压缩象限内台站的符号填充色 [默认为黑色]

.. option:: -N

**-N**
    不跳过地图边界外的符号

.. option:: -Q

**-Q**\ *mode*\ [*args*]
    设置多个属性，该选项可重复使用。

    **-Qe**\ [*pen*]
        拉伸象限内符号的轮廓属性。不设置 *pen* 则使用 :option:`-W` 的设置。

    **-Qf**\ [*pen*]
        震源球的轮廓属性。不设置 *pen* 则使用 :option:`-W` 的设置。

    **-Qg**\ [*pen*]
        压缩象限内符号的轮廓属性。不设置 *pen* 则使用 :option:`-W` 的设置。

    **-Qh**
        使用 HYPO71 输出的特殊格式。

    **-Qs**\ *half-size*\ [**+v**\ *v_size*\ [*vecspecs*]]
        绘制S波偏振方位角。S波偏振信息位于最后一列。
        *half-size* 可以附加单位 **c**, **i**, 或 **p** 。
        **+v** 用于设置箭头。*v_size* 为箭头大小，后可接其它箭头相关属性，详见 :doc:`/basis/vector` 一节。

    **-Qt**\ *pen*
        *station_code* 的字体颜色。

.. option:: -T

**-T**\ [**+a**\ *angle*][**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\[/*dy*]]
    在符号附近绘制台站代码 *station_code* 。默认在符号上方绘制台站代码，默认字体大小为 12p。
    可以附加：

    * **+a**\ *angle* ：更改文本角度。
    * **+f**\ *font* ：设置文本字体。
    * **+j**\ *justify* ：更改文本相对于符号的对齐位置。
    * **+o** ：偏移文本字符串，偏移量 *dx/dy* 。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [**-**\|\ **+**][*pen*][*attr*]
    设置画笔属性，默认为 0.25p,black,solid。

.. include:: explain_-XY.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-t.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

.. gmtplot:: polar/polar_ex1.sh
   :width: 60%
   :align: center

   polar示例1

相关模块
--------

:doc:`meca`,
:doc:`coupe`,
:doc:`basemap`,
:doc:`plot`
