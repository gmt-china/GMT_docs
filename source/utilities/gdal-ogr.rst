GDAL/OGR
========

`GDAL <https://gdal.org/>`__\（\ **G**\ eospatial \ **D**\ ata \ **A**\ bstraction \ **L**\ ibrary）
是光栅（raster）和矢量（vector）地理空间数据格式的转换库/工具，
支持多种光栅或矢量地理空间数据格式的互相转换和处理。

简介
----

历史上，GDAL 仅用于处理光栅地理空间数据，而 OGR 则仅用于处理矢量地理空间数据。
自 GDAL 2.0 开始，二者集成在一起了，一般统称为 GDAL 或 GDAL/OGR。
因此，GDAL 现在具备了处理光栅和矢量地理空间数据格式的能力。

.. note::

    若无显式说明，本手册提到 GDAL 和 GDAL/OGR 时，表示同一个意思；
    提到 OGR 时，仅表示地理空间矢量数据格式。

GDAL/OGR 有两个核心部分：

- GDAL 部分：支持多种光栅地理空间数据格式的互相转换，
  如常见的 netCDF、GeoTiff、HDF5、XYZ 等，
  详见\ `光栅格式列表 <http://www.gdal.org/formats_list.html>`__
- OGR 部分：支持多种矢量数据格式的互相转换，
  如常见的 OGR/GMT（即 GMT）、Shapefile 、KML、MapInfo、Excel 等，
  详见\ `矢量格式列表 <https://gdal.org/drivers/vector/index.html>`__

安装
----

Windows
^^^^^^^

Windows 用户可以通过安装 `OSGeo4W <https://trac.osgeo.org/osgeo4w/>`__
来使用其提供的 GDAL，安装及使用方式如下：

1.  下载 OSGeo4W 安装包

    到 OSGeo4W 官网下载\ `安装包 <http://download.osgeo.org/osgeo4w/x86/>`__\ ：
    :file:`osgeo4w-setup-x86.exe`\ （32 位）或 :file:`osgeo4w-setup-x86_64.exe`\ （64 位）

2.  安装 OSGeo4W

    按照如下步骤安装：

    - 双击安装包
    - 选择“Express Desktop Install”
    - 选择下载地址
    - 只勾选 GDAL
    - 等待下载安装完成
    - 安装完成后，桌面上会生成一个 :file:`OSGeo4W` 文件夹

    .. note::

       有经验的用户也可以选择“Advanced Install”以自定义安装。

3.  测试安装

    双击 :file:`OSGeo4W` 文件夹内的快捷链接即可打开一个命令行窗口，
    然后在命令行窗口中输入 ``ogr2ogr --version``\ ，若出现版本号则表示安装成功。

4.  修改环境变量

    如果只是偶尔使用，建议按照如上方式运行；
    如果需要经常使用，建议将 :file:`C:\\OSGeo4W64\\bin` 添加到环境变量 **PATH** 中。

如果由于某些原因无法使用 OSGeo4W，也可以使用 `MapServer for Windows（MS4W） <http://www.ms4w.com/>`__
或 `GISInternals <http://www.gisinternals.com/>`__ 等软件包，他们也附带了 GDAL 工具。

Linux
^^^^^

Fedora 用户::

    $ sudo dnf install gdal

RHEL/CentOS 用户::

    $ sudo yum install gdal

Ubuntu/Debian 用户::

    $ sudo apt install gdal-bin

.. note::

    由于 Linux 发行版众多，使用其他发行版的用户请到 https://pkgs.org 自行搜索 GDAL 的安装方法。

macOS
^^^^^

建议 macOS 用户使用 `Homebrew <https://brew.sh/>`__ 安装::

    $ brew install gdal

macOS 下的非 Homebrew 用户可以到 `William Kyngesburye <http://www.kyngchaos.com/software/frameworks>`__
的网站下载 dmg 安装包。

跨平台安装
^^^^^^^^^^

跨平台安装是指同时适用于 Linux、macOS 以及 Windows 的安装方式。

`conda <https://conda.io/>`_ 是由 `Anaconda <https://www.anaconda.com/>`__
提供的一个跨平台软件包管理器。conda 的 `conda-forge <https://conda-forge.org/>`_
通道提供了 GDAL 安装包。使用 conda 安装 GDAL 的优点有：跨平台、安装简单、版本切换方便等。

Anaconda 用户可以直接通过以下命令安装、升级以及卸载 GDAL。
可以参考 `Anaconda 简易教程 <https://seismo-learn.org/software/anaconda/>`__ 安装 Anaconda。

.. rubric:: 安装 GDAL

1.  安装 GDAL::

        $ conda install gdal -c conda-forge

2.  测试安装::

        $ ogr2ogr --version
        GDAL 3.3.0, released 2021/04/26

3.  升级 GDAL::

        $ conda update gdal

4.  卸载 GDAL::

        $ conda remove gdal

.. _gdal_ogr2ogr:

ogr2ogr
-------

GDAL 提供的 ``ogr2ogr`` 命令可以实现这几十种地理矢量数据格式之间的互相转换。
因而，可以用其将任意地理矢量数据格式转换为 GMT 可识别的 OGR/GMT 格式，以供 GMT 直接使用。
该命令的详细用法请参考 `ogr2ogr 官方文档 <https://gdal.org/programs/ogr2ogr.html#ogr2ogr>`__\ ，
这里仅介绍该命令的基本用法：

::

    ogr2ogr -f GMT 输出数据文件名 输入数据文件名

例如，将 Shapefile 格式的数据文件 :file:`gadm36_USA_0.shp` 转换为 GMT 可识别的 OGR/GMT 格式，
输出文件名为 :file:`gadm36_USA_0.gmt`\ ：

::

    ogr2ogr -f GMT gadm36_USA_0.gmt gadm36_USA_0.shp
