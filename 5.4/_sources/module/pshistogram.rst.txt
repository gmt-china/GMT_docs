.. index:: ! pshistogram

pshistogram
===========

:官方文档: :doc:`gmt:pshistogram`
:简介: 统计并绘制直方图

该命令会读取数据中的第一列，对其进行统计，并绘制直方图或累积直方图。

必选选项
--------

``-W<bin_width>[+l|h|b]``
    设置直方图计算时的bin宽度

    ``[+l|h|b]`` 用于控制落在 ``-R`` 范围外的数据点的处理方式。默认情况下，
    这些数据会被忽略

    - ``+b`` 将落在范围外的数据包含在第一个或最后一个bin中
    - ``+l`` 仅将小于第一个bin的数据放在第一个bin中
    - ``+h`` 仅将大于最后一个bin的数据放在最后一个bin中

可选选项
--------

``-A``
    绘制水平直方图，默认绘制垂直直方图

``-C<cpt>``
    指定CPT文件，将每个bar的中间值作为Z值查询CPT中的颜色

``-D[+b][+f<font>][+o<offset>][+r]``
    为每个bar添加标注，标注内容是每个bar的统计数目

    - ``+b`` 将标注放在bar的下边（默认放在上边）
    - ``+f<font>`` 设置标注的字体
    - ``+o<offset>`` 修改bar与标注的距离（默认值为6p）
    - ``+r`` 将标注从水平方向旋转为垂直方向

``-F``
    center bin on each value（默认是左边界）

    假设数据范围是0到100，bin宽度为10。默认情况下，会将0到10作为第一个bin，
    10到20作为第二个bin，以此类推。若使用该选项，则第一个bin以0为中心，即0到5
    是第一个bin，5到15是第二个bin，以此类推。

``-G<fill>``
    设置bar的填充色

``-I[o|O]``
    返回计算结果不绘图。

    - ``-I`` 返回 ``xmin xmax ymin ymax``
    - ``-Io`` 返回bin的X和Y值
    - ``-IO`` 返回bin的X和Y值，即使Y=0

``-L<pen>``
    设置bar的边框的画笔属性

``-N[<mode>][+p<pen>]``
    绘制等效的正态分布曲线

    ``<mode>`` 用于设定正态分布的中间位置及比例：

    - mode=0：mean and standard deviation (default)
    - mode=1：median and L1 scale
    - mode=2：LMS mode and scale

    ``<pen>`` 用于指定曲线的属性。该选项可以使用多次以绘制多条曲线。

``-Q``
    绘制累积直方图

``-S``
    绘制阶梯状直方图。

    默认的直方图中，每个bin都用一个bar表示。使用该选项，则去除bar内部的线条。

``-Z[<type>][+w]``
    选项直方图的种类

    - type=0：counts（默认值）
    - type=1：frequency_percent
    - type=2：log (1.0 + count)
    - type=3：log (1.0 + frequency_percent)
    - type=4：log10 (1.0 + count)
    - type=5：log10 (1.0 + frequency_percent).

    若要使用第二列数据而不是count数作为权重，可以加上 ``+w`` 选项。

    若需要绘制其他种类的直方图，则只能先自己对输入数据做处理再绘图。

示例
----

访问 :doc:`/gallery/histogram/index` 以查看更多示例。
