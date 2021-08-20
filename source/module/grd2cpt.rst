.. index:: ! grd2cpt

*******
grd2cpt
*******

:官方文档: :doc:`gmt:grd2cpt`
:简介: 根据grid文件生成CPT

语法
--------

.. include:: common_SYN_OPTs.rst_

**gmt grd2cpt** *grid*
[ |-A|\ *transparency*\ [**+a**] ]
[ |-C|\ *cpt* ]
[ |-D|\ [**i**\|\ **o**] ]
[ |-E|\ [*nlevels*][**+c**][**+f**\ *file*] ]
[ |-F|\ [**R**\|\ **r**\|\ **h**\|\ **c**][**+c**\ [*label*]] ]
[ |-G|\ *zlo*\ /\ *zhi* ]
[ |-H| ]
[ |-I|\ [**c**][**z**] ]
[ |-L|\ *minlimit/maxlimit* ]
[ |-M| ]
[ |-N| ]
[ |-Q|\ [**i**\|\ **o**] ]
[ |SYN_OPT-R| ]
[ |-S|\ **h**\|\ **l**\|\ **m**\|\ **u** ]
[ |-T|\ *start/stop/inc* ]
[ |SYN_OPT-V| ]
[ |-W|\ [**w**] ]
[ |-Z| ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT--| ]

描述
-----------

**grd2cpt** 读取一个或多个grid文件，并生成对应的CPT文件。在经典模式中，CPT文件的内容会输出到屏幕标准输出中。
而在现代模式中，该命令不会生成显式的CPT文件，而是隐式地将其自动设置为后面的绘图命令的默认CPT文件。
因此无法使用经典的 ``gmt grd2cpt grid > cpt`` 方式生成CPT文件。如果需要在现代模式中生成CPT文件，
则可以使用 **-H** 选项： ``gmt grd2cpt grid -H > cpt`` 。
关于经典模式和现代模式的语法区别，建议阅读《 :doc:`/migrating/classic2modern` 》。

grid文件的z值范围以外的数值，将分别使用3种颜色来表示，分别是：
背景色 (B，background color，表示低于最小z值时所对应的颜色)、
前景色 (F，foreground color，表示高于最大z值时所对应的颜色)、
以及NaN颜色 (N，表示z值被定义为NaN时对应的颜色，即z值未定义的情况)。
默认情况下，这三种颜色会沿用 **-C** 选项所指定的主CPT文件的设置，但也可以使用 **-D** 选项进行修改。
或者使用 :doc:`gmtset` 命令对 :term:`COLOR_BACKGROUND`\、
\ :term:`COLOR_FOREGROUND` 与 :term:`COLOR_NAN` 进行自定义修改。

颜色模式 (RGB, HSV, CMYK) 会沿用 **-C** 选项所指定的主CPT文件的设置。
或者使用 :doc:`gmtset` 命令对 :term:`COLOR_MODEL` 进行自定义修改。

必选选项
------------------

*grid*
    grid文件的文件名。 `grd2cpt` 将根据grid文件的z值范围生成对应的CPT文件。

可选选项
------------------

.. _-A:

**-A**\ *transparency*\ [**+a**]
    设置透明度，*transparency* 的取值范围是0到100。
    加上 **+a** 则该透明度同时应用于前景色、背景色和NaN颜色。
    默认不透明，即0。

.. _-C:

**-C**\ *cpt*
    指定主CPT文件，默认值是GMT自带的 **rainbow**。
    `grd2cpt` 根据主CPT文件的配色方案，将z值范围拉伸至grid文件的z值范围，生成新的CPT。
    GMT自带的CPT文件的配色方案列表，请参见《 :doc:`/cpt/builtin-cpt` 》。

    除了GMT自带的CPT文件，也可以设为用户自定义的CPT文件，也可以是通过
    **-C**\ *color1*,\ *color2*\[,\ *color3*] 语法指定一个线性连续变化的颜色列表。

.. _-D:

**-D**\ [**i**]
	将背景色和前景色分别设置为输出的CPT文件中最低值和最高值对应的颜色。
	不设置本项时，GMT默认使用主CPT文件规定的背景色与前景色，或是采用配置参数
	:term:`COLOR_BACKGROUND`\、:term:`COLOR_FOREGROUND` 与 :term:`COLOR_NAN` 的设置。
	加上 **i** 则设置为主CPT文件中最低值和最高值对应的颜色。

.. _-E:

**-E**\ *nlevels*
    生成的CPT文件会被重采样为 *nlevels* 个等间距的切片。

.. _-F:

**-F**\ [**R|r|h|c**][**+c**]
    使用默认选项 **-FR** ，输出的CPT以r/g/b，灰度值，或名称指定颜色；
    使用 **-Fr** ，输出的CPT以r/g/b方式指定颜色；
    使用 **-Fh** ，输出的CPT以h-s-v方式指定颜色；
    使用 **-Fc** ，输出的CPT以c/m/y/k方式指定颜色；
    附加 **+c** 以分类格式编写离散型调色板。

.. _-G:

**-G**\ *zlo*\ /\ *zhi*
    截断主CPT文件，将主CPT的最小和最大z值分别限制为 *zlo* 与 *zhi*。

.. _-H:

**-H**\
    仅限现代模式：
    默认情况下是将CPT保存为隐藏的当前CPT，加上 **-H** 命令会显式地将CPT写入标准输出。
    在写制作动画的脚本时，需要传递显式命名的CPT文件，因此需要使用本功能。
    建议阅读《 :doc:`/migrating/classic2modern` 》。

.. _-I:

**-I**\ [**c**][**z**]
	利用 **-Iz** 选项倒转CPT的z值指向（不包括前景色、背景色）。
	利用 **-Ic** 选项翻转颜色的顺序，包括前景色和背景色。详细用法和说明见《 :doc:`/cpt/makecpt` 》。

.. include:: explain_-R.rst_

.. _-S:

**-S**\ **h**\|\ **l**\|\ **m**\|\ **u**
    强制生成0对称的CPT (范围从 -*R* 到 +\ *R*)。 **-Sl** : *R* =\|zmin\|, **-Su** : *R* =
    \|zmax\|, **-Sm** : *R* = min(\|zmin\|, \|zmax\|), **-Sh** : *R* =
    max(\|zmin\|, \|zmax\|).

.. _-T:

**-T**\ *start/stop/inc* 
    定义要生成的CPT文件的Z值范围( *start* to *stop* )及Z值间隔(*inc*)。

.. _-Z:

**-Z**
    强制生成连续的CPT文件（默认为离散不连续的CPT）。

.. |Add_-bo| replace:: [Default is 2]. This option
    only applies if **-E** selects CDF output.
.. include:: explain_-bo.rst_

.. include:: explain_help.rst_

.. include:: explain_-ocols.rst_

示例
--------

根据0/60/0/60范围内的5弧分精度的地形起伏数据，以GMT自带的geo为主CPT文件，生成对称的CPT::

    gmt grd2cpt @earth_relief_05m -R0/60/0/60 -Cgeo -Su

根据用户自己的数据mydata.nc，以GMT自带的relief为主CPT，以20为间隔生成0 - 200范围内的CPT文件::

    gmt grd2cpt mydata.nc -Crelief -T0/200/20
