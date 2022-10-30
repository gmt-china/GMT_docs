.. index:: ! gmtwhich
.. include:: common_SYN_OPTs.rst_

gmtwhich
========

:官方文档: :doc:`gmt:gmtwhich`
:简介: 返回指定文件的完整路径

该模块会报告文件的完整路径，使得用户可以确认自己在使用的究竟是哪个数据文件。

GMT 会依次在如下目录中去寻找命令行中指定的文件：
当前目录 > GMT 用户目录 > GMT 数据目录 > GMT 缓存目录。
可以参考 :doc:`/basis/input-files` 了解每个目录的具体指定方式。

语法
----

**gmt which** *files*
[ |-A| ]
[ |-C| ]
[ |-D| ]
[ |-G|\ [**a**\|\ **c**\|\ **l**\|\ **u**] ]
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
    仅考虑用户有读权限的文件 [默认不考虑权限问题]

.. _-C:

**-C**
    不报告完整路径，只打印 **Y** 或 **N** 以表示是否找到文件

.. _-D:

**-D**
    不报告完整路径，仅打印包含该文件的目录名

.. _-G:

**-G**\ [**a**\|\ **c**\|\ **l**\|\ **u**]
    自动下载指定的文件。指定下载文件的方式有：

    - URL 链接形式指定的文件：下载到当前目录
    - **@**\ *filename* 形式指定的文件：从 GMT 数据服务器上下载到缓存目录
    - **@earth_relief_**\ *xxy* 形式指定的文件（即 GMT 提供的地学数据集）：
      从 GMT 数据服务器上下载到用户目录下的 :file:`server` 子目录

    使用该选项时，GMT 会先按照 :doc:`/basis/input-files` 中指定的搜索顺序寻找文件，
    若未找到文件，才会尝试下载该文件：

    - **-Gl**： 下载到当前目录 [默认选项]
    - **-Ga**： 下载到用户目录的子目录中，如 :file:`server`、:file:`cache` 子目录
    - **-Gu**： 下载到数据目录
    - **-Gc**： 下载到缓存目录

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

示例
----

查看某个文件的路径::

    gmt which myjunk.txt

下载并返回GMT提供的10分精度的全球地形起伏数据::

    gmt which -Ga @earth_relief_10m

从GMT数据服务器下载GMT示例数据。该数据会被下载到GMT缓存目录中（默认为 ``~/.gmt/cache``）::

    gmt which -Gc @hotspots.txt
