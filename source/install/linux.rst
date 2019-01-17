Linux 下安装GMT
===============

解决依赖关系
------------

GMT 在运行时依赖 fftw（>=3.3）、glib2（>=2.32）、netCDF（>4.0且支持netCDF-4/HDF5）、
ghostscript等。GMT在安装时主要依赖GCC编译器和 cmake（>=2.8.5）。
因而，需要先安装GMT所依赖的软件包。

.. warning::

   由于 Linux 发行版众多，不同发行版下软件包的名称不同。
   因而，以下仅所列仅供参考，其他用户应自行根据关键词到
   https://pkgs.org 上确认自己使用的发行版上软件包的
   具体名字。

对于Ubuntu/Debian::

    # 更新
    $ sudo apt-get update

    # 安装编译所需软件包
    $ sudo apt-get install gcc g++ cmake make libc6

    # 安装运行所需软件包
    $ sudo apt-get install ghostscript
    $ sudo apt-get install libnetcdf-dev
    $ sudo apt-get install libgdal-dev python-gdal
    $ sudo apt-get install liblapack3
    $ sudo apt-get install libglib2.0-dev
    $ sudo apt-get install libpcre3-dev
    $ sudo apt-get install libfftw3-dev

对于CentOS/RHEL/Fedora::

    # CentOS用户必须先安装epel-release, RHEL/Fedora用户无需安装
    $ sudo yum install epel-release

    # 安装编译所需软件包
    $ sudo yum install gcc gcc-c++ cmake make glibc

    # 安装运行所需软件包
    $ sudo yum install ghostscript
    $ sudo yum install netcdf-devel
    $ sudo yum install gdal-devel gdal-python
    $ sudo yum install lapack64-devel lapack-devel
    $ sudo yum install glib2-devel
    $ sudo yum install pcre-devel
    $ sudo yum install fftw-devel

安装完依赖包后，需要进一步确认 netCDF 是否支持 netCDF-4/HDF5 格式::

    $ nc-config --has-nc4
    yes

若输出为 ``yes`` 则表示安装的 netCDF 支持 netCDF-4/HDF5 格式，则可继续安装 GMT，
否则无法安装 GMT。

下载
----

Linux下安装GMT需要下载如下三个文件（这里提供中科大提供的国内下载镜像）：

#. GMT源码： https://github.com/GenericMappingTools/gmt/archive/master.tar.gz
#. 全球海岸线数据GSHHG： http://mirrors.ustc.edu.cn/gmt/gshhg-gmt-2.3.7.tar.gz
#. 全球数字图表DCW： http://mirrors.ustc.edu.cn/gmt/dcw-gmt-1.1.4.tar.gz

.. note::

    由于 GMT 6.0.0 尚未发布，此处下载的是 GMT 开发版的源代码。

安装GMT
-------

将下载的三个压缩文件放在同一个目录里，按照如下步骤进行安装：

.. code-block:: bash

   # 解压三个压缩文件
   $ tar -xvf gmt-master.tar.gz
   $ mv gmt-master/ gmt-6.0.0/
   $ tar -xvf gshhg-gmt-2.3.7.tar.gz
   $ tar -xvf dcw-gmt-1.1.4.tar.gz

   # 将gshhg和dcw数据复制到gmt的share目录下
   $ mv gshhg-gmt-2.3.7 gmt-6.0.0/share/gshhg
   $ mv dcw-gmt-1.1.4 gmt-6.0.0/share/dcw-gmt

   # 切换到gmt源码目录下
   $ cd gmt-6.0.0

   # 新建用户配置文件
   $ gedit cmake/ConfigUser.cmake

向 ``cmake/ConfigUser.cmake`` 文件中加入如下语句::

    set (CMAKE_INSTALL_PREFIX "/opt/GMT-6.0.0")
    set (COPY_GSHHG TRUE)
    set (COPY_DCW TRUE)
    set (GMT_INSTALL_MODULE_LINKS FALSE)
    set (GMT_DATA_URL "http://mirrors.ustc.edu.cn/gmt/data/")
    set (GMT_USE_THREADS TRUE)

其中，

- ``CMAKE_INSTALL_PREFIX`` 用于设置GMT的安装路径，上面的语句会将GMT安装在
  ``/opt/GMT-6.0.0`` 目录下，用户可以自行修改为其他路径。没有 root 权限的
  一般用户，可以将安装路径设置为 ``/home/xxx/software/GMT-6.0.0`` 等有可读写
  权限的路径；
- ``COPY_GSHHG`` 和 ``COPY_DCW`` 设置为 TRUE 会将相关数据复制到 GMT 的 share 目录下
- ``GMT_INSTALL_MODULE_LINKS`` 为 ``FALSE``\ ，表明不在GMT的bin目录下建立命令的
  软链接，不建议设置为 ``TRUE`` （可选）
- ``GMT_DATA_URL`` 设置从中科大镜像下载GMT数据，以加快数据下载速度（可选）
- ``GMT_USE_THREADS`` 表示是否开启某些模块的并行功能（可选）

.. warning::

   CentOS 6 用户需要将用户配置文件的最后一行改为 ``set (GMT_USE_THREADS FALSE)``

.. tip::

   此处为了便于一般用户理解，只向 ``cmake/ConfigUser.cmake`` 中写入了必要的语句。

   高级用户可以直接在 GMT 提供的模板配置文件的基础上进行更多配置。
   将 ``cmake/ConfigUserTemplate.cmake`` 复制为 ``cmake/ConfigUser.cmake``\ ，
   然后根据配置文件中的大量注释说明信息自行修改配置文件。

继续执行如下命令以检查GMT的依赖是否满足::

    # 注意，此处新建的 build 文件夹位于 gmt-6.0.0 目录下，不是 gmt-6.0.0/cmake 目录下
    $ mkdir build
    $ cd build/
    $ cmake ..

``cmake ..`` 会检查GMT对软件的依赖关系，我的检查结果如下::

    *  Options:
    *  Found GSHHG database       : /home/user/GMT/gmt-6.0.0/share/gshhg (2.3.7)
    *  Found DCW-GMT database     : /home/user/GMT/gmt-6.0.0/share/dcw-gmt
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
    *  Installing GMT in          : /opt/GMT-6.0.0
    *  GMT_DATADIR                : /opt/GMT-6.0.0/share
    *  GMT_DOCDIR                 : /opt/GMT-6.0.0/share/doc
    *  GMT_MANDIR                 : /opt/GMT-6.0.0/share/man
    -- Configuring done
    -- Generating done

正常情况下的检查结果应该与上面给出的类似。若出现问题，则需要检查之前的步骤是否
有误，检查完成后删除原build目录再新建build，继续执行 ``cmake ..``\ ，
直到出现类似的检查结果。

.. warn::

    Anaconda用户请注意！由于Anaconda中也安装了FFTW、GDAL、netCDF等库文件，
    GMT在配置过程中通常会找到Anaconda提供的库文件，进而导致配置、编译或执行
    过程中出错。

    解决办法是，在 `~/.bashrc` 中将 Anaconda 相关的环境变量注释掉，以保证GMT
    在配置和编译过程中找到的不是 Anaconda 提供的库文件。待GMT安装完成后，再
    将 Anaconda 相关环境变量改回即可。

检查完毕后，开始编译和安装::

    $ make -j
    $ sudo make -j install

.. note::

   ``-j`` 选项可以实现并行编译以减少编译时间。但并行编译可能在个别发行版上
   无法使用。

修改环境变量
------------

向 ``~/.bashrc`` 中加入如下语句以修改环境变量，并重启终端使其生效::

    export GMT6HOME=/opt/GMT-6.0.0
    export PATH=${GMT6HOME}/bin:$PATH
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT6HOME}/lib64

说明：

- 第一个命令添加了环境变量 ``GMT6HOME``
- 第二个命令修改 GMT6 的 bin 目录加入到 ``PATH`` 中，使得终端可以找到GMT命令
- 第三个命令将 GMT6 的 lib 目录加入到动态链接库路径中。
  通常，32位系统的路径为 ``lib``\ ，64位系统的路径为 ``lib64``

测试是否安装成功
----------------

打开终端，键入如下命令，若正确显示GMT版本号，则表示安装成功::

    $ gmt --version
    6.0.0
