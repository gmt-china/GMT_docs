CentOS 下安装 GMT
=================

:贡献者: |田冬冬|

----

CentOS 7、CentOS 8 以及 CentOS Stream 用户，可以启用
`GMT 官方 RPM 仓库 <https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/>`__
以安装 GMT 最新版本。

.. note::

    CentOS 的 EPEL 源提供了 GMT 二进制包，但通常其版本比较老，不建议安装使用。
    如果已经安装了 EPEL 源提供的 GMT 软件包，则必须先使用以下命令卸载，
    然后再使用 GMT 官方仓库提供的 GMT 安装包::

        $ sudo yum remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high

安装 GMT
--------

1.  安装并启用 EPEL 源::

        $ sudo yum install epel-release

2.  CentOS 8 和 CentOS Stream 用户需要启用 powertools 源::

        $ sudo yum config-manager --set-enabled powertools

3.  启用 GMT 官方 RPM 仓库::

        $ sudo yum install yum-plugin-copr
        $ sudo yum copr enable genericmappingtools/gmt

4.  安装最新版 GMT::

        $ sudo yum install gmt

5.  安装 GMT 相关工具以增强 GMT 功能

    地理空间数据格式转换工具 `GDAL <https://gdal.org/>`__\ （**必须**，未安装则无法使用高精度地形数据）::

        $ sudo yum install gdal

    制作 GIF 格式的动画需要 `GraphicsMagick <http://www.graphicsmagick.org/>`__\ （**可选**）::

        $ sudo yum install GraphicsMagick

    制作 MP4、WebM 格式的动画需要 `FFmpeg <https://ffmpeg.org/>`__\ （**可选**）::

        $ sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-`rpm -E %rhel`.noarch.rpm
        $ sudo yum install ffmpeg

升级 GMT
--------

GMT 新版本发布后，执行如下命令升级 GMT::

    $ sudo yum update gmt

卸载 GMT
--------

可以执行如下命令卸载 GMT::

    $ sudo yum remove gmt dcw-gmt gshhg-gmt
