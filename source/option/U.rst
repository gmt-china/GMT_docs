``-U`` 选项
===========

``-U`` 选项会在图上绘制一个UNIX系统时间戳。其语法为::

    -U[<label>][+c][+j<just>][+o<dx>/<dy>]

- ``-U`` 不加任何参数时会在当前图的左下角添加一个带时间戳的logo
- ``-U<label>`` 会在时间戳后打印字符串 ``<label>``\ ，比如 ``-U"This is string"``
- ``-U+c`` 会在时间戳后打印当前命令
- ``-U+j<just>+o<dx>/<dy>`` 用于控制时间戳相对于当前坐标原点的锚点
  （见 :doc:`/basis/anchor`\ ）和偏移量。例如，\ ``-jBL+o0/0`` 表示将时间戳的
  左下角与底图的坐标原点对齐

GMT参数中有一些与LOGO相关的参数：

- :ref:`MAP_LOGO <MAP_LOGO>` 控制是否绘制时间戳，默认值为 ``FALSE``
- :ref:`MAP_LOGO_POS <MAP_LOGO_POS>` 用于控制时间戳的位置
- :ref:`FORMAT_TIME_STAMP <FORMAT_TIME_STAMP>` 用于控制时间戳的显示格式
- :ref:`FONT_LOGO <FONT_LOGO>` 时间戳中文本的字体

.. gmt-plot::
    :caption: ``-U`` 选项加时间戳

    gmt basemap -R0/10/0/5 -JX10c/3c -Bx1 -By1 \
        -U"This is a GMT logo"+jBL+o-1.5c/1.5c -png GMT_-U

.. important::

   每个带有 ``-U`` 选项的绘图命令都会绘制一遍时间戳，因而只需要一个绘图命令中
   使用 ``-U`` 即可。
