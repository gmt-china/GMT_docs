构建网站
========

本文档使用基于 Python 的文档生成工具 `Sphinx <http://www.sphinx-doc.org/>`__ 构建得到。
读者可以按照如下步骤在自己的计算机上构建网站。

1.  安装 `Anaconda <https://seismo-learn.org/software/anaconda/>`__
    （用于科学计算的 Python 发行版）

2.  下载文档源码

    ::

        # 假设将源码下载到 ~/Downloads/ 目录下，切换至该目录
        $ cd ~/Downloads/

        # 克隆源码
        $ git clone --depth=100 https://github.com/gmt-china/GMT_docs.git

3.  安装 Sphinx 等文档所需依赖

    ::

        # 进入下载的源码目录
        $ cd ~/Downloads/GMT_docs/

        # 安装依赖
        $ pip install -r requirements.txt

4.  编译生成 HTML 格式的文档

    执行以下命令即可编译生成 HTML 格式的文档。生成的文档位于 :file:`build/html/` 目录下，
    直接用浏览器打开 :file:`build/html/index.html` 即可在本地预览。

    ::

        $ make html

6.  编译生成 PDF 格式的文档

    编译 PDF 文档需要先安装 TeXLive：

    - Linux 用户：参考 http://blog.seisman.info/texlive-install
    - macOS 用户：直接执行 ``brew cask install mactex-no-gui`` 安装 mactex

    安装好 TeXLive 后，执行以下命令即可编译生成 PDF 格式的文档，即 :file:`build/latex/GMT_docs.pdf`\ ::

        $ make latexpdf
