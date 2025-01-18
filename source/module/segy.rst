.. index:: ! segy
.. include:: common_SYN_OPTs.rst_

segy
======

:官方文档: :doc:`gmt:supplements/segy/segy`
:简介: 读取一个原生（IEEE）格式的 SEGY 文件，并生成地震数据的绘图。使用 **imagemask** 操作符将地震数据以单色或灰度（由用户指定）1-bit 深度位图的形式绘制，背景为透明。位图分辨率取自当前的 GMT 默认设置。通过使用道头中的信息，可以在真实位置绘制地震道（此时，文件中道的顺序无关紧要）。标准的 GMT 几何处理方法被用于绘制，因此原则上可以采用任何地图投影。然而，地理投影可能会导致意外的结果。另外需注意，某些参数具有非标准含义。

需要注意的是，在绘制地震数据之前，处理操作顺序为：**deviation*[clip]([bias]+[normalize](sample value))**。  
其中，**deviation** 决定了在绘图坐标系中，**[normalized][biased][clipped]** 的样本值为 1 时，与道位置的偏移距离。

SEGY 文件应包含 3200 字节的文本头部（将被忽略）、400 字节的二进制卷头、以及每道 240 字节的头部

语法
------

**gmt segy** *SEGYfile* |-J|\ *parameters*
|SYN_OPT-R|
|-D|\ *deviation*
|-F|\ [*color*] |-W|
[ |-C|\ *clip* ]
[ |-E|\ *error* ] [ |-I| ] [ |-L|\ *nsamp* ]
[ |-M|\ *ntrace* ] [ |-N| ]
[ |-Q|\ **b**\|\ **i**\|\ **u**\|\ **x**\|\ **y**\ *value* ]
[ |-S|\ *header* ]
[ |-T|\ *filename* ]

必须选项
------------------

*SEGYfile*
    地震 SEGY 数据文件

.. _-D:

**-D**\ *deviation*
   表示在缩放后的地震道上，值为 1.0 时在绘图中 X 轴单位上的偏移量。

.. _-F:

**-F**\ [*color*]
    填充地震道（可变面积，默认填充正值）。指定用于填充 **imagemask** 的颜色 *color* 。

.. _-W:

**-W**
    绘制波形道。

注意： *必须* 在 |-W| 和 |-F| 之中指定至少一个选项。

Optional Arguments
------------------

.. _-A:

**-A**
    Flip the default byte-swap state (default assumes data have a
    bigendian byte-order).

.. _-C:

**-C**\ *clip*
    Sample value at which to clip data (clipping is applied to both
    positive and negative values).

.. _-E:

**-E**\ *error*
    Allow *error* difference between requested and actual trace
    locations when using |-T| option.

.. _-I:

**-I**
    Fill negative rather than positive excursions.

.. _-L:

**-L**
    Override number of samples per trace in reel header (program
    attempts to determine number of samples from each trace header if
    possible to allow for variable length traces).

.. _-M:

**-M**
    Override number of traces specified in reel header. Program detects
    end of file (relatively) gracefully, but this parameter limits
    number of traces that the program attempts to read.

.. _-N:

**-N**
    Normalize trace by dividing by rms amplitude over full trace length.

.. _-Q:

**-Q**\ **b**\|\ **i**\|\ **u**\|\ **x**\|\ **y**\ *value*
    Can be used to change 5 different settings depending on the directive (repeatable):
       **-Qb**\ *bias* to bias scaled traces (-**Qb**\ -0.1 subtracts 0.1 from values).

       **-Qi**\ *dpi* sets the dots-per-inch resolution of the image [300].

       **-Qu**\ *redvel* to apply reduction velocity (negative value removes reduction already present).

       **-Qx**\ *mult* to multiply trace locations by *mult*.

       **-Qy**\ *dy* to override sample interval in SEGY reel header.

.. _-S:

**-S**\ *header*
    Read trace locations from trace headers: header is either **c** for CDP,
    **o** for offset, or **b**\ *num* to read a long starting at byte *num* in the
    header (first byte corresponds to *num* = 0). Default has location given
    by trace number.

.. _-T:

**-T**\ *filename*
    Plot only traces whose location corresponds to a list given in
    *filename*. Order in which traces are listed is not significant -
    the entire space is checked for each trace.

.. |Add_-U| replace:: |Add_-U_links|
.. include:: ../../explain_-U.rst_
    :start-after: **Syntax**
    :end-before: **Description**

.. |Add_-V| replace:: |Add_-V_links|
.. include:: /explain_-V.rst_
    :start-after: **Syntax**
    :end-before: **Description**

.. |Add_-XY| replace:: |Add_-XY_links|
.. include:: ../../explain_-XY.rst_
    :start-after: **Syntax**
    :end-before: **Description**

.. _-Z:

**-Z**
    Do not plot traces with zero rms amplitude.

.. |Add_perspective| unicode:: 0x20 .. just an invisible code
.. include:: ../../explain_perspective.rst_

.. include:: ../../explain_-t.rst_
.. include:: ../../explain_help.rst_

.. module_common_ends

Examples
--------

.. include:: ../../oneliner_info.rst_

To plot the SEGY file wa1.segy with normalized traces plotted at true
offset locations, clipped at ±3 and with wiggle trace and positive
variable area shading in black, use

::

  gmt segy wa1.segy -JX5i/-5i -R0/100/0/10 -D1 -C3 -N -So -W -Fblack -pdf segy

To plot the SEGY file wa1.segy with traces plotted at true cdp\*0.1,
clipped at ±3, with bias -1 and negative variable area shaded red, use

::

  gmt segy wa1.segy -JX5i/-5i -R0/100/0/10 -D1 -C3 -Sc -Qx0.1 -Fred -Qb-1 -I -pdf segy

