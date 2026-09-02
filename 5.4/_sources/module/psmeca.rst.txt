.. index:: ! psmeca

psmeca
======

:官方文档: :doc:`gmt:supplements/meca/psmeca`
:简介: 在地图上绘制震源机制解

-S选项
------

``-S`` 确定了输入文件的格式，其语法为::

    -S<format><scale>[/<fontsize>[/<offset>][u]]

- ``<format>`` 可以取 ``a`` 、 ``c`` 等，在下面会介绍
- ``<scale>`` 指定了5级地震（地震矩为4.0E23 dynes-cm）的震源球的直径。默认
  情况下，震源球的直径与震级大小成正比，实际直径由如下公式决定::

        size = M / 5 * <scale>

- ``<fontsize>`` 是震源球的标题的字体大小
- ``<offset>`` 震源球标题相对于震源球的偏移量
- ``u`` 震源球标题位于震源球的下方

下面介绍各种震源机制解的格式，使用下面这个地震作为示例::

    Date: 1976/ 1/ 1   Centroid Time:  1:29:53.4 GMT
    Lat= -29.25 Lon=-176.96
    Depth= 47.8   Half duration= 9.4
    Centroid time minus hypocenter time: 13.8
    Moment Tensor: Expo=26  7.680 0.090 -7.770 1.390 4.520 -3.260
    Mw = 7.3    mb = 6.2    Ms = 0.0   Scalar Moment = 9.56e+26
    Fault plane:  strike=202    dip=30   slip=93
    Fault plane:  strike=18    dip=60   slip=88

``-Sa``
    Aki and Richards约定的震源机制格式，输入文件的具体格式为::

        X  Y  depth  strike  dip  rake  mag  newX  newY  title

    - ``X`` 和 ``Y`` 为震源经纬度
    - ``depth`` 是地震深度，单位为km
    - ``strike`` 、 ``dip`` 、 ``rake`` 断层的三个参数，单位为度
    - ``mag`` 为震级
    - ``newX`` 和 ``newY`` 放置震源球的经纬度，这样可以避免震源球覆盖震源位置。
      若值为0，则表示将震源球放在震源位置
    - ``title`` 出现中震源球上方/下方的字符串（可选）

    ::

        gmt psmeca -Rg -JN15c -Sa2c > meca.ps << EOF
        -176.96 -29.25 47.8 202 30 93 7.3 0 0 197601010129
        EOF

``−Sc``
    Harvard CMT（现在的Global CMT）定义的格式::

        X Y depth strike1 dip1 rake1 strike2 dip2 rake2 mantissa exponent newX newY title

    - ``X`` 和 ``Y`` 为震源经纬度
    - ``depth`` 是地震深度，单位为km
    - 两组 ``strike`` 、 ``dip`` 、 ``rake`` 分别是两个断层面的参数
    - ``mantissa`` 和 ``exponent`` 是地震标量矩的尾数和指数部分。例如，地震
      标量矩为9.56e+26 dyne-cm，则 ``mantissa=9.56`` 、 ``exponent=26``

    ::

        gmt psmeca -Rg -JN15c -Sc2c > meca.ps << EOF
        -176.96 -29.25 47.8 202 30 93 18 60 88 9.56 26 0 0 197601010129
        EOF

``-Sm|d|z``
    GCMT的零迹矩张量解，输入数据格式为::

        X Y depth mrr mtt mff mrt mrf mtf exp newX newY title

    - ``X`` 和 ``Y`` 为震源经纬度
    - ``depth`` 是地震深度，单位为km
    - ``mrr`` 等是地震矩的6个分量，单位是 :math:`10^{exp}` dyne-cm
    - ``exp`` 地震矩的指数部分（比如， ``mrr=2.0`` 、 ``exp=26`` ，则真实的 ``mrr=2.0e26`` ）

    地震矩张量可以分解成各向同性部分（ISO）、双力偶部分（DC）和补偿线性向量
    偶极部分（CLVD）。

    - ``m`` 表示绘制地震矩的零迹部分（DC+CLVD）
    - ``d`` 表示仅绘制地震矩的双力偶部分（DC）
    - ``z`` 表示仅绘制地震矩的零迹各向异性部分（DC+CLVD）

    说明：

    - ``m`` 和 ``z`` 是一个东西？还是我的理解有误？ TODO
    - GMCT所使用的rtf坐标，实际上就是USE坐标系

    ::

        gmt psmeca -Rg -JN15c -Sm2c > meca.ps << EOF
        -176.96 -29.25 47.8 7.680 0.090 -7.770 1.390 4.520 -3.260 26 0 0 title
        EOF

``-Sp``
    由两个断层平面的部分数据构成的机制解，输入数据格式为::

        X Y depth strike1 dip1 strike2 fault mag newX newY title

    - ``X`` 和 ``Y`` 为震源经纬度
    - ``depth`` 是地震深度，单位为km
    - ``strike1`` 和 ``dip1`` 平面1的断层参数
    - ``strike2`` 平面2的断层参数
    - ``fault`` 取-1或+1，表示正断层和逆断层
    - ``mag`` 震级

``-Sx|y|t``
    指定主坐标轴的方位，即T、N、P轴，输入数据格式为::

        X Y depth Tvalue Tazim Tplunge Nvalue Nazim Nplunge Pvalue Pazim Pplunge exp newX newY title

    - ``X`` 和 ``Y`` 为震源经纬度
    - ``depth`` 是地震深度，单位为km
    - ``Tvalue`` 等9个量定义了T、N、P轴的大小和方向
    - ``exp`` 是 ``Tvalue`` 等的指数部分

    对这种表示不太熟悉，应该是跟地震矩等效的：

    - ``x`` 绘制标准的GCMT解
    - ``y`` 只绘制地震矩的double couple部分（DC）
    - ``z`` 绘制0迹地震矩

选项
----

``<table>``
    输入文件，文件中震源机制信息，具体格式由 ``-S`` 选项决定。

``-C[<pen>][P<pointsize>]``
    绘制 (X,Y) 和 (newX,newY) 的连线

    将震源球放在输入文件的 ``newX`` 和 ``newY`` 所指定的位置，在震源位置处绘制
    一个小圆，并绘制一条直线连接小圆和震源球。

    ``<pen>`` 指定直线的属性， ``<pointsize>`` 指定圆的大小。

``-D<depmin>/<depmax>``
    只绘制震源深度在 ``<depmin>`` 和 ``<depmax>`` 之间的地震。

``-E<fill>``
    扩张部分的填充色，默认为白色

``-F<mode>[<args>]``
    设置多个属性，可重复使用多次。

    - ``-Fa[<size>][/<P_axis_symbol>[<T_axis_symbol>]]`` 在震源球上P轴和T轴处
      绘制符号。 ``<size>`` 是符号大小；符号可以取 ``c|d|h|i|p|s|t|x``
      （具体含义见 :doc:`psxy` 的 ``-S`` 选项），默认值为 ``6p/cc`` ，即在P轴
      和T轴处分别绘制一个大小为6p的圆
    - ``-Fe<fill>`` 设置T轴符号的填充色
    - ``-Fg<fill>`` 设置P轴符号的填充色
    - ``-Fp<pen>`` 设置P轴符号的画笔属性
    - ``-Ft<pen>`` 设置T轴符号的画笔属性
    - ``-Fo`` 使用旧版本的 ``psvelomeca`` 命令的输入数据格式，即不需要第三列的深度信息
    - ``-Fr<fill>`` 在标签后加一个方框
    - ``-Fz<pen>`` 覆盖零迹矩张量的画笔属性

``-G<fill>``
    指定压缩部分的填充色，默认值为黑色

``-L<pen>``
    设置震源球外部轮廓的线条属性。

``-M``
    所有震级使用相同的大小，具体大小由 ``-S`` 选项的 ``<scale>`` 参数决定。

``-N``
    地图区域外的震源球也要绘制，默认不绘制。

``-T<num_of_planes][/<pen>]``
    绘制断层平面。 ``<num_of_planes>`` 可以取：

    - ``0`` 绘制两个断层面
    - ``1`` 绘制第一个断层面
    - ``2`` 绘制第二个断层面

``-W<pen>``
    同时设置所有线条以及符号轮廓的画笔属性以及标题颜色。

    该选项设置的属性可以被 ``-C`` 、 ``-L`` 、 ``-T`` 、 ``-Fz`` 指定的属性替代。

``-Z<cpt>``
    指定CPT文件，根据数据文件中第三列的值（即地震深度）确定震源球的压缩部分的颜色。

示例
----

访问 :doc:`/gallery/beachball/index` 以查看示例。
