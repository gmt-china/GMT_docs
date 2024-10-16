.. index:: ! colorbar
.. include:: common_SYN_OPTs.rst_

colorbar
========

:官方文档: :doc:`gmt:colorbar`
:简介: 在地图上绘制灰色或彩色色条

**gmt colorbar**
[ |SYN_OPT-B| ]
[ |-C|\ *cpt* ]
[ |-D|\ *refpoint* ]
[ |-F|\ *panel* ]
[ |-G|\ *zlo*\ /\ *zhi* ]
[ |-I|\ [*max\_intens*\|\ *low_i*/*high_i*] ]
[ |-J|\ *parameters* ]
[ |-J|\ **z**\|\ **Z**\ *parameters* ]
[ |-L|\ [**i**][*gap*] ]
[ |-M| ]
[ |-N|\ [**p**\|\ *dpi* ]]
[ |-Q| ]
[ |SYN_OPT-R| ]
[ |-S| ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ *scale* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |-Z|\ *zfile* ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

必选选项
--------

无

可选选项
--------

.. _-B:

**-B**\ [**p**\|\ **s**]\ *parameters*
    设置colorbar的标注、刻度和网格线间隔。

    在不使用 **-B** 选项或不指定标注间隔时，默认会根据CPT文件中每一行的内容
    对colorbar进行标注，具体见 :doc:`/cpt/index`。**-B** 选项的具体说明
    见 :doc:`/option/B`。

    默认情况下，对于水平colorbar而言，X轴的标签会放在colorbar的下边，Y轴标签放在
    colorbar的右边；对于垂直colorbar而言，X轴的标签放在colorbar的右边，Y轴标签
    放在colorbar的上边。除非在 **-D** 选项中使用了 **+m** 子选项。

.. _-C:

**-C**\ [*cpt*]
    要绘制的CPT文件。

    若CPT中Z值范围单位为米，而实际绘图时想使用其它单位，则可在文件名后加上 **+U**\ *unit*。
    若CPT中Z值范围单位不为米，而实际绘图中想使用米为单位，则可在文件名后加上 **+u**\ *unit*。

    对于现代模式，若未指定 *cpt* 或者未使用 **-C** 选项，则使用当前CPT。
    经典模式下，若未指定 **-C** 则从标准输入中读入CPT。

**-D**\ [**g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ [**+w**\ *length*\ [/\ *width*]]\ [**+e**\ [**b**\|\ **f**][*length*]][**+h**\|\ **v**][**+j**\ *justify*]\ [**+m**\ [**a**\|\ **c**\|\ **l**\|\ **u**]][**+n**\ [*txt*]][**+o**\ *dx*\ [/*dy*]]
    指定色标的尺寸和位置。

    简单介绍各子选项的含义，详情见 :doc:`/basis/embellishment`

    - **g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ 指定地图上的参考点

      .. include:: explain_refpoint.rst_

    - **+j**\ *justify* 指定色标上的锚点，默认锚点是 **BL**
    - **+o**\ *dx*/*dy* 在参考点的基础上设置色标的额外偏移量
    - **+w**\ *length*\ [/*width*] 指定色标的长度和宽度。若未指定宽度，则默认为长度
      的4%；若长度为负值则会反转色标。
    - **+h** 绘制水平色标
    - **+v** 绘制垂直色标
    - **+e**\ [**b**\|\ **f**][*length*] 在CPT中为前景色和背景色加一个三角形。
      **+ef** 表示只加前景色三角形，
      **+eb** 表示只加背景色三角形
      *length* 是三角的高度，默认为色标宽度的一半。
    - **+m**\ [**a**\|\ **c**\|\ **l**\|\ **u**] 将标注、标签和单位放在色标的另一边。
      **a** 代表标注，
      **l** 代表标签，
      **u** 代表单位。
      **c** 表示将标签以单列字符垂直打印。
    - **+n**\ *text* 在色标开始处绘制一个矩形，并用NaN的颜色填充

    几种常用的放置色标的方式：

    - 放在左边: **-DjML+w2c/0.5c+o-1c/0c+m**
    - 放在右边: **-DjMR+w2c/0.5c+o-1c/0c**
    - 放在上方: **-DjTC+w2c/0.5c+o0c/-1c+m**
    - 放在下方: **-DjBC+w2c/0.5c+o0c/-1c+m**
    - 放在左上角: **-DjTL+w2c/0.5c+o-1c/0c+m**
    - 放在左下角: **-DjBL+w2c/0.5c+o-1c/0c+m**
    - 放在右上角: **-DjTR+w2c/0.5c+o-1c/0c**
    - 放在右下角: **-DjBR+w2c/0.5c+o-1c/0c**

.. _-F:

**-F**\ [**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]]
    控制色标后的背景边框

    若只使用 **-F** 而不使用其它子选项，则会在色标周围绘制矩形边框。
    下面简单介绍各子选项，详细用法见 :doc:`/basis/embellishment`

    .. include:: explain_-F_box.rst_

.. _-G:

**-G**\ *zlow*\ /\ *zhigh*
    对CPT文件做截断，即只绘制 *zlow* 到 *zhigh* 之间的部分。
    若其中某个值等于NaN，则不对CPT的那一端做处理。

.. _-I:

**-I**\ [*max_intens*\|\ *low_i*/*high_i*]
    为色标加上光照效果

    - **-I**\ *max_intens* 设置光照强度为 [-\ *max_intens*, +\ *max_intens*]，默认值为[-1,+1]
    - **-I**\ *low_i*/*high_i* 指定非对称的光照强度范围

.. include:: explain_-J.rst_

.. _-L:

**-L**\ [**i**][*gap*]
    生成等大小的颜色矩形。

    默认情况下，会根据CPT文件中Z值的范围决定颜色矩形的大小。若使用该选项，则
    会忽略 **-B** 选项设置的间隔。若指定了 *gap* 且CPT文件是离散的，则使用
    每个矩形的Z值下边界作为标注且将标注放在矩形的正中间。
    若使用了 **i** 则标注每个间隔范围。若使用了 **-I** 选项，则每个矩形有自己的
    颜色以及自己的光照强度。

.. _-M:

**-M**
    使用YIQ变换将色标变成单调灰度色标

.. _-N:

**-N**\ [**p**\|\ *dpi*]
    控制色标的图形表示方式

    - **-Np** 用颜色矩形来表示（比如离散的颜色）
    - **-N** 用图形表示（比如连续的颜色），可以加上 *dpi* 指定绘制色标时的等效DPI，默认值为600

.. _-Q:

**-Q**
    使用对数坐标，刻度表示为10的次幂

    CPT文件中所有的Z值都会被转换成 :math:`p = \log10(z)`，其中整数的p会以10^p的格式标注。

.. include:: explain_-R.rst_

.. _-S:

**-S**
    去除不同色块之间的黑色网格线

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *scale*
    将CPT文件中所有的Z值乘以比例因子 *scale*

.. include:: explain_-XY.rst_

.. _-Z:

**-Z**\ *zfile*
    *zfile* 文件用于指定每个颜色块的宽度。

    默认情况下，颜色块的宽度由颜色的Z值范围决定，比如Z=0-100对应的色块宽度是
    Z=100-150的色块宽度的两倍。

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

示例
----

::

    gmt begin map
    gmt makecpt -T-200/1000/100 -Crainbow
    gmt colorbar -C -Dx8c/1c+w12c/0.5c+jTC+h -Bxaf+l"topography" -By+lkm
    gmt end


相关模块
--------

:doc:`makecpt`
:doc:`gmtlogo`,
:doc:`grd2cpt`
:doc:`image`,
:doc:`legend`
