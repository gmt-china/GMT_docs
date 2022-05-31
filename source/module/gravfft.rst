.. index:: ! gravfft
.. include:: common_SYN_OPTs.rst_

gravfft
=======

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/potential/gravfft`
:简介: 网格重力的谱计算，均衡，导纳，以及相干性计算

**gravfft** 包括 3 种模式。

- 模式 1：简单地计算地形网格导致的位变化。需要 |-D| 选项给出密度差
  （相对密度），以及 |-W| 选项给出参考基准面。该模式将对地形网格执行
  2—D FFT 并使用完整的 Parker 理论。

- 模式 2：计算地形挠曲引起的位响应。该模式对网格进行 2—D FFT ， 

- 模式 3：计算导纳或者相干函数（相干谱），结果是径向的平均水平

语法
----

**gmt gravfft** *ingrid* [ *ingrid2* ]
|-G|\ *outgrid*
[ |-C|\ *n/wavelength/mean\_depth*/**t**\|\ **b**\|\ **w** ]
[ |-D|\ *density*\|\ *rhogrid* ]
[ |-E|\ *n_terms* ]
[ |-F|\ [**f**\ [**+s**]\|\ **b**\|\ **g**\|\ **v**\|\ **n**\|\ **e**] ]
[ |-I|\ **w**\|\ **b**\|\ **c**\|\ **t**\|\ **k** ]
[ |-N|\ *params* ]
[ |-Q| ]
[ |-S| ]
[ |-T|\ *te/rl/rm/rw*\ [*/ri*]\ [**+m**] ]
[ |SYN_OPT-V| ]
[ |-W|\ *wd*\ [**k**] ]
[ |-Z|\ *zm*\ [*zl*] ]
[ |SYN_OPT-f| ]
[ |SYN_OPT--| ]



必选选项
--------

*ingrid*\ [=\ *ID*\|\ ?\ *varname*][**+b**\ *band*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*][**+s**\ *scale*]
    
输入网格名

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]
    
    输出网格名，计算实体对该网格中点的异常值。各子选项含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__ 

可选选项
--------

.. _-C:

**-C**\ *n/wavelength/mean\_depth*/**t**\|\ **b**\|\ **w**
    只计算所选模型的理论导纳曲线并退出。

-I
计算相干谱/导纳

默认计算导纳。输出结果为3列或者4列。频率，导纳（相干），误差（1倍）
w 输出的是波长，而不是频率
k 设置波长的单位为千米
c 计算相干谱而不是导纳
b 输出第四列，是理论导纳？
t 也是理论导纳，但是和上面的那个不同

.. _-Z:

**-Z**\ *zm*\ [*zl*]
    
.. include:: explain_fft.rst_

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

网格距离单位
------------

如果输入的笛卡尔网格的水平方向距离的单位不是米，可以通过对输入文件名
**+u**\ *unit* 来将指定的单位转换为米。例如：对输入文件 **+uk** 将会把
输入网格的 x 和 y 坐标的单位从 km 转换为 m。如果输入网格为地理网格，可以
通过 |SYN_OPT-f| 将单位转换为米

示例
----

假设地壳和海水的密度分别为 2700 和 1035，计算海底地形上的海水的影响，将结果写入
到 :file:`water_g.grd` （Paker 公式计算到 4 阶） ::

    gmt gravfft bat.grd -D1665 -Gwater_g.grd -E4

然后在自由空气重力异常 :file:`faa.grd` 中减去该结果即得到布格重力异常 ::

    gmt grdmath faa.grd water_g.grd SUB = bouguer.grd

对上面计算过程做简单解释：


参考文献
--------

Luis, J.F. and M.C. Neves. 2006, The isostatic compensation of the
Azores Plateau: a 3D admittance and coherence analysis. J. Geothermal
Volc. Res. Volume 156, Issues 1-2, Pages 10–22,
`http://dx.doi.org/10.1016/j.jvolgeores.2006.03.010 <http://dx.doi.org/10.1016/j.jvolgeores.2006.03.010>`_

Parker, R. L., 1972, The rapid calculation of potential anomalies, Geophys. J., 31, 447–455.

Wessel. P., 2001, Global distribution of seamounts inferred from gridded Geosat/ERS-1 altimetry,
J. Geophys. Res., 106(B9), 19,431–19,441,
`http://dx.doi.org/10.1029/2000JB000083 <http://dx.doi.org/10.1029/2000JB000083>`_

相关模块
--------

:doc:`grdfft`,
:doc:`gmtflexure`,
:doc:`grdflexure`,
:doc:`gmtgravmag3d`,
:doc:`grdgravmag3d`,
:doc:`grdseamount`,
:doc:`talwani2d`,
:doc:`talwani3d`
