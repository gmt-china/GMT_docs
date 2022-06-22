.. index:: ! gmtgravmag3d
.. include:: common_SYN_OPTs.rst_

gmtgravmag3d
=============

:贡献者: |周茂|
:最近更新日期: 2022-06-21

----

:官方文档: :doc:`gmt:supplements/potential/gmtgravmag3d`
:简介: 计算使用 Okabe 方法计算三维物体的重力异常或磁异常

**gmtgravmag3d** 用来计算由一组三角形描述的多面体的重力异常或磁异常。输出可以在
指定的位置上，也可以在网格上。该方法计算速度并不快，但优势在于可以计算任意复杂
形状导致的异常。

语法
----

**gmt gravmag3d** *xyz_file* |-T|\ **v**\ *vert_file* OR |-T|\ **r\|s**\ *raw_file* OR |-M|\ **+s**\ *body,params*
[ |-C|\ *density* ]
[ |-E|\ *thickness* ]
[ |-F|\ *xy_file* ]
[ |-G|\ *outgrid* ]
[ |-H|\ *f_dec*/*f_dip*/*m_int*/*m_dec*/*m_dip* ]
[ |-L|\ *z_observation* ]
[ |-S|\ *radius* ]
[ |-Z|\ *level* ]
[ |SYN_OPT-V| ]
[ **-fg**]
[ |SYN_OPT--| ]

必选选项
--------

*xyz_file*
    输入表数据。格式见 |-T| 选项

.. _-M:

**-M+s**\ *body,params*
    创建几何体并计算形成的重力异常和磁异常。该选项为 **-Tr**\ /**-Ts** 选项的替代。
    创建的几何体为可以是下面几种情况，接下来首先介绍下面几何体中参数的含义：

    - *x0* 和 *y0* 为几何体中心的水平坐标 [默认为(0,0)，Z 轴朝上]

    - *npts* 是圆的点数

    - *n_slices* 为当物体由切片构成时，切片的个数 [默认为 5 ]。

    - *height* 为高度，相对于 *z0*

    - *rad* 半径

    - *semi_x/semi_y/semi_z* 为半长轴

    - *side_x/side_y/side_z* 为边长

    例如，球和椭球由 2 x *n_slices* 个切面组成，钟形体为 *n_slices* 。几何体也可以是组合形成的。
    例如，**-M+s**\ *prism,1/1/1/-5/-10/1*\ **+s**\ *sphere,1/-5* 表示一个棱柱和一个球体组合
    成的几何体。但是目前对组合体中的每个个体设置不同的密度或者磁参数还不行。单几何体的形状可以
    有以下几种：

    - *bell,height/sx/sy/z0[/x0/y0/n_sig/npts/n_slices]* 钟形体/高斯形状，表特征的 STD 分别为
      *sx* 和 *sy* ，基底的宽度（在 z0 处的宽度）由 *s_sig* 控制，默认为 2；其他参数如上

    - *cylinder,rad/height/z0[/x0/y0/npts/n_slices]* 圆柱体，参数如上

    - *cone,semi_x/semi_y/height/z0[/x0/y0/npts]* 锥体，参数如上

    - *ellipsoid,semi_x/semi_y/semi_z/z_center[/x0/y0/npts/n_slices]* 椭球，中心深度为 *z_center* ，
      其他参数如上

    - *prism,side_x/side_y/side_z/z0[/x0/y0]* 棱柱，参数如上

    - *pyramid,side_x/side_y/height/z0[/x0/y0]* 金字塔形状，参数如上

    - *sphere,rad/z_center[/x0/y0/npts/n_slices]* 球，中心深度为 *z_center* ，其他参数如上。

.. _-T:

**-Tv**\ *vert_file* 或者 **-Tr|s**\ *raw_file*

    两种选项都用来提供闭合的曲面

    **-Tv**\ *vert_file*
    
    给定闭合曲面的的顶点文件 *vert_file* 。文件格式和 :doc:`triangulate` 模块生成的格式相同。
    如果 *xyz_file* 文件可以为 3，4，5，6 或者 8 列，3 列的情况下，表明磁强度/密度假定为常数，
    。4-6 列分别表示，磁强度，倾角，以及偏角；8 列时表示，磁场倾角、偏角以及物体的磁强度、
    倾角和偏角。在大于 3 列的情况下，|-H| 选项被忽略。

    **-Tr|s**\ *raw_file*

    *raw_file* 文件为 N 行 9 列，其中每个三角形占据一行，每个顶点 3 个坐标，即为 9 列。
    **-Ts** 选项表明曲面文件是 ASCII STL (Stereo Lithographic) 格式。
    
可选选项
--------

.. _-C:

**-C**\ *density*
    以国际单位制设置多面体的密度。该选项与 |-H| 互斥

.. _-F:

**-F**\ *xy_file*
    计算磁异常的位置，与 |-G| 选项互斥

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]

    输出网格文件名，其中各子选项的含义见 :doc:`/grid/read`。

.. _-E:

**-E**\ [*thickness*]
    设置层厚度为 *thickness* ，单位为 m，默认为 0。只有多面体为非彼和情况下，想要
    计算一定厚度的层形成的异常时才可用该选项

.. _-L:

**-L**\ [*z_observation*]
    设置观测水平面，默认为 0，同时也是计算异常的高度面

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

.. _-S:

**-S**\ *radius*
    以 km 为单位设置搜索半径。当输出点距离三角形中心的距离大于该半径时，则不考虑该
    三角形。使用该选项可以加快计算速度，但是计算结果回变得不准确

.. _-Z:

**-Z**\ [*level*]
    设置参考平面的高度为 *level* ，默认为 0。当三角形构成的多面体不闭合并使用该不闭合
    的曲面和参考面形成多面体时，才可使用该选项。例如，计算布格异常的 hater 深度

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

网格距离单位
------------

如果网格在水平方向上的单位不是 m，追加 **+u**\ *unit* 可以将输入文件
中的单位转换为 m。如果网格是地理坐标，使用 **-fg** 可以将距离转换为 m。

示例
----

计算位于 5 m 深，以 -10/1 为中心的单位立方体的磁异常，计算位置位于 -R-15/15/-15/15
指定的位置，物体磁偏角为 10 度，倾角为 60，强度为 10 Am，位于 -10 度的偏角，40 度
倾角的磁场中 ::

    gmt gmtgravmag3d -R-15/15/-15/15 -I1 -H10/60/10/-10/40 -M+sprism,1/1/1/-5/-10/1 -Gcube_mag_anom.grd

参考文献
--------

Okabe, M., Analytical expressions for gravity anomalies due to
polyhedral bodies and translation into magnetic anomalies, *Geophysics*,
44, (1979), p 730-741.

相关模块
--------

:doc:`grdgravmag3d`,
:doc:`talwani2d`,
:doc:`talwani3d`
