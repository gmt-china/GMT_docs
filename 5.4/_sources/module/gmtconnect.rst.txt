.. index:: ! gmtconnect

gmtconnect
==========

:官方文档: :doc:`gmt:gmtconnect`
:简介: 将端点接近的线段连接起来

该命令会读入一个或多个多段数据，并检查所有线段的两个端点。若某对端点完全相同
或者二者的距离在可容忍的范围内，则将两段线段连接成一条线段。该进程会一直重复，
直到剩余的端点均不在可容忍的范围内。最终连接得到的线段会被写到终端或特定的
输出文件中。

若不清楚该如何确定可容忍范围值，可以使用 ``-L`` 选项，获得所有端点之间的距离的
列表，通过分析该列表来得到合适的值。

选项
----

``-C[<closed>]``
    将所有闭合多边形写到文件 ``<closed>`` （默认文件名为 ``gmtconnect_closed.txt`` ）i
    中并将其他数据段写到标准输出。

    使用该选项不会对线段做连接。

``-D[<template>]``
    对于多段数据文件，将每段数据分别输出到不同的数据文件中。

    ``<template>`` 是文件名的模板，该模板中必须包含一个整型参数的格式，比如
    ``%d`` 或 ``%08d`` ，也可以在整型参数格式前加上字符参数格式 ``%c`` ，实际
    输出时会被C或O代替，分别表示closed和open。

    默认的模板为 ``gmtconnect_segment_%d.txt`` 。

``-L[<linkfile>]``
    将连接信息写到指定的文件中，默认文件名为 ``gmtconnect_link.txt`` 。

    对于每段数据而言，会写入原始的数据段ID；对于线段的起始点和终点而言，会报告
    离得最近的线段的ID，以及两个线段端点之间的距离。

``-Q[<template>]``
    Used with **-D** to a list file with the names of the individual
    output files. Optionally, append a filename template for the
    individual file names; this template **may** contain a C format
    specifier that can format an character (C or O for closed or open,
    respectively). [Default is gmtconnect_list.txt].

``-T[<cutoff>[<unit>]][/<nn_dist>]``
    Specifies the separation tolerance in the data coordinate units [0];
    append distance unit (see UNITS). If two lines has end-points that
    are closer than this cutoff they will be joined. Optionally, append
    /*nn_dist* which adds the requirement that a link will only be made
    if the second closest connection exceeds the *nn_dist*. The latter
    distance must be given in the same units as *cutoff*.  However, if
    no arguments are given then we close every polygon regardless of
    the gap between first and last point.

示例
----

::

    gmt connect segment_*.txt -Tf0.1 > new_segments.txt

::

    gmt connect my_lines.txt -T150e -DMap_segment_%04d.dat
