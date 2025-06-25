macOS 下安装 GMT
================

macOS 下可以直接使用 GMT 提供的安装包，也可以使用 Homebrew 或 Macports 软件管理
工具进行安装。\ **推荐使用Homebrew**\ 。

使用 Homebrew 安装
------------------

`Homebrew <https://brew.sh/>`__ 是 macOS 下的第三方软件包管理工具。
未安装 Homebrew 的用户，可以访问其 `官网 <https://brew.sh/index_zh-cn>`_
以了解如何安装与使用。

1.  安装 GMT::

       $ brew update && brew upgrade
       $ brew install gmt

    也可以使用如下命令安装GMT的最新开发版（即源码的master分支）::

       $ brew install gmt --HEAD

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

5.  如果需要卸载GMT，可以执行如下命令::

        brew uninstall gmt

使用 GMT 安装包
---------------

GMT 为 macOS 用户提供了 dmg 安装包，其不仅包含了GMT，还包含了运行GMT所需的
Ghostscript、GDAL、GraphicsMagick和FFmpeg，可以直接双击安装使用。

.. note::

    GMT的dmg安装包只支持 macOS >= 10.12。

1. 下载：\ `gmt-6.0.0-darwin-x86_64.dmg <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.0.0-darwin-x86_64.dmg>`_

2. 双击 dmg 包，在弹出的Finder窗口中，将 **GMT-6.0.0.app** 拖动到 Applications 目录

3. 在Finder中的Applications目录下，找到GMT图标以双击启动。
   GMT会启动一个终端并显示欢迎信息。根据欢迎信息中的
   提示将如下语句添加到 :file:`~/.bash_profile` 中以修改PATH环境变量::

       export GMTHOME=/Applications/GMT-6.0.0.app/Contents/Resources
       export PATH=${GMTHOME}/bin:${PATH}
       export PROJ_LIB=$GMTHOME/share/proj6
       export MAGICK_CONFIGURE_PATH=$GMTHOME/lib/GraphicsMagick-1.3.33/config

   .. note::

      以上内容仅供参考，请务必根据GMT欢迎信息中的提示修改环境变量。

4. 打开一个终端，输入如下命令，检测安装是否成功::

       $ gmt --version
       6.0.0

5.  卸载GMT

    若想要卸载GMT，可直接到 **/Applications** 目录下找到 GMT，直接删除即可。

6.  升级GMT

    GMT包不支持自动升级，因而要先删除旧GMT包，再下载新版安装包并按照上面的
    步骤重新安装，即实现升级GMT。

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

5.  如果需要卸载GMT，可以执行如下命令::

        $ sudo port uninstall gmt6

使用 Fink 安装
--------------

`Fink <http://www.finkproject.org/>`_ 是 macOS 下的第三方软件包管理工具。

1.  安装GMT::

        sudo fink install gmt6

2.  安装依赖包::

        sudo fink install graphicsmagick ffmpeg
