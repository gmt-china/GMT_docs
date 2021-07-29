Ubuntu/Debian 下安装 GMT
========================

.. note::

   由于 Ubuntu 和 Debian 自身的软件更新规则，官方软件源提供的通常都是老版本 GMT，
   比如 GMT 5.4.5 或者 GMT 6.0.0，而不是 GMT 的最新版本。

   针对这种情况，有如下几种选择：

   #. 使用老版本 GMT
   #. :doc:`conda` 【推荐】
   #. :doc:`build-source` 【推荐】

通过如下命令，可以安装 Ubuntu/Debian 官方源提供的 GMT 二进制包。

1.  更新软件包列表::

        $ sudo apt update

2.  安装 GMT 及必须的依赖软件::

        $ sudo apt install gmt gmt-dcw gmt-gshhg
        $ sudo apt install ghostscript

3.  安装 GMT 相关工具以增强 GMT 功能::

        $ sudo apt install gdal-bin graphicsmagick ffmpeg

