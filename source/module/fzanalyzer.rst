.. index:: ! fzanalyzer
.. include:: common_SYN_OPTs.rst_

fzanalyzer
=============

:贡献者: |何星辰|
:最近更新日期: 2025-10-11

----

:官方文档: :doc:`gmt:supplements/gsfml/fzanalyzer`
:简介: 使用交叉剖面分析断裂带

**fzanalyzer** 是是 (Global Seafloor Fabric and Magnetic Lineation Project) 的一部分。( 简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。它读取由 :doc:`grdtrack` 生成的已处理断裂带（FZ）轨迹和横剖面数据。然后通过检查与 FZ 走向正交的剖面来分析每条 FZ 的轨迹，并使用一种由 “Atlantic-style” 对称槽和 “Pacific-style” 不对称偶极状异常混合组成的模型，并结合一些外围隆起进行建模。我们还仅拟合对称槽模型，并检查经验数据的最小值和槽宽。随后对数据槽的宽度以及由各种模型给出的最佳 FZ 位置的:math:`1-\sigma`不确定性进行估计。我们还计算若干统计指标，并返回沿每条 FZ 距离变化的所有模型参数。

语法
--------

**gmt fzanalyzer** *crossprofiles*
|-F|\ *fzlines*
[ |-A|\ *min*/*max*/*inc* ]
[ |-C|\ *min*/*max*/*inc* ]
[ |-D|\ *corrwidth* ]
[ |-I|\ *FZ*\ [/*profile*] ]
[ |-S|\ [**b**\|\ **c**]]
[ |-T|\ *prefix* ]
[ |SYN_OPT-V| ]
[ |-W|\ *min*/*max*/*inc* ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-do| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT--| ]

必须选项
------------------

*crossprofiles*
    该文件是使用 :doc:`grdtrack` 命令并带有 **-C** 选项，从一个或多个断裂带（FZ）的近似数字化轨迹（包含 *lon*, *lat*）生成的横剖面表格。此表格是一个 ASCII（或二进制，参见 **-bi**）文件，必须包含 7 个数据列：
    *lon, lat, dist, azimuth, vgg, age, fzdist*。

.. _-F:

**-F**\ *fzlines*
    其中，*fzlines* 是通过运行 :doc:`grdtrack` 命令并使用 **-D** 选项获得的重采样轨迹文件。与 *crossprofiles* 文件类似，该文件必须包含相同的 7 个数据列：
    *lon, lat, dist, azimuth, vgg, age, fzdist*。

可选选项
------------------

.. _-A:

**-A**\ *min*/*max*/*inc*
    指定一个或三个参数，用于控制模型信号混合的方式。
    其中，*min* 为最小不对称值 [0，对应 “Atlantic” 型对称槽]；
    *max* 为最大不对称值 [1，对应 “Pacific” 型偶极信号]；
    *inc* 为搜索时使用的步进增量 [默认 0.05]。
    若只需指定一个固定的不对称值（不进行搜索），则只需提供该单一值。

.. _-C:

    **-C**\ *min*/*max*/*inc*
    指定一个或三个参数，用于控制 “compression” 模型信号的搜索方式。
    其中，*min* 为最小压缩值 [0]；
    *max* 为最大压缩值 [1，对应 “Mexican Hat” 端元模型]；
    *inc* 为搜索步进增量 [默认 0.05]。
    若只需指定一个固定压缩值（不进行搜索），则只需提供该单一值。

.. _-D:

**-D**\ *corrwidth*
    指定中心走廊宽度 *corrwidth*（单位：km）[默认 25]。
    此走廊用于限定断裂带（FZ）槽位置在重新定位时允许偏离中心的最大范围。

.. _-I:

**-I**\ *FZ*\ [/*profile*]
    默认情况下，程序会分析所有断裂带（FZ）生成的横剖面。
    但你可以使用 |-I| 指定特定的断裂带 *id*（首个为 0）。
    还可指定仅处理该断裂带中的某一个 *profile* [默认处理全部]。
    注意，输出文件仍会包含所有剖面，但仅所选剖面对应的导出参数为非零。

.. _-S:

    **-S**\ [**b**|\ **c**]
    以命令行选项设置的参数输出，格式适用于直接嵌入 Bourne/bash shell 脚本中。
    若附加 **c**，则输出为 csh/tcsh 语法格式。

.. _-T:

**-T**\ *prefix*
    设置所有输出文件所使用的文件名前缀 [默认 *fztrack*]。

.. _-W:

**-W**\ *min*/*max*/*inc*
    指定三个参数，用于控制断裂带（FZ）横向信号建模的方式。
    其中，*min* 为最小 FZ 信号宽度（单位：km），用于非线性宽度搜索 [默认 1]；
    *max* 为最大宽度 [默认 50]；
    *inc* 为宽度搜索的步进增量 [默认 1]。
    建议根据具体研究区域调整合适的取值范围并相应设置 |-W|。
    若选择的范围过宽，可能导致模型拟合受到与 FZ 槽无关的数据特征干扰，从而产生虚假结果。

.. include:: explain_-V.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-qi.rst_

.. include:: ../../explain_help.rst_

输入文件
--------

这两个输入文件本身是通过首先运行 :doc:`grdtrack` 生成的。
该步骤需要一组数字化的断裂带（FZ）轨迹（*lon*, *lat*）以及三个数据网格：
(a) 垂直重力梯度（VGG）文件，
(b) 2 分钟分辨率的地壳年龄网格，
(c) 与最近断裂带的距离网格（单位：km），
按上述顺序排列。

其中最关键的是 *VGG 网格文件*。
如果你没有或不关心年龄和距离信息，可以创建全为 NaN 的虚拟网格文件。你可以使用 :doc:`grdtrack` 的 **-C** 和 **-D** 选项来设计横剖面布局并生成重新采样的断裂带轨迹。

