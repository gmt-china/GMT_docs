-Jp：极坐标线性投影
===================

.. figure:: /images/GMT_polar.*
   :width: 100%
   :align: center

   极坐标（ :math:`\theta, r`\ ）的线性投影

该投影方式将极坐标（角度 :math:`\theta` 和半径 :math:`r` ）转换到纸张上的位置。
此时投影函数为 :math:`x' = f(\theta,r)` 和 :math:`y' = g(\theta,r)`\ ，
X和Y是相互耦合的，且具有360度的周期性，因而与地图投影类似。

#. 通常， :math:`\theta` 是相对于水平方向逆时针旋转的角度，但是也可以加一个
   :math:`\theta_0` 作为所有角度的共同偏移量。
   即 :math:`x' = f(\theta, r) = a r \cos (\theta-\theta_0) + b`
   和 :math:`y' = g(\theta, r) = ar \sin (\theta-\theta_0) + c`\ 。

#. 或者， :math:`\theta` 也可以解释成相对于北方向顺时针旋转的角度，
   当然也可以为所有角度指定一个共同的偏移量 :math:`\theta_0` ，
   即 :math:`x' = f(\theta, r) = ar \cos (90 - (\theta-\theta_0)) + b`
   和 :math:`y' = g(\theta, r) = ar \sin (90 - (\theta-\theta_0)) + c` 。

极坐标投影可以通过如下方式定义：

- 用 ``-Jp<scale>`` 指定比例尺或用 ``-JP<width>`` 指定整张图的宽度
- 在 ``p`` 或 ``P`` 后插入 ``a`` 表明输入数据是顺时针的方位角而不是逆时针的角度
- 在后面加上 ``/<theta_0>`` 表明输入数据的偏移量，默认值为0
- 在后面加上 ``r`` 可以反转径向的方向
- 在后面加上 ``z`` to annotate depths rather than radius.

下面的示例，用 ``grdmath`` 命令生成了 一个 :math:`z(\theta, r) = r^2 \cdot \cos{4\theta}` 的
网格文件，并用 ``grdcontour`` 绘图。

.. literalinclude:: /scripts/GMT_polar.sh
