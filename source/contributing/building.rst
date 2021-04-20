构建网站
========

本文档使用 `Sphinx <http://www.sphinx-doc.org/>`__ 构建得到。Sphinx 是基于 Python 的
文档生成工具。如果想要在本地构建文档，则需要安装 Sphinx，否则可以跳过这一节。

1.  安装 `Anaconda <https://seismo-learn.org/software/anaconda/>`__
    （用于科学计算的 Python 发行版）

2.  下载文档源码::

        $ git clone --depth=100 https://github.com/gmt-china/GMT_docs.git

3.  安装文档所需依赖::

        $ cd GMT_docs/
        $ pip install -r requirements.txt

4.  编译生成 HTML 格式的文档

    ::

        $ make html

    生成的文档位于 ``build/html/`` 目录下。

    - Linux 用户可以执行 ``firefox build/html/index.html`` 查看网页
    - macOS 用户可以执行 ``open build/html/index.html`` 查看网页

5.  编译生成PDF文档

    如果想要生成PDF格式的文档，则需要安装TeXLive。

    - Linux 用户：参考 http://blog.seisman.info/texlive-install
    - macOS 用户：直接执行 ``brew cask install mactex-no-gui`` 安装 mactex

    安装完成后执行::

        $ make latexpdf

    生成的的PDF位于 ``build/latex/GMT_docs.pdf``
