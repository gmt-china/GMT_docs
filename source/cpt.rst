CPT文件
=======

在使用2D网格数据绘制彩图或灰度图时，需要为每个Z值或Z值范围指定要使用的颜色。CPT文件的作用就是为每个Z值或Z值范围定义其对应的颜色。CPT全称是color palette table，也称为调色板或色标文件。

CPT文件可以在 ``grdimage`` 、 ``psxy`` 、 ``psxyz`` 等命令中使用。通常，你可以使用 ``makecpt`` 或 ``grd2cpt`` 对已有的CPT（比如GMT内置的CPT）文件进行重采样，并适应你目前所使用的数据范围。当然，也可以自己手写CPT文件，或使用 ``awk`` 、 ``perl`` 之类的文本处理工具自动生成CPT文件。

CPT文件格式
-----------

CPT文件有两种类型，一种适用于分类型数据，一种适用于常规数据。下面会逐一介绍。

分类CPT文件
~~~~~~~~~~~

分类CPT文件适用于有分类型数据，对于这些数据而言，常规的数值操作是未定义的。比如，将陆地分成不同的类型，沙漠、森林、冰川等等，定义沙漠对应的值是1，森林对应的值是2，冰川定义的值是3。显然值取1.5是没有意义的。

对于这种分类型数据，需要给每个分类指定一个 ``<key>`` 。CPT文件中则规定了每个 ``<key>`` 所对应的颜色或填充图案，以及一个可选的标签（通常是类型名）。

分类CPT文件的格式为::

    <key1>      <fill1>     [;<label1>]
    <key2>      <fill2>     [;<label2>]
    ...
    <keyn>      <filln>     [;<labeln>]

几点说明：

#. ``<key>`` 必须单调递增但不必连续
#. ``<fill>`` 可以是颜色，也可以是图案，见 :doc:`fill` 一节
#. 标签名以分号开头

``<key>`` 可以取几个特殊的值：

- ``B`` ：小于 ``<key1>`` 的值的颜色，即背景色，默认值由 :ref:`COLOR_BACKGROUND <COLOR_BACKGROUND>` 控制
- ``F`` ：大于 ``<keyn>`` 的值的颜色，即前景色，默认值由 :ref:`COLOR_FOREGROUND <COLOR_FOREGROUND>` 控制
- ``N`` ：值为 ``NaN`` 所对应的颜色，默认值由 :ref:`COLOR_NAN <COLOR_NAN>` 控制

下面是一个常规CPT文件的示例::

    0  yellow  ;desert
    1  green   ;forest
    2  red     ;iceland

常规CPT文件
~~~~~~~~~~~

对于连续变化的数据而言，可以为几个特定值指定颜色，其他值的颜色则通过插值计算得到。此时可以使用常规CPT文件。常规CPT文件的格式为::

    <z0>     <color_min_1>  <z1>   <color_max_1>    [<A>]    [;<label>]
    <z1>     <color_min_2>  <z2>   <color_max_2>    [<A>]    [;<label>]
    ...
    <zn-1>   <color_min_n>  <zn>   <color_max_n>    [<A>]    [;<label>]
    B   <fill_back>
    F   <fill_fore>
    N   <fill_NaN>

以CPT文件中的第一行为例，其定义了一个Z值切片，切片范围为 ``<z0>`` 到 ``<z1>`` ，切片内每个Z值的颜色由 ``<color_min_1>`` 线性渐变为 ``<color_max_1>`` 。其他行同理。几点说明：

#. ``<z>`` 值必须单调递增
#. 每行的最大 ``<z>`` 必须与下一行的最小 ``<z>`` 相同，即Z切片之间不能存在间断
#. 若 ``<color_min_1>`` 与 ``<color_max_1>`` 相等，则 ``<z0>`` 到 ``<z1>`` 范围内的所有Z值均使用相同的颜色
#. 若 ``<color_min_1>`` 使用了图案，则 ``<color_max_1>`` 必须设置为 ``-``
#. ``<A>`` 是可选的，用于表明在使用 ``psscale`` 命令绘制色标时要如何标注。 ``<A>`` 可以取 ``L`` 、 ``U`` 、 ``B`` ，表示选择每个Z切片的下限、上限或者上下限作为标注。
#. ``;<lable>`` 是切片的标签，当 ``psscale`` 使用 ``-L`` 选项时会在用 ``<label>`` 作为标注
#. ``B|F|N`` 语句分别用于设置背景色（默认值为 :ref:`COLOR_BACKGROUND <COLOR_BACKGROUND>` ）、前景色（默认值为 :ref:`COLOR_FOREGROUND <COLOR_FOREGROUND>` ）和NaN值的颜色（默认值为 :ref:`COLOR_NAN <COLOR_NAN>` ）
#. ``B|F|N`` 语句要放在CPT文件的开头或结尾

.. TODO L|U|B似乎有BUG

下面是一个常规CPT文件的示例::

    30    p200/16  80   -
    80    -        100  -
    100   200/0/0  200  255/255/0
    200   yellow   300  green

本例中

- 30<z<80：以200dpi分辨率的16号图案填充
- 80<z<100：直接跳过
- 100<z<200：从深红色线性变化成黄色
- 200<z<300：从黄色线性变化成绿色

GMT内置CPT
----------

GMT内置了35个常规CPT文件和一个分类CPT文件，位于 ``${GMTHOME}/share/cpt`` 目录中。

下图给出了GMT内置的36个CPT文件，每张图上边的色标为原始CPT，用如下命令绘制::

    gmt psscale -D5c/2c+w10c/1c+h+jTC -B0 -C<cpt> > test.ps

下边的色标是经过 ``makecpt`` 离散成8部分后的色标，用如下命令绘制::

    gmt makecpt -C<cpt> -T-1/1/0.25 > new.cpt
    gmt psscale -D5c/2c+w10c/1c+h+jTC -Bf0.25 -Cnew.cpt > test.ps

.. figure:: /images/GMT_CPT_1.*
   :width: 700 px
   :align: center

   GMT内置CPT示例1

.. figure:: /images/GMT_CPT_2.*
   :width: 700 px
   :align: center

   GMT内置CPT示例2

GMT模块 ``makecpt`` 和 ``grd2cpt`` 可以以这些内置CPT文件为基础，针对用户自己的数据制作专门的CPT文件。比如某个内置CPT文件定义了从0到1颜色从蓝色变成红色，用 ``makecpt`` 可以制作一个从1000到3000颜色从蓝色变成红色的CPT文件。

使用CPT
-------

命令行指定CPT文件名后，GMT会依次在当前目录、 ``~/.gmt`` 和 ``${GMTHOME}/share/cpt/`` 目录下寻找CPT文件，如果找不到还会加上后缀 ``.cpt`` 寻找。

在文件名后加上后缀 ``+u|U<unit>`` 还可以对CPT文件中的Z值进行缩放。

- ``filename.cpt+u<unit>`` 可以将Z值从 ``<unit>`` 变换为以米为单位
- ``filename.cpt+U<unit>`` 可以将Z值从以米为单位变换成 ``<unit>``

其他CPT
-------

更多的CPT可以访问： http://soliton.vm.bytemark.co.uk/pub/cpt-city/
