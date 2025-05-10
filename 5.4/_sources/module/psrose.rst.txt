.. index:: ! psrose

psrose
======

:官方文档: :doc:`gmt:psrose`
:简介: 绘制极坐标下的直方图（sector图、rose图或windrose图）

可选选项
--------

``<table>``
    输入文件，数据格式为 ``length  azimuth``

    若输入文件中只有azimuth一列数据，则此时需要使用 ``-i0`` 选项，此时所有的
    长度都默认为单位长度。

``-A[r]<sector_width>``
    指定扇页宽度，单位为度

    #. 默认扇页宽度为0，即windrose图
    #. 若扇页宽度不为0，则表示绘制sector图
    #. 若扇页宽度不为0且使用了 ``-Ar`` ，则表示绘制rose图

``-B``
    此模块中，X表示径向距离，Y表示方位角。Y轴的标签是图片的标题，比例尺长度由
    径向网格间隔决定。

``-Cm[+w]<mode_file>``
    绘制矢量以显示 ``<mode_file>`` 中指定的主方向。

    使用 ``-Cm`` 则计算并绘制平均方向。使用 ``-Cm+w<mode_file>`` 则将计算得到的
    平均方向及其他统计结果以如下格式保存到文件中::

        mean_az, mean_r, mean_resultant, max_r, scaled_mean_r, length_sum, n, sign@alpha

    其中最后一项可以取0或1，取决于平均结果是否significant at the level of
    confidence set via **-Q**.

``-D``
    对扇页对偏移，使得其位于每个间隔的中间，即第一个扇页的中心在0度处

``-F``
    不绘制scale length bar，默认会在右下角绘制

``-G<fill>``
    绘制扇页的填充色

``-I``
    不绘制图形，只计算 ``-R`` 选项所需要的参数。

    以下统计信息会输出到标准输出::

        n, mean az, mean r, mean resultant length, max bin sum, scaled mean, linear length sum

``-L[<wlabel>,<elabel>,<slabel>,<nlabel>]``
    指定0、90、180、270度处的标签。

    #. 对于full-circle图而言，默认值为 ``WEST,EAST,SOUTH,NORTH``
    #. 对于half-circle图而言，默认值为 ``90W,90E,-,0`` ，其中 ``-`` 表示不显示标签
    #. 只使用 ``-L`` 但无其他参数表示不显示所有标签

``-M<parameters>``
    与 ``-C`` 选项一起使用以修改矢量的属性。具体属性见 :doc:`/basis/vector` 一节

``-Q[<alpha>]``
    设置置信水平，用于决定平均结果是否显著，默认值为 0.05。

    注意：临界值是近似结果且需要至少10个数据点；the critical resultants are
    accurate to at least 3 significant digits. 对于更小的数据集，
    需要查询准确的统计表。

``-R<r0>/<r1>/<az_0>/<az_1>``
    指定绘图的半径和方位角范围。

    - ``r0`` 取 0
    - ``r1`` 取最大长度
    - 方位角范围取 ``-90/90`` 或 ``0/180`` 以绘制half circle plot
    - 方位角范围取 ``0/360`` 以绘制 full circle


``-S[n]<plot_radius>[u]``
    指定圆的半径。

    ``-Sn`` 会将输入的半径归一化到0到1。

``-T``
    指定输入数据为 orientation 数据（即数据范围在0-180度范围内）而不是0-360度
    范围的direction数据。We compensate by counting each record twice:
    First as *azimuth* and second as *azimuth + 180*.
    Ignored if range is given as -90/90 or 0/180.

``-W[v]<pen>``
    设置扇区边框的画笔属性。

    ``-Wv<pen>`` 可用于设置绘制矢量时所需的画笔属性。

``-Zu|<scale>``
    将数据的半径乘以 ``<scale>`` ，比如 ``-Z0.001`` 会将数据的单位从m变成km。

    若不考虑半径，可以通过 ``-Zu`` 将所有的半径设置为单位长度。

``-:``
    输入数据为 ``azimuth, radus`` 而不是 ``radius, azimuth``
