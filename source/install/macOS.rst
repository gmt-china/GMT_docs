macOS 下安装 GMT
================

macOS 下可以直接使用 GMT 提供的安装包，也可以使用 Homebrew 或 Macports 软件管理
工具进行安装。\ **推荐使用Homebrew**\ 。

使用 Homebrew 安装
------------------

`Homebrew <https://brew.sh/>`__ 是 macOS 下的第三方软件包管理工具。
未安装 Homebrew 的用户，可以参考
《\ `macOS 配置指南 <https://seismo-learn.org/seismology101/computer/macos-setup/#homebrew>`__\ 》了解如何安装与使用。

1.  安装 GMT

    更新软件包的描述文件、Homebrew，并且更新所有软件包::

        $ brew update && brew upgrade

    安装最新的 GMT 稳定版本::

        $ brew install gmt

    也可以安装 GMT 开发版本（即源码的 master 分支）::

        $ brew install gmt --HEAD

2.  安装 GMT 依赖的其它软件

    安装必须软件包::

        $ brew install ghostscript


    制作 GIF 格式的动画需要 `GraphicsMagick <http://www.graphicsmagick.org/>`__\ （可选）::

        $ brew install graphicsmagick

    制作 MP4、WebM 格式的动画需要 `FFmpeg <https://ffmpeg.org/>`__\ （可选）::

        $ brew install ffmpeg

3.  测试安装


    重新打开一个终端，键入如下命令，若正确显示 GMT 版本号，则表示安装成功::

        $ gmt --version
        6.2.0

4.  升级 GMT

    GMT 新版本发布后，执行如下命令升级 GMT::

        $ brew upgrade gmt

5.  卸载 GMT


    可以执行如下命令卸载 GMT::

        $ brew uninstall gmt

使用 GMT 安装包
---------------

GMT 为 macOS 用户提供了 dmg 安装包，其不仅包含了 GMT，还包含了运行 GMT 所需的
Ghostscript、GDAL、GraphicsMagick 和 FFmpeg，可以直接双击安装使用。

.. note::

    GMT 的 DMG 安装包只支持 macOS >= 10.14。

1. 下载：\ `gmt-6.2.0-darwin-x86_64.dmg (Intel) <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.2.0-darwin-x86_64.dmg>`__ |
   `gmt-6.2.0-darwin-arm64.dmg (ARM) <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.2.0-darwin-arm64.dmg>`__

2. 双击 dmg 包，在弹出的 Finder 窗口中，将 :file:`GMT-6.2.0.app` 拖动到 :file:`Applications` 目录

3. 在 Finder 中的 :file`Applications 目录下，找到 GMT 图标以双击启动。
   GMT会启动一个终端并显示欢迎信息。根据欢迎信息中的
   提示将如下语句添加到 :file:`~/.bash_profile` 中以修改环境变量::

       export GMTHOME=/Applications/GMT-6.2.0.app/Contents/Resources
       export PATH=${GMTHOME}/bin:${PATH}
       export PROJ_LIB=$GMTHOME/share/proj
       export MAGICK_CONFIGURE_PATH=$GMTHOME/lib/GraphicsMagick/config
       export GS_LIB=${GMTHOME}/share/ghostscript/9.53.3/Resource/Init

   .. note::

      以上内容仅供参考，请务必根据 GMT 欢迎信息中的提示修改环境变量。

4. 打开一个终端，输入如下命令，检测安装是否成功::

       $ gmt --version
       6.2.0

5.  卸载 GMT

    若想要卸载GMT，可直接到 **/Applications** 目录下找到 GMT，直接删除即可。

6.  升级 GMT

    GMT 包不支持自动升级，因而要先删除旧 GMT 包，再下载新版安装包并按照上面的
    步骤重新安装，即实现升级 GMT。

使用 Macports 安装
------------------

`Macports <https://www.macports.org/>`__ 是 macOS 下的第三方软件包管理工具。

1.  安装 GMT::

        $ sudo port install gdal +hdf5 +netcdf +openjpeg
        $ sudo port install gmt6

2.  GMT 会安装在 :file:`/opt/local/lib/gmt6/` 目录下，需要将其 :file:`bin` 目录添加至
    环境变量 **PATH** 中::

        $ echo 'export PATH=/opt/local/lib/gmt6/bin:$PATH' >> ~/.zshrc

3.  安装 GMT 依赖的其他软件::

        $ sudo port install graphicsmagick ffmpeg

4.  重新打开一个终端，检测安装是否成功::

        $ gmt --version
        6.2.0

5.  升级 GMT。当有新版本发布时，可以执行如下命令升级 GMT::

        $ sudo port selfupdate
        $ sudo port upgrade gmt6

6.  如果需要卸载 GMT，可以执行如下命令::

        $ sudo port uninstall gmt6
