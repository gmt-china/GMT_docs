Windows 下编译 GMT 源码
=======================

这一节介绍如何在 Windows 系统（Windows 10、Windows 8.1 或 Windows 7）下
编译 GMT 源码。

安装编译工具
------------

在 Windows 下编译 GMT 源码，需要先自行下载并安装如下软件：

- `Visual Studio <https://visualstudio.microsoft.com/zh-hans/>`__ \（安装时需要勾选 Desktop development with C++ 相关工具）
- `Git <https://git-scm.com/downloads>`__
- `CMake <https://cmake.org/download/>`__
- `Ghostscript <https://www.ghostscript.com/>`__\ ：生成 PDF、JPG 等格式的图片 [**必须**]
- `GraphicsMagick <http://www.graphicsmagick.org>`__\ ：生成 GIF 格式的动画 [**可选**]
- `FFmpeg <http://www.ffmpeg.org/>`__\ ：生成 MP4 格式的动画 [**可选**]

安装 vcpkg 及依赖软件
---------------------

GMT 的编译及运行依赖于其他库文件，包括：

- `netCDF <https://www.unidata.ucar.edu/software/netcdf/>`__\ （>=4.0 且支持 netCDF-4/HDF5）[**必须**]
- `curl <https://curl.haxx.se/>`__\ ：下载网络数据 [**必须**]
- `GDAL <https://www.gdal.org/>`__\ ：读写多种格式的地理空间数据 [**推荐**]
- `PCRE <https://www.pcre.org/>`__\ ：正则表达式支持 [**可选**]
- `FFTW <http://www.fftw.org/>`__\ ：快速傅里叶变换库（>=3.3）[**可选**]
- LAPACK：快速矩阵反演库（macOS 下不需要）[**可选**]
- BLAS：快速矩阵运算库（macOS 下不需要）[**可选**]

Windows 下可以通过 C++ 库管理器 `vcpkg <https://vcpkg.io>`__ 安装这些依赖软件。

首先，需要安装 vcpkg。打开 CMD 窗口，执行如下命令即可将 vcpkg 安装到 :file:`C:\vcpkg`
目录下::

    $ cd C:\
    $ git clone https://github.com/microsoft/vcpkg
    $ cd C:\vcpkg
    $ .\bootstrap-vcpkg.bat

.. note::

    以下假定使用的是 64 位 Windows 系统。对于 32 位 Windows 系统，需要将
    ``x64-windows`` 改成 ``x86-windows``\ 。

先打开一个 CMD 窗口，执行如下命令::

    $ vcpkg install netcdf-c gdal pcre fftw3[core,threads] clapack openblas --triplet x64-windows
    $ vcpkg integrate install

.. note::

    由于 vcpkg 会从源码编译 GMT 所需的全部依赖库，因而这一步会耗时约 1 小时。

安装完成后，还需要将 GDAL 的 bin 目录 ``C:\vcpkg\installed\x64-windows\tools\gdal``
添加到环境变量 **PATH** 以保证 GMT 可以调用 GDAL 提供的命令。

下载源码及数据
--------------

编译 GMT 需要下载如下三个文件：

#. GMT 6.3.0 源码：`gmt-6.3.0-src.tar.gz <http://mirrors.ustc.edu.cn/gmt/gmt-6.3.0-src.tar.gz>`__
#. 全球海岸线数据 GSHHG：`gshhg-gmt-2.3.7.tar.gz <http://mirrors.ustc.edu.cn/gmt/gshhg-gmt-2.3.7.tar.gz>`__
#. 全球数字图表 DCW：`dcw-gmt-2.1.1.tar.gz <https://mirrors.ustc.edu.cn/gmt/dcw-gmt-2.1.1.tar.gz>`__

.. note::

    如果想编译 GMT 开发版，可以使用如下命令获取 GMT 最新开发版源码::

        $ git clone --depth 50 https://github.com/GenericMappingTools/gmt

    其余操作与编译 GMT 正式版没有区别。

安装 GMT
--------

将下载的三个压缩文件放在同一个目录里。打开 Git Bash，并按照如下步骤进行安装::

   # 解压三个压缩文件
   $ tar -xvf gmt-6.3.0-src.tar.gz
   $ tar -xvf gshhg-gmt-2.3.7.tar.gz
   $ tar -xvf dcw-gmt-2.1.1.tar.gz

   # 将 gshhg 和 dcw 数据复制到 gmt 的 share 目录下
   $ mv gshhg-gmt-2.3.7 gmt-6.3.0/share/gshhg-gmt
   $ mv dcw-gmt-2.1.1 gmt-6.3.0/share/dcw-gmt

   # 切换到 gmt 源码目录下
   $ cd gmt-6.3.0

打开 :file:`cmake` 目录，在其中创建文件 :file:`cmake/ConfigUser.cmake`\ ，
并向文件中加入如下语句::

    set (CMAKE_INSTALL_PREFIX "C:/programs/gmt6")

- **CMAKE_INSTALL_PREFIX** 用于设置 GMT 的安装路径，上面的语句会将 GMT 安装在
  :file:`C:/programs/gmt6` 目录下。用户也可以自行修改为其他路径，但路径中不可以
  有空格

.. tip::

   此处为了便于一般用户理解，只向 :file:`cmake/ConfigUser.cmake` 中写入了必要的语句。
   用户可以将 GMT 提供的配置模板 :file:`cmake/ConfigUserTemplate.cmake` 复制为
   :file:`cmake/ConfigUser.cmake` 并根据配置文件中的大量注释说明信息自行修改配置文件。
   也可以进一步将高级配置模板 :file:`cmake/ConfigUserAdvancedTemplate.cmake` 复制为
   :file:`cmake/ConfigUserAdvanced.cmake` 并根据注释说明信息修改高级配置。

继续执行如下命令以检查 GMT 的依赖是否满足：

.. note::

    以下的 ``mkdir build`` 命令新建的 :file:`build` 文件夹位于 GMT 源码压缩包
    解压出来的 :file:`gmt-6.3.0` 目录下。
    不是 :file:`gmt-6.3.0/cmake` 目录下，更不是 :file:`/opt/GMT-6.3.0`\ 。

::

    $ mkdir build
    $ cd build/
    # 64 位系统
    $ cmake .. -DCMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake -DCMAKE_GENERATOR_PLATFORM=x64
    # 32 位系统
    $ cmake .. -DCMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake -DCMAKE_GENERATOR_PLATFORM=x86

``cmake ..`` 会检查系统软件是否满足 GMT 的依赖关系，过程中会输出大量信息，并
在最后汇总输出检查结果。我们只需要关注检查结果是否正确即可。
正常情况下结果结果如下，若存在一些差异也没有问题。只要过程中不出现报错，即可。
如果出现报错，则需要检查之前的步骤是否有误，检查完成后删除原 build 目录再新建 build，
继续执行 ``cmake ..``\ ，直到出现类似的检查结果::

    *
    *  GMT Version:               : 6.3.0
    *
    *  Options:
    *  Found GSHHG database       : D:/a/gmt/gmt/coastline/gshhg (2.3.7)
    *  Found DCW-GMT database     : D:/a/gmt/gmt/coastline/dcw (2.1.1)
    *  Found GMT data server      : oceania
    *  NetCDF library             : C:/vcpkg/installed/x64-windows/lib/netcdf.lib
    *  NetCDF include dir         : C:/vcpkg/installed/x64-windows/include
    *  Curl library               : C:/vcpkg/installed/x64-windows/lib/libcurl.lib
    *  Curl include dir           :
    *  GDAL library               :
    *  GDAL include dir           : C:/vcpkg/installed/x64-windows/include
    *  GEOS library               : C:/vcpkg/installed/x64-windows/lib/geos_c.lib
    *  GEOS include dir           : C:/vcpkg/installed/x64-windows/include
    *  FFTW library               : C:/vcpkg/installed/x64-windows/lib/fftw3f.lib
    *  FFTW threads library       : C:/vcpkg/installed/x64-windows/lib/fftw3f.lib
    *  FFTW include dir           : C:/vcpkg/installed/x64-windows/include
    *  Accelerate Framework       :
    *  Regex support              : PCRE (C:/vcpkg/installed/x64-windows/lib/pcre.lib)
    *  ZLIB library               : C:/vcpkg/installed/x64-windows/lib/zlib.lib
    *  ZLIB include dir           : C:/vcpkg/installed/x64-windows/include
    *  LAPACK library             : yes
    *  BLAS library               : yes
    *  License restriction        : no
    *  Triangulation method       : Shewchuk
    *  OpenMP support             : enabled
    *  GLIB GTHREAD support       : disabled
    *  Build generator            : Ninja
    *  Build GMT core             : always [gmt.dll]
    *  Build PSL library          : always [postscriptlight.dll]
    *  Build GMT supplements      : yes [supplements.dll]
    *  Build GMT for developers   : yes
    *  Build proto supplements    : none
    *  Build module links         : no
    *  Found Ghostscript (gs)     : yes
    *  Found GraphicsMagick (gm)  : yes
    *  Found ffmpeg               : yes
    *  Found open                 : yes
    *  Found ogr2ogr              : yes (3.2.2)
    *  Found gdal_translate       : yes (3.2.2)
    -- Configuring done
    *
    *  Locations:
    *  Installing GMT in          : C:/programs/gmt6
    *  GMT_DATADIR                : C:/programs/gmt6/share
    *  GMT_DOCDIR                 : C:/programs/gmt6/share/doc
    *  GMT_MANDIR                 : C:/programs/gmt6/share/man
    -- Generating done

检查完毕后，开始编译和安装::

    $ cmake --build . --config Release
    $ cmake --build . --target install --config Release

修改环境变量
------------

安装完成后，需要将 GMT 的 bin 目录 ``C:/programs/gmt6/bin`` 添加到环境变量
**PATH** 中。

测试是否安装成功
----------------

启动 CMD，键入如下命令，若正确显示 GMT 版本号，则表示安装成功::

    $ gmt --version
    6.3.0

升级/卸载 GMT
-------------

按照上面的配置，GMT 会被安装到 :file:`C:/programs/gmt6/` 目录下。若想要卸载 GMT，
可以直接删除整个 :file:`C:/programs/gmt6` 即可。

GMT 不支持自动更新，因而若想要升级 GMT，通常建议先卸载 GMT，然后再下载新版源码
并按照上面的步骤重新编译安装。
