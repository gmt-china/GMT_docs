``-P`` 选项
===========

``-P`` 选项用于设置纸张方向为 Portrait 模式。

由于历史原因，GMT 默认使用 Landscape 模式，详情见 :doc:`/basis/paper` 。可以通过 ``-P`` 选项设定使用Portrait模式，也可以通过设置GMT参数 :ref:`PS_PAGE_ORIENTATION <PS_PAGE_ORIENTATION>` 来修改纸张方向。

.. important::

   ``-P`` 选项设置的是\ **画布的属性**\ ，对于由多个命令绘制而成的图片来说，只有第一个命令的 ``-P`` 选项是有效的。因而其他绘图命令中使用或不使用 ``-P`` 选项并不会影响绘图效果。

.. source: http://gmt.soest.hawaii.edu/doc/latest/GMT_Docs.html#portrait-plot-orientation-the-p-option
