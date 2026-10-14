:author: 何星辰, 田冬冬
:date: 2026-01-06

.. index:: ! mlconverter
.. program:: mlconverter

mlconverter
=============

:官方文档: :doc:`gmt:supplements/gsfml/mlconverter`
:简介: 使用选定的磁性地磁时间尺度将磁性带转换为地质年龄

**mlconverter** 模块是 (Global Seafloor Fabric and Magnetic Lineation Project) 的一部分。( 简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。
该模块的主要功能是读取磁性拾取数据文件 ( 或标准输入 ) ，并根据选定的磁性时间尺度，将地磁条带纪的文本标识转换为相应的地质年龄。输入数据必须为 OGR/GMT 格式的数据文件，其格式应与 GSFML 项目所提供的数据文件一致。

语法
--------

**gmt mlconverter**
[ *ML_data* ]
[ :option:`-A` ]
[ :option:`-G`\ [**s**] ]
[ :option:`-S` ]
[ :option:`-T`\ **c**\|\ **g**\|\ **o**\|\ **s** ]
[ :option:`-V`\ [*level*] ]

输入数据
------------------

*ML_data*
    一个磁性 ML 拾取数据的 OGR/GMT 格式文件。
    如果未指定该文件，则程序将从标准输入读取数据。

可选选项
------------------

.. option:: -A

**-A**
    将元数据作为附加列添加到输出记录中。
    默认情况下仅输出 *lon*、*lat* 和 *age* 三个字段。

.. option:: -G

**-G**\ [**s**]
    通过附加地壳年龄生成扩展的 OGR/GMT 表格。
    如有必要，可添加 **s** 来修正不严格的地磁条带命名。

.. option:: -S

**-S**
    使用严格的磁极性时命名法，报告任何不严谨的用法。

.. option:: -T

**-T**\ **c**\|\ **g**\|\ **o**\|\ **s**
    选择要使用的地磁时间尺度。可选：**c** (Cande and Kent, 1995), **g** (Gee and Kent, 2007), **o** (Ogg, 2012), **s** (Gradstein, 2004),默认为 **g**。

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

示例
--------

使用 (Cande and Kent,1995) 时间尺度将时间转换为地质年龄，并在记
录末尾添加元数据。

::

    gmt mlconverter -A -Tc ML_datafile.gmt > convertedfile.txt

相关模块
--------

:doc:`fzanalyzer`,
:doc:`fzblender`,
:doc:`fzinformer`,
:doc:`fzmapper`,
:doc:`fzmodeler`,
:doc:`fzprofiler`

参考文献
--------

Wessel, P., Matthews, K. J., Müller, R. D., Mazzoni, A., Whittaker, J. M., Myhill, R., Chandler, M. T., 2015, “Semiautomatic fracture zone tracking”, Geochem. Geophys. Geosyst., 16 (7), 2462–2472. https://doi.org/10.1002/2015GC005853.
