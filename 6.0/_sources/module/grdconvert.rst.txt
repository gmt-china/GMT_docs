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
[ |SYN_OPT-f| ]
[ |SYN_OPT--| ]

必选选项
--------

*ingrdfile*\ [=id[**+s**\ *scale*][**+o**\ *offset*][**+n**\ *invalid*]]
    要读入的网格文件。

    若读入的网格文件不是标准的netCDF格式文件，则需要加上 **=**\ *id* 以指定
    网格文件格式（见 :doc:`/grid/format`\ ）。此外，

    - **+s**\ *scale* 对数据做比例缩放，即将数据乘以 *scale*
    - **+o**\ *offset* 对数据做偏移，即将数据加上 *offset*
    - **+n**\ *invalid* 数据中哪个值表示无效值

    需要注意的是，在读入网格文件时，总是先缩放再偏移。

    若 *id*\ =\ *gd*\ ，则使用GDAL库检测数据格式并读入数据。实际上，当GMT遇到
    其无法识别的文件格式时，总是自动使用GDAL库读入数据，但可能会遇到问题，
    此时可以设置 *id*\ =\ *gd*\ 强制使用GDAL库读取。

.. _-G:

**-G**\ *outgrdfile*\ [=id[**+s**\ *scale*][**+o**\ *offset*][**+n**\ *invalid*]][*:driver*\ [/*datatype*]]]
    要写入的网格文件。

    若要写的网格文件格式不是标准的netCDF格式，则需要加上 **=**\ *id* 以指定
    网格文件格式（见 :doc:`/grid/format`\ ）。此外：

    - **+s**\ *scale* 对数据做比例缩放，即将数据乘以 *scale*
    - **+o**\ *offset* 对数据做偏移，即将数据加上 *offset*
    - **+n**\ *invalid* 数据中哪个值表示无效值

    需要注意的是，在写网格文件时，总是先偏移再缩放。
    若想要将数据以整型保存以减小文件大小，子选项 **+s** 和 **+o** 经常会遇到。
    此外，还可以使用 **+sa+oa** 让GMT自动选择合适的比例因子和偏移量以生成
    整型网格文件。

    当 *id*\ = *gd*\ 时，网格文件将使用GDAL库写入。此时可以进一步指定 *driver* 和 *datatype*\ 。
    *driver* 由GDAL提供（如 netCDF, GTiff 等），\ *datatype* 则可以取
    *u8*\|\ *u16*\|\ *i16*\|\ *u32*\|\ *i32*\|\ *float32*\ ，
    其中 *i* 和 *u* 分别表示有符号和无符号整型。\ *datatype* 默认值为 *float32*\ 。

    写网格文件时，可以考虑设置 :term:`IO_NC4_DEFLATION_LEVEL`
    以减小生成的文件大小，并进一步优化读写性能。

可选选项
--------

.. _-N:

**-N**
    在生成native二进制文件时，不将GMT网格文件头段写到文件中。

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

注意事项
--------

GMT默认只能读取并处理2D单变量网格。对于多变量、多维度网格文件，需要使用额外的语法
指定要读取的变量或维度，详情见 :doc:`/grid/read`\ 。

示例
----

将网格文件转换成四字节native浮点型网格::

    gmt grdconvert data.nc ras_data.b4=bf -V

将网格文件转换成二字节短整型文件，将其乘以10并减去32000，并设置无数据节点的值为-9999::

    gmt grdconvert values.nc shorts.i2=bs/10/-32000/-9999 -V

从一个三维网格文件中提取第二层数据::

    gmt grdconvert climate.nc?temp[1] temp.nc -V

相关模块
--------

:doc:`grdmath`
