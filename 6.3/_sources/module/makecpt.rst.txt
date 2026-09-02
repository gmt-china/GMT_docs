.. index:: ! makecpt
.. include:: common_SYN_OPTs.rst_

makecpt
=======

:官方文档: :doc:`gmt:makecpt`
:简介: 制作GMT CPT文件

描述
-----------

在经典模式中，CPT文件的内容会输出到屏幕标准输出中。
而在现代模式中，该命令不会生成显式的CPT文件，而是隐式地将其自动设置为后面的绘图命令的默认CPT文件。
因此无法使用经典的 ``gmt makecpt > cpt`` 方式生成CPT文件。如果需要在现代模式中生成CPT文件，
则可以使用 |-H| 选项： ``gmt makecpt -H > cpt`` 。
关于经典模式和现代模式的语法区别，建议阅读《 :doc:`/migrating/classic2modern` 》。

**-T** 选项所指定的z值范围以外的数值，将分别使用3种颜色来表示，分别是：
背景色 (B，background color，表示低于最小z值时所对应的颜色)、
前景色 (F，foreground color，表示高于最大z值时所对应的颜色)、
以及NaN颜色 (N，表示z值被定义为NaN时对应的颜色，即z值未定义的情况)。
默认情况下，这三种颜色会沿用 |-C| 选项所指定的主CPT文件的设置，但也可以使用 |-D| 选项进行修改。
或者使用 :doc:`gmtset` 命令对 :term:`COLOR_BACKGROUND`\、
\ :term:`COLOR_FOREGROUND` 与 :term:`COLOR_NAN` 进行自定义修改。

颜色模式 (RGB, HSV, CMYK) 会沿用 |-C| 选项所指定的主CPT文件的设置。
或者使用 :doc:`gmtset` 命令对 :term:`COLOR_MODEL` 进行自定义修改。

选项
----

**-A**\ *transparency*\ [**+a**]
    设置透明度，*transparency* 的取值范围是0到100。
    加上 **+a** 则该透明度同时应用于前景色、背景色和NaN颜色。
    默认不透明，即0。

**-C**\ *cpt*
    指定主CPT文件，默认值是GMT自带的 **rainbow**。 `makecpt` 根据主CPT文件的配色方案，将z值范围拉伸至 |-T|
    指定的范围，生成新的CPT。GMT自带的CPT文件的配色方案列表，请参见《 :doc:`/cpt/builtin-cpt` 》。

    除了GMT自带的CPT文件，也可以设为用户自定义的CPT文件，也可以是通过
    **-C**\ *color1*,\ *color2*\[,\ *color3*] 语法指定一个线性连续变化的颜色列表。

**-D**\ [**i**]
	将背景色和前景色分别设置为输出的CPT文件中最低值和最高值对应的颜色。
	不设置本项时，GMT默认使用主CPT文件规定的背景色与前景色，或是采用配置参数
	:term:`COLOR_BACKGROUND`\、:term:`COLOR_FOREGROUND` 与 :term:`COLOR_NAN` 的设置。
	加上 **i** 则设置为主CPT文件中最低值和最高值对应的颜色。

**-E**\ *nlevels*
    生成的CPT文件会被重采样为 *nlevels* 个等间距的切片。

**-F**\ [**R|r|h|c**][**+c**]
    使用默认选项 **-FR** ，输出的CPT以r/g/b，灰度值，或名称指定颜色；
    使用 **-Fr** ，输出的CPT以r/g/b方式指定颜色；
    使用 **-Fh** ，输出的CPT以h-s-v方式指定颜色；
    使用 **-Fc** ，输出的CPT以c/m/y/k方式指定颜色；
    附加 **+c** 以分类格式编写离散型调色板。

**-G**\ *zlo*\ /\ *zhi*
    截断主CPT文件，将主CPT的最小和最大z值分别限制为 *zlo* 与 *zhi*。

**-H**\
    仅限现代模式：
    默认情况下是将CPT保存为隐藏的当前CPT，加上 |-H| 命令会显式地将CPT写入标准输出。
    在写制作动画的脚本时，需要传递显式命名的CPT文件，因此需要使用本功能。
    建议阅读《 :doc:`/migrating/classic2modern` 》。

**-I**\ [**c**][**z**]
	利用 **-Iz** 选项倒转CPT的z值指向（不包括前景色、背景色）。
	利用 **-Ic** 选项翻转颜色的顺序，包括前景色和背景色。详细用法和说明见《 :doc:`/cpt/makecpt` 》。

**-T**\ *z_min*/*z_max*\[/*z_inc*\[**+n**]] 或 **-T**\ *ztable*
    定义要生成的CPT文件的Z值范围及Z值间隔

    - 若使用了 |-C| 选项且 *z_inc* 未指定，则Z值间隔的数目与输入的主CPT文件相同。
    - 若 *z_inc* 后有 **+n**，则将 *z_inc* 解释为Z值间隔的数目而不是Z值间隔
    - 也可以指定文件 *ztable*，其中每行一个Z值
    - 若不使用 |-T| 选项，则默认使用主CPT文件中的Z值范围

**-Z**
    生成连续CPT文件。默认生成不连续CPT文件，即每个Z值切片内为同一颜色
