网格文件后缀
============

GMT中也可以将网格文件的后缀与网格文件格式关联起来，就像Windows下 ``docx`` 后缀的文件与MS Word关联一样，这样GMT就可以直接根据文件后缀确定网格文件的格式了，这样更加直观也更加易用。

这一特性通过一个叫 ``gmt.io`` 的文件来实现。GMT会依次在当前目录、家目录或 ``~/.gmt`` 目录下，寻找 ``gmt.io`` 。

``gmt.io`` 的示例格式如下::

    # suffix format_id scale offset NaNxxxComments # GMT i/o shorthand file
    # It can have any number of comment lines like this one anywhere
    # suffix format_id scale offset  NaN   Comments
    grd        nf        -     -      -    Default format
    b          bf        -     -      -    Native binary floats
    i2         bs        -     -    32767  2-byte integers with NaN value
    ras        rb        -     -      -    Sun raster files
    byte       bb        -     -     255   Native binary 1-byte grids
    bit        bm        -     -      -    Native binary 0 or 1 grids
    mask       bm        -     -      0    Native binary 1 or NaN masks
    faa        bs       0.1    -    32767  Native binary gravity in 0.1 mGal
    ns         ns        a     a      -    16-bit integer netCDF grid with auto-scale and auto-offset

要使用这一特性，需要将参数 :ref:`IO_GRIDFILE_SHORTHAND <IO_GRIDFILE_SHORTHAND>` 设置为 ``true`` 。此时，文件名 ``file.i2`` 等效于 ``file.i2=bs///32767`` ， ``wet.mask`` 等效于 ``wet.mask=bm/1/0/0`` 。
