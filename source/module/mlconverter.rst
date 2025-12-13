:author: 何星辰, 田冬冬
:date: 2025-10-11

.. index:: ! mlconverter
.. include:: common_SYN_OPTs.rst_

.. program:: mlconverter

mlconverter
=============

:官方文档: :doc:`gmt:supplements/gsfml/mlconverter`
:简介: 使用选定的磁性地磁时间尺度将磁性带转换为地质年龄

**mlconverter** 模块是 (Global Seafloor Fabric and Magnetic Lineation Project) 的一部分。( 简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。
该模块的主要功能是读取磁性拾取数据文件 ( 或标准输入 ) ，并根据选定的磁性时间尺度，将地磁条带纪的文本标识转换为相应的地质年龄。输入数据必须为 OGR/GMT 格式的数据文件，其格式应与 GSFML 项目所提供的数据文件一致。

语法
--------

**gmt mlconverter** [ *ML_data* ]
[ |-A| ]
[ |-G|\ [**s**] ]
[ |-I|\ *FZid* ] 
[ |-T|\ **c**\|\ **g**\|\ **o**\|\ **s** ]
[ |SYN_OPT-V| ]

注意：选项标志与其对应的参数之间不允许有空格。

可选选项
------------------

*ML_data*
    一个磁性 ML 拾取数据的 OGR/GMT 格式文件。
    如果未指定该文件，则程序将从标准输入读取数据。

.. option:: -A

**-A**
    将元数据作为附加列添加到输出记录中。
    默认情况下仅输出 *lon*、*lat* 和 *age* 三个字段。

.. option:: -G

**-G**\ [**s**]
    通过附加地壳年龄生成扩展的 OGR/GMT 表格。
    如有必要，可添加 **s** 来修正不严格的地磁条带命名。

.. option:: -T

**-T**\ **c**\|\ **g**\|\ **o**\|\ **s**
    选择要使用的地磁时间尺度。可选：**c** (Cande and Kent, 1995), **g** (Gee and Kent, 2007), **o** (Ogg, 2012), **s** (Gradstein, 2004),默认为 **g**。

.. option:: -Z

**-Z**\ *acut*/*vcut*/*fcut*/*wcut*
   我们将尝试为模型分配一个综合质量指标 *Q*，用于表示模型拟合的优劣程度。该指标的确定依赖于四个需要通过经验确定的阈值参数：

    * *a_cut*：剖面模型的最小峰谷振幅（单位：Eotvos），默认值为 25；
    * *v_cut*：模型提供的最小方差降低百分比（单位：%），默认值为 50；
    * *f_cut*：模型计算得到的最小 *F* 统计量，默认值为 50；
    * *w_cut*：典型的断裂带（FZ）槽宽（单位：公里），默认值为 15。

    目前，前面三个参数用于为拟合模型生成一个五级质量指数（范围 0–1），其划分如下：

    * **1.00（非常好）**：模型参数超过全部三个阈值；
    * **0.75（良好）**：模型振幅和方差降低均超过阈值；
    * **0.50（一般）**：仅方差降低超过阈值；
    * **0.25（较差）**：仅振幅超过阈值；
    * **0.00（差）**：不满足任何条件。

    我们分别为 *trough* 模型和 *blend* 模型计算质量指数。
    对于 *empirical trough* 模型，仅有峰谷振幅 *A* 和槽宽 *W* 的估计值。此时，计算公式为：
    取比值 (*A* / *a_cut*) 除以 (*W* / *w_cut*)，再取其反正切 :math:`\tan^{-1}`，
    并将结果缩放至 0–1 范围内，最后四舍五入到最接近的 0.25。

.. include:: explain_-V.rst_
    
.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-qi.rst_

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
