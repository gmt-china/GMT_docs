:author: 田冬冬, 周茂, 朱邓达
:date: 2026-01-04

.. index:: ! image
.. program:: image

image
=====

:官方文档: :doc:`gmt:image`
:简介: 将图片或EPS文件放在图上

**image** 模块可以读取EPS文件或任意一个光栅图片文件，并将其画在图上。该模块的几个主要用途：

- 将多张图合并到一张图上
- 将自己单位的 logo 放在 GMT 生成的图上
- 将一般图片放在图上

图像可以进行任意缩放。对于 1-bit 位图图像，可以执行以下操作：

(1) **反转** ：即黑像素（开启）变白（关闭），反之亦然
(2) **着色** ：指定不同的前景色和背景色
(3) **设置透明** ：即仅绘制前景色或背景色中的一种

此外，用户可以选择使用电视标准的 YIQ 变换将彩色位图图像转换为灰度图。对于位图文件，用户还可以指定将哪种特定颜色设置为透明。
用户还可以选择复制（平铺）图像。当配合适当的裁剪路径使用时，这允许实现更大尺寸的自定义填充模式
（大多数 GMT 模块提供的 **-Gp** 功能仅限于小于 146x146 像素的位图）。

语法
---------

**gmt image**
*imagefile*
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-D`\ *refpoint* ]
[ :option:`-F`\ *box* ]
[ :option:`-G`\ [*color*][**+b**\|\ **f**\|\ **t**] ]
[ :option:`-I` ]
[ :option:`-J`\ *parameters* ]
[ :option:`-Jz|Z`\ *parameters* ]
[ :option:`-M` ]
[ :option:`-R`\ *west*/*east*/*south*/*north*\ [/*zmin*/*zmax*][**+r**][**+u**\ *unit*] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-p`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

*imagefile*
    EPS文件或其他光栅图片格式（GIF、PNG等）的文件

    - EPS文件必须包含合适的BoundingBox
    - 光栅文件的颜色深度可以是1、8、24、32位
    - 光栅文件是通过GDAL读入的，若安装GMT时未配置GDAL，则该命令只支持EPS文件

可选选项
--------

.. include:: explain_-B.rst_

.. option:: -D

**-D**\ [**g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ **+r**\ *dpi*\ **+w**\ [**-**]\ *width*\ [/*height*]\ [**+j**\ *justify*]\ [**+n**\ *nx*\ [/*ny*] ]\ [**+o**\ *dx*\ [/*dy*]]
    指定图片的尺寸和位置

    简单介绍各子选项的含义，详情见 :doc:`/basis/embellishment`

    - [**g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ 指定地图上的参考点

      .. include:: explain_refpoint.rst_

    - **+j**\ *justify* 指定logo上的锚点（默认锚点为logo的左下角(BL)）
    - **+o**\ *dx*/*dy* 在参考点的基础上设置图片的额外偏移量
    - **+r**\ *dpi* 指定图片的DPI以间接指定图片的尺寸
    - **+w**\ [**-**]\ *width*\ [/*height*] 直接指定图片的尺寸。若未给定 *height*
      则按照 *width* 以及原图的横纵比进行缩放；若 *width* 为负值，则使用其绝对值作为宽度，
      并使用PS的图片操作符将图片插值到设备的分辨率
    - **+n**\ *nx*\ [/*ny*] 使图片在水平方向重复 *nx* 次，垂直方向重复 *ny* 次。
      若省略 *ny* 则默认其与 *nx* 相等 [默认值为 **1/1**]

.. option:: -F

**-F**\ [**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]]
    控制图片的背景面板属性

    若只使用 :option:`-F` 而不使用其它子选项，则会在 GMT logo 周围绘制矩形边框。
    下面简单介绍各子选项，详细用法见 :doc:`/basis/embellishment`

    .. include:: explain_-F_box.rst_

.. option:: -G

**-G**\ [*color*][**+b**\|\ **+f**\|\ **+t**]
    修改特定像素值为其它颜色或透明（该选项可重复使用）

    对于1-bit光栅图片，可以通过 **+b** 或 **+f** 指定背景色或前景色为 *color*。
    若不给 *color* 则表示设置背景色或前景色为透明色。
    对于其它图片而言，还可以使用 :option:`-G`\ *color*\ **+t** 将颜色 *color* 设置为
    透明。

.. option:: -I

**-I**
    绘图前对1-bit图片进行反转，即黑色变白色，白色变黑色

.. include:: explain_-J.rst_
..

    仅与 **-p** 一起使用。

.. include:: explain_-Jz.rst_

.. option:: -M

**-M**
    使用YIQ变换将彩图转换成灰度图

.. include:: explain_-Rz.rst_
..

    仅与 **-p** 选项一起使用。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. include:: explain_-XY.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

注意事项
--------

:option:`-G` 和 :option:`-I` 选项仅适用于光栅图片文件，对于EPS文件无效。

示例
----

绘制GMT示例图片 needle.jpg，其宽度为7厘米::

    gmt image @needle.jpg -Dx0/0+w7c -pdf plot

绘制相同的文件，但是反转其RGB带::

    gmt image @needle.jpg+b2,1,0 -Dx0/0+w7c -pdf plot

相同的文件，只绘制其红色带，但以灰度方式绘制::

    gmt image @needle.jpg+b0 -Dx0/0+w7c -pdf plot

绘制EPS文件::

    gmt image @gallo.eps -Dx2i/1i+jTR+w3i -png image

以一个1-bit光栅图片为模板，设其背景色为darkgray、前景色为yellow，并设置重复6x12次，宽度为2.5厘米::

    gmt image @vader1.png -Gdarkgray+b -Gyellow+f -Dx0/0+w2.5c+n6/12 -pdf image

相关模块
--------

:doc:`logo`,
:doc:`legend`,
:doc:`colorbar`,
:doc:`plot`,
:doc:`psconvert`
