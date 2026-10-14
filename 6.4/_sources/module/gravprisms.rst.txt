.. index:: ! gravprisms
.. include:: common_SYN_OPTs.rst_

gravprisms
==========

:贡献者: |周茂|
:最近更新日期: 2022-06-21

----

:官方文档: :doc:`gmt:supplements/potential/gravprisms`
:简介: 计算三维垂直棱柱产生的位异常

**gravprisms** 计算矩形棱柱产生的位场。输入文件/标准输入最多包涵 7 列：
前 4 列为 *x y z_low z_high* ，即棱柱中心的 x 和 y 坐标以及垂直方向的
高度；接下来两列为每个棱柱的增量 *dx* 和 *dy* ，见 |-E| ；最后一列为
棱柱的密度，如果 |-D| 指定了密度，则被固定密度覆盖。或者，也可以使用
|-C| 选项来创建棱柱。如果单个棱柱密度可变（ |-H| ），则每个棱柱被分解为
密度恒定，堆叠的子棱柱，垂直增量为 *dz* 。该模块可以计算等距网格上的异常
（通过 |-R| 和 |-I| 选项指定）或通过 |-N| 指定任意的计算点。可计算的异常
包括自由空气重力异常、垂直重力梯度异常或大地水准面异常。

.. gmtplot:: grdseamount/GMT_seamount_prisms.sh
    :width: 60%
    :show-code: false

上图展示了三种不同密度的海山，海山都由棱柱构成。左图为常密度（|-D|）；
中图为垂向等密度（|-D|）；右图为随 *r* 和 *z* 变化的密度（|-H|）。

语法
----

**gmt gravprisms** [ *table* ]
[ |-A| ]
[ |-C|\ [**+q**][**+w**\ *file*][**+z**\ *dz*] ]
[ |-D|\ *density* ]
[ |-E|\ *dx*\ [/*dy*] ]
[ |-F|\ **f**\|\ **n**\ [*lat*]\|\ **v** ]
[ |-G|\ *outfile* ]
[ |-H|\ *H*/*rho_l*/*rho_h*\ [**+d**\ *densify*][**+p**\ *power*] ]
[ |SYN_OPT-I| ]
[ |-L|\ *base* ]
[ |-M|\ [**h**]\ [**v**] ]
[ |-N|\ *trackfile* ]
[ |SYN_OPT-R| ]
[ |-S|\ *shapegrid* ]
[ |-T|\ *top* ]
[ |SYN_OPT-V| ]
[ |-W|\ *avedens* ]
[ |-Z|\ *level*\|\ *obsgrid* ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    棱柱文件，格式为 *x y z z_low z_high [dx dy] [rho]* 。其中的可选项可以
    通过 |-E| 和 |-D| 控制。密度的单位可以是 kg/m^3 或者 g/cm^3 。如果使用
    |-C| 选项，则无需输入文件。

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-A:

**-A**
    设置 z 轴向上为正 [默认向下为正]

.. _-C:

**-C**\ [**+q**][**+w**\ *file*][**+z**\ *dz*] ]
    与其他选项组合创建棱柱，1）与 **-S**\ *height* 组合创建棱柱；2）与 
    **-L**\ *base* 和 **-T**\ *top* 指定的两个面创建棱柱。对于第二种情况，
    *base* 和 *top* 可以为常数或者网格。对于第一种情况，则创建从 0 到
    *height* 的棱柱。如果使用 |-H| 设置可变密度，则将每个棱柱分为多个堆叠
    的具有单独密度的子棱柱，因此需要为这些子棱柱设置高度增量 *dz* ，第一个
    和最后一个棱柱可能会对高度进行适当的调节。如果不使用 |-H| 选项，则只
    创建统一密度的棱柱，通过 |-D| 可以使每个棱柱具有不同的密度。
    **+w**\ *file* 将会将棱柱保存到文件中，若追加 **+q** 则保存结果后直接
    退出，不进行位计算。

.. _-D:

**-D**\ *density*
    设置一个固定的密度差，可以覆盖输入文件中的密度设置，单位可以为 kg/m^3
    或者 g/cm^3。或者可以指定一个网格，其中网格的每个格点的值为棱柱的密度，
    此时，需要 |-C| 选项，并必须和 |-S| （或 |-L| 和 |-T| ）提供的网格具有
    相同的大小和配准方式。

.. _-E:

**-E**\ *dx*\ [/*dy*]
    如果输入文件中所有棱柱都具有相同的 x/y 方向的尺度，则可以在这里设置其
    增量。在这种情况下，输入文件值包含棱柱的中心坐标和高度以及可选的密度。
    如果 |-E| 选项只给出 *dx* ，则 *dy* = *dx* 。对于地理坐标，*dx* 是经度
    增量，在数值上保持不变，但实际宽度会随着纬度的增大而减小。

.. _-F:

**-F**\ **f**\|\ **n**\ [*lat*]\|\ **v**
    指定计算的位异常。

    - **f** 自由空气重力异常 [默认]

    - **n** 大地水准面，可指定一个平均纬度，默认使用网格或者 |-N| 指定的
      纬度的中值

    - **v** 垂直重力梯度

.. _-G:

**-G**\ *outfile*
    输出网格文件名，计算该网格上的异常，可设置子选项，其中子选项的含义见 
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__ 。

.. _-H:

**-H**\ *H*/*rho_l*/*rho_h*\ [**+d**\ *densify*][**+p**\ *power*]
    为海山设置随深度变化的密度。给定低密度和高密度分别为 *rho_l* 和 *rho_h*
    ，以及固定的参考高度 *H* 。使用 **+d** 和 **+p** 分别设置水压驱动的侧翼
    密度的增量 [0] 以及幂指数变化 [1，线性变化]。该选项需要 |-S| 选项。细节
    请参考 :doc:`grdseamount` 。

.. _-L:

**-L**\ *base*
    设置棱柱基底/下界面，可以为一个网格，也可以为一个常数 [0]

.. _-M:

**-M**\ [**h**]\ [**v**]
    设置距离单位。**h** 表示水平方向单位为 km [m]，**z** 表示垂直方向距离
    单位为 km [m]。

.. _-N:

**-N**\ *trackfile*
    指定计算异常所处的测线，结果输出到标准输出。如果没设置 |-Z| 选项，则
    *trackfile* 必须有 3 列，最后一列为 z 值，否则使用 |-Z| 设置的恒定的
    z 值。

.. _-S:

**-S**\ *height*
    指定完整的海山网格名称，用于创建棱柱或者 |-H| 所需

.. _-T:

**-T**\ *top*
    设置棱柱的上界面，可以为一个网格，也可以为常数

.. _-W:

**-W**\ *avedens*
    指定由 |-C| 和 |-H| 创建的随空间变化的密度网格名，作为输出

.. _-Z:

**-Z**\ *level*\|\ *obsgrid*
    指定观测高度，可以为常数，也可以为可变的值，若为可变的值，则通过网格给定，
    该网格即确定了输出的网格区域

.. include:: explain_-V.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_core.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

假定某棱柱构成的高斯海山高度为 6000 m，底部半径为 30 km，总共包括 2828 个棱柱，
通过 :doc:`gmt:plot3d` 可绘制该海山 ::

    gmt plot3d -R-30/30/-30/30/0/7000 -JX12c -JZ3c -Ggray -So1q+b @prisms.txt -B \
        -Wfaint -p200/20 -pdf smt

计算该海山在给定网格上产生的重力异常，密度差异设置为 1700 kg/m^3，水平距离以
km 为单位，垂直距离以 m 为单位，观测高度为 7000 m ::

    gmt gravprisms -R-40/40/-40/40 -I1 -Mh -G3dgrav.nc @prisms.txt -D1700 -Ff -Z7000
    gmt grdimage 3dgrav.nc -B -pdf 3dgrav

计算该海山在 :file:`crossing.txt` 中位置产生的垂直重力梯度异常 ::

    gmt math -T-30/30/0.1 T 0 MUL = crossing.txt
    gmt gravprisms -Ncrossing.txt -Mh @prisms.txt -D1700 -Fv -Z7000 > vgg_crossing.txt
    gmt plot vgg_crossing.txt -R-30/30/-50/400 -i0,3 -W1p -B -pdf vgg_crossing

重新计算重力，但使用棱柱文件中的密度 ::

    gmt gravprisms -Ncrossing.txt -Mh @prisms.txt -Ff -Z7000 > faa_crossing.txt
    gmt plot faa_crossing.txt -R-30/30/0/350 -i0,3 -W1p -B -pdf faa_crossing

注意事项
--------

垂直棱柱造成的大地水准面的解析表达式（Nagy et al., 2000）比较复杂，包含 48 项。
由于各种抵消，最终结果比重力异常和重力异常垂直梯度更不稳定，因此，最终结果的
有效数字可能比较少。

参考文献
--------

Grant, F. S. and West, G. F., 1965, *Interpretation Theory in Applied Geophysics*,
583 pp., McGraw-Hill.

Kim, S.-S., and P. Wessel, 2016, New analytic solutions for modeling vertical
gravity gradient anomalies, *Geochem. Geophys. Geosyst., 17*,
`https://doi.org/10.1002/2016GC006263 <https://doi.org/10.1002/2016GC006263>`_.

Nagy D., Papp G., Benedek J., 2000, The gravitational potential and its derivatives
for the prism, *J. Geod., 74*, 552–560,
`https://doi.org/10.1007/s001900000116 <https://doi.org/10.1007/s001900000116>`_.

相关模块
--------

:doc:`grdmath`,
:doc:`gravfft`,
:doc:`grdseamount`,
:doc:`gmtgravmag3d`,
:doc:`grdgravmag3d`,
:doc:`talwani3d`,
:doc:`talwani2d`
