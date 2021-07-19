Fedora
======

Fedora 官方源提供了 GMT 二进制包，但通常其版本比较老，不建议安装使用。

Fedora 33、34、rawhide 用户，可以启用
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

还可以安装如下可选包以使用 GMT 的更多功能::

    # 制作 GIF 格式动画需要 GraphicsMagick
    $ sudo dnf install GraphicsMagick

    # 制作 MP4、WebM 格式动画需要 ffmpeg
    $ sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm
    $ sudo dnf install ffmpeg

.. note::

    如果你已经安装了 Fedora 官方源提供的 GMT 软件包，你必须在使用 GMT 官方 RPM 仓库
    前卸载旧的 GMT 安装包。使用如下命令::

        $ sudo dnf remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high
