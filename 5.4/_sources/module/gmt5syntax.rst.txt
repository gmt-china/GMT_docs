.. index:: ! gmt5syntax

gmt5syntax
==========

:官方文档: :doc:`gmt:gmt5syntax`
:简介: 将旧的GMT脚本修改成新的 ``gmt <module>`` 语法。

``gmt5syntax`` 是一个Perl脚本，作用是在命令前加上 ``gmt`` 使得旧版本的语法变成
新版本语法。该脚本位于 ``${GMTHOME}/share/tools`` 目录下。

用法
----

::

    gmt5syntax old_script > new_script
