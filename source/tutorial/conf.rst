参数控制
========

本节介绍 GMT 配置参数及其设置方法。GMT 提供了 150 多个配置参数，
用于控制图像的外观（如底图边框的画笔粗细、颜色，文字标注的字体、大小和颜色等）
和数据的处理方式（如插值使用的数学公式、地图投影使用的椭球等）等。
这些配置参数一般都有默认值。如果不满意默认值的绘图或处理效果，
可以重新设置参数的值以细致地调节图像的外观和数据的处理方式。
例如，下面这幅图的标题相对于底图大了一些，显得不协调。这便产生了需要设置标题字体的需求。

.. gmtplot::
   :language: bash
   :width: 20%

   gmt basemap -JX4c -R0/1/0/1 -Bwsen+t'Title' -png conf0

本节的第一小节介绍参数设置的方法，读者通过学习第一节可以知道如何修改一个参数。
后面两节是指导用户如何依据自己的需求找到相应的参数。

参数设置的方法
---------------

参数设置的方法有两种：一种为全局设置，即对设置以后的所有命令都有效。另一种为临时设置，
即只对该条命令有效。下面以参数 :term:`FONT_TITLE` 为例介绍参数设置的这两种方法。
顾名思义，:term:`FONT_TITLE` 这个参数是设置标题（TITLE）的字体（FONT）。

下面是全局设置的例子。
在这个例子中，参数设置是通过模块 set 实现的。

.. gmtplot::
   :language: bash
   :width: 50%
   :caption: 参数的全局设置

   gmt begin conf1 png
   gmt set FONT_TITLE 12p,Times-Bold,red # 参数全局设置
   gmt subplot begin 1x2 -Fs5c/3c
   gmt subplot set 0
   gmt basemap -JX5c -R0/1/0/1 -Bwsen+t'Title One'
   gmt subplot set 1
   gmt basemap -JX5c -R0/1/0/1 -Bwsen+t'Title Two'
   gmt subplot end
   gmt end

这幅图中两个子图的标题字体都是 ``12p,Times-Bold,red``。

下面是临时设置的例子。
在这个例子中，参数设置是通过添加参数 ``--KEY=value`` 的形式实现的。

.. gmtplot::
   :language: bash
   :width: 50%
   :caption: 参数的临时设置

   gmt begin conf2 png
   gmt subplot begin 1x2 -Fs5c/3c
   gmt subplot set 0
   gmt basemap -JX5c -R0/1/0/1 -Bwsen+t'Title One' --FONT_TITLE=12p,Times-Bold,red
   gmt subplot set 1
   gmt basemap -JX5c -R0/1/0/1 -Bwsen+t'Title Two' --FONT_TITLE=12p,Times-Bold,blue
   gmt subplot end
   gmt end

绘图元素的名称
------------------

下图展示了GMT绘图的绘图元素及其英文名称。

.. figure:: /images/tutor_conf.png
   :width: 80%
   :align: center

寻找参数的方法
------------------

知道了想要设置的绘图元素或者属性，就可以尝试找到相应的参数名。
例如，参数 :term:`FONT_TITLE` 就是字体和标题合并起来的。
下面的命令可以找到和标题相关的参数::

    $ gmt defaults | grep TITLE
    FONT_TITLE                     = 24p,Helvetica,black
    MAP_TITLE_OFFSET               = 14p

下面的命令可以找到和字体相关的参数::

    $ gmt defaults | grep FONT
    # FONT Parameters
    FONT_ANNOT_PRIMARY             = 12p,Helvetica,black
    FONT_ANNOT_SECONDARY           = 14p,Helvetica,black
    FONT_HEADING                   = 32p,Helvetica,black
    FONT_LABEL                     = 16p,Helvetica,black
    FONT_LOGO                      = 8p,Helvetica,black
    FONT_TAG                       = 20p,Helvetica,black
    FONT_TITLE                     = 24p,Helvetica,black
