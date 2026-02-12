.. index:: ! grd2xyz
.. include:: common_SYN_OPTs.rst_

grd2xyz
=======

:官方文档: :doc:`gmt:grd2xyz`
:简介: 将网格文件转换成表数据

**grd2xyz** 读取一个或多个二进制2D网格文件，并将XYZ数据以ASCII或二进制格式
写到标准输出中。ASCII输出的格式由参数 :term:`FORMAT_FLOAT_OUT`
控制，也可以以单精度或双精度浮点数的形式储存为二进制格式，还可以只输出Z值而不包含
XY坐标数据。

语法
----

**gmt grd2xyz** *grid*
[ |-C|\ [**f**\|\ **i**] ]
[ |SYN_OPT-R| ]
[ |SYN_OPT-V| ]
[ |-W|\ [**a**\|\ *weight*] ]
[ |-Z|\ [*flags*] ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-f| ]
[ **-ho**\ [*n*] ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-qo| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT--| ]

必选选项
--------

*grid*
    要转换的2D网格文件

可选选项
--------

.. _-C:

**-C**\ [**f**\|\ **i**]
    输出的XY坐标值用对应的列、行号替代

    默认输出的三列数据是：X坐标、Y坐标和Z值。使用该选项，则输出的三列数据为：
    列号、行号和Z值。其中，行号和列号从0开始算起。使用 **-Cf** 则行号和列号从1开始算起。
    若使用 **-Ci** 会输出两列数据：索引值和Z值。索引值相当于是将二维数组用一维数组表示。

.. include:: explain_-R.rst_
..

    使用 **-R** 选项指定只对网格数据的一个子区域进行操作。若该子区域超过网格边界，
    则只输出二者共同的区域

.. include:: explain_-V.rst_

.. _-W:

**-W**\ [**a**\|\ *weight*]
    输出四列数据XYZW，其中W为 *weight* [*weight*\ 默认值为1]

    若使用 **-Wa** 则权重为每个节点所占据的面积。

.. _-Z:

**-Z**\ [*flags*]
    以 ASCII 或二进制形式输出Z值

    使用该选项，则输出时只有Z值，没有XY信息。输出Z值的顺序由 *flags*
    决定。若是行优先，*flags* 的第一个字符可以取：

    - **T** 表示第一行是y=ymax
    - **B** 表示第一行是y=ynin

    *flags* 的第二个字符可以取：

    - **L** 表示每一行的第一个元素是x=xmin
    - **R** 表示每一行的第一个元素是x=xmax

    若是列优先，则 **L**\|\ **R** 为第一个字符，**B**\|\ **T** 为第二个字符。

    对于网格线配准的网格文件而言：

    - 若网格在X方向是周期的，输出数据时不需要包含x=xmax所在的列，则加上 **x**
    - 若网格在Y方向是周期的，输出数据时不需要包含y=ymax所在的行，则加上 **y**

    若数据需要做字节交换，则加上 **w**。最后需要指定数据以何种数据类型保存：

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

    默认值为 **-ZTLa**。

.. include:: explain_-bo.rst_
..

    该选项只适用于以二进制格式输出XYZ数据。若需要只输出Z值，可以使用 **-Z** 选项。

.. include:: explain_-d.rst_

.. include:: explain_-f.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-qo.rst_

.. include:: explain_-s.rst_

.. include:: explain_help.rst_

非等间隔XY坐标
--------------

几乎所有GMT模块只能处理XY等间隔的网格文件，**grd2xyz** 是个例外。
**grd2xyz** 可以输出非等间隔网格文件的原始 *x y z* 值。

时间坐标
--------

GMT可以识别netCDF网格文件中的时间坐标。netCDF变量的 **unit** 属性会被解析以
确定网格文件中时间坐标的起算点和单位。这些时间坐标值会被进一步根据
:term:`TIME_UNIT` 和 :term:`TIME_EPOCH`
转换为GMT内部时间值。输出时，默认以相对时间的形式输出，也可以使用 **-f** 选项
指定以绝对时间方式输出。

示例
----

将一个netCDF网格文件转换为XYZ文件::

    gmt grd2xyz @AFR.nc > AFR.xyz

将一个netCDF文件以单精度二进制格式输出其Z值::

    gmt grd2xyz @AFR.nc -ZTLf > AFR.b

相关模块
--------

:doc:`grdedit`,
:doc:`grdconvert`,
:doc:`xyz2grd`
