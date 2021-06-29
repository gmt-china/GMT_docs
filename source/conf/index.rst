.. index:: ! gmt.conf

配置参数
########

除了丰富的模块选项之外，GMT 还提供了 150 多个配置参数，
可以用于控制图像的外观（如底图边框的画笔粗细与颜色、文字标注的字体、大小与颜色等）
和数据的处理方式（如默认的插值方式、地图投影使用的椭球等）等。
例如，下面的图例展示了常用的用于控制绘图效果的配置参数。

.. gmtplot:: defaults_1.sh
    :caption: 配置参数示例 1
    :width: 70%
    :show-code: false

.. gmtplot:: defaults_2.sh
    :caption: 配置参数示例 2
    :width: 70%
    :show-code: false

.. gmtplot:: defaults_3.sh
    :caption: 配置参数示例 3
    :width: 70%
    :show-code: false

本章将详细介绍这些 GMT 的配置参数：
.. toctree::
   :maxdepth: 1

   overview
   font
   map
   color
   dir
   format
   io
   proj
   ps
   time
   misc
