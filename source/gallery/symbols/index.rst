绘制符号
========

:doc:`/module/psxy` 模块的 ``-S`` 选项可以绘制几十种不同类型的符号，比如
圆圈、矩形、正方形、三角形、菱形等。

简单符号
--------

下图使用 :doc:`/module/psxy` 绘制了最简单的几个符号。绘制这些符号时，只需要指定
符号的坐标以及符号的大小即可。

使用如下命令::

    echo 0 0 | gmt psxy -R-1/1/-1/1 -Jx3c -Ba -Sc2c -W1p > simple_symbol.ps

并将其中的 ``-Sc`` 改成不同的值，即可绘制对应的符号。

.. gmt-plot:: simple_symbols.sh
   :caption: 使用 psxy 绘制简单符号
   :show-code: false
