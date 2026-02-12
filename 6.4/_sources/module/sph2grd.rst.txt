.. index:: ! sph2grd
.. include:: common_SYN_OPTs.rst_

sph2grd
========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:sph2grd`
:简介: 使用球谐系数计算网格

**sph2grd** 模块利用球谐系数表文件计算特定的网格值。球谐系数模型的格式为
L，M，C[L，M]，S[L，M]

语法
-----

**gmt sph2grd** [table]
|-G|\ *grdfile*
|-I|\ *increment*
|SYN_OPT-R|\ *region*
[ |-D|\ [**g**\|\ **n**] ]
[ |-E|\ ]
[ |-F|\ [**k**]\ *filter* ]
[ |-N|\ [norm] ]
[ |-Q|\ ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-r| ]
[ **-x**\ [-]\ *n* ]
[ |SYN_OPT--| ]

必选选项
----------

*table*
    一个或多个球谐系数文本文件 [ 或者二进制文件，见 **-bi**]。文件预期
    的格式为四列，分别比表示阶 L，度 M，然后是余弦和正弦系数。

.. _-G:

**-G**\ *grdfile*
    *grdfile* 为输出网格文件名。


.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
----------

.. _-D:

**-D**\ [**g**\|\ **n**]
    利用位模型计算场。\ **-Dg** 表示计算引力场，\ **-Dn** 表示计算大地水准
    [ 同时使用 |-E| 选项将会计算基于椭球的场 ]。( 目前该选项还没有实现)

.. _-E:

**-E**
    将参考从默认的球改变为椭球。（ 目前该选项还没有实现 ）

.. _-F:

**-F**\ [**k**]\ *filter*
    根据特定的滤波算法设定滤波参数，默认为球谐系数中的阶数 L ，使用 **Fk** 时，
    滤波参数的单位为千米。可选的滤波算法包括：
    a) 余弦带通滤波：附加四个波长参数 *lc/lp/hp/hc* 。*lc/hc* 之外的系数被截断，
    *lp/hp* 范围内的则可以通过，其余部分将 tapering 。将波长替换为 - 可以跳过设置，
    例如： **-F**-/-/50/75 为低通滤波。
    b) 高斯带通滤波：附加两个波长参数 *lo/hi*，滤波 amplitudes 为 0.5 。将波长替换为 -
    可以跳过设置，例如： **-F**\ 70/- 为高通高斯滤波。

.. _-N:

**-N**\ [norm]
    对球谐系数使用规格化。可选的规格化方法包括：
    **m** 数学正规格化化 - 表面内积和为 1 (默认)。
    **g** 大地测量规格化 - 表面内积和为 4pi 。
    **s** 施密特规格化 - 和地磁学中相同。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_core.rst_

.. include:: explain_help.rst_

示例
------

使用 :file:`egm96_to36.txt` 球谐系数文件创建 1 x 1 度全球网格::

    gmt sph2grd @EGM96_to_36.txt -GEGM96_to_36.nc -Rg -I1 -V

由于 |-D| 选项还未实施，该命令结果没有物理意义。

参考文献
----------

Holmes, S. A., and Featherstone, W. E., 2002,
A unified approach to the Clenshaw summation and the recursive computation of very high degree
and order normalized associated Legendre functions:
*J. Geodesy, v. 76, p. 279-299*.

相关模块
-----------

:doc:`gmt`,
:doc:`gmt:grdfft`,
:doc:`gmt:grdmath`
