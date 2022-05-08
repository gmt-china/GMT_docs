通过 conda 安装 GMT
===================

:贡献者: |田冬冬|

----

`conda <https://conda.io/>`__ 是由 `Anaconda <https://www.anaconda.com/>`__
提供的一个跨平台软件包管理器。conda 的 `conda-forge <https://conda-forge.org/>`__
频道提供了 GMT 安装包。使用 conda 安装 GMT 的优点有：跨平台、安装简单、版本切换方便等。

Anaconda 用户可以直接通过以下命令安装、升级以及卸载 GMT。
未安装 Anaconda 的用户可以参考《`Anaconda 简易教程 <https://seismo-learn.org/software/anaconda/>`__》
安装 Anaconda。

Anaconda 的 base 环境下默认安装了数百个软件包，其中部分软件包与 GMT 存在冲突，
导致 base 环境下 GMT 会出现运行报错的问题。Anaconda 用户必须新建并激活一个新环境安装使用 GMT。

我们推荐用户使用只提供了必须依赖包的 miniconda，以节省硬盘空间并且避免 base 环境下的 GMT 运行问题。

安装 GMT
--------

1.  安装 GMT

    安装最新的 GMT 稳定版本::

        $ conda install gmt -c conda-forge

    也可以安装 GMT 开发版本（该开发版本会每隔几周更新一次）::

        $ conda install gmt -c conda-forge/label/dev

2.  测试安装

    ::

        $ gmt --version
        6.3.0

升级 GMT
--------

GMT 新版本发布后，执行如下命令升级 GMT::

    $ conda update gmt

卸载 GMT
--------

执行如下命令可以卸载 GMT::

    $ conda remove gmt
