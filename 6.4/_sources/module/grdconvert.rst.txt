.. index:: ! grdconvert
.. include:: common_SYN_OPTs.rst_

grdconvert
==========

:官方文档: :doc:`gmt:grdconvert`
:简介: 将网格文件转换为其它网格文件格式

语法
----

**gmt grdconvert** *ingrdfile* |-G|\ *outgrdfile*
[ |-N| ]
[ |SYN_OPT-R| ]
[ |SYN_OPT-V| ]
[ |-Z|\ [**+s**\ *factor*][**+o**\ *offset*] ]
[ |SYN_OPT-f| ]
[ |SYN_OPT--| ]

必选选项
--------

*ingrdfile*\ [=\ *id*\|\ ?\ *varname*][**+b**\ *band*][**+d**\ *divisor*][**+n**\ *invalid*]\
[**+o**\ *offset*][**+s**\ *scale*]
    要读入的网格文件。

    若读入的网格文件不是标准的netCDF格式文件，则需要加上 **=**\ *id* 以指定
    网格文件格式。如果是多变量网格文件，需加上 ?\ *varname* 指定某个变量（见 :doc:`/grid/format`）。此外，

    - **+b**\ *band* 指定抽取出某个波段，编号 *band* 从0开始计数
    - **+d**\ *divisor* 将数据除以 *divisor* 
    - **+s**\ *scale* 将数据乘以 *scale*
    - **+o**\ *offset* 对数据做偏移，即将数据加上 *offset*
    - **+n**\ *invalid* 数据中哪个值表示无效值

    需要注意的是，在读入网格文件时，总是先进行乘除再偏移。

    若 *id*\ =\ *gd*，则使用GDAL库检测数据格式并读入数据。实际上，当GMT遇到
    其无法识别的文件格式时，总是自动使用GDAL库读入数据，但可能会遇到问题，
    此时可以设置 *id*\ =\ *gd*\ 强制使用GDAL库读取。

.. _-G:

**-G**\ *outgrdfile*\ [=\ *id*][**+d**\ *divisor*][**+n**\ *invalid*]\
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]\
[:*driver*\ [*dataType*][**+c**\ *options*]]

    要写入的网格文件。

    若要写的网格文件格式不是标准的netCDF格式，则需要加上 **=**\ *id* 以指定
    网格文件格式（见 :doc:`/grid/format`）。此外：

    - **+d**\ *divisor* 将数据除以 *divisor* 
    - **+s**\ *scale* 将数据乘以 *scale*
    - **+o**\ *offset* 对数据做偏移，即将数据加上 *offset* 
    - **+n**\ *invalid* 数据中哪个值表示无效值

    需要注意的是，在写网格文件时，总是先偏移再乘除。
    若想要将数据以整型保存以减小文件大小，子选项 **+s** 和 **+o** 经常会用到。
    此外，还可以使用 **+sa+oa** 让GMT自动选择合适的比例因子和偏移量以生成
    整型网格文件。

    当 *id*\ = *gd*\ 时，网格文件将使用GDAL库写入。此时可以进一步指定 *driver* 和 *datatype*。
    *driver* 由GDAL提供（如 netCDF, GTiff 等），*datatype* 则可以取
    *u8*\|\ *u16*\|\ *i16*\|\ *u32*\|\ *i32*\|\ *float32*，
    其中 *i* 和 *u* 分别表示有符号和无符号整型。*datatype* 默认值为 *float32*。

    写网格文件时，可以考虑设置 :term:`IO_NC4_DEFLATION_LEVEL`
    以减小生成的文件大小，并进一步优化读写性能。

可选选项
--------

.. _-N:

**-N**
    在生成native二进制文件时，不将GMT网格文件头段写到文件中。

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ [**+s**\ *factor*][**+o**\ *offset*]
    在写网格文件前，从数据中减去 *offset* 并将结果乘以 *factor*。

    注意：该选项功能与 **+s** 和 **+o** 子选项的功能不同。
    使用 **+s** 和 **+o** 子选项，数据也会进行缩放和偏移，修改后的数据会被写入到
    网格文件中，但同时缩放因子和偏移量会写入到网格文件的元信息中。因而，在读取
    这些新生成的网格时，会自动根据元信息中的值恢复数据的原始值。
    而使用该选项则永久修改了网格文件中的数据值。

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

注意事项
--------

GMT默认只能读取并处理2D单变量网格。对于多变量、多维度网格文件，需要使用额外的语法
指定要读取的变量或维度，详情见 :doc:`/grid/read`。

示例
----

从一个含有红绿蓝三个波段数据的tif文件中分别抽出三个波段的数据::

    gmt grdconvert map.tif+b0 -Gred.nc
    gmt grdconvert map.tif+b1 -Ggreen.nc
    gmt grdconvert map.tif+b2 -Gblue.nc

将网格文件转换成四字节native浮点型网格::

    gmt grdconvert data.nc ras_data.b4=bf -V

将网格文件转换成二字节短整型文件，将其乘以10并减去32000，并设置无数据节点的值为-9999::

    gmt grdconvert values.nc shorts.i2=bs/10/-32000/-9999 -V

从一个三维网格文件中提取第二层数据::

    gmt grdconvert climate.nc?temp[1] temp.nc -V

相关模块
--------

:doc:`grdmath`
