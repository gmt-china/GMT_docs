.. index:: ! gmt5syntax

gmt5syntax
==========

:官方文档: :doc:`gmt:gmt5syntax`
:简介: 将旧的GMT4脚本修改成GMT5的 **gmt** *module* 语法

GMT4中每个模块都是一个单独的命令，这可能会造成命令冲突。从GMT5开始，GMT只提供
一个命令，即 **gmt**\ 。其他所有命令都变成了 **gmt** 的模块。

因而，GMT4中的 **psbasemap** 命令在GMT5中应写作 **gmt psbasemap**\ 。

**gmt5syntax** 是一个Perl脚本，作用是在命令前加上 **gmt** 将GMT4的语法改成
GMT5的新语法。该脚本位于 ``${GMTHOME}/share/tools`` 目录下。

用法
----

::

    gmt5syntax old_script > new_script
