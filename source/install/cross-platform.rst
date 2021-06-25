跨平台安装 GMT
==============

跨平台安装是指同时适用于 Linux、macOS 以及 Windows 的安装方式。

通过 conda 安装
---------------

`conda <https://conda.io/>`_ 是由 `Anaconda <https://www.anaconda.com/>`__
提供的一个跨平台软件包管理器。conda的 `conda-forge <https://conda-forge.org/>`_
通道提供了最新的 GMT。

如果你是 Anaconda 用户（可以参考
`Anaconda 简易教程 <https://seismo-learn.org/software/anaconda/>`__ 安装 Anaconda），
则可以直接通过如下命令安装：

安装 GMT
^^^^^^^^^

1.  安装 GMT

    安装最新的 GMT 稳定版本::

        $ conda install gmt -c conda-forge

    安装 GMT 开发版本::

        $ conda install gmt -c conda-forge/label/dev

2.  测试安装（以 GMT 稳定版本为例）\ ::

        $ gmt --version
        6.2.0

升级 GMT
^^^^^^^^^

GMT 新版本发布后，执行如下命令升级 GMT::

    $ conda update gmt

卸载 GMT
^^^^^^^^^

可以执行如下命令卸载 GMT::

    $ conda remove gmt
