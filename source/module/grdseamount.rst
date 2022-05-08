.. index:: ! grdseamount
.. include:: common_SYN_OPTs.rst_

grdseamount
===========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/potential/grdseamount`
:简介: 创建合成海山（包括高斯、抛物线、多项式、圆锥、圆盘形状的圆形或椭圆型海山）

**grdseamount** 使用给定的地形形状参数生成多种合成海山。输入数据中包括每个海山的
位置和大小，即 *lon*, *lat*, *radius*, *height* 。对于椭圆形的海山（ **-E**
），则包括 *lon*, *lat*, *azimuth*, *semi-major*, *semi-minor*, *height* 。
如果使用 **-F** 选项以生成平顶海山，但后面没有 *flattening* 参数，则输入数据的
最后一列为 *flattening* 参数。对于随时间变化的地形，可以使用 **-T** 选项，这样
输入数据的最后两列为海山的开始和停止时间。这种情况下，可以输出海山最终的累积
形状，也可以输出其中每个时间点的形状或变化（ **-Q** ）。

语法
----

**gmt grdseamount** [ *table* ]
|-G|\ *outgrid*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-A|\ [*out*/*in*] ]
[ |-C|\ [**c**\|\ **d**\|\ **g**\|\ **o**\|\ **p**] ]
[ |-D|\ *unit* ]
[ |-E| ]
[ |-F|\ [*flattening*] ]
[ |-H|\ *H*/*rho_l*/*rho_h*\ [**+d**\ *densify*][**+p**\ *power*] ]
[ |-K|\ [*densitymodel*] ]
[ |-L|\ [*cut*] ]
[ |-M|\ [*list*] ]
[ |-N|\ *norm* ]
[ |-Q|\ *bmode*/*fmode*\ [**+d**] ]
[ |-S|\ *scale* ]
[ |-T|\ *t0*\ [/*t1*/*dt*]\ [**+l**] ]
[ |-Z|\ *level* ]
[ |SYN_OPT-V| ]
[ |-W|\ *avedensity* ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT--| ]

必选选项（如果不给定 -L 选项）
------------------------------

.. include:: explain_intables.rst_

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*][**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**][:*driver*\ [*dataType*][**+c**\ *options*]]
    输出网格文件名，其中各子选项的含义见 
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__ 。
    如果使用 |-T| 选项，则需要使用 C 语言的语法指定输出格网序列的名称格式。
    如果输出文件名中包含 %s (单位名称) 或 %c (单位字母)，GMT 将会使用每个
    网格对应的时间生成文件名，否则会使用年作为时间生成文件名。

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-A:

**-A**\ [*out/in*]
    创建一个 mask 网格，分别用 *out* 和 *in* 表示内部和外部的值 [1/NaN]。
    海山的高度以及是否平顶不影响本选项，但 **-L** ，**-N** 和 **-Z** 选项
    不能和本选项同时使用。

.. _-C:

**-C**\ [**c**\|\ **d**\|\ **g**\|\ **o**\|\ **p**]
    选择海山的形状函数： **c** （圆锥）， **d** （圆盘）， **g** （高斯），
    **o** （多项式）和 **p** （抛物线） [默认为高斯]。除圆盘外，其他所有的
    海山都可以使用带 *f* 参数的 **-F** 选项来截断变成平顶海山。如果 **-C**
    选项没有任何追加的字母，则从输入的最后一列中读取海山形状。如果不使用
    **-C** 选项，默认为高斯海山。

.. gmtplot:: grdseamount/GMT_seamount_types.sh
    :width: 60%
    :show-code: false

在上述所有海山中， :math:`h_0` 是海山最大高度，:math:`r_0` 为基地半径，
:math:`h_c` 是相对于 **-L** [0] 的高度，*f* 是 **-F** 选项设置的平顶海山
相关的参数。平顶部分的半径为 :math:`r_t` , 对于圆盘形状海山，不存在该参数。

.. _-D:

**-D**\ *unit*
    设置数据文件中的水平距离的单位。对于地理坐标（ |SYN_OPT-f| ），不需要该
    选项，可自动转换为 km

.. _-E:

**-E**
    设置海山的基地为椭圆形状。如果使用该选项，则海山数据数据格式应该为：
    *lon, lat, azimuth, semi-major, semi-minor, height* (with  the latter in m)
    [ 默认底部为圆，输入数据格式为 *lon, lat, radius, height* ]
    下图中的 :math:`\alpha` 即为 *azimuth*

.. gmtplot:: grdseamount/GMT_seamount_map.sh
    :width: 60%
    :show-code: false

.. _-F:

**-F**\ [*flattening*]
    该参数将海山截断为平顶海山。*flattening* 参数的范围从 0 到 1，如果不使用
    该选项，就默认在输入文件的最后一列读取该参数。[ 默认没有截断 ]。使用
    **-Cd** 选项时，忽略该选项。

.. _-H:

**-H**\ *H*/*rho_l*/*rho_h*\ [**+d**\ *densify*][**+p**\ *power*]
    设置参考海山密度相关的参数，该参数用于随深度变化的径向（即下图中的 r 轴向）密度函数。
    以 kg/m^3 或 g/cm^3 为单位设置海山的密度，以 m 为单位设置固定参考高度 *H* [0]。
    使用 **+d** 和 **+p** 选项改变水压驱动的侧面密度 *densify* ，以及可变密度的指数 
    *power* ，即下图中的 :math:`\Delta \rho_f` 和 *p* ，默认 *power* 为 1，即为线性
    变化。
    下图中，*h(r)* 是海山在 r 位置处的高度，*z(r)* 与 *h(r)* 含义相近，不过在海山
    内部。如果海山为平顶海山（见 **-F** ），*h(r)* 仍然为未截断的情况。
    **注** ：如果使用 **-W** 选项，将会报告每个海山的平均密度。径向密度函数的定义为
    :math:`\Delta \rho_s = \rho_h - \rho_l` ，其中 :math:`\rho_h` 即参数中的 *rho_h* ，
    :math:`\rho_l` 为参数中的 *rho_l* ，分别为密度的两个极值（high 和 low）。:math:`\Delta \rho_f`
    为参数中的 *densify* 

.. math::
    \rho(r,z) = \rho_l + \Delta \rho_f \left (\frac{H-h(r)}{H} \right ) + \Delta \rho_s \left ( \frac{h(r)-z(r)}{H} \right )^p

.. gmtplot:: grdseamount/GMT_seamount_density.sh
    :width: 60%
    :show-code: false

.. _-K:

**-K**\ *densitymodel*
    保存参考模型横截面的预测密度文件 *densitymodel* 。这里使用归一化的坐标，即
    x 从 -1 到 1，z 从 0 到 1，两者的增量都是 0.005，生成 401 x 201 大小的网格。
    **注** ：无需创建海山网格即可使用该选项，因此，**-R**，**-I**，**-G** 和
    **-D** 选项都不是必须的。

.. _-L:

**-L**\ [*cut*]
    输出海山的面积，体积和平均高度。不创建网格。
    使用 *cut* 参数来指定位于 *cut* 高度下的部分将不被统计。[0]

.. _-M:

**-M**\ [*list*]
    在使用 **-T** 参数的前提下，将所有输出网格文件对应的时间和名字输出到
    *list* 文件中。不指定 *list* 时，输出到标准输出。
    输出的序列将可以作为 :doc:`grdflexure` 模块的输入。
    使用 **-M** 参数后的输出网格文件名为 *time reliefgrid *\ [ *densitygrid* ] *timetag*

.. _-N:

**-N**\ *norm*
    标准化海山网格，使得网格的最大高度等于 *norm* 

.. _-Q:

**-Q**\ *bmode*/*fmode*\ [**+d**]
    只能和 **-T** 选项共同使用。*bmode* 和 *fmode* 用来设置如何处理海山的变化。

    *bmode* 用来设置海山演化使用累积结果还是增量结果：
      
      - *c* 表示随时间累积的海山 [默认]

      - *i* 表示每个时间段海山演化的增量

    *fmode* 用来设置海山的变化率
        
      - *c* 表示常数变化率

      - *g* 表示高斯变化率 [默认]

    下图中展示了上述几种模式的区别。默认情况下，计算的海山的增量和累积量，
    使用 **+d** 选项可以将该增量或者累积量以等效圆盘的形式表达。

.. gmtplot:: grdseamount/GMT_seamount_inc.sh
    :width: 60%
    :show-code: false

*bmode* 两种情况下的海山图（高斯海山，没有平顶，体积线性变化），横坐标
为海山水平方向的尺度，纵坐标为海山的高度，以二维的变化来显示海山的演化。
左图为使用 **c** 的情况，表示使用实际地形，也就是随时间累积的地形；
右图为使用 **i** 的情况，显示了地形随时间变化的增量

.. gmtplot:: grdseamount/GMT_seamount_flux.sh
    :width: 60%
    :show-code: false

*fmode* 的两种情况，横坐标为相对时间，纵坐标为某时刻海山体积与初始海山体积
的比值。
虚线为设置为 **c** 的情况；粗实线为设置为 **g** 的结果。

.. _-S:

**-S**\ *scale*
    指定海山半径的比例因子 [1]

.. _-T:

**-T**\ *t0*\ [/*t1*/*dt*]\ [**+l**]
    设置海山演化序列的起始时间，终止时间和，时间间隔，分别为 *t0*, *t1*
    和 *dt* 。默认时间单位是年，追加 *k* 表示千年，追加 *M* 表示百万年。
    默认的 *dt* 步长为 1，单位与设置单位相同。对于对数时间尺度，使用
    **+l** 选项。使用 **-T** 选项后，将对每个时刻的海山都输出一个网格。

.. _-W:

**-W**\ *avedensity*
    指定垂直平均密度的网格文件。如果设置了 **-T** 选项，*avedensity* 必须是
    具有 C 语言语法的模版名称。如果模版文件名中有 %s（单位名）或者 %c（单位
    字符），将使用 |-T| 选项对应的时间的网格文件。

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ *level*
    指定背景海深 [0]。由于所有的海山具有向上的地形，设置较大的负的 *level* 
    可以将海山放在海洋里。

.. include:: explain_-bi.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-icols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

计算两个底部为椭圆型的高斯平顶海山的变化，演化时间分别为 3ma 到 2ma 以及
2.8ma 到 1.9ma，海山体积变化率为常数；从 3ma 到 1.9ma 平均每 0.1ma 输出一个
网格 ::
    
    cat << EOF > t.txt
    #lon lat azimuth, semi-major, semi-minor, height tstart tend
    0   0       -20     120     60      5000    3.0M    2M
    50  80      -40     110     50      4000    2.8M    1.9M
    EOF
    gmt grdseamount -R-1024/1022/-1122/924 -I2000 -Gsmt_%3.1f_%s.nc t.txt \
      -T3M/1.9M/0.1M -Qi/c -Dk -E -F0.2 -Cg -Ml.lis

:file:`l.lis` 文件中将包含时间，网格文件名和单位。

相关模块
--------

:doc:`grdmath`,
:doc:`gravfft`,
:doc:`gmtflexure`,
:doc:`grdflexure`
