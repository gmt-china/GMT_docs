GMT 单行模式
============

在之前的教程中，有很多示例都只需要一个 GMT 命令即可完成绘图。比如::

    gmt begin GlobalMap
        gmt coast -Rg -JH15c -Gpurple -Baf -B+t"My First Plot"
    gmt end show

在这种简单的情况下，每次都需要写 **gmt begin** 和 **gmt end** 未免有些麻烦。

针对这种简单情况，GMT 提供了 “单行模式”。即当绘图只需要一个 GMT 命令时，
可省略 **gmt begin** 和 **gmt end**，只需要在绘图命令后加上
**-**\ *format* *figname* 即可。

例如，上面的三行命令可以用单行模式写成一行命令::

    gmt coast -Rg -JH15c -Gpurple -Baf -B+t"My First Plot" -pdf,png GlobalMap

命令一下子就简单了很多，也可以直接将命令复制粘贴到终端执行。

显然，单行模式只适用于单个命令成图的情况，而大部分实际绘图都需要多个命令才能实现。

.. note::

    GMT 官方文档以及本手册中，很多示例都只需使用单个 GMT 命令来展示某个模块的用法或
    某个选项的绘图效果。

    出于简化代码的考虑，本手册中的很多演示示例都采用了 GMT 单行模式。
    读者应理解其中的差异，并了解如何修改单行模式的命令并应用到自己的实际绘图脚本中。
