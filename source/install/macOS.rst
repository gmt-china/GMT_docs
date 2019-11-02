macOS 下安装 GMT
================

macOS 下可以直接使用 GMT 提供的安装包，也可以使用 Homebrew 或 Macports 软件管理
工具进行安装。

使用 GMT 安装包
---------------

GMT 为 macOS 用户提供了 dmg 安装包，可以直接双击安装使用。

1. 下载：\ `gmt-6.0.0-darwin-x86_64.dmg <ftp://ftp.soest.hawaii.edu/gmt/bin/gmt-6.0.0-darwin-x86_64.dmg>`_

2. 双击 dmg 包，在弹出的Finder窗口中，将 **GMT-6.0.0.app** 拖动到 Applications 目录

3. 将如下语句添加到 :file:`~/.bashrc` 中以修改PATH环境变量::

       export GMTHOME=/Applications/GMT-6.0.0.app/Contents/Resources
       export PATH=${GMTHOME}/bin:${PATH}
       export PROJ_LIB=$GMTHOME/share/proj6
       export MAGICK_CONFIGURE_PATH=$GMTHOME/lib/GraphicsMagick-1.3.33/config

4. 打开一个终端，输入如下命令，检测安装是否成功::

       $ gmt --version
       6.0.0

5.  卸载GMT

    若想要卸载GMT，可直接到 ``/Application`` 目录下找到 GMT，直接删除即可。

6.  升级GMT

    GMT包不支持自动升级，因而要先删除旧GMT包，再下载新版安装包并按照上面的
    步骤重新安装，即实现升级GMT。

使用 Homebrew 安装
------------------

`Homebrew <https://brew.sh/>`__ 是 macOS 下的第三方软件包管理工具。

1.  安装 GMT::

       $ brew update && brew upgrade
       $ brew install gmt

2.  安装GMT依赖的其它软件::

       # 必须软件包
       $ brew install ghostscript

       # 安装生成动画所需要的软件包（可选）
       $ brew install graphicsmagick ffmpeg

3.  重新打开一个终端，检测安装是否成功::

       $ gmt --version
       6.0.0

4.  升级GMT。当有新版本发布时，可以执行如下命令升级GMT::

        brew upgrade gmt

5.  卸载GMT。执行如下命令即可卸载GMT::

        brew uninstall gmt

使用 Macports 安装
------------------

`Macports <https://www.macports.org/>`_ 是 macOS 下的第三方软件包管理工具。

1.  安装GMT::

        $ sudo port install gdal +hdf5 +netcdf +openjpeg
        $ sudo port install gmt6

2.  安装GMT依赖的其他软件::

        $ sudo port install graphicsmagick ffmpeg

3.  重新打开一个终端，检测安装是否成功::

        $ gmt --version
        6.0.0

4.  升级GMT。当有新版本发布时，可以执行如下命令升级GMT::

        $ sudo port selfupdate
        $ sudo port upgrade gmt6

5.  卸载GMT。执行如下命令即可卸载GMT::

        $ sudo port uninstall gmt6
