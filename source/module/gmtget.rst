.. index:: ! gmtget
.. include:: common_SYN_OPTs.rst_

gmtget
======

:官方文档: :doc:`gmt:gmtget`
:简介: 列出单个或多个GMT配置参数的当前值

语法
----

**gmt get**
[ |-G|\ *defaultsfile* ]
[ |-L| ]
*PARAMETER1* [ *PARAMETER2* *PARAMETER3* ... ]

必选选项
--------

*PARAMETER*
    要查看的GMT配置参数名。GMT中配置参数列表见 :doc:`/conf/index`

可选选项
--------

.. _-G:

**-G**\ *defaultsfile*
    读取指定的GMT配置文件

    默认情况下，该模块会依次在如下目录中寻找配置文件 **gmt.conf** 直到找到位置：

    - 当前目录
    - 家目录
    - ``~/.gmt`` 目录
    - ``~/.gmt/server`` 目录
    - ``~/.gmt/cache`` 目录
    - 系统默认配置

.. _-L:

**-L**
    输出时一行只输出一个返回值

    一次指定多个参数名时，默认会将所有返回值输出在一行，各值之间以空格分隔。
    该选项会一行只输出一个返回值。

示例
----

列出一个参数的当前值::

    $ gmt get MAP_FRAME_TYPE
    fancy

列出多个参数的当前值::

    $ gmt get MAP_GRID_CROSS_SIZE_PRIMARY MAP_GRID_CROSS_SIZE_SECONDARY
    24p,Helvetica,black 16p,Helvetica,black

使用 **-L** 选项一行显示一个参数值::

    $ gmt get FONT_TITLE FONT_LABEL MAP_FRAME_TYPE -L
    24p,Helvetica,black
    16p,Helvetica,black
    fancy

相关模块
--------

:doc:`gmt.conf`,
:doc:`gmtdefaults`,
:doc:`gmtset`

