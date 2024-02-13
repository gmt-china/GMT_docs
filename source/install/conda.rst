使用 conda 安装 GMT
===================

:撰写: |田冬冬|, |姚家园|, |陈箫翰|
:最近更新日期: 2023-09-11

----

`conda <https://docs.conda.io/en/latest/>`__ 是一个跨平台的包管理、环境管理工具。
`conda-forge <https://conda-forge.org/>`__ 频道提供了 GMT 安装包，可以使用 conda 安装.

安装 conda
----------

Anaconda 或 Miniconda 中自带了 conda 工具。
未安装 Anaconda/Miniconda 的用户可以参考《`Anaconda 简易教程 <https://seismo-learn.org/software/anaconda/>`__》
安装 Anaconda/Miniconda。

Anaconda 的 base 环境下默认安装了数百个软件包，其中部分软件包与 GMT 存在冲突，
导致 base 环境下 GMT 无法正常安装，因而，Anaconda 用户必须新建并激活一个新环境安装使用 GMT。

推荐用户使用 Miniconda，可以避免 GMT 包与已有安装包冲突的问题，也更节省硬盘空间。

安装 GMT
--------

1.  安装 GMT

    安装最新的 GMT 稳定版本::

        $ conda install gmt -c conda-forge

    也可以安装 GMT 开发版本（该开发版本会每隔几周更新一次）::

        $ conda install gmt -c conda-forge/label/dev

    制作 GIF 格式的动画需要 `GraphicsMagick <http://www.graphicsmagick.org/>`__\ （**可选**）::

        $ conda install graphicsmagick -c conda-forge

    制作 MP4、WebM 格式的动画需要 `FFmpeg <https://ffmpeg.org/>`__\ （**可选**）::

        $ conda install ffmpeg -c conda-forge

2.  测试安装

    ::

        $ gmt --version
        6.5.0

升级 GMT
--------

GMT 新版本发布后，执行如下命令升级 GMT::

    $ conda update gmt

卸载 GMT
--------

执行如下命令可以卸载 GMT::

    $ conda remove gmt
