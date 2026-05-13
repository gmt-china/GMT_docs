IO参数
======

表数据相关参数
--------------

.. glossary::

    **IO_HEADER**
        指定输入/输出的表文件中是否有文件头记录 [false]

        可以取 ``true|false``\ 。若值为 ``true``\ ，则等效于使用 :doc:`/option/h`

    **IO_HEADER_MARKER**
        输入ASCII表文件中文件头记录的标识符 [``#``]

        若希望输入和输出数据中使用不同的文件头标识符，则可以使用逗号分隔输入和
        输出数据的文件头标识符，比如 ``#,:``\ 。

    **IO_N_HEADER_RECS**
        在使用 ``-h`` 选项时，要跳过的文件头记录的数目 [0]

        见 :doc:`/option/h` 和 :doc:`/table/ascii`\ 。

    **IO_FIRST_HEADER**
        若整个数据中只有一个数据段时，是否要写这个数据段的文件头记录。
        默认情况下，只有当这个单独段的头段记录中有额外的内容时才会写该头记录。
        可选的值包括 ``always``\ 、\ ``never`` 和 ``maybe`` [``maybe``]

    **IO_COL_SEPARATOR**
        GMT输出ASCII表数据时列与列之间的分隔符 [tab]

        可以取 ``tab``\ 、\ ``space``\ 、\ ``comma`` 和 ``none``

    **IO_SEGMENT_MARKER**
        多段数据中每段数据开始的标识符 [``>``]

        见 :doc:`/table/ascii` 中的相关介绍。
        若希望输入和输出数据中使用不同的数据段标识符，则可以使用逗号分隔输入和
        输出数据的段标识符，比如 ``>,:``\ 。

        有两个特殊的标识符：

        #. ``B`` 表示将空行作为数据段开始的标识符
        #. ``N`` 表示将一个NaN记录作为数据段开始的标识符

        若想要将字符 ``B`` 或 ``N`` 作为段数据标识符，而不是使用上面提到的特殊含义，
        则必须使用 ``\B`` 或 ``\N``\ 。

    **IO_SEGMENT_BINARY**
        二进制数据中，某个记录的所有值都是NaN时该如何解释 [2]

        默认情况下，当二进制数据中某个记录的值为NaN的列数超过了 ``IO_SEGMENT_BINARY``
        的值时，则将该记录解释为二进制数据中的数据段头记录。将该参数赋值为0或off可以
        关闭这一特性。

网格文件相关参数
----------------

.. glossary::

    **IO_NC4_CHUNK_SIZE**
        控制写netCDF文件时的分块大小 [auto]

    **IO_NC4_DEFLATION_LEVEL**
        输出netCDF4格式的数据时所使用的压缩等级 [3]

        可以取0到9的整数，0表示不压缩，9表示最大压缩。低压缩率可以提高性能并减少文件尺寸，
        而高压缩率虽然可以进一步减小文件尺寸，但却需要更多的处理时间。

    **IO_GRIDFILE_SHORTHAND**
        是否支持自动识别网格文件后缀的功能 [false]

        GMT中也可以将网格文件的后缀与网格文件格式关联起来
        这样GMT就可以直接根据文件后缀确定网格文件的格式了。

        这一特性通过一个叫 ``gmt.io`` 的文件来实现。GMT会依次在当前目录、家目录或
        ``~/.gmt`` 目录下寻找 ``gmt.io``\ 。

        ``gmt.io`` 的示例格式如下::

            # GMT i/o shorthand file

            # It can have any number of comment lines like this one anywhere
            # suffix format_id scale offset NaN Comments
            grd        nf        -     -      -    Default format
            b          bf        -     -      -    Native binary floats
            i2         bs        -     -    32767  2-byte integers with NaN value
            ras        rb        -     -      -    Sun raster files
            byte       bb        -     -     255   Native binary 1-byte grids
            bit        bm        -     -      -    Native binary 0 or 1 grids
            mask       bm        -     -      0    Native binary 1 or NaN masks
            faa        bs       0.1    -    32767  Native binary gravity in 0.1 mGal
            ns         ns        a     a      -    16-bit integer netCDF grid with auto-scale and auto-offset

        要使用这一特性，需要将参数 :term:`IO_GRIDFILE_SHORTHAND <IO_GRIDFILE_SHORTHAND>`
        设置为 ``true``\ 。此时，文件名 ``file.i2`` 等效于 ``file.i2=bs///32767``\ ，
        ``wet.mask`` 等效于 ``wet.mask=bm+n0``\ 。

    **IO_GRIDFILE_FORMAT**
        GMT默认使用的网格文件格式 [nf]

        见 :doc:`/grid/format` 一节。

其他IO参数
----------

.. glossary::

    **IO_LONLAT_TOGGLE**
        数据的前两列是纬度、经度而不是经度、纬度 [false]

        该参数的作用与 :doc:`/option/colon` 功能相同。其可以取如下值：

        #. ``false`` 默认值，输入/输出数据均为 (x, y)
        #. ``true`` 输入/输出数据均为 (y, x)
        #. ``IN`` 仅输入数据为 (y, x)
        #. ``OUT`` 仅输出数据为 (y, x)

    **IO_NAN_RECORDS**
        控制当读入的记录中的X、Y或Z包含NaN记录时的处理方式 [pass]

        可以取如下值：

        - ``skip``\ ：直接跳过NaN记录，并报告NaN记录的数目
        - ``pass``\ ：将所有记录传递给程序
