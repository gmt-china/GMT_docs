.. index:: ! sphinterpolate
.. include:: common_SYN_OPTs.rst_

sphinterpolate
==============

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:sphinterpolate`
:简介:

**sphinterpolate** 读取 lon，lat，z 形式的文件，进行 Delaunay 三角剖分并作球面张力插值。
通过 |-Q| 选项可以使用不同的插值方法。

语法
----

**gmt sphinterpolate** [ *table* ]
|-G|\ *grdfile*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-D|\ [*east*] ]
[ |-Q|\ *mode*\ [*options*] ]
[ |-T| ]
[ |SYN_OPT-V| ]
[ |-Z| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]

    输出网格文件名，其中各子选项的含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__ 。

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-D:

**-D**\ [*east*]
    用于删掉重复点 [默认不删除，即假定数据中不存在重复]；通过追加 *east* 参数表示不对在此经度
    上的点做重复检查

.. _-Q:

**-Q**\ *mode*\ [*options*]
    设置用于内插的计算张力因子的方法，用来保证局部形状特征或满足弧段约束 [默认没有张力]

    - **p** 分段线性插值，不施加张力

    - **l** 使用局部梯度估计进行平滑插值

    - **g**\ [*N*/*M*/*U*] 使用全局梯度估计进行平滑插值。*N*/*M*/*U* 中 *N* 为使用可变
      张力时，迭代次数 [3]; *M* 确定全局梯度时使用的 Gauss-Seidel 迭代次数 [10]; *U* 
      最后一次迭代中梯度变化的阈值 [0.01]

    - **s**\ [*E*/*U*/*N*] 平滑。*E*/*U*/*N* [/0/0/3] 中 *E* 为典型数据值中预期方差；
      *U* 为数据偏差的加权平方和的上限。 *N* 为使用可变张力时的迭代次数。


.. _-T:

**-T**
    使用可变张力; 使用 **-Qp** 选项时，忽略该选项

.. include:: explain_-V.rst_

.. _-Z:

**-Z**
    在内插前，使用最大数据范围 1/(max-min) 进行数据缩放 [默认不缩放]

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

采用分段线性插值由 :file:`mars370d.txt` 生成全球 1 度分辨率网格 ::

    gmt begin mars
        gmt sphinterpolate @mars370d.txt -Rg -I1 -Qp -Gmars.nc
        gmt grdimage mars.nc -JH0/4.5i -B30g30
    gmt end show

使用无张力的插值，由 :file:`testdata.txt` 生成全球 1 度分辨率网格 ::

    gmt sphinterpolate testdata.txt -Rg -I1 -Gsolution.nc

注意事项
--------

STRIPACK 算法需要输入中不包含重复点。
:doc:`gmt:blockmean` 等模块可以将多个接近的点合并成单个点。**sphinterpolate**
的 |-D| 选项也可以删除重复点，但是这通过对点的坐标精确比较实现，对大型
数据集来说，运行可能会很慢。STRIPACK 算法在检测到重复点时，会直接退出执行

参考文献
--------

Renka, R, J., 1997, Algorithm 772: STRIPACK: Delaunay Triangulation and
Voronoi Diagram on the Surface of a Sphere, *AMC Trans. Math. Software*,
**23**\ (3), 416-434.

Renka, R, J,, 1997, Algorithm 773: SSRFPACK: Interpolation of scattered
data on the Surface of a Sphere with a surface under tension, *AMC
Trans. Math. Software*, **23**\ (3), 435-442.

相关模块
--------

:doc:`gmt:greenspline`,
:doc:`nearneighbor`,
:doc:`sphdistance`,
:doc:`sphtriangulate`,
:doc:`surface`,
:doc:`triangulate`
