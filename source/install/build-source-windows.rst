Windows 下编译 GMT 源码
=======================

这一节介绍如何在 Windows 下编译 GMT 源码。

系统要求
--------

- Windows 10, 8.1 或 7
- Visual Studio 2015 Update 3 or newer with "Desktop development with C++" installed
- Git
- CMake >= 3.12.4

安装依赖软件
------------

GMT 的编译及运行依赖于其他软件。

必须的依赖软件包括：

- `CMake <https://cmake.org/>`__\ （>=2.8.12）
- `netCDF <https://www.unidata.ucar.edu/software/netcdf/>`__\ （>=4.0 且支持 netCDF-4/HDF5）
- `curl <https://curl.haxx.se/>`__

可选的依赖软件包括：

- `Ghostscript <https://www.ghostscript.com/>`__\ ：生成 PDF、JPG 等格式的图片
- `GDAL <https://www.gdal.org/>`__\ ：读写多种格式的地理空间数据
- `PCRE <https://www.pcre.org/>`__\ ：正则表达式支持
- `FFTW <http://www.fftw.org/>`__\ ：快速傅里叶变换库（>=3.3，macOS 下不需要）
- `GLib <https://developer.gnome.org/glib/>`__\ ：GTHREAD 多线程支持（>=2.32）
- LAPACK：快速矩阵反演库（macOS 下不需要）
- BLAS：快速矩阵运算库（macOS 下不需要）
- `GraphicsMagick <http://www.graphicsmagick.org>`__\ ：生成 GIF 格式的动画
- `FFmpeg <http://www.ffmpeg.org/>`__\ ：生成 MP4 格式的动画

安装依赖软件
^^^^^^^^^^^^

- CMake
- Ghostscript
- GraphicksMagick
- FFmpeg

安装 Vcpkg
^^^^^^^^^^

::


    cd C:\
    git clone https://github.com/microsoft/vcpkg
    cd C:\vcpkg
    .\bootstrap-vcpkg.bat

安装 GMT 依赖软件
^^^^^^^^^^^^^^^^^

::

    # Build and install libraries
    # If you want to build x64 libraries (recommended)
    vcpkg install netcdf-c gdal pcre fftw3[core,threads] clapack openblas --triplet x64-windows

    # If you want to build x86 libraries
    vcpkg install netcdf-c gdal pcre fftw3[core,threads] clapack openblas --triplet x86-windows

    # hook up user-wide integration (note: requires admin on first use)
    vcpkg integrate install

将 GDAL 的 bin 目录 ``C:\vcpkg\installed\x64-windows\tools\gdal`` 添加到 PATH，
将 vcpkg 的 bin 目录 ``C:\vcpkg\installed\x64-windows\bin`` 添加到 PATH。

下载源码及数据
--------------

编译 GMT 需要下载如下三个文件：

#. GMT 6.2.0 源码：`gmt-6.2.0-src.tar.gz <http://mirrors.ustc.edu.cn/gmt/gmt-6.2.0-src.tar.gz>`_
#. 全球海岸线数据 GSHHG：`gshhg-gmt-2.3.7.tar.gz <http://mirrors.ustc.edu.cn/gmt/gshhg-gmt-2.3.7.tar.gz>`_
#. 全球数字图表 DCW：`dcw-gmt-2.0.0.tar.gz <https://github.com/GenericMappingTools/dcw-gmt/releases/download/2.0.0/dcw-gmt-2.0.0.tar.gz>`_

.. note::

    如果想编译 GMT 开发版，可以使用如下命令获取 GMT 最新开发版源码::

        $ git clone --depth 50 https://github.com/GenericMappingTools/gmt

    其余操作与编译 GMT 正式版没有区别。

安装 GMT
--------

将下载的三个压缩文件放在同一个目录里，按照如下步骤进行安装::

   # 解压三个压缩文件
   $ tar -xvf gmt-6.2.0-src.tar.gz
   $ tar -xvf gshhg-gmt-2.3.7.tar.gz
   $ tar -xvf dcw-gmt-2.0.0.tar.gz

   # 将 gshhg 和 dcw 数据复制到 gmt 的 share 目录下
   $ mv gshhg-gmt-2.3.7 gmt-6.2.0/share/gshhg-gmt
   $ mv dcw-gmt-2.0.0 gmt-6.2.0/share/dcw-gmt

   # 切换到 gmt 源码目录下
   $ cd gmt-6.2.0

   # 用文本编辑器新建并打开 CMake 用户配置文件
   # Linux 用户
   $ gedit cmake/ConfigUser.cmake
   # macOS 用户
   $ touch cmake/ConfigUser.cmake
   $ open -a TextEdit cmake/ConfigUser.cmake

向 :file:`cmake/ConfigUser.cmake` 文件中加入如下语句::

    set (CMAKE_INSTALL_PREFIX "C:/programs/gmt6")
    set (GMT_USE_THREADS TRUE)

- **CMAKE_INSTALL_PREFIX** 用于设置 GMT 的安装路径，上面的语句会将 GMT 安装在
  :file:`/opt/GMT-6.2.0` 目录下，用户可以自行修改为其他路径。没有 root 权限的
  一般用户，可以将安装路径设置为 :file:`/home/xxx/opt/GMT-6.2.0` 等有可读写
  权限的路径
- **GMT_USE_THREADS** 设置为 **TRUE** 会为 GMT 的某些模块增加多线程并行功能以加速计算，
  也可以不设置

.. tip::

   此处为了便于一般用户理解，只向 :file:`cmake/ConfigUser.cmake` 中写入了必要的语句。
   用户可以将 GMT 提供的配置模板 :file:`cmake/ConfigUserTemplate.cmake` 复制为
   :file:`cmake/ConfigUser.cmake` 并根据配置文件中的大量注释说明信息自行修改配置文件。
   也可以进一步将高级配置模板 :file:`cmake/ConfigUserAdvancedTemplate.cmake` 复制为
   :file:`cmake/ConfigUserAdvanced.cmake` 并根据注释说明信息修改高级配置。

继续执行如下命令以检查 GMT 的依赖是否满足：

.. note::

    以下的 ``mkdir build`` 命令新建的 :file:`build` 文件夹位于 GMT 源码压缩包
    解压出来的 :file:`gmt-6.2.0` 目录下。
    不是 :file:`gmt-6.2.0/cmake` 目录下，更不是 :file:`/opt/GMT-6.2.0`\ 。

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
    *  GMT Version:               : 6.2.0
    *
    *  Options:
    *  Found GSHHG database       : /home/user/GMT/gmt-6.2.0/share/gshhg (2.3.7)
    *  Found DCW-GMT database     : /home/user/GMT/gmt-6.2.0/share/dcw-gmt (2.0.0)
    *  Found GMT data server      : https://oceania.generic-mapping-tools.org
    *  NetCDF library             : /usr/lib64/libnetcdf.so
    *  NetCDF include dir         : /usr/include
    *  GDAL library               : /usr/lib64/libgdal.so
    *  GDAL include dir           : /usr/include/gdal
    *  FFTW library               : /usr/lib64/libfftw3f.so
    *  FFTW include dir           : /usr/include
    *  Accelerate Framework       :
    *  Regex support              : PCRE (/usr/lib64/libpcre.so)
    *  ZLIB library               : /usr/lib64/libz.so
    *  ZLIB include dir           : /usr/include
    *  LAPACK library             : yes
    *  BLAS library               : yes
    *  License restriction        : no
    *  Triangulation method       : Shewchuk
    *  OpenMP support             : enabled
    *  GLIB GTHREAD support       : enabled
    *  Build mode                 : shared
    *  Build GMT core             : always [libgmt.so]
    *  Build PSL library          : always [libpostscriptlight.so]
    *  Build GMT supplements      : yes [supplements.so]
    *  Build GMT Developer        : yes
    *  Build proto supplements    : none
    *  Found Ghostscript (gs)     : yes (9.50)
    *  Found GraphicsMagick (gm)  : yes (1.3.33)
    *  Found ffmpeg               : yes (4.2.1)
    *  Found open                 : yes
    *  Found ogr2ogr              : yes (2.4.2)
    *  Found gdal_translate       : yes (2.4.2)
    *
    *  Locations:
    *  Installing GMT in          : /opt/GMT-6.2.0
    *  GMT_DATADIR                : /opt/GMT-6.2.0/share
    *  GMT_DOCDIR                 : /opt/GMT-6.2.0/share/doc
    *  GMT_MANDIR                 : /opt/GMT-6.2.0/share/man
    -- Configuring done
    -- Generating done

检查完毕后，开始编译和安装::

    $ cmake --build . --config Release
    $ cmake --build . --target install --config Release

修改环境变量
------------

打开终端，使用如下命令用文件编辑器打开 Shell 配置文件::

    # Linux 用户
    $ gedit ~/.bashrc

    # macOS 用户
    $ open ~/.zshrc

然后向文件末尾加入如下语句以修改环境变量。修改完成后保存文件并退出，
然后重启终端使其生效::

    export GMT6HOME=/opt/GMT-6.2.0
    export PATH=${GMT6HOME}/bin:$PATH
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT6HOME}/lib64

说明：

- 第一个命令添加了环境变量 **GMT6HOME**
- 第二个命令修改 GMT6 的 :file:`bin` 目录加入到 **PATH** 中，使得在终端或脚本中可以找到 GMT 命令
- 第三个命令将 GMT6 的 :file:`lib` 目录加入到动态链接库路径中。
  通常，32 位系统的路径为 :file:`lib`\ ，64 位系统的路径为 :file:`lib64`

测试是否安装成功
----------------

重新打开一个终端，键入如下命令，若正确显示 GMT 版本号，则表示安装成功::

    $ gmt --version
    6.2.0

升级/卸载 GMT
-------------

按照上面的配置，GMT 会被安装到 :file:`/opt/GMT-6.2.0` 目录下。若想要卸载 GMT，
可以直接删除整个 :file:`/opt/GMT-6.2.0` 即可。

GMT 不支持自动更新，因而若想要升级 GMT，通常建议先卸载 GMT，然后再下载新版源码
并按照上面的步骤重新编译安装。

当然，高级用户也可以同时安装多个版本的 GMT，但需要注意环境变量 **PATH** 的设置。
