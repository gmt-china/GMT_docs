.. index:: ! fitcircle

fitcircle
=========

:官方文档: :doc:`gmt:fitcircle`
:简介: 拟合球面上数据点的平均位置及圆弧

该命令从输入数据的前两列读取经纬度数据，将其转换为单位球面上的笛卡尔三维矢量，
然后计算输入坐标数据的平均位置以及可以拟合这些坐标点的大圆路径的pole。

必选选项
--------

``<table>``
    输入数据

``-L<norm>``

    - ``-L1`` 解法1
    - ``-L2`` 解法2
    - ``-L`` 或 ``-L3`` 同时输出解法1和解法2的结果

    在计算输入坐标的均值和大圆弧pole时有两种计算方法，分别用 ``-L1`` 和 ``-L2``
    表示。当数据沿着某个大圆弧且距离接近时，两组解结果相似。若数据较分散，
    则大圆弧的pole要比均值不精确得多。此时可以比较两组结果以作为相互的验证。

    The **-L1** solution is so called because it approximates the
    minimization of the sum of absolute values of cosines of angular
    distances. This solution finds the mean position as the Fisher average
    of the data, and the pole position as the Fisher average of the
    cross-products between the mean and the data. Averaging cross-products
    gives weight to points in proportion to their distance from the mean,
    analogous to the "leverage" of distant points in linear regression in the plane.

    The **-L2** solution is so called because it approximates the
    minimization of the sum of squares of cosines of angular distances. It
    creates a 3 by 3 matrix of sums of squares of components of the data
    vectors. The eigenvectors of this matrix give the mean and pole
    locations. This method may be more subject to roundoff errors when there
    are thousands of data. The pole is given by the eigenvector
    corresponding to the smallest eigenvalue; it is the least-well
    represented factor in the data and is not easily estimated by either method.

选项
----

``-Ff|m|n|s|c``
    控制输出格式。

    正常情况下，该命令会将计算结果以较复杂的形式输出。使用 ``-F`` 选项，则只
    返回简单的坐标。 ``-F`` 后可以加上其他修饰符以指定要返回的坐标：

    - ``f`` Flat Earth mean location
    - ``m`` mean location
    - ``n`` north pole of great circle
    - ``s`` south pole of great circle
    - ``c`` pole of small circle and its colatitude, which requires ``-S``

``-S[<lat>]``
    拟合小圆弧而不是大圆弧

    The pole will be constrained to lie on the great circle connecting the pole
    of the best-fit great circle and the mean location of the data.
    Optionally append the desired fixed latitude of the small circle
    [Default will determine the latitude].

示例
----

如下命令，用两种计算方法拟合了数据的大圆弧路径和小圆弧路径，并借助 :doc:`project`
生成路径坐标。

.. gmtplot:: fitcircle/fitcircle_ex1.sh

   fitcircle示例
