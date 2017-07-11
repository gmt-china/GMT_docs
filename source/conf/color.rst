COLOR参数
=========

下面列出所有与颜色相关的参数，参数的默认值在中括号内列出。

.. _COLOR_BACKGROUND:

**COLOR_BACKGROUND**
    图片背景色，数据Z值小于CPT文件中最小值所对应的背景色 [black]

.. _COLOR_FOREGROUND:

**COLOR_FOREGROUND**
    图片前景色，数据Z值大于CPT文件中最大值所对应的前景色 [white]

.. _COLOR_NAN:

**COLOR_NAN**
    Z值等于 ``NaN`` 时所使用的颜色 [127.5]

某些绘图命令（比如 ``grdimage`` 、 ``psscale`` ）可以使用强度文件（intensity file）来模拟光照效果。光照效果的实现，本质上是先将任意颜色转换成HSV模型，然后根据强度的正负，增大/减小HSV模型中的S（饱和度）和V（明度），以达到模拟光照的效果。下面的四个参数控制了模拟光照过程中S和V变化的极限值，估计是为了避免过亮或过暗的情况。

.. _COLOR_HSV_MAX_S:

**COLOR_HSV_MAX_S**
    最大正强度对应的S值，取值范围0到1 [0.1]

.. _COLOR_HSV_MIN_S:

**COLOR_HSV_MIN_S**
    最小负强度对应的S值，取值范围0到1 [1.0]

.. _COLOR_HSV_MAX_V:

**COLOR_HSV_MAX_V**
    最大正强度对应的V值，取值范围0到1 [1.0]

.. _COLOR_HSV_MIN_V:

**COLOR_HSV_MIN_V**
    最小负强度对应的V值，取值范围0到1 [0.3]

.. _COLOR_MODEL:

**COLOR_MODEL**
    对CPT文件做插值时所使用的颜色空间 [none]

    可以取如下值：

    - ``none`` ：使用CPT文件的注释行中指定的 ``COLOR_MODEL``
    - ``rgb`` ：在RGB颜色空间中插值
    - ``hsv`` ：在HSV颜色空间中插值
    - ``cmyk`` ：假定文件是CMYK颜色，但在RGB空间插值

    在RGB颜色空间内插值可能会产生异常的色调，而直接在HSV颜色空间插值则可以更好地保留色调值。
