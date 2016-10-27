``-c`` 选项
===========

``-c`` 选项用于指定当前 PS 文件在打印时要被打印多少份，默认值为1。

例如，当绘图命令中使用 ``-c3`` 时，则用打印机打印该 PS 文件时，会自动打印3份。

.. attention::

   ``-c`` 选项本质上是将 PS 代码 ``/#copies n def`` 写到了 PS **文件头** 中，因而该选项仅在第一个绘图命令中使用才有效，即仅当绘图命令中无 ``-O`` 选项时才有效。

.. source: http://gmt.soest.hawaii.edu/doc/latest/GMT_Docs.html#number-of-copies-the-c-option
