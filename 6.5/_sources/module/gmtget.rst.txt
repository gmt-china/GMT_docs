.. index:: ! gmtget
.. include:: common_SYN_OPTs.rst_

gmtget
======

:官方文档: :doc:`gmt:gmtget`
:简介: 列出单个或多个GMT配置参数的当前值、下载数据集

语法
----

**gmt get**
[ *PARAMETER1* *PARAMETER2* *PARAMETER3* ... ]
[ |-D|\ *selection* ]
[ |-G|\ *defaultsfile* ]
[ |-I|\ *inc[m|s]* ]
[ |-L| ]
[ |-N| ]
[ |-Q| ]
[ |SYN_OPT-V| ]

必选选项
--------

*PARAMETER*
    要查看的GMT配置参数名。GMT中配置参数列表见 :doc:`/conf/index`

可选选项
--------

.. _-D:

**-D**\ *selection*
    从GMT服务器下载一个或多个数据目录

    参数 *selection* 可以是 **cache**\（在GMT示例或测试中使用的文件的整个缓存目录），
    也可以是 **data**\（服务器上的整个数据目录），或者 **all**\ （缓存和数据）。
    也可以通过添加 **=**\ *planet* 或 **=**\ *datasetlist* 进一步限定数据。

.. _-G:

**-G**\ *defaultsfile*
    读取指定的GMT配置文件

    默认情况下，该模块会依次在如下目录中寻找配置文件 **gmt.conf** 直到找到位置：

    - 当前目录
    - ``home`` 目录
    - ``~/.gmt`` 目录
    - ``~/.gmt/server`` 目录
    - ``~/.gmt/cache`` 目录
    - 系统默认配置

.. _-I:

**-I**\ *inc*\ [**m**\|\ **s**]
    与 |-D| 结合使用。下载网格间距大于或等于 *inc* 的网格数据。默认无限制。

.. _-L:

**-L**
    输出时一行只输出一个返回值

    一次指定多个参数名时，默认会将所有返回值输出在一行，各值之间以空格分隔。
    该选项会一行只输出一个返回值。

.. _-N:

**-N**
    与 |-D| 结合使用，使得下载的 **JP2000** 压缩格式文件在本地不会自动转化为 **netCDF** 网格文件。
    这种操作可以加快下载数据的速度，等到需要使用数据时再进行格式转换。

.. _-Q:

**-Q**
    与 |-D| （和 |-I| ）结合使用，提供一个可下载数据集的列表。
    输出格式为::

       planet group dataset size nitems remark

.. include:: explain_-V.rst_

示例
----

列出一个参数的当前值::

    $ gmt get MAP_FRAME_TYPE
    fancy

列出多个参数的当前值::

    $ gmt get MAP_GRID_CROSS_SIZE_PRIMARY MAP_GRID_CROSS_SIZE_SECONDARY
    24p,Helvetica,black 16p,Helvetica,black

使用 |-L| 选项一行显示一个参数值::

    $ gmt get FONT_TITLE FONT_LABEL MAP_FRAME_TYPE -L
    24p,Helvetica,black
    16p,Helvetica,black
    fancy

下载所有的地球网格数据，并保持数据文件为 **JP2000** 格式::

    gmt get -Ddata=earth -N

只下载大于或等于 **1X1** 分的地球掩膜数据和白昼影像数据::

    gmt get -Ddata=earth_mask,earth_day -I1m

下载整个缓存目录::

    gmt get -Dcache

相关模块
--------

:doc:`gmtdefaults`,
:doc:`gmtset`
