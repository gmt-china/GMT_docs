跨平台安装 GMT
==============

跨平台安装方案是指，以下安装方式同时适用于Linux、macOS和Windows。

通过 conda 安装
---------------

`conda <https://conda.io/>`_ 是由 `Anaconda <https://www.anaconda.com/>`_ 提供的
一个跨平台软件包管理器。conda的 `conda-forge <https://conda-forge.org/>`_
通道提供了最新的GMT。

如果你是 Anaconda 用户，则可以直接通过如下命令安装。

1.  安装GMT::

        conda install gmt -c conda-forge

2.  安装完成后，在终端执行如下命令以验证::

        $ gmt --version
        6.1.1

3.  升级GMT。当有新版本发布时，可以执行如下命令升级GMT::

        conda update gmt

4.  如果需要卸载GMT，可以执行如下命令::

        conda remove gmt
