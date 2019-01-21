GMT Julia API
=============

简介
----

`Julia <https://julialang.org>`_ 是一门为科学计算设计的编程语言，简单易学。
其与 Matlab、Python 等编程语言都有相似之处。GMT 提供了 Julia 接口，使得 Julia
用户可以直接在 Julia 脚本中调用 GMT 的相关模块。

GMT 的 Julia 接口的官方地址为： https://github.com/GenericMappingTools/GMT.jl

.. note::

   GMT 的 julia 接口还在开发中，因而用法可能出现改动，一切以
   https://github.com/GenericMappingTools/GMT.jl 中的说明为准。

安装
----

关于 Julia 的安装请参考 `Julia 官方网站 <https://julialang.org/downloads/>`_ 的相关说明。

启动 Julia 并按照如下方式即可安装 GMT 的 Julia 接口（即 Julia 下的 GMT 模块）::

    $ julia
                   _
       _       _ _(_)_     |  A fresh approach to technical computing
      (_)     | (_) (_)    |  Documentation: http://docs.julialang.org
       _ _   _| |_  __ _   |  Type "?help" for help.
      | | | | | | |/ _` |  |
      | | |_| | | | (_| |  |  Version 0.5.0 (2016-09-19 18:14 UTC)
     _/ |\__'_|_|_|\__'_|  |  Official http://julialang.org/ release
    |__/                   |  x86_64-pc-linux-gnu

    julia> Pkg.add("GMT")
    INFO: Initializing package repository /home/seisman/.julia/v0.5
    INFO: Cloning METADATA from https://github.com/JuliaLang/METADATA.jl
    INFO: Cloning cache of Compat from https://github.com/JuliaLang/Compat.jl.git
    INFO: Cloning cache of GMT from https://github.com/joa-quim/GMT.jl.git
    INFO: Installing Compat v0.23.0
    INFO: Installing GMT v0.0.3
    INFO: Package database updated

    julia> using GMT
    INFO: Precompiling module Compat.

使用
----

在 Julia 中调用 GMT 的方式，与直接在命令行中调用 GMT 非常类似。通常来说，
一个调用 GMT 的 Julia 脚本具有如下形式：

.. code-block:: julia

   using GMT

   返回值=gmt("<module> <options>", 输入参数)
   gmt("destroy")

说明：

#. ``using GMT`` 的作用是在 Julia 中导入 GMT 模块，使得可以在 Julia 中通过
   ``gmt()`` 函数调用 GMT 的所有模块
#. 安装完 GMT 即可后第一次使用 ``using GMT`` 时，Julia 会对 GMT 即可进行预编译，
   因而会消耗一段时间，但之后再调用时，速度就非常快了
#. 函数 ``gmt()`` 用于调用 GMT 模块，其第一个参数与 GMT 命令行版本的参数几乎一致，
   之后的参数是当前命令所需的输入数据
#. 最后，调用函数 ``gmt("destroy")`` 以清理不需要的内存

最简单的例子
++++++++++++

最简单的情况是，只是简单的绘图，不需要输入数据，也不生成任何数据。

.. code-block:: julia

   using GMT
   gmt("pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P > GMT_lambert_az_hemi.ps")

该 Julia 命令等效于命令行版本的::

   gmt pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P > GMT_lambert_az_hemi.ps

.. note::

   Julia 接口能够正确使用的前提是 Julia 可以找到 GMT 的动态链接库文件。所以，
   若以上命令报错，则可以执行::

        echo 'push!(Libdl.DL_LOAD_PATH, "/opt/GMT-5.4.5/lib64")' >> ~/.juliarc.jl

   将 GMT 的动态库文件所在目录添加到 Julia 的搜索路径中。

向 GMT 传递数据
+++++++++++++++

GMT 的 ``surface`` 命令会读入一个文本数据，对其进行插值以生成一个网格文件并绘图，例如::

    gmt surface input.txt -Goutput.grd -R0/150/0/150 -I1
    grdimage -Goutput.grd -JX8c -Ba -P -Cblue,red > crap_img.ps

下面看看在 Julia 中如何调用 ``surface`` 模块：

.. code-block:: julia

   using GMT
   t = rand(100,3) * 150;
   G = gmt("surface -R0/150/0/150 -I1", t);
   gmt("grdimage -JX8c -Ba -P -Cblue,red > crap_img.ps", G)

本例生成了一个 *100x3* 的随机数矩阵 ``t``\ ，并将其作为 ``gmt()`` 函数的第二个参数，
即将矩阵 ``t`` 作为 ``surface`` 命令的输入数据（即命令行中的 ``input.txt`` ）。
同时，将 ``surface`` 命令的输出数据（即命令行中生成的网格数据 ``-Goutput.grd`` ）
保存到网格变量 ``G`` 中。

紧接着调用了 ``grdimage`` 模块绘制网格变量 ``G`` 。注意，在命令中使用或不使用
``-G`` 选项是完全等效的。即上面例子中的最后一个命令也可以写成：

.. code-block:: julia

   gmt("grdimage -JX8c -Ba -P -Cblue,red -G > crap_img.ps", G)

向 GMT 传递多个数据
+++++++++++++++++++

若需要向 GMT 命令传递多个数据，则输入参数的顺序就变得很重要。

下面的例子在之前例子的基础上先生成了一个 CPT 文件，再利用 ``-C<cpt>`` 选项绘图。

.. code-block:: julia

   using GMT
   t = rand(100,3) * 150;
   G = gmt("surface -R0/150/0/150 -I1", t);
   cpt = gmt("grd2cpt -Cblue,red", G);
   gmt("grdimage -JX8c -Ba -P -C -G > crap_img.ps", G, cpt)

命令行版本中的命令应该是::

    gmt grdimage -JX8c -Ba -P -Cbluered.cpt -Goutput.grd > crap_img.ps

在 Julia 中，CPT 文件和网格文件作为输入数据。参数列表中，必须的输入（即 ``G`` ）
要放在可选输入（即 ``cpt`` ）之前，多个可选输入的参数位置由命令中选项的先后
顺序决定。

其他示例
++++++++

下面的例子展示了如何绘制一条彩色渐变的正弦函数曲线：

.. code-block:: julia

   using GMT
   x = linspace(-pi, pi);             # The *xx* var
   seno = sin(x);                     # *yy*
   xyz  = [x seno seno];              # Duplicate *yy* so that it can be colored
   cpt  = gmt("makecpt -T-1/1/0.1");  # Create a CPT
   gmt("psxy -R-3.2/3.2/-1.1/1.1 -JX12c -Sc0.1c -C -P -Ba > seno.ps", xyz, cpt)

注意，此处输入参数的顺序必须是 ``xyz, cpt`` 而不能是 ``cpt, xyz`` 。

下面的例子展示了如何写字符串：

.. code-block:: julia

   using GMT
   lines = Any["5 6 Some label", "6 7 Another label"];
   gmt("pstext -R0/10/0/10 -JM6i -Bafg -F+f18p -P > text.ps", lines)

在 Julia 脚本结束时，可以使用::

   gmt("destroy")

以清理不必要的内存。

更多示例
--------

GMT 官方将 GMT 自带的示例用 Julia 重写了一遍，Julia 用户可以阅读并运行这些 Julia 代码。

Julia 示例位于： ``~/.julia/v0.5/GMT/test/gallery.jl`` 中，你可以直接阅读 Julia 源码。

如果想要执行该 Julia 脚本，你需要将 ``~/.julia/v0.5/GMT/test/gallery.jl`` 的第7行修改为::

    global g_root_dir = "/opt/GMT-5.4.5/share/"
    global out_path = ""

并安装如下方式运行示例：

.. code-block:: julia

   using GMT
   include("/home/seisman/.julia/v0.5/GMT/test/gallery.jl")
   gallery("ex01")

附录
----

``gmt()`` 函数会返回多种类型的变量，比如上面例子中涉及到的CPT类型和网格类型的变量。
因而需要在 Julia 中专门定义相关类型的变量。

Julia 中网格变量 ``GMTJL_GRID`` 的定义为::

    type GMTJL_GRID 	            # The type holding a local header and data of a GMT grid
       proj4::String              # Projection string in PROJ4 syntax (Optional)
       wkt::String                # Projection string in WKT syntax (Optional)
       range::Array{Float64,1}    # 1x6 vector with [x_min x_max y_min y_max z_min z_max]
       inc::Array{Float64,1}      # 1x2 vector with [x_inc y_inc]
       registration::Int          # Registration type: 0 -> Grid registration; 1 -> Pixel registration
       nodata::Float64            # The value of nodata
       title::String              # Title (Optional)
       comment::String            # Remark (Optional)
       command::String            # Command used to create the grid (Optional)
       datatype::String           # 'float' or 'double'
       x::Array{Float64,1}        # [1 x n_columns] vector with XX coordinates
       y::Array{Float64,1}        # [1 x n_rows]    vector with YY coordinates
       z::Array{Float32,2}        # [n_rows x n_columns] grid array
       x_units::String            # Units of XX axis (Optional)
       y_units::String            # Units of YY axis (Optional)
       z_units::String            # Units of ZZ axis (Optional)
       layout::String             # A three character string describing the grid memory layout
    end

图片变量 ``GMTimage`` 的定义为::

    type GMTimage                 # The type holding a local header and data of a GMT image
       proj4::String              # Projection string in PROJ4 syntax (Optional)
       wkt::String                # Projection string in WKT syntax (Optional)
       range::Array{Float64,1}    # 1x6 vector with [x_min x_max y_min y_max z_min z_max]
       inc::Array{Float64,1}      # 1x2 vector with [x_inc y_inc]
       registration::Int          # Registration type: 0 -> Grid registration; 1 -> Pixel registration
       nodata::Float64            # The value of nodata
       title::String              # Title (Optional)
       comment::String            # Remark (Optional)
       command::String            # Command used to create the image (Optional)
       datatype::String           # 'uint8' or 'int8' (needs checking)
       x::Array{Float64,1}        # [1 x n_columns] vector with XX coordinates
       y::Array{Float64,1}        # [1 x n_rows]    vector with YY coordinates
       image::Array{UInt8,3}      # [n_rows x n_columns x n_bands] image array
       x_units::String            # Units of XX axis (Optional)
       y_units::String            # Units of YY axis (Optional)
       z_units::String            # Units of ZZ axis (Optional) ==> MAKES NO SENSE
       colormap::Array{Clong,1}   #
       alpha::Array{UInt8,2}      # A [n_rows x n_columns] alpha array
       layout::String             # A four character string describing the image memory layout
    end

DATASET变量 ``GMTdataset`` 的定义为::

    type GMTdataset
        header::String
        data::Array{Float64,2}
        text::Array{Any,1}
        comment::Array{Any,1}
        proj4::String
        wkt::String
    end

CPT变量 ``GMTcpt`` 的定义为::

    type GMTcpt
        colormap::Array{Float64,2}
        alpha::Array{Float64,1}
        range::Array{Float64,2}
        minmax::Array{Float64,1}
        bfn::Array{Float64,2}
        depth::Cint
        hinge::Cdouble
        cpt::Array{Float64,2}
        model::String
        comment::Array{Any,1}   # Cell array with any comments
    end

PS变量 ``GMTps`` 的定义为::

    type GMTps
        postscript::String      # Actual PS plot (text string)
        length::Int             # Byte length of postscript
        mode::Int               # 1 = Has header, 2 = Has trailer, 3 = Has both
        comment::Array{Any,1}   # Cell array with any comments
    end
