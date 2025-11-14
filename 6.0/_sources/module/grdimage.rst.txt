.. index:: ! grdimage
.. include:: common_SYN_OPTs.rst_

grdimage
==========

:官方文档: :doc:`gmt:grdimage`
:简介: 绘制网格数据

语法
----

**gmt grdimage** *grd_z* \| *img* \| *grd_r grd_g grd_b*
[ |-A|\ *out_img*\ [**=**\ *driver*] ]
[ |SYN_OPT-B| ]
[ |-C|\ *cpt* ]
[ |-D|\ [**r**] ]
[ |-E|\ [**i**\|\ *dpi*] ] |-J|\ *parameters*
[ |-G|\ *color*\ [**+b**\|\ **+f**] ]
[ |-I|\ [*intensfile*\|\ *intensity*\|\ *modifiers*] ]
[ |-M| ] [ |-N| ]
[ |-Q| ]
[ |SYN_OPT-Rz| ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

必选选项
--------

*grd_z* \| *img* \| *grd_r grd_g grd_b*
    输入数据文件，可以是一个只包含Z数据的网格文件，或GDAL支持的图片文件，
    或三个分别包含red、green、blue值的网格文件。

.. include:: explain_-J.rst_

可选选项
--------

.. _-A:

**-A**\ *out_img*\ [**=**\ *driver*]

``-A<out_img>[=<driver>]``
    将图片以光栅格式保存

    默认图片会以PostScript代码的形式输出，使用此选项可以以其他图片格式保存。
    文件名中使用后缀 ``.ppm`` 则会以Portable Pixel Map格式保存。

    若GMT支持GDAL，则可以以更多的光栅格式保存。

    #. ``<out_img>`` 为要保存的文件名
    #. ``<driver>`` 图片格式，见GDAL的文档

.. include:: explain_-B.rst_

.. _-C:

**-C**\ [*cpt* \|\ *master*\ [**+i**\ *zinc*] \|\ *color1,color2*\ [,\ *color3*\ ,...]]
    绘制网格文件所使用的CPT。

    也可以直接使用GMT自带的CPT文件名，此时GMT会自动根据网格文件的Z值范围将
    自带的CPT采样成16级的连续CPT文件。也可以通过 ``-C<color1>,<color2>[,<color3>,..]``
    的语法构建一个线性连续CPT文件。

.. _-D:

**-D**\ [**r**]
    表明输入的网格文件是需要通过GDAL读取的图片文件，见官方文档。

``-E[i|<dpi>]``
    设置投影后网格的精度，默认值为100。

``-G[f|b]<color>``
    该选项仅当生成的图片是黑白图时才可用。

    This option will instead use the image as a transparent mask and paint
    the mask (or its inverse, with **-Gb**) with the given color combination.

``-I[<intensfile>|<intensity>|<modifiers>]``
    增加光照效果

    可以通过三种方式设置光照效果:

    #. 给定一个Z值范围为(-1,1)的网格文件，该文件可以用 ``grdgradient`` 生成
    #. 给定一个常数作为光照强度
    #. 不指定光照强度文件，只使用 ``-I+`` 则会自动调用 ``grdgradient``
       并使用参数 ``-A-45 -Nt1`` 计算输入网格数据的梯度作为光照强度文件。用户
       可以使用 ``+a<azimuth>+n<args>`` 以自定义 grdgradient 的 -A 和 -N 选项

``-M``
    使用YIQ转换强制将其转换为灰度图。

``-N``
    对于非矩形地图，在地图边界处不对图片做裁剪。

``-Q``
    将值为NaN的节点处设置为透明色

.. include:: explain_-U.rst_

.. include:: explain_-t.rst_

示例
----

使用默认的光照效果::

    gmt grdimage stuff.nc -JX6i+ -I+d -pdf map
