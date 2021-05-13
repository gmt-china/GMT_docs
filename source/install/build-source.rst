Linux/macOS 下编译GMT源码
=========================

这一节介绍如何在 Linux 或者 macOS 下编译GMT源代码。Windows用户如果想编译
GMT源码请参考GMT官方
`编译指南 <https://github.com/GenericMappingTools/gmt/blob/master/BUILDING.md>`_\ 。

编译及运行依赖
--------------

GMT的编译及运行需要如下软件：

- CMake: >=2.8.12
- netCDF（>=4.0且支持netCDF-4/HDF5）
- curl

除此之外，还可以安装如下软件库以增强GMT的更多功能：

- `Ghostscript <https://www.ghostscript.com/>`_: 生成PDF或者其他位图格式的图片
- `GDAL <https://www.gdal.org/>`_: 读写其它地学常用的网格和图片格式
- `PCRE <https://www.pcre.org/>`_: 正则表达式支持
- `FFTW <http://www.fftw.org/>`_: 快速傅里叶变换库（>=3.3，macOS下不需要）
- `GLib <https://developer.gnome.org/glib/>`_: GTHREAD多线程支持
- LAPACK: 快速矩阵反演库 （macOS下不需要）
- BLAS：快速矩阵运算库 （macOS下不需要）
- `GraphicsMagick <http://www.graphicsmagick.org>`_: 生成GIF格式的动画
- `FFmpeg <http://www.ffmpeg.org/>`_: 生成MP4格式的动画

安装依赖软件
------------

对于Ubuntu/Debian::

    $ sudo apt update
    # 安装编译所需软件包
    $ sudo apt install build-essential cmake libcurl4-gnutls-dev libnetcdf-dev
    $ sudo apt install ghostscript gdal-bin libgdal-dev libglib2.0-dev libpcre3-dev libfftw3-dev liblapack-dev
    # 安装制作动画所需的软件包
    $ sudo apt install graphicsmagick ffmpeg

对于CentOS/RHEL::

    $ sudo yum install epel-release
    # 安装编译所需软件包
    $ sudo yum install gcc cmake make glibc netcdf-devel libcurl-devel
    $ sudo yum install ghostscript gdal gdal-devel lapack-devel openblas-devel glib2-devel pcre-devel fftw-devel
    # 安装其他可选包
    $ sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-`rpm -E %rhel`.noarch.rpm
    $ sudo yum install GraphicsMagick ffmpeg

对于Fedora用户::

    # 安装编译所需软件包
    $ sudo dnf install gcc cmake make glibc netcdf-devel libcurl-devel
    $ sudo dnf install ghostscript gdal gdal-devel lapack-devel openblas-devel glib2-devel pcre-devel fftw-devel
    # 安装其他可选包
    $ sudo dnf install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm
    $ sudo dnf install GraphicsMagick ffmpeg

对于macOS用户，建议使用 `Homebrew <https://brew.sh>`_ 安装依赖::

    # 安装必须依赖
    brew install cmake curl netcdf
    brew install ghostscript gdal pcre2 glib fftw graphicsmagick ffmpeg

下载源码及数据
--------------

编译GMT需要下载如下三个文件：

#. GMT 6.1.1 源码：`gmt-6.1.1-src.tar.gz <http://mirrors.ustc.edu.cn/gmt/gmt-6.1.1-src.tar.gz>`_
#. 全球海岸线数据GSHHG：`gshhg-gmt-2.3.7.tar.gz <http://mirrors.ustc.edu.cn/gmt/gshhg-gmt-2.3.7.tar.gz>`_
#. 全球数字图表DCW：`dcw-gmt-1.1.4.tar.gz <http://mirrors.ustc.edu.cn/gmt/dcw-gmt-1.1.4.tar.gz>`_

安装GMT
-------

将下载的三个压缩文件放在同一个目录里，按照如下步骤进行安装：

.. code-block:: bash

   # 解压三个压缩文件
   $ tar -xvf gmt-6.1.1-src.tar.gz
   $ tar -xvf gshhg-gmt-2.3.7.tar.gz
   $ tar -xvf dcw-gmt-1.1.4.tar.gz

   # 将gshhg和dcw数据复制到gmt的share目录下
   $ mv gshhg-gmt-2.3.7 gmt-6.1.1/share/gshhg-gmt
   $ mv dcw-gmt-1.1.4 gmt-6.1.1/share/dcw-gmt

   # 切换到gmt源码目录下
   $ cd gmt-6.1.1

   # 用文本编辑器新建并打开CMake用户配置文件
   # Linux用户
   $ gedit cmake/ConfigUser.cmake
   # macOS用户
   $ touch cmake/ConfigUser.cmake
   $ open -a TextEdit cmake/ConfigUser.cmake

向 :file:`cmake/ConfigUser.cmake` 文件中加入如下语句::

    set (CMAKE_INSTALL_PREFIX "/opt/GMT-6.1.1")

    set (GMT_USE_THREADS TRUE)
    set (GMT_ENABLE_OPENMP TRUE)

- **CMAKE_INSTALL_PREFIX** 用于设置GMT的安装路径，上面的语句会将GMT安装在
  :file:`/opt/GMT-6.1.1` 目录下，用户可以自行修改为其他路径。没有 root 权限的
  一般用户，可以将安装路径设置为 :file:`/home/xxx/software/GMT-6.1.1` 等有可读写
  权限的路径；
- **GMT_USE_THREADS** 和 **GMT_ENABLE_OPENMP** 设置为 **TRUE** 会为GMT的某些模块
  增加多线程并行功能以加速计算，也可以不设置。

.. tip::

   此处为了便于一般用户理解，只向 :file:`cmake/ConfigUser.cmake` 中写入了必要的语句。
   用户可以将GMT提供的配置模板 :file:`cmake/ConfigUserTemplate.cmake` 复制为
   :file:`cmake/ConfigUser.cmake`\ 并根据配置文件中的大量注释说明信息自行修改配置文件。
   进一步，可以将高级配置模板 :file:`cmake/ConfigUserAdvancedTemplate.cmake` 复制为
   :file:`cmake/ConfigUserAdvanced.cmake` 并根据注释说明信息修改高级配置。

继续执行如下命令以检查GMT的依赖是否满足::

    # 注意，此处新建的 build 文件夹位于GMT源码压缩包解压出来的 gmt-6.1.1 目录下，不是 gmt-6.1.1/cmake 目录下，更不是 /opt/GMT-6.1.1
    $ mkdir build
    $ cd build/
    $ cmake ..

``cmake ..`` 会检查系统软件是否满足GMT的依赖关系，过程中会输出大量信息，并
在最后汇总输出检查结果。我们只需要关注检查结果是否正确即可。
正常情况下结果结果如下，若存在一些差异也没有问题。只要过程中不出现报错，即可。
如果出现报错，则需要检查之前的步骤是否有误，检查完成后删除原build目录再新建build，
继续执行 ``cmake ..``\ ，直到出现类似的检查结果::

    *
    *  GMT Version:               : 6.1.1
    *
    *  Options:
    *  Found GSHHG database       : /home/user/GMT/gmt-6.1.1/share/gshhg (2.3.7)
    *  Found DCW-GMT database     : /home/user/GMT/gmt-6.1.1/share/dcw-gmt (1.1.4)
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
    *  Installing GMT in          : /opt/GMT-6.1.1
    *  GMT_DATADIR                : /opt/GMT-6.1.1/share
    *  GMT_DOCDIR                 : /opt/GMT-6.1.1/share/doc
    *  GMT_MANDIR                 : /opt/GMT-6.1.1/share/man
    -- Configuring done
    -- Generating done

.. warning::

    Anaconda用户请注意！由于Anaconda中也安装了FFTW、GDAL、netCDF等库文件，
    GMT在配置过程中可能会找到Anaconda提供的库文件，进而导致配置、编译或执行
    过程中出错。

    解决办法是，在 :file:`~/.bashrc` 中将 Anaconda 相关的环境变量注释掉，以保证GMT
    在配置和编译过程中找到的不是 Anaconda 提供的库文件。待GMT安装完成后，再
    将 Anaconda 相关环境变量改回即可。

检查完毕后，开始编译和安装::

    $ make -j
    $ sudo make -j install

.. note::

   **-j** 选项可以实现并行编译以减少编译时间。但据用户报告，某些Ubuntu发行版下
   使用 **-j** 选项会导致编译过程卡死。Ubuntu用户建议在上面的两条命令中去掉 **-j** 选项。

修改环境变量
------------

打开终端，使用如下命令用文件编辑器打开Bash配置文件::

    # Linux 用户
    gedit ~/.bashrc

    # macOS 用户
    open ~/.bash_profile

然后向文件末尾加入如下语句以修改环境变量。修改完成后保存文件并退出，
然后重启终端使其生效::

    export GMT6HOME=/opt/GMT-6.1.1
    export PATH=${GMT6HOME}/bin:$PATH
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT6HOME}/lib64

说明：

- 第一个命令添加了环境变量 **GMT6HOME**
- 第二个命令修改 GMT6 的 bin 目录加入到 **PATH** 中，使得终端可以找到GMT命令
- 第三个命令将 GMT6 的 lib 目录加入到动态链接库路径中。
  通常，32位系统的路径为 **lib**\ ，64位系统的路径为 **lib64**

测试是否安装成功
----------------

重新打开一个终端，键入如下命令，若正确显示GMT版本号，则表示安装成功::

    $ gmt --version
    6.1.1

升级/卸载GMT
------------

按照上面的配置，GMT会被安装到 :file:`/opt/GMT-6.1.1` 目录下。若想要卸载GMT，
可以直接删除整个 :file:`/opt/GMT-6.1.1` 即可。

GMT不支持自动更新，因而若想要升级GMT，通常建议先卸载GMT，然后再下载新版源码
并按照上面的步骤重新编译安装。

当然，高级用户也可以同时安装多个版本的GMT，但需要注意环境变量 **PATH** 的设置。
