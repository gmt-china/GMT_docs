CentOS/RHEL 下安装 GMT
======================

CentOS/RHEL 的 EPEL 源提供了 GMT 二进制包，但通常其版本比较老，不建议安装使用。

CentOS/REHL 7、8 和 CentOS Stream 用户，可以启用
`GMT 官方 RPM 仓库 <https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/>`__
以安装 GMT 最新版本::

    # 安装 epel-release
    $ sudo yum install epel-release

    # 启用 PowerTools 仓库（仅限于 RHEL/CentOS 8 用户）
    $ sudo yum config-manager --set-enabled powertools

    # 启用 GMT 官方 RPM 仓库
    $ sudo yum install yum-plugin-copr
    $ sudo yum copr enable genericmappingtools/gmt

    # 安装最新版 GMT
    $ sudo yum install gmt

    # 当有新版本发布时可直接更新
    $ sudo yum update gmt

    # 地理数据格式转换工具
    $ sudo yum install gdal

还可以安装如下可选包以使用 GMT 的更多功能::

    # 制作 GIF 格式动画需要 GraphicsMagick
    $ sudo yum install GraphicsMagick

    # 制作 MP4、WebM 格式动画需要 ffmpeg
    $ sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-`rpm -E %rhel`.noarch.rpm
    $ sudo yum install ffmpeg

.. note::

    如果已经安装了 EPEL 源提供的 GMT 软件包，则必须在使用 GMT 官方仓库前卸载旧的 GMT 安装包::

        $ sudo yum remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high
