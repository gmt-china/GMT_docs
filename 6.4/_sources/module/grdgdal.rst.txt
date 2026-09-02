.. index:: ! grdgdal
.. include:: common_SYN_OPTs.rst_

grdgdal
=======

:贡献者: |周茂|
:最近更新日期: 2022-07-02

----

:官方文档: :doc:`gmt:grdgdal`
:简介: 从 gmt 执行 GDAL 光栅相关的程序

**grdgdal** 封装了一部分 :doc:`GDAL </utilities/gdal>` 程序（当前包含 gdalinfo，gdaldem，gdal_grid，gdal_translate，
gdal_rasterize 以及 gdalwarp），因此可以在该模块中实现上述命令的功能。考虑到 gmt 和 GDAL
的语法差异较大，本模块仅提供了较少的 GMT 风格的选项，而是使用 |-F| 选项将 GDAL 风格的语法
传递给 GDAL。因此，要使用该模块的用户可能需要查阅 GDAL 文档来了解其用法。

本模块在输出网格时，提供了一个选项来设置使用 GMT 或 GDAL 来写网格文件。两种方式各有优缺点。
使用 GMT 写网格时会将数据从 GDAL 拷贝到 GMT，因此可能会稍慢，但网格文件可以直接被 Matlab，
Julia，Python 等使用。使用 GDAL 写网格可能会稍为快一些，但网格可能不能直接被上述编程语言
使用。

语法
----

**gmt grdgdal** *infile*
|-A|\ *prog*\ [**+m**\ *method*\ **+c**\ *cpt*]
|-G|\ *outfile*
[ |-F|\ "*gd opts*"]
[ |-M|\ [**+r**\ [**+w**]]]
[ |SYN_OPT-R| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-g| ]
[ **-hi** ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT--| ]

必选选项
--------

*infile*
    ASCII，二进制表数据，OGR 数据或 2—D 网格文件名。具体 |-A| 使用的程序有关

.. _-A:

**-A**\ *prog*\ [**+m**\ *method*\ **+c**\ *cpt*]
    选择要运行的 GDAL 程序，*prog* 可选的值包括：*info*，*dem*，*grid*，*rasterize*，
    *translate*，*warp*。如果为 *dem*，则需追加选项 **+m**\ *method*，*method* 可设置
    为：hillshade，color-relief，slope，TRI，TPI 或 roughness；使用 color-relief 时
    还需使用 **+c**\ *cpt_name* 指定 cpt。

.. include:: explain_grd_out.rst_

可选选项
--------

.. _-F:

**-F**\ "*gdal opts*"
    传递给 |-A| 指定的程序的选项列表，用双引号扩起来

.. _-M:

**-M**\ [**+r**\ [**+w**]]
    |-M| 后不加任何选项时，使用 GDAL 读和写数据。

    - **+r** 使用 GDAL 读数据，使用 GMT 写数据，当读 OGR 格式数据时，该选项为必须

    - **+w** 与 |-M| 相同

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

将 VRT 文件使用最邻近算法网格化，网格分辨率为 0.05，结果保存为 NetCDF 格式 ::

    gmt grdgdal lixo.vrt -Agrid -R0/10/0/10 -Gjunk.nc -I0.05 -F"-a nearest" -M+r

与上述功能相同，但使用 CSV 文件并使用 GDAL 保存网格 ::

    gmt grdgdal lixo.csv -Agrid -R0/10/0/10 -Gjunk.nc -I0.05 -F"-a nearest" -M+w

相关模块
--------

:doc:`grdconvert`
