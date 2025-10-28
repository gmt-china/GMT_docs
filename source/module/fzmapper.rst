:author: 何星辰, 田冬冬
:date: 2025-10-13

----

.. index:: ! fzmapper
.. include:: common_SYN_OPTs.rst_

fzmapper
=============


----

:官方文档: :doc:`gmt:supplements/gsfml/fzmapper`
:简介: 在墨卡托地图上绘制断裂带交叉剖面的 Bash 脚本

**fzmapper** 是一个脚本，是 (Global Seafloor Fabric and Magnetic Lineation Project)
的一部分。(简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。
该脚本用于根据处理后的断裂带（FZ）迹线和由 :doc:`grdtrack` 生成的横断面数据，
来绘制横断面的墨卡托（Mercator）投影地图。
此外，还可选择叠加分析结果与混合模型（blend）结果。

语法
--------

**fzmapper** [ |-A| ]
[ |-F|\ *origfile* ]
[ |-G|\ *vgg_grid* ]
[ |-L|\ *labelint* ] 
[ |-O| ]
[ |-S| ]
[ |-T|\ *prefix* ]
[ |SYN_OPT-V| ]
[ |-W|\ *width*\ [**c**\|\ **i**\|\ **p**] ]

**注意**：选项标志和相关参数之间不允许有任何空格。

可选选项
------------------

.. _-A:

**-A**
     除了重采样后的断裂带（FZ）迹线和横断面外，还叠加 :doc:`fzanalyzer` 的结果，
     以颜色编码的点进行显示（红色代表数据，绿色代表槽模型，蓝色代表混合模型）
     [默认不叠加模型结果]。

.. _-F:

**-F**\ *profile*
     这是最初数字化的断裂带（FZ）迹线文件，
     该文件被作为输入提供给 :doc:`grdtrack`。

.. _-G:

**-G**\ *vgg_grid*
     可选参数，指定用作背景的 VGG 网格名称
     [默认值：@earth_vgg_02m]。

.. _-O:

**-O**
     不生成独立的 PDF 图像，而是将 PostScript 叠加层输出到标准输出（stdout），
     即使用 GMT 的 **-O -K** 选项绘制图像。

.. _-S:

**-S**
     叠加由 :doc:`fzblender` 生成的平滑断裂带迹线 [默认不叠加]。

.. _-T:

**-T**\ *prefix*
     设置所有输入文件的文件名前缀，该前缀由 :doc:`fzanalyzer` 生成
     [默认值为 fztrack]。
     输入文件包括 *prefix*\ _cross.txt、*prefix*\ _par.txt，以及由 :doc:`grdtrack`
     生成的重采样输出文件 *prefix*\ _resampled.txt。
     当使用 |-S| 选项时，还会加载由 :doc:`fzblender` 生成的 *prefix*\ _blend.txt；
     若使用 |-A| 选项，还会加载由 :doc:`fzanalyzer` 生成的 *prefix*\ _analysis.txt。

.. _-W:

**-W**\ *width*\ [**c**\|\ **i**\|\ **p**]
     设置墨卡托投影地图的 *宽度*。
     若未指定单位，则默认使用 GMT 当前的 :term:`PROJ_LENGTH_UNIT` 单位。

.. include:: explain_-V.rst_

示例
--------

若要以地图视图查看横断面、最优拟合模型以及最优断裂带位置，
文件前缀为 “traces”，地图宽度为 9 英寸（Mercator 投影），
并且仅标注每隔一个横断面，可使用以下命令::

    fzmapper -Ttraces -W9i -L2 -Fguides.txt -S -V -A

其中，`guides.txt` 为原始数字化的断裂带位置文件，
并选择仅为每隔一个剖面添加注释。生成的最终地图文件将命名为 *prefix*\ _map.pdf。
若要查看横断面剖面图，请参阅 :doc:`fzprofiler`。

相关模块
--------

:doc:`fzanalyzer`, 
:doc:`fzblender`, 
:doc:`mlconverter`, 
:doc:`fzinformer`, 
:doc:`fzmodeler`, 
:doc:`fzprofiler`,
:doc:`grdtrack`

参考文献
--------

Wessel, P., Matthews, K. J., Müller, R. D., Mazzoni, 
A., Whittaker, J. M., Myhill, R., Chandler, M. T.,2015, 
"Semiautomatic fracture zone tracking", *Geochem. Geophys. 
Geosyst.*, 16 (7), 2462–2472.https://doi.org/10.1002/2015GC005853.