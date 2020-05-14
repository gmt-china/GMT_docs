Linux 下安装 GMT
================

尽管大多数Linux发行版都提供了GMT二进制包，可以直接通过软件包管理器 **apt-get**
或 **yum** 安装，但发行版提供的GMT版本都很老，不建议使用。

针对Fedora/RHEL/CentOS用户，GMT的官方RPM仓库提供了最新版本的GMT。

Fedora
------

**Fedora 30** 及之后版本的用户，可以启用
`GMT官方RPM仓库 <https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/>`__
以安装GMT最新版本::

    # 启用GMT官方RPM仓库
    dnf copr enable genericmappingtools/gmt

    # 安装最新版GMT
    dnf install gmt

    # 当有新版本发布时可直接更新
    dnf update gmt

除此之外，还可以安装如下可选包以使用GMT的更多功能::

    # 地理数据格式转换工具
    dnf install gdal

    # 制作GIF格式动画需要GraphicsMagick
    dnf install GraphicsMagick

    # 制作MP4、WebM格式动画需要ffmpeg
    dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm
    dnf install ffmpeg

.. note::

    如果你已经安装了Fedora系统仓库提供的GMT软件包，你必须在使用GMT官方仓库
    前卸载旧的GMT安装包。使用如下命令::

        dnf remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high

RHEL/CentOS
-----------

**RHEL/CentOS 6/7/8** 用户可以启用
`GMT官方RPM仓库 <https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/>`__
以安装GMT最新版本。

安装方式如下::

    # 安装 epel-release
    yum install epel-release

    # 启用 PowerTools 仓库 (仅限于 RHEL/CentOS 8 用户)
    yum config-manager --set-enabled PowerTools

    # 启用GMT官方仓库 (仅限于RHEL/CentOS 7/8 用户)
    yum install yum-plugin-copr
    yum copr enable genericmappingtools/gmt

    # 启用GMT官方仓库 (仅限于RHEL/CentOS 6 用户)
    wget https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/repo/epel-6/genericmappingtools-gmt-epel-6.repo -O /etc/yum.repos.d/genericmappingtools-gmt-epel-6.repo

    # 安装最新版GMT
    yum install gmt

    # 当有新版本发布时可直接更新
    yum update gmt

除此之外，还可以安装如下可选包以使用GMT的更多功能::

    # 地理数据格式转换工具
    yum install gdal

    # 制作GIF格式动画需要GraphicsMagick
    yum install GraphicsMagick

    # 制作MP4、WebM格式动画需要ffmpeg
    yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-`rpm -E %rhel`.noarch.rpm
    yum install ffmpeg

.. note::

    如果你已经安装了EPEL仓库提供的GMT软件包，你必须在使用GMT官方仓库
    前卸载旧的GMT安装包。使用如下命令::

        yum remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high

Ubuntu/Debian用户
-----------------

Ubuntu 20.04 (Focal Fossa) 和 Debian 11 (测试版）用户可以直接使用如下命令安装GMT::

    sudo apt-get install gmt gmt-dcw gmt-gshhg
    sudo apt-get install ghostscript gdal-bin graphicsmagick ffmpeg

.. warning::

   以上命令在老版本的Ubuntu/Debian上会安装GMT 5.x。

   对于老版本Ubuntu/Debian用户，有如下几种选择：

   #. 使用 GMT 5.x
   #. 升级系统到Ubuntu 20.04 或 Debian 11
   #. 编译GMT源码以安装最新版，具体编译方法见 :doc:`build-source`

ArchLinux用户
-------------

ArchLinux用户可以使用AUR提供的非官方源，使用方法为::

    # 完整更新系统包
    sudo pacman -Syu

    # 安装构建AUR包所需要的工具
    sudo pacman -S base-devel

    # 下载 AUR 提供的 gmt 构建代码
    git clone https://aur.archlinux.org/gmt.git

    # 下载 AUR 提供的其它 gmt 相关包
    git clone https://aur.archlinux.org/gmt-coast.git
    git clone https://aur.archlinux.org/gmt-cpt-city.git
    git clone https://aur.archlinux.org/gmt-dcw.git

    # 使用 makepkg 构建并使用 pacman 安装 gmt
    cd gmt
    makepkg -sc
    sudo pacman -U *.pkg.tar.xz

注意：\ `ArchlinuxCN repo <https://www.archlinuxcn.org/archlinux-cn-repo-and-mirror>`_
尚未提供GMT的二进制包。
