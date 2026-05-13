.. index:: ! psscale

psscale
=======

:官方文档: :doc:`gmt:psscale`
:简介: 在地图上绘制灰色或彩色色条（colorbar）

必选选项
--------

``-D[g|j|J|n|x]<refpoint>[+w<length>[/<width>]][+e[b|f][<length>]][+h|v][+j<justify>][+m[a|c|l|u]][+n[<txt>]][+o<dx>[/<dy>]]``
    指定色标的尺寸和位置。

    #. ``[g|j|J|n|x]<refpoint>`` 指定底图上的参考点，见 :doc:`/basis/embellishment` 一节
    #. ``+j<justify>`` 指定色标上的锚点，默认锚点是 ``BL`` ，见 :doc:`/basis/embellishment` 一节
    #. ``+o<dx>[/<dy>]`` 指定参考点的额外偏移量，见 :doc:`/basis/embellishment`
    #. ``+w<length>[/<width>]`` 指定色标的长度和宽度。若未指定宽度，则默认为长度
       的4%；若长度为负值则会反转色标
    #. ``+h`` 绘制水平色标
    #. ``+v`` 绘制垂直色标，默认值
    #. ``+e`` 选项为前景色和背景色加一个三角形， ``+ef`` 表示只加前景色三角形，
       ``+eb`` 表示只加背景色三角形， ``<length>`` 是三角的高度，默认为色标宽度的一半
    #. ``+m[a|c|l|u]`` 将标注、标签和单位放在色标的另一边， ``a`` 代表标注，
       ``l`` 代表标签， ``u`` 代表单位。 ``c`` 表示将标签以单列字符垂直打印。
    #. ``+n<text>`` 在色标开始处绘制一个矩形，并用NaN的颜色填充

    几种常用的放置色标的方式：

    - 放在左边: ``-DjML+w2c/0.5c+o-1c/0c+m``
    - 放在右边: ``-DjMR+w2c/0.5c+o-1c/0c``  可能存在问题
    - 放在上方: ``-DjTC+w2c/0.5c+o0c/-1c+m``
    - 放在下方: ``-DjBC+w2c/0.5c+o0c/-1c+m`` 可能存在问题
    - 放在左上角: ``-DjTL+w2c/0.5c+o-1c/0c+m``
    - 放在左下角: ``-DjBL+w2c/0.5c+o-1c/0c+m``
    - 放在右上角: ``-DjTR+w2c/0.5c+o-1c/0c``
    - 放在右下角: ``-DjBR+w2c/0.5c+o-1c/0c``

选项
----

``-B[p|s]<parameters>``
    设置colorbar的标注、刻度和网格线间隔。

    在不使用 ``-B`` 选项，或者不指定标注间隔时，默认会根据CPT文件中每一行的内容
    对colorbar进行标注，具体见 :doc:`/cpt/index`\ 。

    默认情况下，对于水平colorbar而言，X轴的标签会放在colorbar的下边，Y轴标签放在
    colorbar的右边；对于垂直colorbar而言，X轴的标签放在colorbar的右边，Y轴标签
    放在colorbar的上边。除非在 ``-D`` 选项中使用了 ``+m`` 子选项。

``-C``
    要绘制的CPT文件。

``-F``
    为colorbar加上背景边框，见 :doc:`/basis/embellishment` 一节

``-G<zlow>/<zhigh>``
    绘图前先对CPT文件做截断，使得其只绘制 ``<zlow>`` 到 ``<zhigh>`` 之间的部分。
    若其中某个值等于NaN，则不对CPT的那一端做处理。

``-I[<max_intens>|<low_i>/<high_i>]``
    为色标加上光照效果

    #. ``-I<max_intens>`` 光照强度为 ``[-<max_intens>, +<max_intens]`` ，默认值为1
    #. ``-I<low_i>/<high_i>`` 指定非对称的光照强度范围

``-L[i][<gap>]``
    生成等大小的颜色矩形。

    默认情况下，会根据CPT文件中Z值的范围决定颜色矩形的大小。若使用该选项，则
    会忽略 ``-B`` 选项设置的间隔。若指定了 ``<gap>`` 且CPT文件是离散的，则使用
    每个矩形的Z值下边界作为标注且将标注放在矩形的正中间。

    If **i** is prepended we annotate the interval range instead.
    If **-I** is used then each rectangle will have its constant color
    modified by the specified intensity.

``-M``
    使用YIQ变换将色标变成单调灰度色标

``-N[p|<dpi>]``
    控制color scale如何用PostScript语言表示。

    - ``-Np`` 用颜色矩形来表示（比如离散的颜色）
    - ``-N<dpi>`` 用图像来表示， ``<dpi>`` 默认值为 600

``-Q``
    使用对数坐标，刻度表示为10的次幂

    CPT文件中所有的Z值都会被转换成 p = log10(z)，其中整数的p会以10^p的格式标注。

``-S``
    去除不同色块之间的黑色网格线

``-W<scale>``
    将CPT文件中所有的Z值乘以比例因子 ``<scale>``

``-Z<zfile>``
    ``<zfile>`` 文件用于指定每个颜色块的宽度。

    默认情况下，颜色块的宽度由颜色的Z值范围决定，比如Z=0-100对应的色块宽度是
    Z=100-150的色块宽度的两倍。

示例
----

::

    gmt makecpt -T-200/1000/100 -Crainbow > t.cpt
    gmt psscale -Ct.cpt -Dx8c/1c+w12c/0.5c+jTC+h -Bxaf+l"topography" -By+lkm > map.ps
