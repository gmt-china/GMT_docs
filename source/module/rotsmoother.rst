.. index:: ! rotsmoother
.. include:: common_SYN_OPTs.rst_

rotsmoother
=============

:贡献者: |何星辰|
:最近更新日期: 2025-10-17

----

:官方文档: :doc:`gmt:supplements/spotter/rotsmoother`
:简介: 从有限旋转集中获取平均旋转和协方差矩阵

**rotsmoother** 读取一个总重建表格，并根据旋转年龄（或所有旋转）将其划分为若干子组，计算每个子组的平均旋转（以及可选的协方差矩阵）。

语法
--------

**gmt rotsmoother** [ *table* ]
[ |-A| ]
[ |-C| ]
[ |-N| ]
[ |-S| ]
[ |-T|\ *ages* ]
[ |SYN_OPT-V| ]
[ |-W| ]
[ |-Z| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必需选项
------------------

*table*
    包含 (*lon lat time angle* [*weight*]) 值的旋转表名称。

可选选项
------------------

.. _-A:

**-A**
    使用张开角（opening angles）作为时间的代理。当无法为旋转指定时间时适用。
    在这种情况下，输入应包含 *lon lat angle* [*weight*] 记录，且 |-T| 的设置将对应于角度而非时间。
    默认情况下，输入应为 *lon lat time angle* [*weight*]，且 |-T| 表示时间。

.. _-C:

**-C**
    为每个平均旋转计算协方差矩阵。
    该过程将每个有限旋转转换为四元数（quaternion），求取平均四元数（即平均旋转），
    并将所有旋转视为相对于平均旋转的扰动。
    然后根据这些扰动计算出协方差矩阵。

.. _-N:

**-N**
    确保所有旋转极点位于北半球。
    [默认确保张开角为正值。]

.. _-S:

**-S**
    确保所有旋转极点位于南半球。
    [默认确保张开角为正值。]

.. _-T:

**-T**\ *ages*
    设置所需的年龄分组。
    若只给定一个时间点，则附加所需的时间值，所有旋转将用于计算单个平均旋转。
    若需按等间隔划分的重建年龄区间，请使用 **-T**\ *start*\ /\ *stop*\ /\ *inc*，
    或 **-T**\ *start*\ /\ *stop*\ /\ *npoints*\ **+n**。
    若为非等间隔的重建年龄集合，请通过文件的第一列传入，例如 **-T**\ *agefile*。
    我们读取或生成的年龄将作为分箱边界（bin boundaries），输出每个箱内所有旋转的平均时间。

.. include:: explain_-V.rst_

.. _-W:

**-W**
    在输入表的最后一列中指定权重，以执行加权平均旋转 [默认不使用权重]。

.. _-Z:

**-Z**
    输出负的张开角 [默认输出正值]。

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_-n.rst_

.. include:: explain_help.rst_

.. include:: explain_geodetic.rst_

大地坐标与地心坐标
--------

所有球面旋转操作都在地心坐标下进行。
这意味着输入的数据点和网格被视为大地坐标，需要首先转换为地心坐标；
旋转操作完成后，重建得到的点会再转换回大地坐标。
如果将椭球体设置参数 **PROJ_ELLIPSOID** 改为 *Sphere*，则可以跳过这种默认行为。

示例
--------

要以 3 Myr 的时间步长平滑旋转组，并确保极点位于北半球，执行::

    gmt rotsmoother rotations.txt -N -T3/3/30 -V > rot_means.txt

要平滑所有旋转并计算单个平均旋转（分配时间为 5），同时输出对应的协方差矩阵，执行::

    gmt rotsmoother rotations.txt -C -T5 -V > rot_means_cov.txt

相关模块
--------

:doc:`backtracker`,
:doc:`gmtpmodeler`,
:doc:`grdpmodeler`,
:doc:`grdspotter`,
:doc:`hotspotter`,
:doc:`originater`,
:doc:`rotconverter`

