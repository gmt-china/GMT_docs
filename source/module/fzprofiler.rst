:author: 何星辰, 田冬冬
:date: 2025-10-15

.. index:: ! fzprofiler
.. include:: common_SYN_OPTs.rst_

.. program:: fzprofiler

fzprofiler
=============

:官方文档: :doc:`gmt:supplements/gsfml/fzprofiler`
:简介: 绘制断裂带交叉剖面图的 Bash 脚本

**fzprofiler** 是一个脚本，是 (Global Seafloor Fabric and Magnetic Lineation Project)
的一部分。(简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。
它用于绘制由 :doc:`fzanalyzer` 生成的横断面剖面图及相关信息。所有剖面图将被组合在一个页面上，
页面大小会根据各个剖面图的尺寸自动调整。

语法
--------

**fzprofiler** [ |-H|\ *height*\ [**c**\|\ **i**\|\ **p**] ]
[ |-I|\ *profile* ] 
[ |-L|\ *inc* ]
[ |-M|\ *ncols* ]
[ |-T|\ *prefix* ]
[ |SYN_OPT-V| ]
[ |-W|\ *width*\ [**c**\|\ **i**\|\ **p**] ]

**注意**：选项标志和相关参数之间不允许有任何空格。

可选选项
------------------

.. option:: -H

**-H**\ *width*\ [**c**\|\ **i**\|\ **p**]
    设置单个剖面图的高度。如果未附加单位，则默认单位为 GMT 当前设置的 :term:`PROJ_LENGTH_UNIT`。

.. option:: -I

**-I**\ *profile*
    默认情况下，我们会将所有横断面剖面绘制为一个堆叠图。
    若要仅选择一个特定剖面，请指定其编号，其中 0 表示第一个剖面。

.. option:: -L

**-L**\ *inc*
    决定绘制哪些剖面。默认绘制每一个剖面 (*inc* = 1)。
    使用 |-L| 可以选择每隔 *inc* 个剖面绘制一次 [默认值为 1]。

.. option:: -N

**-N**\ *ncols*
    设置剖面在图中的列数。
    如果 *ncols* = 1，则所有剖面垂直堆叠在一列中；
    若 *ncols* = 2，则剖面将在两列中平均分配，依此类推。

.. include:: explain_-V.rst_

**-T**\ *prefix*
    设置所有输入文件的文件名前缀，这些文件由 :doc:`fzanalyzer` 生成 [默认值为 fztrack]。
    文件包括 *prefix*\ _cross.txt、*prefix*\ _analysis.txt、*prefix*\ _par.txt，
    以及由 :doc:`grdtrack` 生成的重采样输出文件 *prefix*\ _resampled.txt。

.. option:: -W

**-W**\ *width*\ [**c**\|\ **i**\|\ **p**]
    设置单个剖面图的宽度。单位同 |-H|。

图像特征
--------

**fzprofiler** 在每个剖面图中集成了丰富的信息，使用不同的符号与颜色进行区分。
横断面 VGG 数据以红色圆点显示，并用淡红色虚线连接。
由 :doc:`fzanalyzer` 的 **-D** 选项定义的中心带区域以浅蓝色表示。
黑色线条表示最优对称槽模型；倒三角表示断裂带（FZ）最佳位置，误差条表示半宽度。
蓝色线条表示最优非对称混合模型；圆点表示最大 VGG 坡度的位置。
倒红三角及误差条表示经验确定的槽位置。
橙色虚线表示地壳年龄变化。
剖面方向由 W-E 或 S-N 标注指示，垂直刻度左侧为 VGG，右侧为年龄。
每个面板还打印最佳混合参数。

示例
--------

若要分别查看横断面、最佳拟合模型及最优断裂带位置，
使用此前的前缀 “traces”，将剖面分为两列，每个剖面宽 6 英寸、
高 2 英寸，可执行以下命令::

    fzprofiler -Ttraces -W6i -H2i -N2 -V

最终生成的图像文件名为 *prefix*\ _cross.pdf。
若希望在地图视图中查看同样的剖面，请使用 :doc:`fzmapper`。
若要绘制合成剖面，请参见 :doc:`fzmodeler`。

相关模块
--------

:doc:`fzanalyzer`,
:doc:`fzblender`,
:doc:`mlconverter`,
:doc:`fzinformer`,
:doc:`fzmodeler`,
:doc:`fzmapper`,
:doc:`grdtrack`

参考文献
--------

Wessel, P., Matthews, K. J., Müller, R. D., Mazzoni, 
A., Whittaker, J. M., Myhill, R., Chandler, M. T.,
2015, "Semiautomatic fracture zone tracking", 
*Geochem. Geophys. Geosyst.*, 16 (7), 2462–2472.
https://doi.org/10.1002/2015GC005853.
