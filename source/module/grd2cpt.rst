:author: 田冬冬, 朱邓达, 陈箫翰
:date: 2025-12-31

.. index:: ! grd2cpt
.. program:: grd2cpt

grd2cpt
==========

:官方文档: :doc:`gmt:grd2cpt`
:简介: 根据grid文件生成CPT

**grd2cpt** 读取一个或多个 grid 文件，并根据 grid 文件的z值范围生成对应的CPT文件。
在经典模式中，CPT文件的内容会输出到屏幕标准输出中。
而在现代模式中，该命令不会生成显式的CPT文件，而是隐式地将其自动设置为后面的绘图命令的默认CPT文件。
因此无法使用经典的 ``gmt grd2cpt grid > cpt`` 方式生成CPT文件。如果需要在现代模式中生成CPT文件，
则可以使用 :option:`-H` 选项： ``gmt grd2cpt grid -H > cpt`` 。
关于经典模式和现代模式的语法区别，建议阅读《 :doc:`/migrating/classic2modern` 》。

生成 CPT 文件时会基于选择的主 CPT，通过计算数据的累积分布函数 (CDF) 实现数据值到颜色的映射，从而使颜色经过直方图均衡化。
因此，如果网格文件及其生成的 CPT 在使用线性投影的 :doc:`grdimage` 中调用，则颜色在图上的面积分布将是均匀的。
设 z 为网格中的数据值，定义 CDF(Z) = (z < Z 的数量) / (网格中 z 的总数)。（忽略 NaN 值）。
这些 z 值随后被归一化到主 CPT，并按所需间隔进行颜色采样。

grid文件的z值范围以外的数值，将分别使用3种颜色来表示，分别是：
背景色 (B，background color，表示低于最小z值时所对应的颜色)、
前景色 (F，foreground color，表示高于最大z值时所对应的颜色)、
以及NaN颜色 (N，表示z值被定义为NaN时对应的颜色，即z值未定义的情况)。
默认情况下，这三种颜色会沿用 :option:`-C` 选项所指定的主CPT文件的设置，但也可以使用 :option:`-D` ， :option:`-M` 和 :option:`-N` 选项进行修改。
或者使用 :doc:`set` 命令对 :term:`COLOR_BACKGROUND`\、
\ :term:`COLOR_FOREGROUND` 与 :term:`COLOR_NAN` 进行自定义修改。

颜色模式 (RGB, HSV, CMYK) 会沿用 :option:`-C` 选项所指定的主CPT文件的设置。
或者使用 :doc:`set` 命令对 :term:`COLOR_MODEL` 进行自定义修改。

语法
--------

**gmt grd2cpt**
*ingrid*
[ :option:`-A`\ *transparency*\ [**+a**] ]
[ :option:`-C`\ *cpt* ]
[ :option:`-D`\ [**i**\|\ **o**] ]
[ :option:`-E`\ [*nlevels*][**+c**][**+f**\ *file*] ]
[ :option:`-F`\ [**R**\|\ **c**\|\ **g**\|\ **h**\|\ **r**\|\ **x**][**+c**\ [*label*]][**+k**\ *keys*] ]
[ :option:`-G`\ *zlo*\ /\ *zhi* ]
[ :option:`-H` ]
[ :option:`-I`\ [**c**][**z**] ]
[ :option:`-L`\ *minlimit/maxlimit* ]
[ :option:`-M` ]
[ :option:`-N` ]
[ :option:`-Q`\ [**i**\|\ **o**] ]
[ :option:`-R`\ *region* ]
[ :option:`-S`\ **h**\|\ **l**\|\ **m**\|\ **u** ]
[ :option:`-T`\ *start/stop/inc*\|\ **n** ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [**w**] ]
[ :option:`-Z` ]
[ :option:`-bo`\ *binary* ]
[ :option:`-h`\ *headers* ]
[ :option:`-o`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

.. include:: explain_grd_in.rst_

可选选项
------------------

.. option:: -A

**-A**\ *transparency*\ [**+a**]
    设置透明度，*transparency* 的取值范围是0到100。
    加上 **+a** 则该透明度同时应用于前景色、背景色和NaN颜色。
    默认不透明，即0。

.. include:: create_cpt.rst_

.. option:: -D

**-D**\ [**i**\|\ **o**]
	将背景色和前景色分别设置为输出的CPT文件中最低值和最高值对应的颜色（ :option:`-D` 默认等效于 :option:`-D`\ **o** ）。
	不设置本项时，GMT默认使用主CPT文件规定的背景色与前景色，或是采用配置参数
	:term:`COLOR_BACKGROUND`\、:term:`COLOR_FOREGROUND` 与 :term:`COLOR_NAN` 的设置。
	加上 **i** 则设置为主CPT文件中最低值和最高值对应的颜色。

.. option:: -E

**-E**\ [*nlevels*][**+c**][**+f**\ *file*]
    保持 CPT 中的颜色区间数量保持不变，将 CPT 的取值范围变为网格文件的 Z 值范围，创建一个线性颜色表。
    附加 *nlevels* 把颜色表重新采样为 *nlevels* 个等间距的切片。
    附加 **+c** 以估计数据的累积分布函数并相应地分配颜色区间。
    如果使用了 **+c**，则可以附加 **+f** 以将 CDF 保存到 *file*；输出格式请参见 :option:`-bo` 和 :option:`-o` 。

.. include:: explain_cpt_output.rst_

.. option:: -G

**-G**\ *zlo*\ /\ *zhi*
    截断主CPT文件，将主CPT的最小和最大z值分别限制为 *zlo* 与 *zhi*。

.. option:: -H

**-H**\
    仅限现代模式：
    默认情况下是将CPT保存为隐藏的当前CPT，加上 :option:`-H` 命令会显式地将CPT写入标准输出。
    在写制作动画的脚本时，需要传递显式命名的CPT文件，因此需要使用本功能。
    建议阅读《 :doc:`/migrating/classic2modern` 》。

.. option:: -I

**-I**\ [**c**][**z**]
	利用 **-Iz** 选项倒转CPT的z值指向（不包括前景色、背景色）。
	利用 **-Ic** 选项翻转颜色的顺序，包括前景色和背景色。详细用法和说明见《 :doc:`/cpt/makecpt` 》。

.. option:: -L

**-L**\ *minlimit/maxlimit*
    将 CPT 的范围限制在 *minlimit/maxlimit* 之间，并在估计 CDF(Z) 时不统计该范围之外的数据。
    若要仅设置一个限制，请将另一个限制指定为“-”[默认使用数据的最小值和最大值]。

.. option:: -M

**-M**
    使用 :term:`COLOR_BACKGROUND` ， :term:`COLOR_FOREGROUND` 和 :term:`COLOR_NAN` 参数值，
    覆盖主 CPT 中指定的背景色、前景色和 NaN 颜色。当与 :option:`-D` 一起使用时，仅考虑 :term:`COLOR_NAN`。

.. option:: -N

**-N**
    不输出背景、前景和 NaN 颜色字段 [默认将输出这些字段]。

.. option:: -Q

**-Q**\ [**i**\|\ **o**]
    选择对数插值方案 [默认为线性]。
    **-Qi** 表示输入的 z 值为 :math:`\log_{10}`(z)，分配颜色并输出 z [默认]。
    **-Qo** 先取 :math:`\log_{10}`(z)，分配颜色，然后输出 z。

.. include:: explain_-R.rst_

.. option:: -S

**-S**\ **h**\|\ **l**\|\ **m**\|\ **u**
    强制生成0对称的CPT (范围从 -*R* 到 +\ *R*)。 **-Sl** : *R* =\|zmin\|, **-Su** : *R* =
    \|zmax\|, **-Sm** : *R* = min(\|zmin\|, \|zmax\|), **-Sh** : *R* =
    max(\|zmin\|, \|zmax\|).

.. option:: -T

**-T**\ *start/stop/inc* 或 **-T**\ *n*
    指定要生成的 CPT 文件的 Z 值范围( *start* to *stop* )及 Z 值间隔(*inc*)。
    默认情况下，会基于高斯累积分布函数 (CDF) 的等间距值，通过一种复杂的方案来自动计算这些值。
    使用 **-T**\ *n* 会从累积正态分布中选择 *n* 个点生成 CPT 文件的 *n* 个颜色区间 [默认 11]。

.. include:: explain_-V.rst_
    使用本选项会把 CDF(Z) 的估计值写入到 stderr。

.. option:: -W

**-W**\ [**w**]
    不对输入颜色表进行插值，而是从色板的起始处开始选取输出颜色。这在与分类颜色表结合使用时特别有用。
    使用 **-Ww** 生成一个循环（周期性）颜色表，使其范围无限循环重复。

.. option:: -Z

**-Z**
    强制生成连续的CPT文件（默认为离散不连续的CPT）。

.. include:: explain_-bo.rst_
    使用 :option:`-E` 保存 CDF 时有效。

.. include:: explain_-h.rst_

.. include:: explain_help.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_transparency.rst_

颜色铰链
--------

一些 GMT 主动态 CPT 实际上是两个在 *铰链 (hinge)* 处汇合的独立 CPT。
通常，跨越铰链时颜色会发生剧烈变化，这被用于区分两个不同的域（例如，跨越海岸线的陆地和海洋）。
具有铰链的 CPT 将根据规定的新范围分别拉伸其两个部分，即从底部到铰链的部分与从铰链到顶部的部分将相互独立地进行拉伸。
铰链分为 **硬 (hard)** 铰链或 **软 (soft)** 铰链。软铰链必须通过在 CPT 名称后附加 **+h**\ [*hinge*] 来 **激活**。
如果选定的范围不包含已激活的软铰链或硬铰链，则仅从 CPT 中属于该范围的那一半采样颜色。

离散与连续 CPT
------------------------

所有的 CPT 都可以被拉伸，但只有连续的 CPT 可以在新节点处采样（即通过在 :option:`-T` 中给定增量）。
施加此限制是为了避免对原始 CPT 产生混叠。

示例
--------

根据0/60/0/60范围内的5分精度的地形起伏数据，以GMT自带的geo为主CPT文件，生成对称的CPT::

    gmt grd2cpt @earth_relief_05m -R0/60/0/60 -Cgeo -Su

根据用户自己的数据mydata.nc，以GMT自带的relief为主CPT，以20为间隔生成0 - 200范围内的CPT文件::

    gmt grd2cpt mydata.nc -Crelief -T0/200/20

相关模块
--------

:doc:`grdhisteq`,
:doc:`grdinfo`,
:doc:`makecpt`

参考文献
----------

Crameri, F., (2018). Scientific colour-maps. Zenodo. http://doi.org/10.5281/zenodo.1243862

Crameri, F. (2018), Geodynamic diagnostics, scientific visualisation and StagLab 3.0,
*Geosci. Model Dev.*, 11, 2541-2562, https://doi.org/10.5194/gmd-11-2541-2018.