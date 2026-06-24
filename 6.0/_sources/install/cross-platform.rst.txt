跨平台GMT安装方案
=================

跨平台安装方案是指，以下安装方式同时适用于Linux、macOS和Windows。

通过 conda 安装
---------------

`conda <https://conda.io/>`_ 是由 `Anaconda <https://www.anaconda.com/>`_ 提供的
一个跨平台软件包管理器。conda的 `conda-forge <https://conda-forge.org/>`_
通道提供了最新的GMT。

如果你是 Anaconda 用户，则可以直接通过如下命令安装。

安装GMT 6.0.0::

    conda install gmt -c conda-forge

注意：由于conda-forge没有提供Windows下的GraphicsMagick，因而Windows用户还需
自行下载并安装 GraphicsmMagick 才能制作GIF格式的动画。

安装完成后，在终端执行如下命令以验证::

    $ gmt --version
    6.0.0
