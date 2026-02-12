:orphan:

使用地形起伏数据对其他非地形起伏数据进行明暗调制
================================================

在使用 :doc:`/module/grdimage` 绘制\ **非**\ 地形起伏的网格数据时，有时会想要给
绘制的图件加上地形起伏的效果，使得图件在展示原始数据的同时还能显示地形变化，且
使得图片更加有立体感。

要实现这一需求，通常需要两步走：

1. 使用 ``grdgradient`` 模块对地形起伏数据生成地形起伏梯度文件
2. 使用 :doc:`/module/grdimage` 模块绘制网格数据，同时 **-I** 选项指定前一步
   生成的地形起伏梯度文件

伪代码为::

    gmt grdgradient earth-relief-data.nc -Gearth-relief-gradient.nc ...
    gmt grdimage other-data.nc -Iearth-relief-gradient.nc ...

这一操作要求地形起伏数据、地形起伏梯度数据、要绘制的原始网格数据，三者必须有
相同的区域范围、网格间隔和配准方式。因而，实际应用时，用户可能需要对地形起伏数据
做裁剪（:doc:`/module/grdcut` 模块）和重采样（``grdsample`` 模块）。

当要绘制的原始网格数据与地形起伏数据具有相同的区域范围、网格间隔和配准方式时，
上面的伪代码可以简化为如下伪代码::

    gmt grdimage other-data.nc -Iearth-relief-data.nc+d ...

在 ``-I`` 末尾加上 ``+d`` ，GMT 会自动计算地形起伏数据 earth-relief-data.nc 的梯度，并在绘制原始
网格数据 other-data.nc 用自动计算出的梯度数据进行明暗调制。

下面的示例展示了在绘制洋壳年龄数据时如何增加地形起伏效果。原始洋壳年龄数据
``@earth_age_06m`` 和地形起伏数据 ``@earth_relief_06m`` 具有相同的区域范围、
网格间隔和配准方式，因而可以用上面提到的第二种方式直接绘制。

下图中，左图和右图分别是未加地形起伏效果和添加地形起伏效果的图件。

.. gmtplot:: ex003.sh
