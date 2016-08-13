GMT的Julia接口
==============

简介
----

`Julia <http://julialang.org>`_ 是一门为科学计算设计的编程语言，简单易学。其与 Matlab、Python 等编程语言都有相似之处。GMT 提供了 Julia 接口，使得 Julia 用户可以直接在 Julia 脚本中调用 GMT 的相关模块。

安装
----

关于 Julia 的安装请参考 `Julia 官方网站 <http://julialang.org/downloads/>`_ 的相关说明。

启动 Julia　并按照如下方式即可安装GMT 的 Julia 接口（即 Julia 下的 GMT 模块）::

    $ julia
                   _
       _       _ _(_)_     |  A fresh approach to technical computing
      (_)     | (_) (_)    |  Documentation: http://docs.julialang.org
       _ _   _| |_  __ _   |  Type "?help" for help.
      | | | | | | |/ _` |  |
      | | |_| | | | (_| |  |  Version 0.4.6 (2016-06-19 17:16 UTC)
     _/ |\__'_|_|_|\__'_|  |
    |__/                   |  x86_64-redhat-linux

    julia> Pkg.init()
    INFO: Initializing package repository /home/seisman/.julia/v0.4
    INFO: Cloning METADATA from git://github.com/JuliaLang/METADATA.jl

    julia> Pkg.clone("git://github.com/joa-quim/GMT.jl.git")
    INFO: Cloning GMT from git://github.com/joa-quim/GMT.jl.git
    INFO: Computing changes...
    INFO: No packages to install, update or remove
    INFO: Package database updated

安装完成后，还需要通过如下命令::

    echo 'push!(Libdl.DL_LOAD_PATH, "/opt/GMT-5.2.1/lib64")' >> ~/.juliarc.jl

将 GMT 的动态库文件所在目录添加到 Julia 的搜索路径中。

使用
----

在 Julia 中调用 GMT 的方式，与直接在命令行中调用 GMT 非常类似。通常来说，一个调用 GMT 的 Julia 脚本具有如下形式：

.. code-block:: julia

   using GMT

   返回值=gmt("<module> <options>", 输入参数)
   gmt("destroy")

说明：

#. ``using GMT`` 的作用是在 Julia 中导入 GMT 模块，使得可以在 Julia 中通过 ``gmt()`` 函数调用 GMT 的所有模块。
#. 安装完 GMT 即可后第一次使用 ``using GMT`` 时，Julia 会对 GMT 即可进行预编译，因而会消耗一段时间，但之后再调用时，速度就非常快了
#. 函数 ``gmt()`` 用于调用 GMT 模块，其第一个参数与GMT命令行版本的参数几乎一致，之后的参数是当前命令所需的输入数据
#. 最后，调用函数 ``gmt("destroy")`` 以清理不需要的内存

最简单的例子
++++++++++++

最简单的情况是，只是简单的绘图，不需要输入数据，也不生成任何数据。

.. code-block:: julia

   using GMT
   gmt("pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P > GMT_lambert_az_hemi.ps")

该 Julia 命令等效于命令行版本的::

   gmt pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P > GMT_lambert_az_hemi.ps

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

本例生成了一个 *100x3* 的随机数数组（矩阵） ``t`` ，并将其作为 ``gmt()`` 函数的第二个参数，即将数组 ``t`` 作为 ``surface`` 命令的输入数据（即命令行中的 ``input.txt`` ）。同时，将 ``surface`` 命令的输出数据（即命令行中生成的网格数据 ``-Goutput.grd`` ）保存到网格变量 ``G`` 中。

紧接着调用了 ``grdimage`` 模块绘制网格变量 ``G`` 。注意，在命令中使用或不使用 ``-G`` 选项是完全等效的。即上面例子中的最后一个命令也可以写成：

.. code-block:: julia

   gmt("grdimage -JX8c -Ba -P -Cblue,red -G > crap_img.ps", G)

向 GMT 传递多个数据
+++++++++++++++++++

若需要向 GMT 命令传递多个数据，则输入参数的顺序就变得很重要。

下面的例子在之前例子的基础上先生成了一个CPT文件，再利用 ``-C<cpt>`` 选项绘图。

.. code-block:: julia

   using GMT
   t = rand(100,3) * 150;
   G = gmt("surface -R0/150/0/150 -I1", t);
   cpt = gmt("grd2cpt -Cblue,red", G);
   gmt("grdimage -JX8c -Ba -P -C -G > crap_img.ps", cpt, G)

命令行版本中的命令应该是::

    gmt grdimage -JX8c -Ba -P -Cbluered.cpt -Goutput.grd > crap_img.ps

在 Julia 中，CPT 文件和网格文件作为输入数据，其在参数列表中的顺序由命令中 ``-C`` 和 ``-G`` 选项的先后顺序决定。

其他示例
++++++++

下面的例子展示了如何绘制一条彩色渐变的正弦函数曲线：

.. code-block:: julia

   using GMT
   x = linspace(-pi, pi);             # The *xx* var
   seno = sin(x);                     # *yy*
   xyz  = [x seno seno];              # Duplicate *yy* so that it can be colored
   cpt  = gmt("makecpt -T-1/1/0.1");  # Create a CPT
   gmt("psxy -R-3.2/3.2/-1.1/1.1 -JX12c -Sc0.1c -C -P -Ba > seno.ps", cpt, xyz)

注意，由于变量 ``cpt`` 对应的是 ``-C`` 选项，而变量 ``xyz`` 是 ``psxy`` 模块的直接输入数据，所以，此处输入参数的顺序必须是 ``cpt, xyz`` 而不能是 ``xyz, cpt`` 。

下面的例子展示了如何写字符串：

.. code-block:: julia

   using GMT
   lines = Any["5 6 Some label", "6 7 Another label"];
   gmt("pstext -R0/10/0/10 -JM6i -Bafg -F+f18p -P > text.ps", lines)

附录
----

``gmt()`` 函数会返回多种类型的变量，比如上面例子中涉及到的CPT类型和网格类型的变量。因而需要在 Julia 中专门定义相关类型的变量。

Julia 中网格变量 ``GMTJL_GRID`` 的定义为::

    type GMTJL_GRID     # The type holding a local header and data of a GMT grid
       ProjectionRefPROJ4::ASCIIString    # Projection string in PROJ4 syntax (Optional)
       ProjectionRefWKT::ASCIIString      # Projection string in WKT syntax (Optional)
       range::Array{Float64,1}            # 1x6 vector with [x_min x_max y_min y_max z_min z_max]
       inc::Array{Float64,1}              # 1x2 vector with [x_inc y_inc]
       n_rows::Int                        # Number of rows in grid
       n_columns::Int                     # Number of columns in grid
       n_bands::Int                       # Not-yet used (always == 1)
       registration::Int                  # Registration type: 0 -> Grid registration; 1 -> Pixel registration
       NoDataValue::Float64               # The value of nodata
       title::ASCIIString                 # Title (Optional)
       remark::ASCIIString                # Remark (Optional)
       command::ASCIIString               # Command used to create the grid (Optional)
       DataType::ASCIIString              # 'float' or 'double'
       x::Array{Float64,1}                # [1 x n_columns] vector with XX coordinates
       y::Array{Float64,1}                # [1 x n_rows]    vector with YY coordinates
       z::Array{Float32,2}                # [n_rows x n_columns] grid array
       x_units::ASCIIString               # Units of XX axis (Optional)
       y_units::ASCIIString               # Units of YY axis (Optional)
       z_units::ASCIIString               # Units of ZZ axis (Optional)
    end

图片变量 ``GMTJL_IMAGE`` 的定义为::

    type GMTJL_IMAGE     # The type holding a local header and data of a GMT image
       ProjectionRefPROJ4::ASCIIString    # Projection string in PROJ4 syntax (Optional)
       ProjectionRefWKT::ASCIIString      # Projection string in WKT syntax (Optional)
       range::Array{Float64,1}            # 1x6 vector with [x_min x_max y_min y_max z_min z_max]
       inc::Array{Float64,1}              # 1x2 vector with [x_inc y_inc]
       n_rows::Int                        # Number of rows in image
       n_columns::Int                     # Number of columns in image
       n_bands::Int                       # Number of bands in image
       registration::Int                  # Registration type: 0 -> Grid registration; 1 -> Pixel registration
       NoDataValue::Float64               # The value of nodata
       title::ASCIIString                 # Title (Optional)
       remark::ASCIIString                # Remark (Optional)
       command::ASCIIString               # Command used to create the image (Optional)
       DataType::ASCIIString              # 'uint8' or 'int8' (needs checking)
       x::Array{Float64,1}                # [1 x n_columns] vector with XX coordinates
       y::Array{Float64,1}                # [1 x n_rows]    vector with YY coordinates
       image::Array{UInt8,3}              # [n_rows x n_columns x n_bands] image array
       x_units::ASCIIString               # Units of XX axis (Optional)
       y_units::ASCIIString               # Units of YY axis (Optional)
       z_units::ASCIIString               # Units of ZZ axis (Optional) ==> MAKES NO SENSE
       colormap::Array{Clong,1}           #
       alpha::Array{UInt8,2}              # A [n_rows x n_columns] alpha array
    end

CPT变量 ``GMTJL_CPT`` 的定义为::

    type GMTJL_CPT
        colormap::Array{Float64,2}
        alpha::Array{Float64,1}
        range::Array{Float64,2}
        rangeMinMax::Array{Float64,1}
    end
