.. index:: ! grdconvert

grdconvert
==========

:官方文档: :doc:`gmt:grdconvert`
:简介: 在不同的网格格式之间互相转换

必选选项
--------

``<ingrdfile>[=<id>[+s<scale>][+o<offset>][+n<invalid>]]``
    要读入的网格文件。

``<outgrdfile>[=<id>[+s<scale>][+o<offset>][+n<invalid>]][:<driver>[/<datatype>]]``
    要写入的网格文件。

``-N``
    如果你想要将一个网格文件转换为 native 二进制文件供 :doc:`grdraster` 模块直接使用，则需要使用 ``-N`` 选项，以保证不将 GMT 头段结构写到文件中。

示例
----

从一个三维网格文件中提取第二层数据::

    gmt grdconvert climate.nc?temp[1] temp.nc -V

将网格文件转换成四字节native浮点型网格::

    gmt grdconvert data.nc ras_data.b4=bf -V

将网格文件转换成二字节短整型文件，将其乘以10并减去32000，并设置无数据节点的值为-9999::

    gmt grdconvert values.nc shorts.i2=bs/10/-32000/-9999 -V

将网格文件转换为 :doc:`grdraster` 可直接使用的二进制文件::

    gmt grdconvert etopo2.nc etopo2.i2=bs -N -V

To creat a dumb file saved as a 32 bits float GeoTiff using GDAL::

    gmt grdmath -Rd -I10 X Y MUL = lixo.tiff=gd:GTiff
