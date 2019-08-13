macOS 下安装 GMT
================

macOS 下可以直接使用 GMT 提供的安装包安装，也可以使用 Homebrew 软件管理工具进行安装。

使用 GMT 安装包
---------------

GMT 为 macOS 用户提供了 dmg 安装包，可以直接双击安装使用。

1. 下载：\ `gmt-6.0.0rc3-darwin-x86_64.dmg <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.0.0rc3-darwin-x86_64.dmg>`_

2. 双击 dmg 包，在弹出的窗口中，将 ``GMT-6.0.0rc3.app`` 拖动到 Applications 目录

3. GMT 默认会安装到 ``/Applications/GMT-6.0.0rc3.app/`` 目录下。为了能够在任意终端使用GMT。
   需要将如下语句::

       export PATH=${PATH}:/Applications/GMT-6.0.0rc3.app/Contents/Resources/bin

   添加到 ``~/.bashrc`` 中。

4. 重新打开一个终端，输入如下命令，检测安装是否成功::

       $ gmt --version
       6.0.0rc3

5. 使用Homebrew安装GMT依赖的其它软件::

       # 必须软件包
       $ brew install ghostscript

       # 可选软件包
       $ brew install gdal

       # 安装生成动画所需要的软件包（可选）
       $ brew install graphicsmagick ffmpeg

使用 homebrew 安装
------------------

.. note::

    homebrew 尚未将GMT更新到6.0.0rc3，故而目前无法使用homebrew安装GMT6。

`Homebrew <https://brew.sh/>`_ 是 macOS 下的第三方软件包管理工具。

1.  安装 GMT::

       $ brew update && brew upgrade
       $ brew install gmt

2.  安装GMT依赖的其它软件::

       # 必须软件包
       $ brew install ghostscript

       # 可选软件包
       $ brew install gdal

       # 安装生成动画所需要的软件包（可选）
       $ brew install graphicsmagick ffmpeg

3.  重新打开一个终端，检测安装是否成功::

       $ gmt --version
       6.0.0
