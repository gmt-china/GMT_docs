:author: 田冬冬, 朱邓达, 陈箫翰
:date: 2025-12-31

.. index:: ! grd2xyz
.. program:: grd2xyz

grd2xyz
=======

:官方文档: :doc:`gmt:grd2xyz`
:简介: 将网格文件转换成表数据

**grd2xyz** 读取一个或多个二进制2D网格文件，并将XYZ数据以ASCII或二进制格式
写到标准输出中。ASCII输出的格式由参数 :term:`FORMAT_FLOAT_OUT`
控制，也可以以单精度或双精度浮点数的形式储存为二进制格式，还可以只输出Z值而不包含
XY坐标数据（参见下文的 :option:`-Z` ）。或者可以使用 :option:`-T` 将网格保存为用于 3D 打印机的 STL 格式。
此外，通过 :option:`-C` 提供 CPT，将根据 *z* 值在输出中添加 *r*、*g*、*b*、*a* 列。

语法
----

**gmt grd2xyz**
*ingrid*
[ :option:`-C`\ [*section*/]\ *master*\|\ *cpt*\|\ *color*\ :math:`_1`,\ *color*\ :math:`_2`\ [,\ *color*\ :math:`_3`\ ,...]\ [**+h**\ [*hinge*]][**+i**\ *dz*][**+u**\|\ **U**\ *unit*][**+s**\ *fname*] ]
[ :option:`-F`\ [**f**\|\ **i**] ]
[ :option:`-L`\ [**c**\|\ **r**\|\ **x**\|\ **y**]\ *value* ]
[ :option:`-R`\ *region* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-T`\ [**a**\|\ **b**][*base*] ]
[ :option:`-W`\ [**a**\ [**+u**\ *unit*]\|\ *weight*] ]
[ :option:`-Z`\ [*flags*] ]
[ :option:`-bo`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-o`\ *flags* ]
[ :option:`-qo`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

.. include:: explain_grd_in.rst_

可选选项
--------

.. include:: dump_rgb.rst_

.. option:: -F

**-F**\ [**f**\|\ **i**]
    输出的XY坐标值用对应的列、行号替代

    默认输出的三列数据是：X坐标、Y坐标和Z值。使用该选项，则输出的三列数据为：
    列号、行号和Z值。其中，行号和列号从0开始算起。使用 **-Ff** 则行号和列号从1开始算起。
    若使用 **-Fi** 会输出两列数据：索引值和Z值。索引值相当于是将二维数组用一维数组表示。

.. option:: -L

**-L**\ [**c**\|\ **r**\|\ **x**\|\ **y**]\ *value*
    将记录的输出限制在单行或单列。通过 *行* 或 *列* 编号（分别通过指令 **c** 或 **r**），
    或通过固定的 *x* 或 *y* 值（分别通过指令 **x** 或 **y**）来指定所需的向量。
    如果超出有效范围，则不会产生输出并发出警告。 **注意**：对于指令 **x** 和 **y**，将分别查找最接近的列或行。

.. include:: explain_-R.rst_
..

    使用 :option:`-R` 选项指定只对网格数据的一个子区域进行操作。若该子区域超过网格边界，
    则只输出二者共同的区域

.. option:: -T

**-T**\ [**a**\|\ **b**][*base*]
    将用于 3D 打印的 STL 三角网写入标准输出。默认情况下（ **-Ta**）写入 STL ASCII 文件。
    附加 **b** 则改为写入 STL 二进制（小端序）格式。有关 STL 的更多信息，
    请参见 `维基百科上的 STL 概述 <https://en.wikipedia.org/wiki/STL_(file_format)>`_。
    **注意**：所有坐标都经过调整，使得 *xmin = ymin = zmin = 0*。
    可以附加一个不同于网格最小值的更低的 *base* [默认]。
    **注意**：网格必须不含 NaN 值。如果网格包含 NaN，将自动用网格中的最小值替换它们；
    如果希望选择其他值，请使用 :doc:`grdmath` 预处理网格。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [**a**\ [**+u**\ *unit*]\|\ *weight*]
    输出四列数据 *x, y, z, w*，其中 *w* 是提供的权重 *weight*（如果未提供则为 1）[默认仅输出 *x, y, z*]。
    使用 **-Wa** 则权重为每个节点所占据的面积。
    对于笛卡尔网格，这仅是 *x* 和 *y* 增量的乘积（边界处 [一半] 和角落处 [四分之一] 的网格线配准网格除外）。
    对于地理网格，默认长度单位为 **k**（因此面积单位为 km\ :sup:`2`）。通过附加 **+u**\ *unit* 来更改单位。
    对于此类网格，其面积随纬度变化，并且在边界、角落和极点处的网格线注册布局也存在特殊情况。

.. option:: -Z

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

    该选项只适用于以二进制格式输出XYZ数据。若需要只输出Z值，可以使用 :option:`-Z` 选项。

.. include:: explain_-d.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_
..

    **-h** 根据第一个网格文件头中的信息输出 1 条头记录。如果选择了二进制输出，则忽略该选项 [默认无头记录]。

.. include:: explain_-ocols.rst_

.. include:: explain_-qo.rst_

.. include:: explain_-s.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_precision.rst_

非等间隔XY坐标
--------------

几乎所有GMT模块只能处理XY等间隔的网格文件， **grd2xyz** 是个例外。
**grd2xyz** 可以输出非等间隔网格文件的原始 *x y z* 值。

时间坐标
--------

GMT可以识别netCDF网格文件中的时间坐标。netCDF变量的 **unit** 属性会被解析以
确定网格文件中时间坐标的起算点和单位。这些时间坐标值会被进一步根据
:term:`TIME_UNIT` 和 :term:`TIME_EPOCH`
转换为GMT内部时间值。输出时，默认以相对时间的形式输出，也可以使用 :option:`-f` 选项
指定以绝对时间方式输出。

行顺序
--------

**-Lr** 选项允许输出网格中的特定行。请注意，虽然网格的 y 坐标向上为正，但内部行号是扫描线编号，因此向下为正。
因此，第一行 (0) 与最大的 *y* 值重合。这意味着 **-Lr**\ *0* 和 **-Ly**\ *ymax* （使用正确的最大 y 值）将产生相同的结果。
相比之下， *x* 和列号都是向右为正，其中 **-Lc**\ *0* 和 **-Lx**\ *xmin* （使用正确的最小 x 值）将产生相同的输出。

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
