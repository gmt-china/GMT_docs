.. index:: !x2sys_solve
.. include:: common_SYN_OPTs.rst_

x2sys_solve
===========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_solve`
:简介: 使用最小二乘平差计算系统误差改正值，即交叉点平差

**x2sys_solve** 使用给定的交叉点信息计算系统误差改正值，并应用于每条轨迹以
提高数据质量。本模块可消除 7 种不同的系统误差。

语法
----

**gmt x2sys_solve** |-C|\ *column* |-T|\ *TAG* |-E|\ **c**\|\ **d**\|\ **g**\|\ **h**\|\ **s**\|\ **y**\|\ **z**
[ *COE_list.txt* ]
[ |SYN_OPT-V| ]
[ |-W|\ [**+u**] ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT--| ]


必选选项
--------

*COE_list.txt*
    由 :doc:`x2sys_list` 模块筛选的某观测量的交叉点文件。
    如果使用了 **-bi** 选项，开始的两列为轨迹的 ID，
    否则，就在最后两列给出轨迹名称。
    如果不给定该输入文件，就从标准输入读取数据。

.. _-T:

**-T**\ *TAG*
    指定 x2sys TAG，参见 :doc:`x2sys_init`

.. _-C:

**-C**\ *column*
    指定要处理的列，需要和 :doc:`x2sys_list` 中准备的输入数据中的选项一致。

.. _-E:

**-E**\ **c**\|\ **d**\|\ **g**\|\ **h**\|\ **s**\|\ **y**\|\ **z**
    设置用来拟合系统误差的模型。模型的类型可以从下面的函数 f(**p**) 中选择，
    其中 **p** 是每条轨迹所包含的参数，参数个数为 *m* 个，
    GMT 将使用最小二乘拟合这些参数。

    - **c**   f(**p**) = *a* （a 为常数）；记录中必须包含交叉点不符值（COE）, ID1 和 ID2

    - **d**   f(**p**) = *a* + *b* \* *d* （线性漂移，**d** 为沿轨距离）；
      记录中必须包含：轨迹 1 距离（d1），轨迹 2 距离（d2），COE， ID1 和 ID2

    - **g**   f(**p**) = *a* + *b* sin(y)^2 （1880-1930 重力改正）；
      记录中必须包含：交叉点的纬度 y，COE，ID1，ID2

    - **h**   f(**p**) = *a* + *b* cos(h) + *c* cos(2h) + *d* sin(h) + *e* sin(2h)
      （磁朝向改正，*h* 为交叉点处的轨迹方位角）；记录中必须包含：
      轨迹 1 方位角（h1），轨迹 2 方位角（h2），COE，ID1，ID2

    - **s**   f(**p**) = *a* \* z （a 是单位缩放改正，*z* 是交叉点的观测值）；
      记录中必须包含：z1，z2，ID1，ID2

    - **t**   f(**p**) = *a* + *b* \* (*t - t0*) （线性漂移， *t -t0* 是
      沿轨累积时间，*t* 为观测时刻，*t0* 为测线起始时刻）；
      记录中必须包含：t1-t0，t2-t0，COE，ID1，ID2

    - **z**  f(**p**) = *a* + *b* \* z （偏移加单位缩放）；记录中必须包含
      z1，z2，ID1，ID2

可选选项
--------

.. _-W:

**-W**\ [**+u**]
    使用该选项则意味着，每种观测值在其前面还有一列，表示其权重，
    可用于加权最小二乘平差 [默认没有权重列]。
    追加 **+u** 将输出不含权重的均值和标准差 [默认输出带有权重的统计值]

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_core.rst_

.. include:: explain_help.rst_

注意事项
--------

|-E| 选项中的大多数系统误差模型均包含一个常数偏移量。由于交叉点不符值是两个点
的差值，因此，这种常数偏移是相对量，而不是绝对量。为了最终结果可解，GMT 添加
了其他的约束，即所有的常数偏移量的和等于 0。
如果轨迹形成的集合中只包含同类轨迹，与其他轨迹不存在交叉点，
则形成两个轨迹集合，则每个集合的约束是独立的。GMT 会自动确定集合的数量，
并自动添加约束。如果需要设置特定的轨迹具有指定的偏移，则可以从每条轨迹
中减去本身的偏移，然后加上设定的偏移。

示例
----

以 MGD77 为 TAG 的所有轨道的重力异常均包含一个简单的常数偏移，
对该系统误差进行平差::

    gmt x2sys_list COE_data.txt -V -TMGD77 -Cfaa -Fnc > faa_coe.txt
    gmt x2sys_solve faa_coe.txt -V -TMGD77 -Cfaa -Ec > coe_table.txt

若重力异常观测数据中存在与时间相关的线性漂移::
    
    gmt x2sys_list COE_data.txt -V -TMGD77 -Cfaa -FnTc > faa_coe.txt
    gmt x2sys_solve faa_coe.txt -V -TMGD77 -Cfaa -Et > coe_table.txt

以 MGD77 为 TAG 的轨迹数据生成磁观测交叉点文件 :file:`COE_data.txt` ，
估计磁朝向改正::
    
    gmt x2sys_list COE_data.txt -V -TMGD77 -Cmag -Fnhc > mag_coe.txt
    gmt x2sys_solve mag_coe.txt -V -TMGD77 -Cmag -Eh > coe_table.txt

基于测深交叉点估计单位缩放因子::
    
    gmt x2sys_list COE_data.txt -V -TMGD77 -Cdepth -Fnz > depth_coe.txt
    gmt x2sys_solve depth_coe.txt -V -TMGD77 -Cdepth -Es > coe_table.txt

相关模块
--------

:doc:`x2sys_binlist`,
:doc:`x2sys_datalist`,
:doc:`x2sys_get`,
:doc:`x2sys_list`,
:doc:`x2sys_put`,
:doc:`x2sys_report`,
:doc:`x2sys_init`,
:doc:`x2sys_cross`,
:doc:`x2sys_merge`
