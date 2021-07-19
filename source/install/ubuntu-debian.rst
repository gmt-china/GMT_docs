Ubuntu/Debian
=============

Ubuntu 和 Debian 用户可以直接使用如下命令安装 GMT::

    $ sudo apt install gmt gmt-dcw gmt-gshhg
    $ sudo apt install ghostscript gdal-bin graphicsmagick ffmpeg

.. warning::

   由于 Ubuntu 和 Debian 自身的软件更新规则，通常以上命令安装的都是老版本的 GMT，
   比如 GMT 5.4 或者 GMT 6.0.0，而不是 GMT 的最新版本。

   针对这种情况，有如下几种选择：

   #. 使用老版本 GMT
   #. 使用其它 Linux 发行版
   #. 编译 GMT 源码以安装最新版，具体编译方法见 :doc:`build-source`
