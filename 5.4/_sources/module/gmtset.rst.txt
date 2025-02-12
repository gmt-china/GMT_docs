.. index:: ! gmtset

gmtset
======

:官方文档: :doc:`gmt:gmtset`
:简介: 修改单个或多个GMT参数的值

该命令会修改当前目录下GMT配置文件 ``gmt.conf`` 中指定参数的值。若配置文件不存在，
则新建一个并设置对应的参数值。

由于该命令会修改当前目录下的配置文件 ``gmt.conf`` ，因而该命令修改的参数将对
接下来的命令一直有效，直到GMT参数再次被修改或覆盖。若想要参数修改仅对某个命令
有效，可以在该命令中使用 ``--<PARAMETER>=<value>`` 语法。

.. note::

   GMT 5.4.0 之后的版本中， 只有与GMT系统默认值不同的参数才会被写到 ``gmt.conf`` 中。

必选选项
--------

``<PARAMETER>=<value>``
    要修改的GMT参数名 ``<PARAMETER>`` 以及想要设置的值 ``<value>``

    参数名和值必须成对存在，二者可以用等号 ``=`` 连接，也可以省略等号。

    修改主标注字体为Helvetica，字号为12p，设置网格交叉线的尺寸为0.2厘米::

        gmt gmtset FONT_ANNOT_PRIMARY 12p,Helvetica MAP_GRID_CROSS_SIZE_PRIMARY 0.2c

    也可以用等号将参数名和参数值连接起来::

        gmt gmtset FONT_ANNOT_PRIMARY=12p,Helvetica MAP_GRID_CROSS_SIZE_PRIMARY=0.2c

可选选项
--------

``-C``
    将当前目录下的GMT4配置文件 ``.gmtdefaults4`` 转换为GMT5所使用的 ``gmt.conf``
    文件，并保留原GMT4配置文件。

``-D[s|u]``
    基于系统配置文件修改参数值。

    #. ``-D`` ：使用GMT编译过程中指定的默认参数文件
    #. ``-Du`` ：使用US单位制下的默认参数文件
    #. ``-Ds`` ：使用SI单位制下的默认参数文件

    使用 ``-D`` 选项而不指定其他参数则会在当前目录下生成一个系统配置文件::

        gmt set -D

``-G<defaultsfile>``
    指定要读取并修改的配置文件名 ``<defaultsfile>``

``-[BJRXxYycp]<value>``
    修改GMT命令历史文件 ``gmt.history`` 中的值。该选项用于在不执行其他绘图命令的
    前提下强行修改命令历史，但用处不大。

    例如::

        $ gmt psbasemap -JX10c/5c -B0/10/0/10 -B1 > test.ps
        $ gmt gmtset -JX5c/5c

    该命令会将GMT命令历史文件 ``gmt.history`` 中 ``-J`` 选项的值从 ``X10c/5c``
    改成 ``X5c/5c`` 。

FAQ
---

#. 错误消息::

       gmtset: Warning: parameter xxxx is deprecated. Use xxx instead.

   出现该错误是因为GMT5重命名了几乎所有参数，而当前命令使用的是GMT4的老参数名。
   解决办法在警告信息中已经说了，使用GMT5的新参数名即可。
