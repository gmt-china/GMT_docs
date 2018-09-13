Linux 下安装GMT
===============

安装预编译版
------------

大多数 Linux 发行版都可以通过系统自带的软件包管理器直接安装 GMT。但通常系统软件
源里自带的 GMT 版本都比较老，因而如果可能，还是建议 Linux 用户手动编译安装。

CentOS 7 用户::

    sudo yum install epel-release
    sudo yum install GMT GMT-devel GMT-doc
    sudo yum install dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high

Ubuntu 用户::

    sudo apt-get install gmt gmt-dcw gmt-gshhg

其他发行版用户可以到 https://pkgs.org/ 查询自己的 Linux 发行版软件源中是否包含
GMT 以及 GMT 的具体版本。

.. 从 conda 安装 GMT
.. include:: conda-install-gmt.rst_

从源码编译
----------

为了使用最新版本的 GMT，建议用户从源码编译 GMT。

解决依赖关系
~~~~~~~~~~~~

GMT 主要依赖于 cmake（>=2.8.5）、fftw（>=3.3）、glib2（>=2.32）、
netCDF（>4.0且支持netCDF-4/HDF5）、ghostscript等。

.. warning::

   由于 Linux 发行版众多，以下仅所列仅供参考，请自行确认自己的发行版上软件包的
   具体名字。

对于Ubuntu/Debian::

    # 更新
    $ sudo apt-get update

    $ sudo apt-get install gcc g++ cmake make libc6
    $ sudo apt-get install ghostscript
    $ sudo apt-get install libnetcdf-dev

    $ sudo apt-get install libgdal-dev python-gdal
    $ sudo apt-get install liblapack3
    $ sudo apt-get install libglib2.0-dev
    $ sudo apt-get install libpcre3-dev
    $ sudo apt-get install libfftw3-dev

对于CentOS/RHEL/Fedora::

    $ sudo yum install epel-release  # CentOS用户必须先安装epel-release

    $ sudo yum install gcc gcc-c++ cmake make glibc
    $ sudo yum install ghostscript
    $ sudo yum install netcdf-devel

    $ sudo yum install gdal-devel gdal-python
    $ sudo yum install lapack64-devel lapack-devel
    $ sudo yum install glib2-devel
    $ sudo yum install pcre-devel
    $ sudo yum install fftw-devel

确认 netCDF 支持 netCDF-4/HDF5 格式::

    $ nc-config --has-nc4
    yes

若输出为 ``yes`` 则可正常安装 GMT，否则无法正常安装。

下载
~~~~

Linux安装GMT需要下载三个文件（这里提供的国内下载源）：

#. GMT源码： http://mirrors.ustc.edu.cn/gmt/gmt-5.4.4-src.tar.gz
#. 全球海岸线数据GSHHG： http://mirrors.ustc.edu.cn/gmt/gshhg-gmt-2.3.7.tar.gz
#. 全球数字图表DCW： http://mirrors.ustc.edu.cn/gmt/dcw-gmt-1.1.4.tar.gz

安装GMT
~~~~~~~

将下载的三个压缩文件放在同一个目录里，按照如下步骤进行安装：

.. code-block:: bash

   # 解压三个压缩文件
   $ tar -xvf gmt-5.4.4-src.tar.gz
   $ tar -xvf gshhg-gmt-2.3.7.tar.gz
   $ tar -xvf dcw-gmt-1.1.4.tar.gz

   # 将gshhg和dcw数据复制到gmt的share目录下
   $ mv gshhg-gmt-2.3.7 gmt-5.4.4/share/gshhg
   $ mv dcw-gmt-1.1.4 gmt-5.4.4/share/dcw-gmt

   # 切换到gmt源码目录下
   $ cd gmt-5.4.4

   # 新建用户配置文件
   $ gedit cmake/ConfigUser.cmake

向 ``cmake/ConfigUser.cmake`` 文件中加入如下语句::

    set (CMAKE_INSTALL_PREFIX "/opt/GMT-5.4.4")
    set (GMT_INSTALL_MODULE_LINKS FALSE)
    set (GMT_DATA_URL "http://mirrors.ustc.edu.cn/gmt/data/")
    set (COPY_GSHHG TRUE)
    set (COPY_DCW TRUE)
    set (GMT_USE_THREADS TRUE)

其中，

- ``CMAKE_INSTALL_PREFIX`` 用于设置GMT的安装路径，上面的语句会将GMT安装在
  ``/opt/GMT-5.4.4`` 目录下，用户可以自行修改为其他路径。没有 root 权限的
  一般用户，可以将安装路径设置为 ``/home/xxx/software/GMT-5.4.4`` 等有可读写
  权限的路径；
- ``GMT_INSTALL_MODULE_LINKS`` 为FALSE，表明不在GMT的bin目录下建立命令的软链接，
  也可设置为TRUE
- ``GMT_DATA_URL`` 设置从中科大镜像下载GMT数据，以加快数据下载速度
- ``COPY_GSHHG`` 为TRUE会将GSHHG数据复制到 ``GMT/share/coast`` 下
- ``COPY_DCW`` 为TRUE会将DCW数据复制到 ``GMT/share/dcw`` 下
- ``GMT_USE_THREADS`` 表示是否开启某些模块的并行功能

.. warning::

   CentOS 6 用户需要将用户配置文件的最后一行改为 ``set (GMT_USE_THREADS FALSE)``

.. tip::

   此处为了便于一般用户理解，只向 ``cmake/ConfigUser.cmake`` 中写入了必要的5行语句。

   对于高级用户而言，可以直接在 GMT 提供的配置模板基础上进行更多配置。将
   ``cmake/ConfigUserTemplate.cmake`` 复制为 ``cmake/ConfigUser.cmake`` ，
   然后根据配置文件中的大量注释说明信息自行修改配置文件。

继续执行如下命令以检查GMT的依赖关系::

    # 注意，此处新建的 build 文件夹位于 gmt-5.4.4 目录下，不是 gmt-5.4.4/cmake 目录下
    $ mkdir build
    $ cd build/
    $ cmake ..

``cmake ..`` 会检查GMT对软件的依赖关系，我的检查结果如下::

    *  Options:
    *  Found GSHHG database       : /home/user/GMT/gmt-5.4.4/share/gshhg (2.3.7)
    *  Found DCW-GMT database     : /home/user/GMT/gmt-5.4.4/share/dcw-gmt
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
    *  License restriction        : no
    *  Triangulation method       : Shewchuk
    *  OpenMP support             : enabled
    *  GLIB GTHREAD support       : enabled
    *  PTHREAD support            : enabled
    *  Build mode                 : shared
    *  Build GMT core             : always [libgmt.so]
    *  Build PSL library          : always [libpostscriptlight.so]
    *  Build GMT supplements      : yes [supplements.so]
    *  Build GMT Developer        : yes
    *  Build proto supplements    : none
    *
    *  Locations:
    *  Installing GMT in          : /opt/GMT-5.4.4
    *  GMT_DATADIR                : /opt/GMT-5.4.4/share
    *  GMT_DOCDIR                 : /opt/GMT-5.4.4/share/doc
    *  GMT_MANDIR                 : /opt/GMT-5.4.4/share/man
    -- Configuring done
    -- Generating done

正常情况下的检查结果应该与上面给出的类似。若出现问题，则需要检查之前的步骤是否
有误，检查完毕后重新执行 ``cmake ..`` ，直到出现类似的检查结果。检查完毕后，
开始编译和安装::

    $ make
    $ sudo make install

.. note::

   对于多核计算机，可以使用如下命令实现并行编译以减少编译时间::

        $ make -j
        $ sudo make -j install

   但并行编译可能在个别发行版上无法使用。

修改环境变量
~~~~~~~~~~~~

修改环境变量并使其生效：

.. code-block:: bash

   $ echo 'export GMT5HOME=/opt/GMT-5.4.4' >> ~/.bashrc
   $ echo 'export PATH=${GMT5HOME}/bin:$PATH' >> ~/.bashrc
   $ echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT5HOME}/lib64' >> ~/.bashrc
   $ exec $SHELL -l

说明：

- 第一个命令向 ``~/.bashrc`` 中添加环境变量 ``GMT5HOME``
- 第二个命令修改 ``~/.bashrc`` ，将 GMT5 的 bin 目录加入到 ``PATH`` 中
- 第三个命令将 GMT5 的 lib 目录加入到动态链接库路径中，若为 32 位系统，则为 lib ；64 位系统则为 lib64
- 第四个命令是重新载入 bash，相当于 ``source ~/.bashrc``

测试是否安装成功
~~~~~~~~~~~~~~~~

在终端键入 ``gmt`` ，若出现如下输出，则安装成功::

    $ gmt --version
    5.4.4
