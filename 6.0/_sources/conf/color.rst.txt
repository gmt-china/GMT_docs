COLOR参数
=========

这一节列出所有与颜色相关的配置参数，参数的默认值在中括号内列出。

CPT相关参数
-----------

.. glossary::

    **COLOR_BACKGROUND**
        数据Z值小于CPT文件中最小值时使用的背景色 [``black``]

    **COLOR_FOREGROUND**
        数据Z值大于CPT文件中最大值时使用的前景色 [``white``]

    **COLOR_NAN**
        数值Z值为 NaN 时使用的颜色 [``127.5``]

    **COLOR_MODEL**
        对CPT文件做插值生成新CPT时所使用的色彩模型 [``none``]

        可以取如下值：

        - ``none``\ ：使用CPT文件中指定的 ``COLOR_MODEL``
        - ``rgb``\ ：在RGB色彩空间中插值
        - ``hsv``\ ：在HSV色彩空间中插值
        - ``cmyk``\ ：假定颜色是CMYK色彩空间，但在RGB空间内插值

光照相关参数
------------

某些绘图模块（如 :doc:`/module/grdimage`\ 、\ :doc:`/module/colorbar`\ ）
可以利用强度文件模拟光照效果。
光照效果的实现，本质上是先将任意颜色转换成HSV模型，然后根据
强度的正负，增大/减小HSV模型中的S（饱和度）和V（明度），以达到模拟光照的效果。
下面的四个参数控制了模拟光照过程中S和V变化的极限值，以避免模拟的光照过亮或过暗。

.. glossary::

    **COLOR_HSV_MIN_S**
        负强度最小值对应的S值，取值范围0到1 [1.0]

    **COLOR_HSV_MAX_S**
        正强度最大值对应的S值，取值范围0到1 [0.1]

    **COLOR_HSV_MIN_V**
        负强度最小值对应的V值，取值范围0到1 [0.3]

    **COLOR_HSV_MAX_V**
        正强度最大值对应的V值，取值范围0到1 [1.0]
