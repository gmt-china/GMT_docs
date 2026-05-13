Fedora 下安装 GMT
=================

:贡献者: |田冬冬|

----

Fedora 34、Fedora 35、Fedora 36 和 Fedora rawhide 用户，可以启用
`GMT 官方 RPM 仓库 <https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/>`__
以安装 GMT 最新版本。

.. note::

    Fedora 官方源提供了 GMT 二进制包，但通常其版本比较老，不建议安装使用。
    如果已经安装了 Fedora 官方源提供的 GMT 软件包，则必须先使用以下命令卸载，
    然后再使用 GMT 官方仓库提供的 GMT 安装包::

        $ sudo dnf remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high

安装 GMT
--------

1.  启用 GMT 官方 RPM 仓库::

        $ sudo dnf copr enable genericmappingtools/gmt

2.  安装最新版 GMT::

        $ sudo dnf install gmt

3.  安装 GMT 相关工具以增强 GMT 功能

    地理空间数据格式转换工具 `GDAL <https://gdal.org/>`__\ （**必须**，未安装则无法使用高精度地形数据）::

        $ sudo dnf install gdal

    制作 GIF 格式的动画需要 `GraphicsMagick <http://www.graphicsmagick.org/>`__\ （**可选**）::

        $ sudo dnf install GraphicsMagick

    制作 MP4、WebM 格式的动画需要 `FFmpeg <https://ffmpeg.org/>`__\ （**可选**）::

        $ sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm
        $ sudo dnf install ffmpeg

升级 GMT
--------

GMT 新版本发布后，执行如下命令升级 GMT::

    $ sudo dnf update gmt

卸载 GMT
--------

可以执行如下命令卸载 GMT::

    $ sudo dnf remove gmt dcw-gmt gshhg-gmt
