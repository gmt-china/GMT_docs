:author: 何星辰
:date: 2025-10-13

.. index:: ! fzinformer
.. program:: fzinformer

fzinformer
=============

:官方文档: :doc:`gmt:supplements/gsfml/fzinformer`
:简介: 绘制与断裂带相关的统计信息的 Bash 脚本

**fzinformer** 是一个脚本，是 (Global Seafloor Fabric and Magnetic Lineation Project)
的一部分。(简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。
该脚本用于绘制与断裂带（FZ）相关的统计信息图，
这些统计数据是由工具 :doc:`fzanalyzer` 根据断裂带沿线位置计算得到的。

语法
--------

**fzinformer** 
[ :option:`-D` ]
[ :option:`-F`\ *max* ]
[ :option:`-I`\ *profile* ] 
[ :option:`-N`\ *max* ] 
[ :option:`-S`\ *max* ]
[ :option:`-T`\ *prefix* ]
[ :option:`-W`\ *max* ]
[ :option:`-V`\ [*level*] ]


可选选项
------------------

.. option:: -D

**-D**
     使用 :doc:`fzblender` 的过滤输出结果，而不是原始分析文件来生成绘图。
     此选项要求在运行 :doc:`fzblender` 时使用 **-D** 选项。

.. option:: -F

**-F**\ *max*
     设置绘图中 *F*-统计量的最大幅值 [10000]。
     此面板使用对数坐标轴；其他面板均为线性坐标。

.. option:: -I

**-I**\ *profile*
     默认情况下，我们将所有的横断面叠加绘制。
     若要仅选择单个剖面，请附加该剖面的序号，其中 0 表示第一个剖面。

.. option:: -N

**-N**\ *max*
     设置绘图中 VGG 幅值的最大范围（单位：Eotvos）[200]。

.. option:: -S

**-S**\ *max*
     设置断裂带（FZ）位移的最大（±）半范围（单位：km）[25]。

.. option:: -T

**-T**\ *prefix*
     设置在运行 :doc:`fzanalyzer` 和 :doc:`fzblender` 时使用的文件名前缀[默认值为 fztrack]。
     此处使用的文件为 *prefix*\ _analysis.txt（若使用 :option:`-D`，则为 *prefix*\ _filtered.txt）以及 *prefix*\ _blend.txt。

.. option:: -W

**-W**\ *max*
     设置断裂带宽度的最大范围（单位：km）[50]。

.. include:: explain_-V.rst_

.. option:: -Z

**-Z**\ *acut*/*vcut*/*fcut*/*wcut*
     我们将尝试为每个模型分配一个单一质量指数 *Q*，以总结模型拟合的优劣。
    该分配依赖四个需经验确定的阈值：
    
    - *a_cut*：交叉剖面模型的最小峰谷振幅（单位 Eotvos）[25]
    - *v_cut*：模型提供的最小方差降低（%）[50]
    - *f_cut*：模型计算的最小 F 统计量 [50]
    - *w_cut*：典型 FZ 槽宽（单位 km）[15]

    目前，前三个量用于生成五级质量指数（0-1），如下：

    1. Very Good（非常好）：模型参数均超过阈值
    2. Good（好）：幅度和方差降低超过阈值
    3. Fair（一般）：仅方差降低超过阈值
    4. Poor（差）：仅幅度超过阈值
    5. Bad（差）：未满足任何标准

    我们分别为槽模型和混合模型计算质量指数。对于经验槽模型，
    只估计峰谷振幅 *A* 和槽宽 *W*。这里，将比值 (*A*/*a_cut*) / (*W*/*w_cut*) 的
    反正切（:math:`\tan^{-1}`）缩放至 0-1 范围，并四舍五入到最接近 0.25 的倍数。

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_help.rst_

图像特征
--------

**fzinformer** 通过使用不同的符号和颜色，在每个绘图中展示大量信息。
从原始数据获得的经验信息以红色显示；
由强制槽型断裂带（FZ）模型得到的信息以绿色显示；
而由最优混合模型（blend model）得到的信息以蓝色显示。

对于每条断裂带（FZ），我们展示 7 个面板（Panel）：

* **面板 1（顶部）**：显示 *F*-统计量参数随距离的变化（槽模型为绿色，混合模型为蓝色）。
* **面板 2**：显示上述两个模型的方差降低量。
* **面板 3**：显示两个模型及经验数据（红色）的最大幅值。
* **面板 4**：显示三类数据的断裂带信号宽度。
* **面板 5**：显示数字化迹线与最优断裂带位置之间的偏移量（单位：km），每种类型对应一条曲线。
* **面板 6**：显示哪一侧为年轻一侧（左侧为 -1，右侧为 +1），假设采用太平洋边缘异常模型。
  当信号接近对称时，该值可能在两侧之间跳动，因此仅应在信号明显不对称时使用。
* **面板 7**：显示混合模型与槽模型的压缩参数 *C* ，以及最优混合模型的混合参数 *A* （黑线）。

示例
--------

若要查看名为 “traces” 的一组断裂带中，第 5 条（从 0 开始计数）的断裂带的统计信息，
并接受所有默认参数，仅将最大幅值上限修改为 100，可使用以下命令::

    fzinformer -Ttraces -N100 -I5

生成的统计图文件将命名为 *prefix*\ _stat.pdf。

相关模块
--------

:doc:`fzanalyzer`, 
:doc:`fzblender`, 
:doc:`mlconverter`, 
:doc:`fzmapper`, 
:doc:`fzmodeler`, 
:doc:`fzprofiler`

参考文献
--------

Wessel, P., Matthews, K. J., Müller, R. D., Mazzoni, 
A., Whittaker, J. M., Myhill, R., Chandler, M. T.,2015, 
"Semiautomatic fracture zone tracking", *Geochem. Geophys. 
Geosyst.*, 16 (7), 2462–2472.https://doi.org/10.1002/2015GC005853.
