Ubuntu/Debian 下安装 GMT
========================

:贡献者: |田冬冬|

----

.. note::

   由于 Ubuntu 和 Debian 自身的软件更新规则，官方软件源提供的通常都是老版本 GMT，
   比如 GMT 5.4.5 或者 GMT 6.0.0，而不是 GMT 的最新版本。

   针对这种情况，有如下几种选择：

   #. 使用老版本 GMT
   #. :doc:`conda` 【推荐】
   #. :doc:`build-source-unix` 【推荐】

通过如下命令，可以安装 Ubuntu/Debian 官方源提供的 GMT 二进制包。

1.  更新软件包列表::

        $ sudo apt update

2.  安装 GMT::

        $ sudo apt install gmt gmt-dcw gmt-gshhg

3.  安装 GMT 相关工具

    生成 PDF、JPG 等图片格式需要 `Ghostscript <https://www.ghostscript.com/>`__\ （**必须**）::

        $ sudo apt install ghostscript

    地理空间数据格式转换工具 `GDAL <https://gdal.org/>`__\ （**必须**，未安装则无法使用高精度地形数据）::

        $ sudo apt install gdal-bin

    制作 GIF 格式的动画需要 `GraphicsMagick <http://www.graphicsmagick.org/>`__\ （**可选**）::

        $ sudo apt install graphicsmagick

    制作 MP4、WebM 格式的动画需要 `FFmpeg <https://ffmpeg.org/>`__\ （**可选**）::

        $ sudo apt install ffmpeg
