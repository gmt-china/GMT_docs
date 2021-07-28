Ubuntu/Debian 下安装 GMT
========================

Ubuntu 和 Debian 的官方源提供了 GMT 二进制包，可以直接使用如下命令安装 GMT。

1.  更新软件包列表::

        $ sudo apt update

2.  安装 GMT 及必须的依赖软件::

        $ sudo apt install gmt gmt-dcw gmt-gshhg
        $ sudo apt install ghostscript

3.  安装 GMT 相关工具以增强 GMT 功能::

        $ sudo apt install gdal-bin graphicsmagick ffmpeg

由于 Ubuntu 和 Debian 自身的软件更新规则，通常以上命令安装的都是老版本的 GMT，
比如 GMT 5.4 或者 GMT 6.0.0，而不是 GMT 的最新版本。

针对这种情况，有如下几种选择：

#. 使用老版本 GMT
#. :doc:`conda` 【推荐】
#. :doc:`build-source` 【推荐】
