.. index:: ! pscoupe

pscoupe
=======

:官方文档: :doc:`gmt:supplements/meca/pscoupe`
:简介: 绘制震源机制解的剖面图

:doc:`psmeca` 在绘制震源球时，本质上是取了一个水平剖面，并将三维震源球的下半球
投影到该水平剖面上。而 :doc:`pscoupe` 则更灵活一些，可以将三维震源球投影到任意
一个剖面上。

- 对于一个水平剖面，会将下半球投影到平面上（即 :doc:`psmeca` 的做法）
- 对于一个垂直剖面，会将垂直平面后的半球投影到平面上
- 对于任意一个非水平的平面而言：

  - 北方向为平面的最速下降方向
  - 东方向为平面的走向方向
  - 下方向则根据右手定则确定

剖面类型
--------

``-A`` 选项用于确定剖面。

``-Aa<lon1>/<lat1>/<lon2>/<lat2>/<dip>/<p_width>/<dmin>/<dmax>[f]``

    - ``<lon1>/<lat1>`` 剖面起点的经纬度
    - ``<lon2>/<lat2>`` 剖面终点的经纬度
    - 起点和终点确定了剖面的长度
    - ``<dip>`` 剖面所在平面的倾角（0表示水平剖面，90表示垂直剖面）
    - ``<p_width>`` 剖面的宽度（即剖面不是一个平面，而是一个有厚度的长方体）
    - ``<dmin>/<dmax>`` 是沿着最速下降方向（“北”方向）的最小、最大距离
    - ``f`` 表示根据剖面的参数自动计算边框的范围
    - TODO: ``<p_width>/<dmin>/<dmax>`` 的具体含义尚不明确

``-Ab<lon1>/<lat1>/<strike>/<p_length>/<dip>/<p_width>/<dmin>/<dmax>[f]``

    - ``<lon1>/<lat1>`` 剖面起点的经纬度
    - ``<strike>`` 是剖面的走向
    - ``<p_length>`` 是剖面的长度
    - 其他参数与 ``-Aa`` 相同

``-Ac<x1>/<y1>/<x2>/<y2>/<dip>/<p_width>/<dmin>/<dmax>[f]``

    与 ``-Aa`` 选项相同，只是 ``<x>/<y>`` 为笛卡尔坐标而不是地理坐标

``-Ad<x1>/<y1>/<strike>/<p_length>/<dip>/<p_width>/<dmin>/<dmax>[f]``

    与 ``-Ab`` 选项相同，只是 ``<x>/<y>`` 为笛卡尔坐标而不是地理坐标

选项
----

``-E<color>``
    扩张部分的填充色，默认为白色

``-F<mode>[<args>]``
    设置多个属性，可重复使用多次

    - ``-Fs<symbol>[<size[/<fontsize>[/<offset>[<u>]]]]`` 见官方文档
    - ``-Fa[<size>][/<P_axis_symbol>[<T_axis_symbol>]]`` 计算并绘制P和T轴的符号。 ``<size>`` 是符号大小，符号与 :doc:`psxy` 类似，可以取 ``c|d|h|i|p|s|t|x`` ，默认值为 ``6p/cc``
    - ``-Fe<fill>`` 设置T轴符号的填充色
    - ``-Fg<fill>`` 设置P轴符号的填充色
    - ``-Fp<pen>`` P轴轮廓的画笔属性
    - ``-Ft<pen>`` T轴轮廓的画笔属性
    - ``-Fr<fill>`` 在标签后加一个方框

``-G<color>``
    指定压缩部分的填充色，默认值为黑色

``-L[<pen>]``
    设置震源球外部轮廓的线条属性

``-M``
    所有震级使用相同的大小，具体大小由 ``-S`` 选项的 ``<scale>`` 参数决定。

``-N``
    地图区域外的震源球也要绘制，默认不绘制。

``-Q``
    默认会生成一些临时文件，其中包含了剖面和剖面上的震源机制的信息，使用该选项，则不会生成这些临时文件。

``-T<num_of_planes][/<pen>]``
    绘制断层平面。 ``<num_of_planes>`` 可以取：

    - ``0`` 绘制两个断层面
    - ``1`` 绘制第一个断层面
    - ``2`` 绘制第二个断层面

``-S``
    选择震源机制解的格式。与 :doc:`psmeca` 中 ``-S`` 选项用法相同

    唯一的不同在于，输入文件中 ``newX`` 和 ``newY`` 对该命令无效，这里加上 ``newX`` 和 ``newY`` 只是为了是的该命令可以使用与 :doc:`psmeca` 相同的输入文件。

``-W<pen>``
    设置断层边界的画笔属性

``-Z<cpt>``
    指定CPT文件，根据数据文件中第三列的值（即地震深度）确定震源球的压缩部分的颜色。

示例
----

下面的示例展示了 ``-Aa`` 选项的用法，指定P1和P2为剖面的起点和终点，并展示了不同倾角时的震源球的效果。

.. literalinclude:: /scripts/pscoupe_ex1.sh
   :language: bash

.. figure:: /images/pscoupe_ex1.*
   :alt: pscoupe example 1
   :width: 100%
   :align: center

   pscoupe示例图1

下面的示例将震源球投影到不同方位角的剖面上的效果：

.. literalinclude:: /scripts/pscoupe_ex2.sh
   :language: bash

.. figure:: /images/pscoupe_ex2.*
   :alt: pscoupe example 2
   :width: 100%
   :align: center

   pscoupe示例图2
