macOS 下安装 GMT
================

macOS 下 GMT 的安装方法有很多，可以直接使用安装包，也可以使用各种软件管理工具。

.. note::

    由于GMT6.0.0尚未正式发布，因而只能通过编译源码的方式在 macOS 上安装。

    建议用 homebrew 安装软件。

    首先下载GMT6的formula：https://gitlab.com/snippets/1749251/raw?inline=false

    下载完成后执行如下命令：

    brew unlink gmt # 删除 gmt5
    brew install --HEAD gmt6.rb # 安装 gmt6

.. note::

    由于GMT 6.0.0尚未发布，请忽略以下内容。

使用 homebrew 安装
------------------

`Homebrew <http://brew.sh/>`_ 是 macOS 下的第三方软件包管理工具。

1.  安装 Homebrew::

       $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

2.  安装 GMT::

       $ brew update && brew upgrade
       $ brew install gmt

3.  安装 ghostscript::

       $ brew install ghostscript

4.  测试安装是否成功::

       $ gmt --version
       6.0.0

如果想同时安装 GMT4 和 GMT5，还需要执行以下步骤::

       # 安装 GMT4
       $ brew install gmt4

       # 删除 GMT5 带的软链接
       $ cd /usr/local/opt/gmt@5/bin/
       $ find . -size -4c -delete       # 删除所有文件大小小于4字节的软链接

然后向 ``~/.bashrc`` 中写入如下语句以修改环境变量::

    export GMT4HOME=/usr/local/opt/gmt@4'
    export PATH=${GMT4HOME}/bin:$PATH
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT4HOME}/lib64'

使用 GMT 安装包
---------------

GMT 为 macOS 用户提供了 dmg 安装包。

1. 到 `下载页面 <http://gmt.soest.hawaii.edu/projects/gmt/wiki/Download>`_ 下载最新版本的 dmg 安装包。

2. 双击 dmg 包以解压，将解压得到的 ``GMT-6.0.0.app`` 拖动到 Applications 目录即可。

3. GMT 默认会安装到 ``/Applications/GMT-6.0.0.app/`` 目录下，将如下语句::

       export PATH=${PATH}:/Applications/GMT-6.0.0.app/Contents/Resources/bin

   加入到 ``~/.bashrc`` 中即可。

4. 测试安装是否成功::

       $ gmt --version
       6.0.0
