.. index:: ! grd2rgb

grd2rgb
=======

:官方文档: :doc:`gmt:grd2rgb`
:简介: 将网格文件、原始RGB文件、SUN光栅文件转换成R/G/B三个网格文件

该命令的作用是：

#. 读取8、24或32位Sun光栅文件，并将其中的red、green、blue分量（0-255）分别写到
   三个网格文件中，由于光栅文件的头段信息有限，可以使用 ``-R`` 、 ``-I`` 和
   ``-r`` 选项设置完整的头段信息
#. 读取2D网格文件，并根据指定的CPT文件，将Z值转换为对应的RGB值，然后将red、green、i
   blue分量分别写到单独的网格文件中
#. 读取RGB或RGBA原始光栅文件，并将red、green、blue分量分别写到单独的网格文件中，
   此时需要使用 ``-W`` 选项

必选选项
--------

``<infile>``
    输入文件，可以是Sun光栅文件、2D网格文件或原始光栅文件

``-G<template>``
    要生成的三个网格文件的文件名模板，模板中必须包含 ``%c``

    例如， ``-Gout_%c.nc`` 会生成三个网格文件 out_r.nc、out_g.nc和out_b.nc

可选选项
--------

``-C<cpt>``
    若输入文件是2D网格文件，则需要指定CPT文件，以将Z值转换为RGB颜色

.. include:: explain_-I.rst_

``-L<layer>``
    只输出某一分量， ``<layer>`` 可以取 ``r|g|b`` 。默认会输出三个分量。

``-W<width>/<height>[/<n_bytes>]``
    设置原始光栅文件中的尺寸信息。

    原始光栅文件中不包含图片的尺寸信息，因而需要单独的选项来设置。默认情况下，
    假定光栅文件是RGB原始文件，即每个像素3个字节；对于RGBA文件，每个像素4个字节，
    此时 ``<n_bytes>=4`` 。

    使用 ``-W=/=/4`` 可以自动猜测RGBA光栅文件的尺寸信息。

示例
----

使用CPT文件将2D网格文件转换为R、G、B三个网格文件::

    gmt grd2rgb hawaii_grv.nc -Ctopo.cpt -Ghawaii_grv_%c.nc

从Sun光栅文件中输出R分量::

    gmt grd2rgb radiation.ras -Lr -Gcomp_%c.nc
