:author: 田冬冬, 陈箫翰
:date: 2025-12-31

.. index:: ! fitcircle
.. program:: fitcircle

fitcircle
=========

:官方文档: :doc:`gmt:fitcircle`
:简介: 拟合球面上数据点的平均位置及圆弧

**fitcircle** 从标准输入 [或 *table*] 的前两列读取 (*经度, 纬度*) 值。这些值被转换为单位球上的笛卡尔三维矢量。
然后找到两个位置：输入位置的平均值，以及最拟合输入位置的大圆的极点。用户可以从该问题的两个可能解中选择一个或两个。
第一个称为 **-L1**，第二个称为 **-L2**。当数据沿大圆紧密聚集时，两个解相似。
如果数据分散程度较大，则大圆极点的确定将不如平均值那样准确。比较这两个解可作为定性检查。

**-L1** 解近似于角距离余弦绝对值之和的最小化。
该解将平均位置确定为数据的 Fisher 平均值，将极点位置确定为平均值与数据之间叉积的 Fisher 平均值。
对叉积取平均会根据点到平均值的距离按比例赋予权重，类似于平面线性回归中远距离点的“杠杆作用”。

**-L2** 解近似于角距离余弦平方和的最小化。
它创建了一个由数据矢量分量平方和组成的 3 x 3 矩阵。该矩阵的特征向量给出了平均位置和极点位置。
当有数千个数据时，此方法可能更容易受到舍入误差的影响。极点由最小特征值对应的特征向量给出；
它是数据中表现最差的因子，且通过任何一种方法都不易估计。

语法
----

**gmt fitcircle**
[ *table* ]
:option:`-L`\ *norm*
[ :option:`-F`\ *flags* ]
[ :option:`-S`\ [*lat*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-a`\ *flags* ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
------------------

.. include:: explain_intables.rst_

必须选项
--------

.. option:: -L

**-L**\ *norm*
    *norm* 取值
    - 1: 解法1
    - 2: 解法2
    - 3 或留空: 同时输出解法1和解法2的结果

可选选项
--------

.. option:: -F

**-F**\ **f**\|\ **m**\|\ **n**\|\ **s**\|\ **c**
    控制输出格式。

    正常情况下，该命令会将计算结果以较复杂的形式输出。使用本选项，则只返回简单的坐标。
    后面可以加上其他修饰符以指定要返回的坐标：

    - **f** 平面地球平均位置
    - **m** 平均位置
    - **n** 大圆北极
    - **s** 大圆南极
    - **c** 小圆极点及其余纬，需要 :option:`-S`

.. option:: -S

**-S**\ *lat*
    尝试拟合小圆而非大圆。极点将被约束在连接“最佳拟合大圆极点”与“数据平均位置”的大圆上。
    可附加所需的小圆固定纬度 *lat* [默认自动确定最佳纬度]。

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

示例
----

.. include:: explain_example.rst_

以最小二乘法寻找最拟合远程文件 @sat_03.txt 中 (*经度, 纬度*) 点的大圆参数::

    gmt fitcircle @sat_03.txt -L2 -Fm

假设在文件 ship.xyg 中有沿着弯曲船迹的 *经度, 纬度, 重力* 数据。希望将这些数据投影到大圆上，并按距离进行重采样，以便对其进行滤波或检查其频谱::

    gmt fitcircle ship.xyg -L2
    gmt project ship.xyg -Cox/oy -Tpx/py -S -Fpz | gmt sample1d -S-100 -I1 > output.pg

此处，ox/oy 是 **fitcircle** 得到的平均位置的经纬度，而 px/py 是极点的经纬度。文件 output.pg 包含了沿最拟合 ship.xyg 的大圆每隔 1 km 采样一次的距离和重力数据。

数据文件 data.txt 中包含 *经度, 纬度* 点，使用 L2 范数返回北半球大圆极点位置::

    gmt fitcircle data.txt -L2 -Fn > pole.txt

用两种计算方法拟合了数据的大圆弧路径和小圆弧路径，并借助 :doc:`project` 生成路径坐标。

.. gmtplot:: fitcircle/fitcircle_ex1.sh
    :width: 80%

    fitcircle示例

相关模块
--------

:doc:`vector`,
:doc:`project`,
:doc:`mapproject`,
:doc:`sample1d`