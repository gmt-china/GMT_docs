.. index:: ! fzmodeler
.. include:: common_SYN_OPTs.rst_

fzmodeler
=============

:贡献者: |何星辰|, |田冬冬|
:最近更新日期: 2025-10-13

----

:官方文档: :doc:`gmt:supplements/gsfml/fzmodeler`
:简介: 构建断裂带交叉剖面模型的 Bash 脚本

**zmodeler** 是一个脚本，是 (Global Seafloor Fabric and Magnetic Lineation Project)
的一部分。(简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。
该脚本根据选定的模型参数生成一个合成的横断面模型，并可选择将该剖面绘制为 PDF 图像。其所评估的模型为：

[
z(x) = A[mG_1 + (1 - m)(uG_2 - G_0)]
]

其中：

* *A* 表示幅值（由 |-N| 控制），
* *m* 表示不对称性（由 |-A| 控制），
* *u* 表示压缩率（由 |-C| 控制）。

这里，:math:`G_0` 是高斯函数（Gaussian function），
:math:`G_1` 和 :math:`G_2` 分别是其前两个水平方向导数。

**注意：** 混合模型（blend model）中会减去 :math:`G_0`，
因为在断裂带（Fracture Zones, FZ）中，我们希望得到负高斯形态的信号。

.. _GFSML_model:

.. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT_gsfml_components.png
    :width: 500 px
    :align: center

    这三个分量（高斯函数及其前两个导数）可用于构建一个混合模型，以拟合断裂带（FZ）横穿处的 VGG 异常。
    建模过程中还可能需要加入一个线性趋势项。


语法
--------

**fzmodeler** [ |-A|\ *asymmetry* ]
[ |-C|\ *compression* ]
[ |-D|\ *min*/*max*/*inc* ]
[ |-G|\ *comp* ]
[ |-M| ]
[ |-N|\ *amplitude* ]
[ |-O| ]
[ |-P| ]
[ |-S|\ *shift* ]
[ |-T|\ *prefix* ]
[ |SYN_OPT-V| ]
[ |-W|\ *width* ]

**注意**：选项标志和相关参数之间不允许有任何空格。

可选选项
------------------

.. _-A:

**-A**\ *asymmetry*
     设置混合模型中的不对称参数，用于在对称信号（“大西洋”）与不对称信号（“太平洋”）之间进行混合 [默认值 0]。

.. _-C:

**-C**\ *compression*
     设置混合中使用的压缩量（范围 0–1）[默认值 0]。

.. _-D:

**-D**\ *min*/*max*/*inc*
     设置评估模型的自变量范围。
     若使用 |-M| 选项，则范围以 km 为单位；否则，*min* 和 *max* 被认为是纬度（单位：度），*inc* 被解析为弧分 [-5/5/2 或 -100/100/2，取决于是否使用 |-M|]。

.. _-G:

**-G**\ *comp*
     仅绘制分量 :math:`G_i(x)`，其中 i = 0、1 或 2。

.. _-M:

**-M**
     当选定 |-D| 范围时，以纬度为单位，增量为弧分 [默认单位为 km]。

.. _-N:

**-N**\ *amplitude*
     设置混合信号的峰-谷幅值 [默认值 100]。

.. _-O:

**-O**
     不生成独立 PDF 图，而是将 PostScript 叠加层输出到标准输出（stdout），
     即使用 GMT 经典代码 **-O -K** 选项绘图。需要（或自动设置）|-P|。

.. _-P:

**-P**
     生成合成断裂带（FZ）剖面的 PDF 图（文件名为 *prefix*.pdf）[默认不绘图]。

.. _-S:

**-S**\ *shift*
     设置断裂带位置相对于原点的偏移量（单位：km）[默认值 0]。

.. _-T:

**-T**\ *prefix*
     设置模型剖面输出文件的前缀 [默认 fzprof]。
     若使用 |-T -|，则将模型剖面输出到标准输出（stdout）。

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *width*
     设置断裂带的全宽度（单位：km）[默认值 25]。

示例
--------

若要绘制太平洋的合成剖面，并使用其他默认参数，可执行::

    fzmodeler -C1 -V

生成的最终图像文件为 *prefix*.pdf，模型数据为 *prefix*.txt。若仅绘制归一化分量 :math:`G_2(x)`，可执行::

    fzmodeler -D-30/30/1 -C1 -N1 -W10 -G2 -T- | gmt plot -W1p -B -R-30/30/-1/1 -png G2


相关模块
--------

:doc:`fzanalyzer`,
:doc:`fzblender`,
:doc:`mlconverter`,
:doc:`fzinformer`,
:doc:`fzprofiler`,
:doc:`fzmapper`,

参考文献
--------

Wessel, P., Matthews, K. J., Müller, R. D., Mazzoni, 
A., Whittaker, J. M., Myhill, R., Chandler, M. T.,2015, 
"Semiautomatic fracture zone tracking", *Geochem. Geophys. 
Geosyst.*, 16 (7), 2462–2472.https://doi.org/10.1002/2015GC005853.