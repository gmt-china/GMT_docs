.. index:: ! wiggle
.. include:: common_SYN_OPTs.rst_

wiggle
======

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:wiggle`
:简介: 绘制沿轨 z = f(x,y) 异常

从文件或者标准输入中读取 (x,y,z)，在沿轨方向绘制 z 值。
连续的 (x,y) 坐标对定义了沿轨距离轴，z 轴垂直于距离轴，形成右手坐标系。
正异常或者负异常都可以带有阴影。

语法
----

**gmt wiggle** [ *table* ] |-J|\ *parameters* |SYN_OPT-Rz| |-Z|\ *scale*
[ |-A|\ [*azimuth*] ]
[ |SYN_OPT-B| ]
[ |-C|\ *center* ]
[ |-D|\ *refpoint* ]
[ |-F|\ *panel* ]
[ |-G|\ *fill*\ [**+n**][**+p**] ]
[ |-I|\ *fix_az* ]
[ |-T|\ *pen* ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-:| ]

必选选项
--------

.. include:: explain_intables.rst_

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. _-Z:

**-Z**\ *scale*
    以数据坐标单位或距离单位指定异常值的缩放因子（即比例尺）。
    追加 **c**，**i** 或者 **p** 表明距离单位分别为
    cm，inch 或 point。如果不指定单位，使用 :term:`PROJ_LENGTH_UNIT` 默认的单位。

可选参数
--------

.. _-A:

**-A**\ [*azimuth*]
    设置绘制正异常值的方位角，正异常将被“吸引”到该方向。
    即：如果轨迹的正法线的方位角在 *azimuth* ± 90 度的范围内，则沿其正法线方向绘制正异常值。
    如果正法线的方位角在该范围外，则沿负法线的方向绘制正异常值。[默认为 **-A**\0]

.. include:: explain_-B.rst_

.. _-C:

**-C**\ *center*
    绘图前从数据中减去 *center*，默认值为 0

.. _-D:

**-D**\ [**g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ \ **+w**\ *length*\ [**+j**\ *justify*]\ [**+a**\ **l**\|\ **r**]\ [**+o**\ *dx*\ [/*dy*]]\ [**+l**\ [*label*]]
    使用四种坐标系统定义比例尺的参考点，
    详见\ `修饰物-定位 <https://docs.gmt-china.org/6.2/basis/embellishment/#id2>`__

    .. include:: explain_refpoint.rst_

    - **+w**\ *length* 指定比例尺的长度，单位和数据（z 坐标）的单位一致
    - **+j**\ *justify* 指定比例尺的锚点 [默认为 ML]
    - **+al** 将比例尺标签放在比例尺左边 [默认为比例尺右边]
    - **+l**\ [\ *label*\ ] 指定将 z 坐标的单位用于比例尺标签 [默认无单位]。

    比例尺标签的文字属性由 :term:`FONT_ANNOT_PRIMARY` 控制。
    比例尺的刻度属性由 :term:`MAP_TICK_PEN_PRIMARY` 控制。

.. note::

    **-Dj** 或者 **-DJ** 选项将会影响锚点的位置，
    详见\ `修饰物锚点 <https://docs.gmt-china.org/latest/basis/embellishment/#id6>`__ 。

.. _-F:

**-F**\ [**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]]\ [**+s**\ [[*dx*/*dy*/][*shade*]]]
    绘制比例尺的背景面板，
    详见\ `修饰物-背景面板 <https://docs.gmt-china.org/6.2/basis/embellishment/#id8>`__

    .. include:: explain_-F_box.rst_

.. _-G:

**-G**\ *fill*\ [**+n**][**+p**]
    设置异常值下的阴影填充的颜色和样式。 [默认不填充]
    追加 **+p** 子选项为填充正异常区域 [默认]。
    追加 **+n** 子选项为填充负异常区域。
    追加 **+n+p** 为使用相同的方式填充正异常和负异常区域。

    **注**：如果需要设置正异常和负异常使用不同的填充方式，需要重复使用 |-G| 选项。

.. _-I:

**-I**\ *fix_az*
    绘制异常值时使用固定方位角（见 |-A| 选项）。
    使用该选项时，轨迹法线的方位角将被 *fixed_az* 覆盖。

.. _-T:

**-T**\ *pen*
    绘制轨迹 [默认不绘制]。可以附加画笔属性 [默认值为： width = 0.25p，color = black，style = solid]。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *pen*
    设置异常值轮廓画笔属性 [默认没有轮廓]

.. include:: explain_-XY.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-t.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

下面的示例展示了如果使用 **wiggle** 模块绘图。示例中使用的数据为 :download:`temp.dat <temp.dat>`\ ：

.. gmtplot::
    :show-code: true
    :width: 600 px

    gmt begin wiggle_exam
    gmt wiggle temp.dat -R-10/10/-3/3 -JM6i -B -Z100i -DjRM+w100+lnT -Tfaint -Gred+p -W1p -BWSne
    gmt end show

考虑另外一个示例：使用 :file:`track.xym` 文件绘制沿轨磁异常，移去均值（32000 nTesla），
比例尺设置为图上 1 cm 代表实际 500 nTesla。
使用 15 cm 宽的立体等角投影，设置刻度间隔为 5 度，
正异常阴影为红色，轨迹线宽度为 0.25p，颜色为蓝色::

    gmt wiggle track.xym -R-20/10/-80/-60 -JS0/90/15c -Z500 -B5 \
    -C32000 -Gred -T0.25p,blue -DjRM+w1000+lnT -V -pdf track_xym

上述示例中，正异常绘制方向为北方向，使用 |-D| 选项设置比例尺长度为 1000 nT 。
如果要设置绘制正异常的方位角为固定的 45 度，可使用 |-I| 选项::

    gmt wiggle track.xym -R-20/10/-80/-60 -JS0/90/15c -Z1000 -B5 \
    -C32000 -Gred -I45 -T0.25p,blue -DjRM+w1000+lnT -V -pdf track_xym

除测线数据外，wiggle 模块也常用于绘制卫星沿轨观测序列，
如 `GMT 官方示例 <https://docs.generic-mapping-tools.org/latest/gallery/ex09.html#example-09>`__ 。
该示例使用 Geosat 卫星观测的沿轨海面高梯度数据来揭示海底构造和海岭。

Bugs
----

某些情况下，(x,y) 坐标的有效数字位数不足，导致局部方位角变化较大，异常摆动也较大。
使用下面命令可以查看是否存在这种情况::

    gmt mapproject -Af yourdata.xyz

如果存在上述情况，可以使用 :doc:`filter1d` 对数据滤波::

    awk '{ print NR, $0 }' yourdata.xyz \
    | gmt filter1d -Fb5 -N4 --FORMAT_FLOAT_OUT=%.12g > smoothed.xyz

上述命令使用了 5 个点的 boxcar 滤波，然后可以使用处理后的数据绘图。

相关模块
--------

:doc:`filter1d`,
:doc:`basemap`,
:doc:`gmt:gmtsplit`
