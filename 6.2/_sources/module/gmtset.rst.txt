.. index:: ! gmtset
.. include:: common_SYN_OPTs.rst_

gmtset
======

:官方文档: :doc:`gmt:gmtset`
:简介: 修改单个或多个GMT配置参数的值

该模块用于修改GMT配置参数的值以调整接下来的绘图或者命令的运行。

该模块修改的参数将对接下来的命令一直有效，直到GMT参数再次被修改或覆盖。
若想要参数修改仅对某个命令有效，可以在该命令中使用 **--**\ *PARAMETER*\ **=**\ *value* 语法。

语法
----

**gmt set**
[ |-C| \| |-D|\ [**s**\|\ **u**] \| |-G|\ *defaultsfile* ]
[ **-**\ [**BJRXxYycp**]\ *value* ]
PARAMETER1 *value1*
PARAMETER2 *value2*
PARAMETER3 *value3*

必选选项
--------

*PARAMETER* *value*
    要修改的GMT配置参数名 *PARAMETER* 以及想要设置的值 *value*

    参数名和值必须成对存在。GMT配置参数见 :doc:`/conf/index`。

可选选项
--------

.. _-C:

**-C**
    将 GMT4 创建的 GMT4配置文件 :file:`.gmtdefaults4` 转换为GMT5及之后版本所使用的
    :file:`gmt.conf` 文件，并保留原GMT4配置文件。

.. _-D:

**-D**\ [**s**\|\ **u**]
    在系统默认配置的基础上修改参数值

    - **-D**：使用GMT编译过程中指定的默认参数文件（通常是SI单位制配置文件）
    - **-Du**：使用US单位制下的默认参数文件
    - **-Ds**：使用SI单位制下的默认参数文件

.. _-G:

**-G**\ *defaultsfile*
    指定要读取并修改的配置文件名 *defaultsfile*

**-**\ [**BJRXxYycp**]\ *value*
    强行修改GMT命令历史文件 **gmt.history** 中的值。

    GMT在执行一个命令时会在命令历史文件 **gmt.history** 中记录一些选项的参数值，
    使得接下来的命令可以不用再提供这个选项的参数值。
    该选项用于在不执行其他绘图命令的前提下强行修改命令历史，但用处不大。

.. include:: explain_help.rst_

示例
----

修改主标注字体为Helvetica，字号为12p，设置网格交叉线的尺寸为0.2厘米::

    gmt set FONT_ANNOT_PRIMARY 12p,Helvetica MAP_GRID_CROSS_SIZE_PRIMARY 0.2c

FAQ
---

#. 错误消息::

       gmtset: Warning: parameter xxxx is deprecated. Use xxx instead.

   GMT5对所有的配置参数进行了重命令，以使得参数名更容易记忆。出现该报错的原因是，
   当前命令使用的是GMT4的老参数名。解决办法是根据警告信息替换为新的GMT5配置参数名。

相关模块
--------

:doc:`gmt.conf`,
:doc:`gmtdefaults`,
:doc:`gmtget`
