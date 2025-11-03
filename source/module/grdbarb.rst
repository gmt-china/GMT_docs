:author: 何星辰, 田冬冬
:date: 2025-10-15

.. index:: ! grdbarb
.. include:: common_SYN_OPTs.rst_

grdbarb
=============

:官方文档: :doc:`gmt:supplements/windbarbs/grdbarb`
:简介: 从两个分量网格中绘制风羽场

**grdbarb** 读取两个二维网格文件，分别表示风场的 *x* 分量和 *y* 分量，
并通过绘制风羽（wind barbs）的方式生成风场图，
风羽的方向与羽毛形状根据文件中的信息确定。
另外，也可以提供极坐标 (*r*, *theta*) 网格数据来代替笛卡尔坐标输入。

语法
--------

**grdbarb**
*compx.nc* *compy.nc*
**-J**\ *parameters*
[ |-A| ]
[ |SYN_OPT-B| ]
[ |-C|\ *cpt* ]
[ |-G|\ *fill* ]
[ |-I|\ [**x**]\ *dx*\ [/*dy*] ]
[ |-N| ]
[ |-Q|\ *length*\ [**+a**\ *angle*][**+g**\ -\|\ *fill*][**+jb**\|\ **c**\|\ **e**][**+p**\ -\|\ *pen*][**+s**\ *scale*][**+w**\ *width*] ]
[ |SYN_OPT-R| ]
[ |-T| ]
[ |SYN_OPT-U| ]
[ |-W|\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |-Z| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]

**注意** ：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

*compx.nc*
    包含风场的 x 分量。（参见 :doc:`/grid/format` ）
*compy.nc*
    包含风场的 y 分量。（参见 :doc:`/grid/format` ）

.. include:: explain_-J.rst_

可选选项
------------------

.. _-A:

**-A**
    网格文件包含极坐标形式的风场分量 (速度, 方向)，
    而不是笛卡尔分量 (u, v) [默认使用 (u, v)]。

.. include:: explain_-B.rst_

.. _-C:

**-C**\ [*cpt*]
    使用 *cpt* 文件根据风速分配颜色。
    或者，提供 GMT 的动态主色带 CPT 名称 [默认 rainbow]，
    将根据网格的 z 范围自动生成连续色带。
    如果该动态 CPT 有默认范围，则会使用该范围。
    还可以使用 -Ccolor1,color2[,color3,...] 自动从这些颜色生成线性连续色带。
    其中 *color*\ **n** 可以是 r/g/b 三元组、颜色名称或 HTML 十六进制颜色（例如 ``#aabbcc`` ）。

.. _-G:

**-G**\ *fill*
    设置风羽内部的填充颜色或灰度 [默认无填充]。

.. _-I:

**-I**\ [**x**]\ *dx*\ [/*dy*]
    仅在每隔 *x_inc*、*y_inc* 节点处绘制风羽（必须是原网格间距的整数倍）。
    追加 **m** 表示以弧分为单位，**s** 表示以弧秒为单位。
    或者使用 **-Ix** 指定倍率 *multx*\ [/*multy*] [默认绘制所有节点]。

.. _-N:

**-N**
    不在地图边界处裁剪风羽 [默认会裁剪]。

.. _-Q:

**-Q**\ *length*\ [**+a**\ *angle*][**+g**\ -\|\ *fill*][**+jb**\|\ **c**\|\ **e**][**+p**\ -\|\ *pen*][**+s**\ *scale*][**+w**\ *width*]
    修改风羽参数。
    指定风羽长度 *length* [默认 0.5c]。
    可以附加以下修饰符以控制风羽的布局、形状和对齐方式：

    - **+a** - 设置风羽角度 [默认 120°]。
    - **+g** - 关闭填充（若为 -），或设置风羽填充色 [默认使用当前填充]。
    - **+p** - 设置风羽轮廓线笔属性。若 *pen* 以 `-` 开头，则不绘制轮廓线 [默认绘制]。
    - **+j** - 设置输入点 (*x*, *y*) 与风羽的对应关系： **b** （起点，默认）、 **e** （终点）、 **c** （中心）。
    - **+s** - 设置长羽对应的风速 [默认 5]。
    - **+w** - 设置风羽的宽度。

.. |Add_-Rgeo| replace:: |Add_-R_auto_table|
.. include:: explain_-Rgeo.rst_

.. _-T:

**-T**
    调整笛卡尔数据集的方位角，使其与 x、y 方向比例尺符号一致 [默认不调整]。
    当某一方向比例尺为负值（例如 y 轴向下为正）时，可以使用此选项修正向量方位。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *pen*
    设置用于绘制风羽轮廓的画笔属性 [默认：黑色实线，默认宽度]。

.. include:: explain_-XY.rst_

.. _-Z:

**-Z**
    表示提供的 theta 网格包含的是方位角而非方向（隐含启用 **-A**）。

.. include:: explain_-f.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

示例
--------

.. include:: explain_example.rst_

若要根据文件 `r.nc` 和 `theta.nc` 绘制风场图，使用 0.1 英寸长的风羽并将其居中于节点位置，命令如下::

    gmt grdbarb r.nc theta.nc -Jx5c -A -Q0.1i+jc -png gradient

若要绘制地理坐标数据集（文件 `comp_x.nc` 与 `comp_y.nc`），
并仅在每三个节点处绘制风羽，可运行::

    gmt grdbarb comp_x.nc comp_y.nc -Ix3 -JH0/20c -Q0.1i+jc -png globe

相关模块
--------

:doc:`grdvector`, 
:doc:`barb`
