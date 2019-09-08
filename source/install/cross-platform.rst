跨平台GMT安装方案
=================

跨平台安装方案是指，以下安装方式同时适用于Linux、macOS和Windows。

通过 conda 安装
---------------

`conda <https://conda.io/>`_ 是由 `Anaconda <https://www.anaconda.com/>`_ 提供的
一个跨平台软件包管理器。conda的conda-forge频道中提供了GMT 6.0.0rc4。

如果你是 conda 用户，则可以直接通过如下命令安装。

安装GMT 6.0.0rc4::

    conda install gmt=6.0.0rc4 -c conda-forge/label/dev -c conda-forge

安装FFmpeg::

    conda install ffmpeg -c conda-forge

安装完成后，在终端执行如下命令以验证::

    $ gmt --version
    6.0.0rc4
