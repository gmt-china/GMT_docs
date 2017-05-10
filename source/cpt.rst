CPT文件
=======

有些程序需要将用户数据用颜色、绘图或图案来表示。比如，在使用2D网格数据绘制彩图
或灰度图时，需要为每个Z值或Z值范围指定要使用的颜色；再比如，有些程序需要根据Z值
决定线条颜色、符号的填充色等。CPT文件的作用就是为每个Z值或Z值范围定义其对应的
颜色。CPT全称是color palette table，也称为调色板或色标文件。

CPT文件可以在 ``grdimage`` 、 ``psxy`` 、 ``psxyz`` 等命令中使用。通常，你可以
使用 ``makecpt`` 或 ``grd2cpt`` 对已有的CPT（比如GMT内置的CPT）文件进行重采样，
并适应你目前所使用的数据范围。当然，也可以自己手写CPT文件，或使用 ``awk`` 、
``perl`` 之类的文本处理工具自动生成CPT文件。

由于GMT中可以用多种方式来指定颜色，因而GMT自带的或用户自己的CPT文件中通常含有
如下注释语句::

    # COLOR_MODEL = model

其中 ``model`` 可以取 RGB、hsv、cmyk，其指定了CPT文件中的颜色要如何进行解释。

CPT文件格式
-----------

CPT文件有两种类型，一种适用于分类型数据，一种适用于常规数据。下面会逐一介绍。

分类CPT文件
~~~~~~~~~~~

分类CPT文件适用于有分类型数据，对于这些数据而言，常规的数值操作是未定义的。
比如，将陆地分成不同的类型，沙漠、森林、冰川等等，定义沙漠对应的值是1，森林
对应的值是2，冰川定义的值是3。显然值取1.5是没有意义的。

对于这种分类型数据，需要给每个分类指定一个 ``<key>`` 。CPT文件中则规定了每个
``<key>`` 所对应的颜色或填充图案，以及一个可选的标签（通常是类型名）。

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

下面是一个分类CPT文件的示例::

    0  yellow  ;desert
    1  green   ;forest
    2  red     ;iceland

常规CPT文件
~~~~~~~~~~~

对于连续变化的数据而言，可以为几个特定值指定颜色，其他值的颜色则通过插值计算
得到。此时可以使用常规CPT文件。常规CPT文件的格式为::

    <z0>     <color_min_1>  <z1>   <color_max_1>    [<A>]    [;<label>]
    <z1>     <color_min_2>  <z2>   <color_max_2>    [<A>]    [;<label>]
    ...
    <zn-1>   <color_min_n>  <zn>   <color_max_n>    [<A>]    [;<label>]
    B   <fill_back>
    F   <fill_fore>
    N   <fill_NaN>

以CPT文件中的第一行为例，其定义了一个Z值切片，切片范围为 ``<z0>`` 到 ``<z1>`` ，
切片内每个Z值的颜色由 ``<color_min_1>`` 线性渐变为 ``<color_max_1>`` 。
其他行同理。几点说明：

#. ``<z>`` 值必须单调递增
#. 每行的最大 ``<z>`` 必须与下一行的最小 ``<z>`` 相同，即Z切片之间不能存在间断
#. 若 ``<color_min_1>`` 与 ``<color_max_1>`` 相等，则 ``<z0>`` 到 ``<z1>``
   范围内的所有Z值均使用相同的颜色
#. 若 ``<color_min_1>`` 使用了图案，则 ``<color_max_1>`` 必须设置为 ``-``
#. ``<A>`` 是可选的，用于表明在使用 ``psscale`` 命令绘制色标时要如何标注。
   ``<A>`` 可以取 ``L`` 、 ``U`` 、 ``B`` ，表示选择每个Z切片的下限、上限或者
   上下限作为标注。
#. ``;<lable>`` 是切片的标签，当 ``psscale`` 使用 ``-L`` 选项时会在用 ``<label>`` 作为标注
#. ``B|F|N`` 语句分别用于设置背景色（默认值为 :ref:`COLOR_BACKGROUND <COLOR_BACKGROUND>` ）、
   前景色（默认值为 :ref:`COLOR_FOREGROUND <COLOR_FOREGROUND>` ）和
   NaN值的颜色（默认值为 :ref:`COLOR_NAN <COLOR_NAN>` ）
#. ``B|F|N`` 语句要放在CPT文件的开头或结尾

下面是一个常规CPT文件的示例::

    30    p16+200  80   -
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

GMT内置了43个常规CPT文件和一个分类CPT文件，位于 :file:`${GMTHOME}/share/cpt` 目录中。

下图给出了GMT内置的44个CPT文件，每张图上边的色标为原始CPT，用如下命令绘制::

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

动态CPT
-------

GMT 内置的 CPT 文件都是动态的。

所有动态CPT文件都按照两种方式中的一种进行了归一化：

#. 如果为存在分界（hinge）的区域填色（如地形颜色在高程为0的海岸线处发生非连续的
   分界）那么CPT的z值在一侧为-1到0；另一侧为0到1；分界线上为0。CPT文件中对
   分界线的值注释如下::

        # HINGE = <hinge-value>

   按照这种方式归一化的内置CPT包括 ``earth`` ``etopo1`` ``geo``  ``globe``
   ``polar`` ``red2green`` ``relief`` ``sealand`` ``split`` ``terra``
   ``topo`` ``world``

#. 如果不存在颜色的分界，则CPT的z值归一化为0到1之间。实际使用中，CPT的z值会拉伸
   到用户指定的范围，包括两种拉伸模式：

   #. 默认指定一个数值范围，实际应用中（如地形渲染）再拉伸到真实值。见CPT文件中
      的RANGE注释::

	    # RANGE = <zmin/zmax>

   #. 若未给定范围，则扩展到数据的极限值

下图展示了动态的内置CPT如何拉伸适用于用户自定义数据，绘制命令如下:

.. literalinclude:: ../scripts/GMT_CPT_3.sh
   :language: bash

.. figure:: /images/GMT_CPT_3.*
   :width: 700 px
   :align: center

   动态CPT的拉伸

原始的内置CPT（globe，上图）的初始范围为-10000至10000，颜色不连续处的分界值
（hinge）为0，小于0的部分为海蓝色系，大于0的部分为大地色系。但实际上，我们要
绘制的区域高程值是非对称的，从-8000米到3000米（下图）。由于hing值的存在，负高程
依旧由海蓝色拉伸填充，正高程则由大地色压缩填充。

注：若要实现hinge分界效果，``makecpt`` 命令中的 ``-T`` 选项不可设置 ``/<z_int>``。

调整CPT
-------

GMT模块 ``makecpt`` 和 ``grd2cpt`` 可以内置CPT文件为基础，针对用户自己的数据
制作专门的CPT文件；也可以将用户自定义CPT重新调整为一个新的范围、颜色倒转甚至
屏蔽部分颜色的新色标文件。比如某个内置CPT文件定义了从0到1颜色从蓝色变成红色，
用 ``makecpt`` 可以制作一个从1000到3000颜色从蓝色变成红色的CPT文件。不同的是，
``makecpt`` 常用于已知极值范围的表数据，而 ``grd2cpt`` 常用于将cpt适用于一个
或多个格网数据。此外，两者均可通过以下方式翻转颜色：

#. 利用 ``-Iz`` 选项倒转CPT的z值指向（不包括前景色、背景色）。用于数据的正负
   颜色表示和惯例不符的情况（比如用正值表示海平面以下的深度，而不是惯常的负高程）。
#. 利用 ``-Ic`` 选项翻转颜色的顺序，包括前景色和背景色（与 ``psscale`` 的宽度
   设为负值效果一致）。
#. ``-Icz`` 表示以上两种效果的叠加，即颜色顺序不变，只调转了前景色和背景色
#. 利用 ``-G`` 选项提取主CPT的一部分颜色
#. 最后，将初始的内置CPT或修改后的CPT拉伸为自定义数据范围

.. literalinclude:: ../scripts/GMT_CPT_4.sh
   :language: bash

.. figure:: /images/GMT_CPT_4.*
   :width: 700 px
   :align: center

   CPT颜色翻转

注：这些CPT的调整选项顺序也是有优先级的。比如 ``-Iz`` 使用后，所有其他的更改
都是基于z值反向的前提进行的。

使用CPT
-------

命令行指定CPT文件名后，GMT会依次在当前目录、 :file:`~/.gmt` 和 :file:`${GMTHOME}/share/cpt/`
目录下寻找CPT文件，如果找不到还会加上后缀 ``.cpt`` 寻找。

在文件名后加上后缀 ``+u|U<unit>`` 还可以对CPT文件中的Z值进行缩放。

- ``filename.cpt+u<unit>`` 可以将Z值从 ``<unit>`` 变换为以米为单位
- ``filename.cpt+U<unit>`` 可以将Z值从以米为单位变换成 ``<unit>``

其他CPT
-------

更多的CPT可以访问： http://soliton.vm.bytemark.co.uk/pub/cpt-city/
