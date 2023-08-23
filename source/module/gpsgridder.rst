.. index:: ! gpsgridder
.. include:: common_SYN_OPTs.rst_

gpsgridder
==========

:贡献者: |周茂|
:最近更新日期: 2022-02-07

----

:官方文档: :doc:`gmt:supplements/geodesy/gpsgridder`
:简介: 使用格林函数内插 GPS 应变以分析弹性形变

**gpsgridder** 使用基于 2—D 弹性耦合模型来格网化 2—D 向量。通过调整
有效 Poisson 比 :math:`\nu` 来改变耦合程度。可以设置为一些极端情况，例如为 1 为
刚性，不可压缩；0.5 为典型的弹性；或设置为 -1 表明基本上消除了弹性
耦合。通过去除小的特征值来得到平滑的结果。最终两个分量网格分别为：

.. math::

    u(\mathbf{x}) = \sum_{j=1}^{n} \alpha_j q(\mathbf{x}, \mathbf{x}_j) +  \beta_j w(\mathbf{x}, \mathbf{x}_j)\\
    v(\mathbf{x}) = \sum_{j=1}^{n} \alpha_j w(\mathbf{x}, \mathbf{x}_j) +  \beta_j p(\mathbf{x}, \mathbf{x}_j)

其中 2-D 弹性耦合格林函数为：

.. math::

    q(\mathbf{a}, \mathbf{b}) = (3 - \nu)\log r + (1 + \nu) \frac{y^2}{r^2}\\
    p(\mathbf{a}, \mathbf{b}) = (3 - \nu)\log r + (1 + \nu) \frac{x^2}{r^2}\\
    w(\mathbf{a}, \mathbf{b}) = -(1 + \nu) \frac{xy}{r^2}

式中，*r* 是点 **a** 和 **b** 之间的距离，*x* 和 *y* 分别为其在两个方向的分量。
体积力 :math:`\alpha_j` 和 :math:`\beta_j` 可以通过在数据所处的位置求解并对线性
系统求逆得到，详见 *Sandwell and Wessel* [2016] 和 *Haines et al.* [2015]。

语法
----

**gmt gpsgridder** [ *table* ]
|-G|\ *outgrid*
[ |-C|\ [[**n**\|\ **r**\|\ **v**]\ *value*\ [%]][**+c**][**+f**\ *file*][**+i**][**+n**] ]
[ |-E|\ [*misfitfile*] ]
[ |-F|\ [**d**\|\ **f**]\ *fudge* ]
[ |SYN_OPT-I| ]
[ |-L| ]
[ |-N|\ *nodefile* ]
[ |SYN_OPT-R| ]
[ |-S|\ *nu* ]
[ |-T|\ *maskgrid* ]
[ |SYN_OPT-V| ]
[ |-W|\ [**+s**\|\ **w**] ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    输入数据文件，其中数据为离散点的 GPS 应变。输入格式必须为 *x y u v* [ *du dv* ]
    （设置不确定度或者权请见 |-W| ）。如果输入数据为地理坐标，必须使用 **-fg** , gmt
    则以平地球近似来计算距离

.. include:: explain_grd_out.rst_
    
- 如果设置了 |-R| 和 |-I|，则输出两个网格，分别为 u 和 v 分量。
- 如果设置了 |-T| 选项，则输出两个文本文件，分别为离散点上的 u 和 v 分量
- 如果设置了 |-N| 选项，输出单个文本文件。

可选选项
--------

.. _-C:

**-C**\ [[**n**\|\ **r**\|\ **v**]\ *value*\ [%]][**+c**][**+f**\ *file*][**+i**][**+n**]
    拟合曲面：通过 SVD 求解线性系统的样条参数，并去除某些特征值以得到平滑的结果；
    通常使用 Gauss-Jordan 去除。通过追加子选项以及数值来确定保留那些特征值：

    - **n** 保留前 *value* 个最大的特征值
    - **r** 默认选项，保留与最大特征值的比值小于 *value* 的特征值 [0]
    - **v** 保留所需的特征值，以确保模型预测方差分数大于 *value* 

    对于 **n** 和 **v** 选项，需在 *value* 后追加 % 以设置为百分数。
    此外，还可设置如下子选项：

    - **+f**\ *file* 将特征值保存到 *file* 文件中以便后续分析
    - **+n** 该选项需要 **+f**\ *file* 选项，只保存特征值结果，不做进一步计算

    **+i** 和 **+c** 选项都可以用于输出 u 和 v 分量的网格以及特征值，并在文件名
    中分别插入 "_cum_###" 或 "_inc_###"。

    - **+i** 将输出每个特征值对网格贡献的增量
    - **+c** 将输出每个特征值对网格贡献的累积量

    同时使用两者即同时输出两种类型。

.. _-E:

**-E**\ [*misfitfile*]
    在输入数据位置处计算拟合值，并报告 u 和 v 的残差的统计值（mean, std, rms）。
    可追加一个文件 *misfitfile* ，将统计数据写入文件中，在 u 和 v 两列之后增加两列，
    用于存放拟合值和残差。如果设置了 |-W| 选项，将再追加两列，存放 :math:`\chi_u^2`
    和 :math:`\chi_v^2` 。如果设置了 |-C| 选项，将不输出上述内容，而是输出特征值
    的编号，特征值以及残差的方差，rms，rms_u 和 rms_v。如果同时使用了 |-W| ， 则
    同样追加输出 :math:`\chi^2` ，:math:`\chi_u^2` ，:math:`\chi_v^2`

.. _-F:

**-F**\ [**d**\|\ **f**]\ *fudge*
    格林函数与 :math:`r^{-2}` 和 :math:`\log(r)` 是成正比的，因此，在 :math:`r=0` 时，
    结果会出问题。为了防止这种情况发生，GMT 提供了两种方案：

    - **-Fd**\ *del_radius* 在 *r* 添加一个常数偏移，单位与输入数据计算的距离单位相同
    - **-Ff**\ *factor* 从点之间的距离中选择最短距离，乘以 *factor* 作为 *del_radius*
      [0.01]

.. include:: explain_-I.rst_

.. _-L:

**-L**
    在进行样条拟合的时候，不移去趋势。[默认移去趋势，拟合残差，然后恢复趋势]

.. _-N:

**-N**\ *nodefile*
    计算 *nodefile* 中位置处的应变并在其后追加 *w* 值，并输出到 |-G| 设置的
    文件中，不指定 |-G| 时，输出到标准输出。该选项无需使用 |-R| 和 |-I| 选项

.. include:: explain_-R.rst_

.. _-S:

**-S**\ *nu*
    设置 2-D 弹性板的泊松比，默认为 0.5。设置为 1 时，表明弹性板时刚性的，
    设置为 -1 表明两个方向的应变没有耦合关系

.. _-T:

**-T**\ *maskgrid*
    只计算 *maskgrid* 文件中指定的节点的值，该选项无需使用 |-R| 和 |-I|

.. _-W:

**-W**\ [**+s**\|\ **w**]
    输入文件必须在最后两列中提供 *u* 和 *v* 的一倍不确定度。如果不确定度是
    一倍中误差，则使用 1/(sigma^2) 作为权重计算，即默认情况，或使用 **+s**
    的情况。如果不确定度为权重，则使用 **+w** ，将输入数据直接作为权重。需要
    注意的是，只有设置了 |-C| 时，|-W| 才有效。

.. include:: explain_-V.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

**-fg**
    地理坐标网格将会被转换为平地球近似下来计算

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

关于 SVD 解
-----------

通常情况下，很难知道使用多少个特征值来做拟合，可以使用 |-C| 选项分别测试所有
方案，并估计模型的方差和以及数据的匹配程度，这样可获得一个函数，用来分析
需要选择多少个特征值。这些一系列的方案可以做成一个动图，可以更方便地分析结果。

示例
----

基于文件 :file:`gps.txt` 中的 GPS 数据计算 *u* 和 *v* 方向的应变。*gps.txt*
文件中的数据记录形式为 ``x y u v du dv`` , 计算结果位于加利福尼亚，网格分辨率
为 2 分，计算过程中只使用约 25% 的最大特征值 ::

    gmt gpsgridder gps.txt -R-125/-114/31/41 -I2m -fg -W -r -Cn25% -Ggps_strain_%s.nc -V

废弃用法
--------

- 6.3.0: 在 |-C| 中使用 **+n** 选项来设置 dry-run，废弃以前的设置为负数的做法。 `#5725 <https://github.com/GenericMappingTools/gmt/pull/5725/>`_

参考
----

Haines, A. J. et al., 2015, *Enhanced Surface Imaging of Crustal Deformation*, SpringerBriefs in Earth Sciences.

Sandwell, D. T. and P. Wessel, 2016, Interpolation of 2-D Vector Data Using Constraints from Elasticity,
*Geophys. Res. Lett., 43*, 10,703-10,709.

相关模块
--------

:doc:`greenspline` 
:doc:`nearneighbor` 
:doc:`surface` 
