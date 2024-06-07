Ubuntu/Debian 下安装 GMT
========================

:撰写: |田冬冬|
:最近更新日期: 2023-09-12

----

Ubuntu/Debian 官方源提供了 GMT 二进制包，可直接使用 ``apt`` 安装，
但官方源提供的可能不是 GMT 最新版本。针对这种情况，有如下几种选择：

#. 使用老版本 GMT
#. :doc:`conda` [**推荐**]
#. :doc:`build-source-unix` [**推荐**]


Ubuntu 23.04 和 Debian 12 官方源中提供了 GMT 6.4.0，可直接通过如下命令安装 GMT。

1.  更新软件包列表::

        $ sudo apt update

2.  安装 GMT::

        $ sudo apt install gmt gmt-dcw gmt-gshhg

3.  安装 GMT 相关工具

    生成 PDF、JPG 等图片格式需要 `Ghostscript <https://www.ghostscript.com/>`__ [**必须**]::

        $ sudo apt install ghostscript

    自动打开生成的图片需要 ``xdg-utils``::

        $ sudo apt install xdg-utils

    地理空间数据格式转换工具 `GDAL <https://gdal.org/>`__ [**必须**]::

        $ sudo apt install gdal-bin

    制作 GIF 格式的动画需要 `GraphicsMagick <http://www.graphicsmagick.org/>`__ [**可选**]::

        $ sudo apt install graphicsmagick

    制作 MP4、WebM 格式的动画需要 `FFmpeg <https://ffmpeg.org/>`__ [**可选**]::

        $ sudo apt install ffmpeg
