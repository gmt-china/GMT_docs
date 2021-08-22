配置参数的设置
================

本节介绍 GMT 配置参数及其设置的方法。GMT 提供了 150 多个配置参数，
用于控制图形的外观（如底图边框的画笔粗细、颜色、文字标注的字体、大小和颜色等）
和数据的处理方式（如插值使用的数学公式、地图投影使用的椭球等）。
这些配置参数一般都有默认值。有时，这些默认值并不合适。例如，下面这幅图的标题相对于底图大了一些，
显得不协调。遇到这样的不让人满意的情况，可以自行设置相关参数，
以细致地调节图形的外观或数据的处理方式。

.. gmtplot::
   :language: bash
   :width: 20%

   gmt basemap -JX4c -R0/1/0/1 -Bwsen+t'Title' -png conf0

要设置参数，就需要解决两个问题：第一个问题是确定需要改哪一个参数，第二个问题才是如何改。

确定参数的方法
--------------

参数的名称是由它控制的元素的属性决定的。上面的例子中的问题是标题的字体太大，
因此需要修改的参数就是「标题的字体」。「标题（TITLE）」是该参数的元素，
「字体（FONT）」则是属性。知道了想要设置的绘图元素或者属性，就可以尝试寻找相应的参数名。
下面的命令可以找到和「标题（TITLE）」相关的参数::

    $ gmt defaults | grep TITLE
    FONT_TITLE                     = 24p,Helvetica,black
    MAP_TITLE_OFFSET               = 14p

下面的命令可以找到和「字体（FONT）」相关的参数::

    $ gmt defaults | grep FONT
    # FONT Parameters
    FONT_ANNOT_PRIMARY             = 12p,Helvetica,black
    FONT_ANNOT_SECONDARY           = 14p,Helvetica,black
    FONT_HEADING                   = 32p,Helvetica,black
    FONT_LABEL                     = 16p,Helvetica,black
    FONT_LOGO                      = 8p,Helvetica,black
    FONT_TAG                       = 20p,Helvetica,black
    FONT_TITLE                     = 24p,Helvetica,black

因为最常修改的是底图，所以建议读者记住底图各个元素的确切名称：

.. figure:: ../basis/tutor_conf.png
   :width: 100%
   :align: center

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