:author: 田冬冬, 周茂, 陈箫翰
:date: 2025-08-11

.. index:: ! logo
.. program:: logo

logo
=======

:官方文档: :doc:`gmt:gmtlogo`
:说明: 在图上绘制GMT的图形logo

该模块将GMT的图形logo绘制在图上。默认情况下，GMT的图形logo默认宽2英寸，高1英寸，
将放在当前的绘图原点处。

.. gmtplot::
   :width: 25%
   :show-code: false

   gmt logo -png logo

语法
----

**gmt logo** 
[ :option:`-D`\ [**g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ **+w**\ *width*\ [**+j**\ *justify*]\ [**+o**\ *dx*\ [/*dy*]] ]
[ :option:`-F`\ [**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]] ]
[ :option:`-J`\ *parameters* ] [ :option:`-J`\ **z**\|\ **Z**\ *parameters* ]
[ :option:`-R`\ *west*/*east*/*south*/*north*\ [/*zmin*/*zmax*][**+r**][**+u**\ *unit*] ]
[ :option:`-S`\ [**l**\|\ **n**\|\ **u**] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-t`\ *transp* ]
[ :doc:`--PAR=value </conf/overview>` ]

必须选项
--------

无

可选选项
--------

.. option:: -D

**-D**\ [**g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ **+w**\ *width*\ [**+j**\ *justify*]\ [**+o**\ *dx*\ [/*dy*]]
    设置logo在图中的位置

    简单介绍各子选项的含义，详情见 :doc:`/basis/embellishment`

    - **g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ 指定地图上的参考点

      .. include:: explain_refpoint.rst_

    - **+j**\ *justify* 指定logo上的锚点（默认锚点为logo的左下角(BL)）
    - **+o**\ *dx*/*dy* 在参考点的基础上设置logo的额外偏移量
    - **+w**\ *width* 设置logo的宽度

.. option:: -F

**-F**\ [**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]]
    控制GMT logo的背景面板属性

    若只使用 :option:`-F` 而不使用其它子选项，则会在 GMT logo 周围绘制矩形边框。
    下面简单介绍各子选项，详细用法见 :doc:`/basis/embellishment`

    .. include:: explain_-F_box.rst_

.. include:: explain_-R.rst_
.. include:: explain_-Rz.rst_

.. option:: -S

**-S**\ [**l**\|\ **n**\|\ **u**]
    控制GMT logo中地图下方的文字

    - **l** 添加文字“The Generic Mapping Tools” [默认值]
    - **n** 不添加文字
    - **u** 添加GMT网站链接

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. include:: explain_-XY.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

示例
----

单独绘制一个2英寸宽的GMT logo::

    gmt logo -pdf map

将GMT logo作为一个图层放在当前底图的右上角：

.. gmtplot::
   :width: 80%

   gmt begin logo
   gmt basemap -R0/10/0/10 -JX10c/5c -Baf -BWSen
   gmt logo -DjTL+w3c+o0.25c -F
   gmt end show

注意
----

若想要绘制链接到GMT官网的二维码，可以使用 :doc:`plot` 提供的自定义符号
**QR** 和 **QR_transparent**。

相关模块
--------

:doc:`legend`,
:doc:`image`,
:doc:`colorbar`,
:doc:`plot`
