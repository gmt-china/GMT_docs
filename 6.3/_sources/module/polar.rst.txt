.. index:: ! polar
.. include:: common_SYN_OPTs.rst_

polar
=====

:官方文档: :doc:`gmt:supplements/seis/polar`
:简介: 将台站的极性信息画在震源球上

通常可以使用 :doc:`meca` 模块绘制震源球，再使用 :doc:`polar` 模块将每个台站的
震相极性信息画在相应的震源球上。

语法
----

**gmt polar** [ *table* ] |-D|\ *lon/lat* |-J|\ *parameters*
|SYN_OPT-R|
|-M|\ *size*\ [**+m**\ *mag*]
|-S|\ *<symbol><size>*
[ |SYN_OPT-B| ]
[ |-C|\ *lon*/*lat*\ [**+p**\ *pen*][**+s**\ *pointsize*] ]
[ |-E|\ *fill* ]
[ |-F|\ *fill* ]
[ |-G|\ *fill* ]
[ |-N| ]
[ |-Q|\ *mode*\ [*args*] ]
[ |-T|\ *angle*/*form*/*justify*/*fontsize* ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必须选项
--------

.. include:: explain_intables.rst_
..

    输入数据的格式为::

        station_code  azimuth  take-off_angle polarity

    - *station_code* 台站名或其它任意字符串
    - *azimuth* 震相从源到台站的方位角
    - *take-off_angle* 震相从源出发时的出射角
    - *polarity* 震相极性

       - 压缩部分（正极性）可以用 **c**, **C**, **u**, **U**, **+** 表示
       - 拉伸部分（负极性）可以取 **d**, **D**, **r**, **R**, **-** 表示
       - 未定义：其他字符

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. _-D:

**-D**\ *longitude/latitude*
    震源球的位置，需要与 :doc:`meca` 模块输入数据中震源球的位置相同

.. _-M:

**-M**\ *size*\ [**+m**\ *mag*]
    震源球尺寸，需要与 :doc:`meca` 模块中 |-S| 选项的参数保持一致

    **+m**\ *mag* 可以用于指定当前地震的震级，此时 *size* 表示5级地震震源球的
    大小，当前地震的实际大小为 *mag* / 5.0 * *size*。

**-S**\ *<symbol_type><size>*
    选择符号以及符号的大小。

    符号可以取 **a**, **c**, **d**, **h**, **i**, **p**, **s**, **t**, **x**。
    符号的具体含义见 :doc:`plot` 模块的 |-S| 选项。

可选选项
--------

.. _-C:

**-C**\ *lon*/*lat*\ [**+p**\ *pen*][**+s**\ *pointsize*]
    将震源球放在新的位置上，并将新位置与老位置之间连线。

.. _-E:

**-E**\ *color*
    拉伸象限内台站的符号填充色 [默认为250]

.. _-F:

**-F**\ *fill*
    设置震源球的背景色 [默认不填充]

.. _-G:

**-G**\ *color*
    压缩象限内台站的符号填充色 [默认为黑色]

.. _-N:

**-N**
    不跳过地图边界外的符号

.. _-Q:

**-Q**\ *mode*\ [*args*]
    设置多个属性，该选项可重复使用。

**-Qe**\ [pen]
    拉伸象限内符号的轮廓属性

**-Qf**\ [pen]
    震源球的轮廓属性

**-Qg**\ [pen]
    压缩象限内符号的轮廓属性

**-Qh**
    使用HYPO71输出的特殊格式

**-Qs**\ *half-size*\ [**+v**\ *v_size*\ [*vecspecs*]]
    绘制S波偏振方位角。S波偏振信息位于最后一列。

    **+v** 用于设置箭头。*v_size* 为箭头大小，后可接其它箭头相关属性。

**-Qt**\ *pen*
    *station_code* 的字体颜色

.. _-T:

**-T**\ *angle*/*form*/*justify*/*fontsize*
    将 *station_code* 写到图上，其余参数字符串的角度、形式、对齐方式和字体大小。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *pen*
    设置画笔属性

.. include:: explain_-XY.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-t.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

.. gmtplot:: polar/polar_ex1.sh
   :width: 60%
   :align: center

   polar示例

相关模块
--------

:doc:`meca`,
:doc:`coupe`,
:doc:`basemap`,
:doc:`plot`
