``-U`` 选项
===========

``-U`` 选项会在图上绘制一个带有UNIX系统时间戳的GMT logo。其语法为::

    -U[<just>/<dx>/<dy>/][c|<label>]

- ``-U`` 不加任何参数时会在当前图的左下角添加一个带时间戳的logo
- ``-U<just>/<dx>/<dy>`` 用于控制时间戳的锚点（见 :doc:`/basic/anchors`\ ）
  及时间戳相对于当前坐标原点的位置，比如 ``-UBL/-1c/-1c``
- ``-U<label>`` 会在时间戳后打印字符串 ``<label>``，比如 ``-U"This is string"``
- ``-Uc`` 会在时间戳后打印当前命令

GMT参数中有一些与LOGO相关的参数：

- :ref:`MAP_LOGO <MAP_LOGO>` 控制是否绘制时间戳，默认值为 ``FALSE``
- :ref:`MAP_LOGO_POS <MAP_LOGO_POS>` 用于控制时间戳的位置
- :ref:`FORMAT_TIME_STAMP <FORMAT_TIME_STAMP>` 用于控制时间戳的显示格式
- :ref:`FONT_LOGO <FONT_LOGO>` 时间戳中文本字体

执行如下命令::

    gmt basemap -R0/8/0/3 -Jx1c -Bx1 -By1 -UBL/-1.5c/-1.5c/"This is a GMT logo" -pdf GMT_-U

得到的图片效果如下：

.. figure:: /images/GMT_-U.*
   :width: 100%
   :align: center

   ``-U`` 选项加时间戳

.. important::

   每个带有 ``-U`` 选项的绘图命令都会绘制一遍时间戳，因而只需要一个绘图命令中使用 ``-U`` 即可。
