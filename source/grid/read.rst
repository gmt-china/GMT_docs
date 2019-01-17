读netCDF文件
------------

netCDF格式的设计相当灵活，可以包含多个多维变量。而GMT中与网格相关的模块，只能
直接处理包含一个二维变量的netCDF文件。因而，GMT在读取包含了多个多维变量的
netCDF文件时，可以做一些特殊的处理。

多个二维变量的处理
~~~~~~~~~~~~~~~~~~

当netCDF网格文件中包含多个二维变量时，GMT默认会读取第一个二维变量作为Z值，并
忽略其余的二维变量。如果用户想要自己指定读取某个特定的二维变量，可以在网格文件
名后加上后缀 ``?<varname>`` 来实现，其中 ``<varname>`` 是netCDF文件中包含的变量名。

比如想要从文件中获取名为 ``slp`` 的二维变量的信息，可以用::

    gmt grdinfo "file.nc?slp"

两点说明：

#. netCDF中包含的变量名 ``<varname>`` 可以用 ``ncdump -c file.nc`` 得到
#. Linux下问号会被解析为通配符，因而在命令行或Bash中使用时需要将问号转义，或者
   将整个文件名放在单引号或双引号内

三维变量的处理
~~~~~~~~~~~~~~

偶尔会遇到三维网格文件，比如地球参考模型，三个维度分别是经度、纬度和深度，模型
中的速度和密度等则是一个三维变量。

在遇到多维变量时，GMT默认会读取第一层（即深度值最小的那一层）数据。可以通过
如下两种方法来读取特定层的数据。

#. 文件名后加上 ``[<index>]``

   ``<index>`` 是第三维度变量（比如深度）的索引值，第一层的索引值为0

#. 文件名后加上 ``(<level>)``

   ``<level>`` 是要获取数据的那一层的深度值。若 ``<level>`` 指定的深度与网格
   不重合，则GMT会找到离其最近的深度，而不会去做插值

假设有一个地球模型文件，\ ``ncdump -c file.nc`` 的结果为（只列出与深度有关的部分）::

    dimensions:
        depth = 32 ;
    variables:
        float depth(depth) ;
        depth:long_name = "depth below earth surface" ;
        depth:units = "km" ;
        depth:positive = "down" ;
    data:
        depth = 50, 100, 200, 300, 400, 400, 500, 600, 600, 700, 800, 900, 1000,
            1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200,
            2300, 2400, 2500, 2600, 2700, 2800, 2850 ;

从中可以看到，该模型在深度方向上有32层，分别对应50千米、100千米，一直到2850千米。
``file.nc?vp[1]`` 会读取第二层（即深度100 km处）的P波速度；而 ``file.nc?vp(200)``
会读取深度200千米处的P波速度。

说明：

#. ``ncdump -c file.nc`` 命令可以查看netCDF网格文件中的信息
#. Linux下中括号和小括号有特殊含义，因而在命令行或Bash中使用时需要进行转义，或者
   将整个文件名放在单引号或双引号内

四维变量的处理
~~~~~~~~~~~~~~

对于四维变量，方法类似。假设有一个四维网格文件，四个维度分别是纬度、经度、深度、
时间，变量为压强。利用 ``ncdump`` 可以查看四个纬度的取值范围::

    lat(lat): 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    lon(lon): 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    depth(depth): 0, 10, 20, 30, 40, 50, 60, 70, 80, 90
    time(time): 0, 12, 24, 36, 48
    pressure(time,depth,lat,lon): 共10x10x10x5=5000个值

为了得到depth=10，time=24处的变量信息，可以用::

    gmt grdinfo "file.nc?pressure[2,1]"

或者::

    gmt grdinfo "file.nc?pressure(24,10)"

需要注意，时间在前，深度在后。

一维变量的处理
~~~~~~~~~~~~~~

包含一维变量的netCDF文件，也就是前面所说的netCDF表。可以通过在文件名后加上变量名
来使用一个一维变量，比如::

    gmt psxy "file.nc?lon/lat" ...
    gmt convert "file.nc?time/lat/lon"

If one or more of the selected variables are two-dimensional, and have
the same leading dimension as the other selected variables they will be
plotted in their entirety. For example, if a netCDF files contains 6
time steps recording temperature at 4 points, and the variable ``temp`` is a 6 by
4 array, then the command ``gmt convert "file.nc?time/temp"`` can result in:

    2012-06-25T00:00:00 20.1 20.2 20.1 20.3
    2012-06-25T12:00:00 24.2 23.2 24.5 23.5
    2012-06-26T00:00:00 16.1 16.2 16.1 16.3
    2012-06-26T12:00:00 22.1 23.0 23.9 23.5
    2012-06-27T00:00:00 17.5 16.9 17.2 16.8

If, for example, only the second temperature column is needed, use
``gmt convert "file.nc?time/temp[1]"`` (indices start counting at 0).

修改坐标单位
~~~~~~~~~~~~

某些GMT工具要求网格中的两个维度的单位必须是米，若输入数据中的维度的单位不是米，
则需要对网格坐标做一些变换。

#. 如果使用的是地理网格数据（即两个维度是经度和纬度），可以加上 ``-fg`` 选项，
   则网格坐标会根据Flat Earth近似，自动转换成以米为单位。
#. 若使用的是笛卡尔坐标下的网格，但维度的单位不是米（比如是千米），则可以在
   网格文件名后加上 ``+u<unit>`` 选项来指定当前网格的维度单位，程序会在内部
   自动转换成以米为单位。比如，要读入一个维度单位为千米的网格文件，可以通过
   ``filename+uk`` 将其转换成以米为单位。在输出网格时，会自动使用输入数据的
   原始单位，除非输出网格文件名中有额外的 ``+u`` 选项。也可以使用 ``+U<unit>``
   实现逆变换，将以米为单位的网格坐标变成以 ``<unit>`` 为单位。

