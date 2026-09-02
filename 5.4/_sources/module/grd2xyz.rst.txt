.. index:: ! grd2xyz

grd2xyz
=======

:官方文档: :doc:`gmt:grd2xyz`
:简介: 将网格文件转换成表数据

该命令读取一个或多个2D网格文件，并将XYZ数据以ASCII或二进制格式写到标准输出中。
ASCII输出的格式由参数 ``FORMAT_FLOAT_OUT`` 控制。

必选选项
--------

``<grid>``
    要转换的2D网格文件

可选选项
--------

``-C[f|i]``
    输出的XY坐标值用对应的列、行号替代

    默认输出的三列数据是：X坐标、Y坐标和Z值。使用该选项，则输出的三列数据为：
    列号、行号和Z值。其中，行号和列号从0开始算起。

    - 使用 ``-Cf`` 则行号和列号从1开始算起
    - ``-Ci`` 会输出两列数据：索引和Z值。索引相当于是将二维数组用一维数组表示

``-R<west>/<east>/<south>/<north>``
    指定要转换的网格文件的数据范围

``-W[a|<weight>]``
    默认输出XYZ三列数据，使用该选项则输出四列XYZW，其中W即 ``<weight>``

    若使用 ``-Wa`` 则权重为每个节点所占据的面积。

``-Z[flags]``
    以 ASCII 或二进制形式输出表数据

    使用该选项，则输出时只有Z值，没有XY信息。输出Z值的顺序由 ``<flags>``
    决定。若是行优先， ``<flags>`` 的第一个字符可以取：

    - ``T`` 表示第一行是y=ymax
    - ``B`` 表示第一行是y=ynin

    ``<flags>`` 的第二个字符可以取：

    - ``L`` 表示每一行的第一个元素是x=xmin
    - ``R`` 表示每一行的第一个元素是x=xmax

    若是列优先，则 ``L|R`` 为第一个字符， ``B|T`` 为第二个字符。

    对于网格线配准的网格文件而言：

    - 若网格在X方向是周期的，输出数据时不需要包含x=xmax所在的列，则加上 ``x``
    - 若网格在Y方向是周期的，输出数据时不需要包含y=ymax所在的行，则加上 ``y``

    若数据需要做字节交换，则加上 ``w`` 。最后需要指定，数据以何种数据类型保存：

    - ``a`` ASCII表，每行输出一个Z值
    - ``c`` int8_t, signed 1-byte character
    - ``u`` uint8_t, unsigned 1-byte character
    - ``h`` int16_t, short 2-byte integer
    - ``H`` uint16_t, unsigned short 2-byte integer
    - ``i`` int32_t, 4-byte integer
    - ``I`` uint32_t, unsigned 4-byte integer
    - ``l`` int64_t, long (8-byte) integer
    - ``L`` uint64_t, unsigned long (8-byte) integer
    - ``f`` 4-byte floating point single precision
    - ``d`` 8-byte floating point double precision

    默认值为 ``-ZTLa`` 。

示例
----

::

    gmt grd2xyz hawaii_grv.nc > hawaii_grv.xyz

::

    gmt grd2xyz raw_data.nc -ZTLf > hawaii_grv.b
