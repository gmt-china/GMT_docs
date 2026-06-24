.. index:: ! surface

*******
surface
*******

:官方文档: :doc:`gmt:surface`
:简介: 使用可调节张量连续曲率样条插值法对数据进行网格化

语法
--------

.. include:: common_SYN_OPTs.rst_

**gmt surface** [ *table* ] |-G|\ *outputfile.nc*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-A|\ *aspect_ratio*\|\ **m** ]
[ |-C|\ *convergence_limit*\ [%] ]
[ |-J|\ *parameters* ]
[ |-D|\ *breakline_file*\ [**+z**\ [*level*]] ]
[ |-L|\ **l**\ *lower* ] [ |-L|\ **u**\ *upper* ]
[ |-M|\ *max_radius* ]
[ |-N|\ *max_iterations* ]
[ |-Q| ]
[ |-S|\ *search_radius*\ [**m**\|\ **s**] ]
[ |-T|\ [**i**\|\ **b**]\ *tension_factor* ]
[ |SYN_OPT-V| ]
[ |-Z|\ *over-relaxation_factor* ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

描述
-----------

**surface** 从标准输入或ASCII格式的文件 *table* 中读取离散的数据点 (x,y,z)，
通过解微分方程，得到网格化的数据 z(x,y) 并生成grid网格文件

.. math::

    (1 - t) \nabla ^2(z) + t \nabla (z) = 0,

其中 *t* 是0到1之间的张量因子， :math:`\nabla` 是拉普拉斯算子。
对于势能场数据，建议 *t* ~ 0.25 。对于陡峭的地形数据，则建议 *t* ~ 0.35。
建议用户事先使用 :doc:`gmt:blockmean`， :doc:`gmt:blockmedian`，或 :doc:`gmt:blockmode` 预处理数据，
以避免空间假频与消除冗余数据。解微分方程时，采用自然边界条件。对于经度范围是360度的地理数据，
将会采用周期边界条件。

.. warning::

    在每个维度上至少必须有4个点，否则无法使用 **surface** 。
    
    如果你的数据是等间隔的 (x,y,z) 数据，请不要使用 **surface** 生成网格文件。正确的做法是
    使用 :doc:`xyz2grd` 生成网格文件。

必选选项
------------------

.. |Add_intables| unicode:: 0x20 .. just an invisible code
.. include:: explain_intables.rst_

.. _-G:

**-G**\ *outputfile.nc*
    输出的文件名。输出文件的格式参见《 :doc:`/grid/format` 》。

.. _-I:

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
------------------

.. _-A:

**-A**\ *aspect_ratio*\|\ **m**
    设置网格纵横比 *aspect_ratio* ，其中 dy = dx / *aspect_ratio* 。
    对于地理数据，可以使用 **-Am** 设置网格纵横比为纬度平均值的余弦。
    不设置本项时，默认网格纵横比为1，即各向同性网格。

.. _-L:

**-Ll**\ *lower* and **-Lu**\ *upper*
    对微分方程的解加上限制。 **-Ll**\ *lower* 设置下限，其中 *lower* 可以是一个grid网格文件的文件名、
    或一个固定值。 **-Lu**\ *upper* 设置上限，同样 *upper*  可以是一个grid网格文件的文件名、
    或一个固定值。

.. _-T:

**-T**\ [**i**\|\ **b**]\ *tension_factor*
    设置张量因子，必须在0到1之间。 不设置时默认为0。

**-V**
    显示多项式系数等详细信息。 

示例
--------

将ASCII数据 hawaii_5x5.xyg 网格化为5分，设置 *tension_factor* = 0.25 :

   ::

    gmt surface hawaii_5x5.xyg -R198/208/18/25 -I5m -Ghawaii_grd.nc -T0.25
