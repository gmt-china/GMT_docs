Linux 下安装GMT
===============

大多数Linux发行版都提供了预编译的GMT二进制包，可以通过发行版的软件包安装
工具进行安装GMT。

Ubuntu/Debian用户::

    sudo apt install gmt gmt-dcw gmt-gshhg

RHEL/CentOS用户::

    sudo yum install epel-release
    sudo yum install GMT gshhg-gmt-nc4-all dcw-gmt

Fedora用户::

    sudo dnf install GMT gshhg-gmt-nc4-all dcw-gmt

大多数发行版提供的GMT版本都较老，故不推荐直接安装发行版提供的版本，而建议
直接从源码编译GMT。

解决依赖关系
------------

GMT 在运行时依赖 fftw（>=3.3）、netCDF（>4.0且支持netCDF-4/HDF5）、
ghostscript等。GMT在安装时主要依赖GCC编译器和 cmake（>=2.8.5）。
因而，需要先安装GMT所依赖的软件包。

.. warning::

   由于 Linux 发行版众多，不同发行版下软件包的名称不同。
   因而，以下仅所列仅供参考，其他用户应自行根据关键词到
   https://pkgs.org 上确认自己使用的发行版上软件包的
   具体名字。

对于Ubuntu/Debian::

    # 更新
    $ sudo apt update

    # 安装编译所需软件包
    $ sudo apt-get install build-essential cmake

    # 安装必须软件包
    $ sudo apt install ghostscript
    $ sudo apt install libnetcdf-dev
    $ sudo apt install libcurl4-gnutls-dev

    # 安装可选软件包
    $ sudo apt install libgdal-dev python-gdal
    $ sudo apt install liblapack3
    $ sudo apt install libglib2.0-dev
    $ sudo apt install libpcre3-dev
    $ sudo apt install libfftw3-dev

    # 安装制作动画所需的软件包
    $ sudo apt install graphicsmagick ffmpeg

对于CentOS/RHEL/Fedora::

    # CentOS用户必须先安装epel-release, RHEL/Fedora用户无需安装
    $ sudo yum install epel-release

    # 安装编译所需软件包
    $ sudo yum install gcc gcc-c++ cmake make glibc

    # 安装必须软件包
    $ sudo yum install ghostscript
    $ sudo yum install netcdf-devel
    $ sudo yum install libcurl-devel

    # 安装可选软件包
    $ sudo yum install gdal-devel gdal-python
    $ sudo yum install lapack64-devel lapack-devel
    $ sudo yum install glib2-devel
    $ sudo yum install pcre-devel
    $ sudo yum install fftw-devel

    # 安装其他可选包
    $ sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
    $ sudo yum install GraphicsMagick ffmpeg

.. warning::

   GMT需要使用 ghostscript 生成PDF、JPG等格式的图片。但ghostscript 9.27存在
   严重bug，会导致生成的图片中有用信息被裁剪。
   请使用 ``gs --version`` 确认安装的ghostscript不是9.27版本。

下载
----

Linux下安装GMT需要下载如下三个文件：

#. GMT 6.0.0rc3 源码：`gmt-6.0.0rc3-src.tar.gz <http://mirrors.ustc.edu.cn/gmt/gmt-6.0.0rc3-src.tar.gz>`_
#. 全球海岸线数据GSHHG：`gshhg-gmt-2.3.7.tar.gz <http://mirrors.ustc.edu.cn/gmt/gshhg-gmt-2.3.7.tar.gz>`_
#. 全球数字图表DCW：`dcw-gmt-1.1.4.tar.gz <http://mirrors.ustc.edu.cn/gmt/dcw-gmt-1.1.4.tar.gz>`_

安装GMT
-------

将下载的三个压缩文件放在同一个目录里，按照如下步骤进行安装：

.. code-block:: bash

   # 解压三个压缩文件
   $ tar -xvf gmt-6.0.0rc3.tar.gz
   $ tar -xvf gshhg-gmt-2.3.7.tar.gz
   $ tar -xvf dcw-gmt-1.1.4.tar.gz

   # 将gshhg和dcw数据复制到gmt的share目录下
   $ mv gshhg-gmt-2.3.7 gmt-6.0.0rc3/share/gshhg
   $ mv dcw-gmt-1.1.4 gmt-6.0.0rc3/share/dcw-gmt

   # 切换到gmt源码目录下
   $ cd gmt-6.0.0rc3

   # 新建用户配置文件
   $ gedit cmake/ConfigUser.cmake

向 ``cmake/ConfigUser.cmake`` 文件中加入如下语句::

    set (CMAKE_INSTALL_PREFIX "/opt/GMT-6.0.0rc3")
    set (COPY_GSHHG TRUE)
    set (COPY_DCW TRUE)
    set (GMT_INSTALL_MODULE_LINKS FALSE)

其中，

- ``CMAKE_INSTALL_PREFIX`` 用于设置GMT的安装路径，上面的语句会将GMT安装在
  ``/opt/GMT-6.0.0rc3`` 目录下，用户可以自行修改为其他路径。没有 root 权限的
  一般用户，可以将安装路径设置为 ``/home/xxx/software/GMT-6.0.0rc3`` 等有可读写
  权限的路径；
- ``COPY_GSHHG`` 和 ``COPY_DCW`` 设置为 TRUE 会将相关数据复制到 GMT 的 share 目录下
- ``GMT_INSTALL_MODULE_LINKS`` 为 ``FALSE``\ ，表明不在GMT的bin目录下建立命令的
  软链接，不建议设置为 ``TRUE`` （可选）

.. tip::

   此处为了便于一般用户理解，只向 ``cmake/ConfigUser.cmake`` 中写入了必要的语句。

   用户可以将GMT提供的配置模板 ``cmake/ConfigUserTemplate.cmake`` 复制为
   ``cmake/ConfigUser.cmake``\ ，然后根据配置文件中的大量注释说明信息自行修改配置文件。

继续执行如下命令以检查GMT的依赖是否满足::

    # 注意，此处新建的 build 文件夹位于 gmt-6.0.0rc3 目录下，不是 gmt-6.0.0rc3/cmake 目录下
    $ mkdir build
    $ cd build/
    $ cmake ..

``cmake ..`` 会检查GMT对软件的依赖关系，我的检查结果如下::

    *
    *  GMT Version:               : 6.0.0rc3
    *
    *  Options:
    *  Found GSHHG database       : /home/user/GMT/gmt-6.0.0rc3/share/gshhg (2.3.7)
    *  Found DCW-GMT database     : /home/user/GMT/gmt-6.0.0rc3/share/dcw-gmt
    *  Found GMT data server      : http://oceania.generic-mapping-tools.org
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
    *  GLIB GTHREAD support       : disabled
    *  PTHREAD support            : disabled
    *  Build mode                 : shared
    *  Build GMT core             : always [libgmt.so]
    *  Build PSL library          : always [libpostscriptlight.so]
    *  Build GMT supplements      : yes [supplements.so]
    *  Build GMT Developer        : yes
    *  Build proto supplements    : none
    *  Found GhostScript (gs)     : yes
    *  Found GraphicsMagick (gm)  : yes
    *  Found ffmpeg               : yes
    *  Found open                 : yes
    *  Found ogr2ogr              : yes
    *  Found gdal_translate       : yes
    *
    *  Locations:
    *  Installing GMT in          : /opt/GMT-6.0.0rc3
    *  GMT_DATADIR                : /opt/GMT-6.0.0rc3/share
    *  GMT_DOCDIR                 : /opt/GMT-6.0.0rc3/share/doc
    *  GMT_MANDIR                 : /opt/GMT-6.0.0rc3/share/man
    -- Configuring done
    -- Generating done

正常情况下的检查结果应该与上面给出的类似。若出现问题，则需要检查之前的步骤是否
有误，检查完成后删除原build目录再新建build，继续执行 ``cmake ..``\ ，
直到出现类似的检查结果。

.. warning::

    Anaconda用户请注意！由于Anaconda中也安装了FFTW、GDAL、netCDF等库文件，
    GMT在配置过程中通常会找到Anaconda提供的库文件，进而导致配置、编译或执行
    过程中出错。

    解决办法是，在 ``~/.bashrc`` 中将 Anaconda 相关的环境变量注释掉，以保证GMT
    在配置和编译过程中找到的不是 Anaconda 提供的库文件。待GMT安装完成后，再
    将 Anaconda 相关环境变量改回即可。

检查完毕后，开始编译和安装::

    $ make -j
    $ sudo make -j install

.. note::

   ``-j`` 选项可以实现并行编译以减少编译时间。但据用户报告，某些Ubuntu发行版下
   使用 ``-j`` 选项会导致编译过程卡死。若出现此种情况，建议去除 ``-j`` 选项。

修改环境变量
------------

向 ``~/.bashrc`` （某些系统需要修改 ``~/.bash_profile``\ ）中加入如下语句以
修改环境变量，并重启终端使其生效::

    export GMT6HOME=/opt/GMT-6.0.0rc3
    export PATH=${GMT6HOME}/bin:$PATH
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT6HOME}/lib64

说明：

- 第一个命令添加了环境变量 ``GMT6HOME``
- 第二个命令修改 GMT6 的 bin 目录加入到 ``PATH`` 中，使得终端可以找到GMT命令
- 第三个命令将 GMT6 的 lib 目录加入到动态链接库路径中。
  通常，32位系统的路径为 ``lib``\ ，64位系统的路径为 ``lib64``

测试是否安装成功
----------------

重新打开一个终端，键入如下命令，若正确显示GMT版本号，则表示安装成功::

    $ gmt --version
    6.0.0rc3
