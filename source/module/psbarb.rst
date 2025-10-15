.. index:: ! psbarb
.. include:: common_SYN_OPTs.rst_

psbarb
=============

:贡献者: |何星辰|, |田冬冬|
:最近更新日期: 2025-10-15

----

:官方文档: :doc:`gmt:supplements/windbarbs/psbarb`
:简介: 在 2D 和 3D 中绘制凤羽场

语法
--------
**psbarb**
[ *table* ]
|-J|\ *parameters* |-J|\ **z**\ \|\ **Z**\ *parameters*
|SYN_OPT-Rz|
[ |SYN_OPT-B| ]
[ |-C|\ *cpt* ]
[ |-D|\ *dx*/*dy*\ [/*dz*] ]
[ |-G|\ *fill* ]
[ |-I|\ *intens* ]
[ |-K| ]
[ |-N| ]
[ |-O| ] [ |-P| ]
[ |-Q|\ *parameters* ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*pen*][*attr*] ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-:| ]

.. include:: barb.rst

.. include:: common_classic.rst_

示例
--------

.. include:: explain_example.rst_

要在三维空间 (0-10)、(0-10)、(0-100) 的投影中，在文件 *heights.xyz* 指定的位置绘制蓝色柱状体（宽度 = 1.25 cm），
每隔 2、2 和 10 设置刻度，并从东南方向以 30° 俯角观察，可使用以下命令::

     gmt psbarb heights.xyz -R0/10/0/10/0/100 -Jx1.25c -Jz0.125c -So1.25c -Gblue \
          -Bx2+lXLABEL -By2+lYLABEL -Bz10+lZLABEL -B+t"3-D PLOT" -p135/30 -Uc -W -P > heights.ps

分段头参数
--------

分段头记录可包含以下一个或多个选项：

**-G**\ *fill*
    使用新的 *fill* 并开启填充。
**-G-**
    关闭填充。
**-G**
    恢复默认填充（如果命令行未设置则为无填充）。
**-W**\ *pen*
    使用新的 *pen* 并开启轮廓线。
**-W**
    恢复默认画笔 :term:`MAP_DEFAULT_PEN`（如果命令行未设置）。
**-W-**
    关闭轮廓线。
**-Z**\ *zval*
    使用 *zval* 进行 CPT 查找以获得填充颜色。
**-Z**\ *NaN*
    从 CPT 中获取 NaN 颜色。

相关模块
--------

:doc:`gmtcolors`,
:doc:`grdvector`, 
:doc:`barb`,
:doc:`psxyz`
