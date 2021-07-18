Linux 下安装 GMT
================

尽管大多数 Linux 发行版都提供了 GMT 二进制包，可以直接通过软件包管理器 **apt**
或 **yum** 安装，但发行版提供的 GMT 版本都很老，不建议使用。

针对 Fedora/RHEL/CentOS 用户，GMT 的官方 RPM 仓库提供了最新版本的 GMT。

Fedora
------

**Fedora 33** 及之后版本的用户，可以启用
`GMT 官方 RPM 仓库 <https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/>`__
以安装 GMT 最新版本::

    # 启用 GMT 官方 RPM 仓库
    $ sudo dnf copr enable genericmappingtools/gmt

    # 安装最新版 GMT
    $ sudo dnf install gmt

    # 当有新版本发布时可直接更新
    $ sudo dnf update gmt

    # 地理数据格式转换工具
    $ sudo dnf install gdal

除此之外，还可以安装如下可选包以使用 GMT 的更多功能::

    # 制作 GIF 格式动画需要 GraphicsMagick
    $ sudo dnf install GraphicsMagick

    # 制作 MP4、WebM 格式动画需要 ffmpeg
    $ sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm
    $ sudo dnf install ffmpeg

.. note::

    如果你已经安装了 Fedora 系统仓库提供的 GMT 软件包，你必须在使用 GMT 官方仓库
    前卸载旧的 GMT 安装包。使用如下命令::

        $ sudo dnf remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high

RHEL/CentOS
-----------

**RHEL/CentOS 7/8** 用户可以启用
`GMT 官方 RPM 仓库 <https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/>`__
以安装 GMT 最新版本。

安装方式如下::

    # 安装 epel-release
    $ sudo yum install epel-release

    # 启用 PowerTools 仓库 (仅限于 RHEL/CentOS 8 用户)
    $ sudo yum config-manager --set-enabled powertools

    # 启用 GMT 官方仓库 (仅限于 RHEL/CentOS 7/8 用户)
    $ sudo yum install yum-plugin-copr
    $ sudo yum copr enable genericmappingtools/gmt

    # 安装最新版 GMT
    $ sudo yum install gmt

    # 当有新版本发布时可直接更新
    $ sudo yum update gmt

    # 地理数据格式转换工具
    $ sudo yum install gdal

除此之外，还可以安装如下可选包以使用 GMT 的更多功能::

    # 制作 GIF 格式动画需要 GraphicsMagick
    $ sudo yum install GraphicsMagick

    # 制作 MP4、WebM 格式动画需要 ffmpeg
    $ sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-`rpm -E %rhel`.noarch.rpm
    $ sudo yum install ffmpeg

.. note::

    如果你已经安装了 EPEL 仓库提供的 GMT 软件包，你必须在使用 GMT 官方仓库
    前卸载旧的 GMT 安装包。使用如下命令::

        $ sudo yum remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high

Ubuntu/Debian 用户
------------------

Ubuntu 和 Debian 用户可以直接使用如下命令安装 GMT::

    $ sudo apt install gmt gmt-dcw gmt-gshhg
    $ sudo apt install ghostscript gdal-bin graphicsmagick ffmpeg

.. warning::

   由于 Ubuntu 和 Debian 自身的软件更新规则，通常以上命令安装的都是老版本的 GMT，
   比如 GMT 5.4 或者 GMT 6.0.0，而不是 GMT 的最新版本。

   针对这种情况，有如下几种选择：

   #. 使用老版本 GMT
   #. 使用其它 Linux 发行版
   #. 编译 GMT 源码以安装最新版，具体编译方法见 :doc:`build-source`

ArchLinux 用户
--------------

ArchLinux 用户请参考 https://github.com/GenericMappingTools/gmt/wiki/Install-latest-GMT-on-ArchLinux
