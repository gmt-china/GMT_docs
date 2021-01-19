参数控制
========

下面这幅图的标题相对于底图太大了。这便产生了需要设置标题字体的需求。

.. gmtplot::
   :language: bash
   :width: 20%

   gmt basemap -JX4c -R0/1/0/1 -Bwsen+t'Title' -png conf0

入门教程的最后一节介绍 GMT 的参数设置。GMT 有一些用于约束绘图和数据处理的参数。
用户如果想要更为细致地调节绘图和数据的处理，则需要设置这些参数。

参数设置的方法
---------------

首先借用参数 :term:`FONT_TITLE` 介绍参数设置的两种方法。
顾名思义，``FONT_TITLE`` 这个参数是设置标题（TITLE）的字体（FONT）。
两种设置方式：一种为全局设置，即设置之后对所有命令有效。另一种是临时参数，即只对该命令有效。

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

下面是临时参数的例子。
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
