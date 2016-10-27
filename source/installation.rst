安装GMT
=======

这一节介绍如何在Linux/Windows/Mac OS下安装GMT 5.3.1。

Linux
-----

大多数Linux发行版的软件源中都有GMT，因而可以通过系统自带的软件包管理器来安装。但通常系统软件源里自带的GMT都比较老，所以在Linux还是建议自己手动编译安装。

编译过程有些复杂，一般用户可以尝试使用为CentOS和Ubuntu用户准备的 `快速安装脚本 <https://github.com/gmt-china/gmt-easy-installer>`_ 。其他发行版的用户也可以测试一下。

解决依赖关系
~~~~~~~~~~~~

GMT主要依赖于 cmake（>=2.8.5）、fftw（>=3.3）、glib2（>=2.32）、netCDF（>4.0且支持netCDF-4/HDF5）、ghostscript等。

对于Ubuntu/Debian::

    # 更新
    $ sudo apt-get update
    # 必须安装的包
    $ sudo apt-get install gcc g++ cmake make libc6 ghostscript libnetcdf-dev
    # 可选包
    $ sudo apt-get install libgdal-dev python-gdal liblapack3 libglib2.0-dev
    $ sudo apt-get install libpcre3-dev libfftw3-dev

对于CentOS/RHEL/Fedora::

    # 必须安装的包
    $ sudo yum install gcc gcc-c++ cmake make glibc ghostscript netcdf-devel
    # 可选包
    $ sudo yum install glib2-devel gdal-devel gdal-python lapack64-devel lapack-devel
    $ sudo yum install pcre-devel fftw-devel

确认 netCDF 支持 netCDF-4/HDF5 格式::

    $ nc-config --has-nc4
    yes

若输出为 ``yes`` 则可正常安装 GMT，否则无法正常安装。

下载
~~~~

Linux安装GMT需要下载三个文件（这里提供的国内下载源）：

#. GMT源码： http://mirrors.ustc.edu.cn/gmt/gmt-5.3.1-src.tar.gz
#. 全球海岸线数据GSHHG： http://mirrors.ustc.edu.cn/gmt/gshhg-gmt-2.3.6.tar.gz
#. 全球数字图表DCW： http://mirrors.ustc.edu.cn/gmt/dcw-gmt-1.1.2.tar.gz

也可以到社区主页的 `下载页面 <http://gmt-china.org/download/>`_ 下载对应的文件。

安装GMT
~~~~~~~

将下载的三个压缩文件放在同一个目录里，按照如下步骤进行安装：

.. code-block:: bash

   # 解压三个压缩文件
   $ tar -xvf gmt-5.3.1-src.tar.gz
   $ tar -xvf gshhg-gmt-2.3.6.tar.gz
   $ tar -xvf dcw-gmt-1.1.2.tar.gz

   # 将gshhg和dcw数据复制到gmt的share目录下
   $ mv gshhg-gmt-2.3.6 gmt-5.3.1/share/gshhg
   $ mv dcw-gmt-1.1.2 gmt-5.3.1/share/dcw-gmt

   # 切换到gmt源码目录下
   $ cd gmt-5.3.1

   # 新建用户配置文件
   $ gedit cmake/ConfigUser.cmake

向 ``cmake/ConfigUser.cmake`` 文件中加入如下语句::

    set (CMAKE_INSTALL_PREFIX "/opt/GMT-5.3.1")
    set (GMT_INSTALL_MODULE_LINKS FALSE)
    set (COPY_GSHHG TRUE)
    set (COPY_DCW TRUE)
    set (GMT_USE_THREADS TRUE)

- ``CMAKE_INSTALL_PREFIX`` 设置GMT的安装路径，可以修改为其他路径。对于没有 root 权限的用户，可以将安装路径设置为 ``/home/xxx/software/GMT-5.3.1`` 等有可读写权限的路径；
- ``GMT_INSTALL_MODULE_LINKS`` 为FALSE，表明不在GMT的bin目录下建立命令的软链接，也可设置为TRUE
- ``COPY_GSHHG`` 为TRUE会将GSHHG数据复制到 ``GMT/share/coast`` 下
- ``COPY_DCW`` 为TRUE会将DCW数据复制到 ``GMT/share/dcw`` 下
- ``GMT_USE_THREADS`` 表示是否开启某些模块的并行功能

继续执行如下命令以检查GMT的依赖关系::

    $ mkdir build
    $ cd build/
    $ cmake ..

``cmake ..`` 会检查GMT对软件的依赖关系，我的检查结果如下::

    *  Options:
    *  Found GSHHG database       : /home/user/GMT/gmt-5.3.1/share/gshhg (2.3.6)
    *  Found DCW-GMT database     : /home/user/GMT/gmt-5.3.1/share/dcw-gmt
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
    *  Installing GMT in          : /opt/GMT-5.3.1
    *  GMT_DATADIR                : /opt/GMT-5.3.1/share
    *  GMT_DOCDIR                 : /opt/GMT-5.3.1/share/doc
    *  GMT_MANDIR                 : /opt/GMT-5.3.1/share/man
    -- Configuring done
    -- Generating done

正常情况下的检查结果应该与上面给出的类似。若出现问题，则需要检查之前的步骤是否有误，检查完毕后重新执行 ``cmake ..`` ，直到出现类似的检查结果。检查完毕后，开始编译和安装::

    $ make
    $ sudo make install

修改环境变量
~~~~~~~~~~~~

修改环境变量并使其生效：

.. code-block:: bash

   $ echo 'export GMT5HOME=/opt/GMT-5.3.1' >> ~/.bashrc
   $ echo 'export PATH=${GMT5HOME}/bin:$PATH' >> ~/.bashrc
   $ echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT5HOME}/lib64' >> ~/.bashrc
   $ exec $SHELL -l

测试是否安装成功
~~~~~~~~~~~~~~~~

在终端键入 ``gmt`` ，若出现如下输出，则安装成功::

    $ gmt --version
    5.3.1

Windows
-------

GMT为Windows用户提供了安装包，可以直接安装使用。Windows下需要安装GMT、ghostscript和gsview。

1. 下载

   到社区主页的 `下载页面 <http://gmt-china.org/download/>`_ 下载所需要的安装包。

2. 安装GMT

   直接双击安装包即可安装，直接点击下一步，使用默认的选项即可，无须做任何修改。在“选择组件”页面，建议将四个选项都勾选上，然后点击下一步安装完成。

   安装完成后，“开始”->“所有程序”->“附件”->“命令提示符”以启动cmd。在cmd窗口中执行::

       C:\Users\xxxx> gmt --version
       5.3.1

   即表示安装成功。

2. 安装ghostscript

   安装的过程没什么可说的，在最后一步，记得勾选“Generate cidfmap for Windows CJK TrueType fonts”。

3. 安装gsview

   双击直接安装即可。

Mac OS
------

Mac OS下GMT的安装方法有很多，可以直接使用安装包，也可以使用各种软件管理工具。推荐使用 `Homebre <http://brew.sh/>`_ 。

1. 使用homebrew安装::

    brew update && brew upgrade
    brew install gmt

2. 直接使用GMT提供的安装包

   到社区主页的 `下载页面 <http://gmt-china.org/download/>`_ 下载安装包。

   安装完成后，在桌面会出现GMT的图标。点击该图标会启动一个终端，在终端内执行::

       echo ${PATH%%:*}

   并将输出的目录添加到 ``~/.bashrc`` 中::

       echo 'PATH=${PATH}:/path/to/gmt' >> ~/.bashrc

3. 使用macports安装::

    sudo port install gdal +curl +geos +hdf5 +netcdf +fftw3 +openmp
    sudo port install gmt5

4. 使用fink安装::

    sudo fink install gmt5
