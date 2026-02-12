.. index:: ! gmtwhich
.. include:: common_SYN_OPTs.rst_

gmtwhich
========

:官方文档: :doc:`gmt:gmtwhich`
:简介: 返回指定文件的完整路径

GMT会依次在如下目录中去寻找命令行中指定的文件::

    当前目录 > $GMT_USERDIR (``~/.gmt``) > $GMT_DATADIR (``~/.gmt/server``) > $GMT_CACHEDIR (``~/.gmt/cache``)

该命令会报告文件的完整路径，使得用户可以确认自己在使用的究竟是哪个数据文件。

语法
----

**gmt which** *files*
[ |-A| ]
[ |-C| ]
[ |-D| ]
[ |-G|\ [**c**\|\ **l**\|\ **u**] ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必选选项
--------

*files*
    任意一个或多个数据文件名

可选选项
--------

.. _-A:

**-A**
    仅考虑用户有读权限的文件

.. _-C:

**-C**
    不报告完整路径，只打印 **Y** 或 **N** 以表示是否找到文件

**-D**
    不报告完整路径，仅打印包含该文件的目录名

.. _-G:

**-G**\ [**c**\|\ **l**\|\ **u**]
    自动下载指定的文件

    GMT可以自动下载某些文件：

    - 以链接形式给定的文件，会自动下载到当前目录
    - 以 **@**\ *filename* 形式指定的文件会自动从GMT数据服务器上下载
    - ``@earth_relief_xxy`` GMT提供的全球地形起伏数据

    使用该选项，若GMT在当前目录或本地缓存目录中位找到文件，则会尝试下载。

    **-Gl** 表示下载到当前目录（默认行为），\ **-Gu** 表示下载到用户数据目录，
    **-Gc** 表示下载到用户缓存目录

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

示例
----

查看文件的路径::

    gmt which myjunk.txt

下载并返回GMT提供的10弧分精度的全球地形起伏数据::

    gmt which -Gu @earth_relief_10m

从GMT数据服务器下载GMT示例数据。该数据会被下载到GMT缓存目录中（默认为 ``~/.gmt/cache``\ ）::

    gmt which -Gc @hotspots.txt
