.. index:: ! grdhisteq
.. include:: common_SYN_OPTs.rst_

grdhisteq
=============

:author: 何星辰
:date: 2025-10-17

----

:官方文档: :doc:`gmt:grdhisteq`
:简介: 对网格做直方图均衡

**grdhisteq** 允许用户找到能将给定网格文件划分为等面积区域的数据值。
其中一个常见用途是实现图像的直方图均衡化。
例如，假设用户有一个包含平坦地形并在中间有一座山的网格。
如果用 :doc:`grdimage` 或 :doc:`grdview` 按地形高度线性映射到灰度值，
则图像的大部分区域会非常暗，而山峰部分几乎全白。
使用 **grdhisteq** 可以将输入网格划分为 *n_cells* 个等面积的区间，并输出这些区间对应的数据值。
通过 **awk** 或 :doc:`makecpt` 可以用这些值生成一个 CPT 文件，
再用该 CPT 配合 :doc:`grdimage` 绘图，就能让图像中各个灰度级的分布更加均匀。
参照 :doc:`grd2cpt`。

第二个常见用途是根据某种累积分布函数生成统计意义上的等概率网格。
在这种情况下，输出网格在 *(x, y)* 位置上与输入网格相同，但其值被替换为在累积分布中的位置。
例如：

* 若要找出数据中最低的 10%，可以使用 **grdhisteq** 生成一个 *n_cells = 10* 的网格，
* 然后绘制结果中的 1 等值线，这条线将包围数据中最低 10% 的部分。
* 又如，为了对 :doc:`grdgradient` 的输出进行均衡，使其具有更平滑（如高斯型）的分布，
* 可以运行 **grdhisteq** 并使用 *Gaussian* 选项生成输出网格。
  结果网格的值将服从均值为 0、方差为 1 的高斯分布，其空间位置与输入数据对应：
  最小的输出值对应输入中最小的位置，依此类推。

语法
--------

**gmt grdhisteq** *ingrid* [ |-G|\ *outgrid* ]
[ |-C|\ *n_cells* ] [ |-D|\ [*file*] ] [ |-N|\ [*norm*] ]
[ |-Q| ]
[ |SYN_OPT-R| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

.. include:: explain_grd_in.rst_

可选选项
------------------

.. _-C:

**-C** *n_cells*
    设置将数据范围划分为多少个区间（默认 16）。

.. _-D:

**-D** [*file*]
    将层级信息输出到 *file*，若未指定文件则输出到标准输出。

.. _-G:

.. include:: explain_grd_out.rst_

.. _-N:

**-N** [*norm*]
    生成高斯输出。与 **-G** 一起使用可输出标准正态分布网格。
    若附加 *norm*，则强制值落在 ±*norm* 范围内（默认为标准正态分布）。

.. _-Q:

**-Q**
    选择二次（非线性）直方图均衡化方式（默认是线性）。

.. _-R:

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. include:: explain_-h.rst_

.. include:: explain_help.rst_

示例
--------

.. include:: explain_example.rst_

计算全球地形文件 `earth_relief_05m` 中能将选定区域划分为 16 个等面积区间的高度值::

    gmt grdhisteq -C16 -D @earth_relief_05m -R0/20/0/20 > levels.txt

对文件 `raw_intens.nc` 中分布不均的亮度数据进行均衡化，使其适合 :doc:`grdimage` 或 :doc:`grdview` 使用::

    gmt grdhisteq raw_intens.nc -Gsmooth_intens.nc -N -V

备注
--------

1. 对地理网格会执行加权的直方图均衡化，因为节点面积随纬度变化。
2. 若使用 **grdhisteq** 生成高斯分布输出用于 :doc:`grdimage` 或 :doc:`grdview` 的光照着色，需注意：
   输出值范围为 [-x, x]，其中 *x* 取决于输入网格点数 *(nx × ny)* 和高斯分布函数 F(x)。
   令 N = nx × ny，则 x 会被调整，使 F(x) = (N - 1 + 0.5)/N。
   标准正态分布中约 68% 的值位于 ±1 范围内，因此输出网格也将如此。
   当 N 很大时，x 可能大于 4。
   在 :doc:`grdview` 中，若光照梯度被裁剪到 [-1, 1]，则仅 68% 的数据会正确显示，
   16% 会被裁剪为 -1，另 16% 为 +1。
   若图像过亮或过暗，可使用 :doc:`grdmath` 乘以小于 1 的系数缩小值域，或使用 **-N** 指定归一化因子。

相关模块
--------

:doc:`grd2cpt`, 
:doc:`grdgradient`, 
:doc:`grdimage`, 
:doc:`grdmath`, 
:doc:`grdview`, 
:doc:`makecpt`

