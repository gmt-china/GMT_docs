.. index:: ! psimage

psimage
=======

:官方文档: :doc:`gmt:psimage`
:简介: 将图片或EPS文件放在地图上

该命令可以读取一个 EPS 文件或光栅图片格式，并将其画在地图上。

该命令可以用于：

#. 将多张图合并到一张图上
#. 将自己单位的 logo 放在 GMT 生成的图上
#. 将一般图片放在图上

必选选项
--------

``<imagefile>``
    EPS文件或其他光栅图片格式（GIF、PNG等）的文件

    - EPS文件必须包含合适的BoundingBox
    - 光栅文件的颜色深度可以是1、8、24、32位
    - 光栅文件是通过GDAL读入的，若安装GMT时未配置GDAL，则该命令只支持EPS文件

    .. note::

       ``psimage`` 并不支持 PS 文件，建议使用如下命令将 PS 文件转化为 EPS 文件::

            gmt psconvert -A -P -Te xxx.ps

可选选项
--------

``-D[g|j|J|n|x]<refpoint>+r<dpi>+w[-]<width>[/<height>][+j<justify>][+n<nx>[/<ny>]][+o<dx>[/<dy>]]``
    指定图片的尺寸和位置

    #. ``[g|j|J|n|x]<refpoint>`` 指定底图上的参考点，见 :doc:`/basis/embellishment` 一节
    #. ``+r<dpi>`` 指定图片的DPI以间接指定图片的尺寸
    #. ``+w[-]<width>[/<height>]`` 直接指定图片的尺寸。若未给定 ``<height>`` 则按照 ``<width>`` 以及原图的横纵比进行缩放；若 ``<width>`` 为负值，则使用其绝对值作为宽度，并使用PS的图片操作符将图片插值到设备的分辨率
    #. ``+j<justify>`` 指定图片的锚点，默认锚点是 ``BL`` ，见 :doc:`/basis/embellishment` 一节
    #. ``+o<dx>[/<dy>]`` 指定参考点的额外偏移量，见 :doc:`/basis/embellishment`
    #. ``+n<nx>/<ny>`` 使图片在水平方向重复 ``<nx>`` 次，垂直方向重复 ``<ny>`` 次，若省略 ``<ny>`` 则默认其与 ``<nx>`` 相等，默认值为 ``1/1``

``-F[+c<clearance(s)>][+g<fill>][+i[[<gap>/]<pen>]][+p[<pen>]][+r[<radius>]][+s[<dx>/<dy>/][<fill>]]``
    为图片加上背景边框，见 :doc:`/basis/embellishment` 一节

    - ``+p<pen>`` 面板边框的画笔属性
    - ``+g<fill>`` 面板填充色
    - ``+c<clearance>`` 设置 logo 与面板边框之间空白区域的大小
    - ``+i<gap>/<pen>`` 为背景面板加上额外的内边框
    - ``+r<radisu>`` 面板使用圆角矩形边框
    - ``+s<dx>/<dy>/<fill>`` 为面板增加阴影区

``-M``
    使用YIQ变换将彩图转换成灰度图

``-G[b|f|t]<color>``
    对光栅图片设置颜色属性

    1-bit图片默认为黑色和白色，可以通过如下选项进行修改：

    - ``-Gb<color>`` 设置背景色，即将白色替换成其他颜色
    - ``-Gf<color>`` 设置前景色，即将黑色替换成其他颜色
    - ``<color>`` 可以取 ``-`` ，表示透明色

    对于8、24、32位图片而言：

    - ``-Gt<color>`` 将某个特定颜色设置为透明

``-I``
    绘图前对1-bit图片进行反转，即黑色变白色，白色变黑色

示例
----

::

    gmt psimage logo.jpg -Dx0/0+w1i -F+pthin,blue > image.ps

::

    gmt psimage tiger.eps -Dx2i/1i+jTR+w3i > image.ps

::

    gmt psimage 1_bit.ras -Gbbrown -Gfred -Dx0/0+w1c+n5 > image.ps
