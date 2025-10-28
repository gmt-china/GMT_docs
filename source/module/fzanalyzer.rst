.. index:: ! fzanalyzer
.. include:: common_SYN_OPTs.rst_

fzanalyzer
==========

:贡献者: |何星辰|, |田冬冬|
:最近更新日期: 2025-10-11

----

:官方文档: :doc:`gmt:supplements/gsfml/fzanalyzer`
:简介: 使用交叉剖面分析断裂带

**fzanalyzer** 是 (Global Seafloor Fabric and Magnetic Lineation Project) 的一部分。
( 简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。
它读取由 :doc:`grdtrack` 生成的已处理断裂带（FZ）轨迹和横剖面数据。
然后通过检查与 FZ 走向正交的剖面来分析每条 FZ 的轨迹，
并使用一种由 “Atlantic-style” 对称槽和 “Pacific-style” 不对称偶极状异常混合组成的模型，
并结合一些外围隆起进行建模。我们还仅拟合对称槽模型，并检查经验数据的最小值和槽宽。
随后对数据槽的宽度以及由各种模型给出的最佳 FZ 位置的:math:`1-\sigma`不确定性进行估计。
我们还计算若干统计指标，并返回沿每条 FZ 距离变化的所有模型参数。

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

必选选项
------------------

*crossprofiles*
    该文件是使用 :doc:`grdtrack` 命令并带有 **-C** 选项，
    从一个或多个断裂带（FZ）的近似数字化轨迹（包含 *lon*, *lat*）生成的横剖面表格。
    此表格是一个 ASCII（或二进制，参见 **-bi**）文件，必须包含 7 个数据列：
    *lon, lat, dist, azimuth, vgg, age, fzdist*。

.. _-F:

**-F**\ *fzlines*
    其中，*fzlines* 是通过运行 :doc:`grdtrack` 命令并使用
     **-D** 选项获得的重采样轨迹文件。与 *crossprofiles* 文件类似，
     该文件必须包含相同的 7 个数据列：
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

.. include:: explain_help.rst_

输入文件
--------

这两个输入文件本身是通过首先运行 :doc:`grdtrack` 生成的。
该步骤需要一组数字化的断裂带（FZ）轨迹（*lon*, *lat*）以及三个数据网格：
(a) 垂直重力梯度（VGG）文件，
(b) 2 分钟分辨率的地壳年龄网格，
(c) 与最近断裂带的距离网格（单位：km），
按上述顺序排列。

其中最关键的是 *VGG 网格文件*。
如果你没有或不关心年龄和距离信息，可以创建全为 NaN 的虚拟网格文件。
你可以使用 :doc:`grdtrack` 的 **-C** 和 **-D** 选项来设计横剖面布局并生成重新采样的断裂带轨迹。

最近断裂带距离
--------------

可以使用 :doc:`grdmath` 来生成制作剖面所需的“最近断裂带距离”网格（单位：公里）。
对于 Nazca plate ，示例如下::

    gmt grdmath -R-120/-65/-50/5 -I5m -fg digitize.txt LDIST DEG2KM = dist2fz.nc

由于对大量断裂带（FZ）进行该计算的速度较慢，因此没有必要在 **-I** 中使用过高的分辨率，
因为距离变化是平滑的，插值结果也会近似正确。建议生成一个全球网格，但将其划分为四个象限（或更小的区域块），
并在多核计算机上并行运行。
例如，要通过象限方式生成全球网格，可以运行以下命令::

    gmt grdmath -R0/180/0/90 -I2m -fg -V3 global_FZ.txt LDIST DEG2KM = WN.nc
    gmt grdmath -R180/360/0/90 -I2m -fg -V3 FZ_KM.txt LDIST DEG2KM = EN.nc
    gmt grdmath -R0/180/-90/0 -I2m -fg -V3 FZ_KM.txt LDIST DEG2KM = WS.nc
    gmt grdmath -R180/360/-90/0 -I2m -fg -V3 FZ_KM.txt LDIST DEG2KM = ES.nc

然后使用以下命令将这些象限网格合并为一个全球网格::

    gmt grdblend -Rg -I2 -fg EN.nc WN.nc ES.nc WS.nc -Gdist2FZ.nc -V
    rm -f WN.nc EN.nc WS.nc ES.nc

若要为 Nazca plate 生成用于年龄和或距离的 NaN 网格，可使用以下命令::

    gmt grdmath -R-120/-65/-50/5 -I5m -fg 0 0 NaN = ages.nc


输出文件
--------

**fzanalyzer** 最多可以生成三个输出文件，具体说明如下：

    1. 文件 *prefix*\_analysis.txt 包含每条横剖面的分析结果。该文件共有 61 列输出数据，
    包含拟合值或观测值（参见“确定参数”部分）。此文件可被 :doc:`fzblender` 使用，
    以生成对断裂带的平滑且最优的拟合。

    2. 文件 *prefix*\_cross.txt 包含每条横剖面的观测值和最佳拟合模型的预测值。
    可用于逐剖面绘图或结果的可视化分析。

    3. 文件 *prefix*\_par.[c]sh 是一个 Bourne shell 脚本(|-S|) 或 C shell 脚本(|-S|\ **c**)，
    其中包含命令行指定的所有参数作为 shell 变量。你可以在自定义绘图或分析脚本中引用这些变量。

    4. 最后，虽然不是 **fzanalyzer** 的输出文件，你应使用 *prefix*\_resampled.txt 
    作为 :doc:`grdtrack` **-D** 的输出文件名，因为绘图脚本会以此文件为输入。

示例
--------

为了分析数字化的断裂带（FZ），我们使用 Sandwell/Smith 的 VGG 数据
（1 分钟分辨率的垂直重力梯度，@earth_vgg_01m）、
1 分钟分辨率的地壳年龄网格（@earth_ages_01m）以及最近断裂带距离网格（单位：km）。
假设多段文件 `fz_digitized.txt` 中包含潜在的断裂带位置，我们设置横剖面长度为 40 km，
剖面间隔为 5 km，沿横剖面的采样间隔为 2 km，并运行命令::

    gmt grdtrack fz_digitized.txt -C40k/2k/5k -G@earth_vgg_01m -G@earth_ages_01m -Gdist.nc -Dtraces_resampled.txt -fg --FORMAT_GEO_OUT=ddd.xxxx --FORMAT_FLOAT_OUT=%.1f > xprofiles.txt

生成的这两个数据表即可用于 **fzanalyzer** 分析轨迹。此处，
我们设置中央走廊宽度为 20 km，并接受大部分参数的默认值::

    gmt fzanalyzer xprofiles.txt -D20 -Ftraces_resampled.txt -Ttraces -S --FORMAT_GEO_OUT=ddd.xxxx --FORMAT_FLOAT_OUT=%.1f

之后，可以使用以下命令绘制带有最佳拟合曲线及参数的横剖面图::

    fzprofiler traces -W6i -H2i -N2

该命令会将所有横剖面以 6×2 英寸的尺寸绘制在同一垂直面板中。
若希望在地图视图中展示这些信息，可使用::

    fzmapper traces -W9i -L1 -Ffz_digitized.txt

更多细节请参见 :doc:`fzprofiler` 和 :doc:`fzmapper` 的文档。

确定参数
--------

以下是 61 列输出数据的列名及其含义：

* **XR**：原始数字化轨迹的经度。
* **YR**：原始数字化轨迹的纬度。
* **DR**：原始数字化轨迹上各点的距离。
* **AR**：原始数字化轨迹上各点的方位角。
* **ZR**：数字化位置处的数据值。
* **TL**：断裂带左侧的地壳年龄估计（负距离）。
* **TR**：断裂带右侧的地壳年龄估计（正距离）。
* **SD**：数据最小值相对于原始轨迹起点的偏移（单位：km）。
* **ST**：槽模型最小值相对于原始轨迹起点的偏移（单位：km）。
* **SB**：混合模型最小值相对于原始轨迹起点的偏移（单位：km）。
* **SE**：混合模型最大坡度相对于原始轨迹起点的偏移（单位：km）。
* **BL**：最佳混合值 [0-1]。
* **OR**：混合模型剖面方向（-1 表示左侧为老地壳，+1 表示左侧为年轻地壳）。
* **WD**：数据槽宽度。
* **WT**：模型槽宽度（槽模型）。
* **WB**：模型槽宽度（混合模型）。
* **AD**：数据的峰-谷振幅。
* **AT**：模型的峰-谷振幅（槽模型）。
* **AB**：模型的峰-谷振幅（混合模型）。
* **UT**：压缩指标（槽模型）。
* **UB**：压缩指标（混合模型）。
* **VT**：模型方差减小百分比（槽模型）。
* **VB**：模型方差减小百分比（混合模型）。
* **FT**：F 统计量（槽模型）。
* **FB**：F 统计量（混合模型）。
* **XDL**：数据最小值左界经度。
* **XD0**：数据最小值经度。
* **XDR**：数据最小值右界经度。
* **YDL**：数据最小值左界纬度。
* **YD0**：数据最小值纬度。
* **YDR**：数据最小值右界纬度。
* **ZDL**：数据最小值左界值。
* **ZD0**：数据最小值。
* **ZDR**：数据最小值右界值。
* **XTL**：槽模型最小值左界经度。
* **XT0**：槽模型最小值经度。
* **XTR**：槽模型最小值右界经度。
* **YTL**：槽模型最小值左界纬度。
* **YT0**：槽模型最小值纬度。
* **YTR**：槽模型最小值右界纬度。
* **ZTL**：槽模型左界预测值。
* **ZT0**：槽模型最小值预测。
* **ZTR**：槽模型右界预测值。
* **XBL**：混合模型最小值左界经度。
* **XB0**：混合模型最小值经度。
* **XBR**：混合模型最小值右界经度。
* **YBL**：混合模型最小值左界纬度。
* **YB0**：混合模型最小值纬度。
* **YBR**：混合模型最小值右界纬度。
* **ZBL**：混合模型左界预测值。
* **ZB0**：混合模型最小值预测。
* **ZBR**：混合模型右界预测值。
* **XEL**：混合模型最大坡度左界经度。
* **XE0**：混合模型最大坡度经度。
* **XER**：混合模型最大坡度右界经度。
* **YEL**：混合模型最大坡度左界纬度。
* **YE0**：混合模型最大坡度纬度。
* **YER**：混合模型最大坡度右界纬度。
* **ZEL**：混合模型最大坡度左界预测值。
* **ZE0**：混合模型最大坡度预测值。
* **ZER**：混合模型最大坡度右界预测值。

相关模块
--------

:doc:`fzblender`,
:doc:`fzinformer`,
:doc:`fzmapper`,
:doc:`fzmodeler`,
:doc:`fzprofiler`,
:doc:`grdmath`,
:doc:`grdtrack`
:doc:`mlconverter`

参考文献
--------

Wessel, P., Matthews, K. J., Müller, R. D., Mazzoni, A., 
Whittaker, J. M., Myhill, R., Chandler, M. T.,2015, 
"Semiautomatic fracture zone tracking", *Geochem. 
Geophys. Geosyst.*, 16 (7), 2462–2472.https://doi.org/10.1002/2015GC005853.
