环境变量
========

**GMT_SHAREDIR**
    指定GMT的share目录的位置。若该变量为空，则GMT会使用默认值 ``${GMTHOME}/share`` 。

**GMT_DATADIR**
    用于指定用户自己的数据文件的放置目录。当在命令中给定文件名时，GMT首先会在当前
    目录寻找该文件。若找不到，则会到环境变量 ``$GMT_DATADIR`` 所指定的目录中寻找。

    对于一些常用的数据文件，可以放在特定的目录中，并将任意一个环境变量指向该目录，
    则在命令中使用该文件时只需要指定文件名而不必给出完整路径。多个目录之间用逗号
    分隔。

    Linux和macOS下以 ``/`` 结尾的目录会被递归搜索，而Windows暂不支持这一功能。

**GMT_USERDIR**
    用于指定用户自定义的配置文件的放置目录。比如 ``gmt.conf`` 、自定义的符号、CPT、
    数学宏、网格文件自定义后缀 ``gmt.io`` 等。

    若 **GMT_USERDIR** 未定义，则使用默认值 ``${HOME}/.gmt``\ 。

**GMT_TMPDIR**
    GMT写临时文件 ``gmt.history`` 和 ``gmt.conf`` 的路径。若未指定，则默认写到当前目录。

**GMT_CACHEDIR**
    用户缓存GMT从其服务器上下载的数据。若未指定，则默认下载到 ``${HOME}/.gmt/cache`` 下。
    可以使用 ``gmt clear cache`` 清空缓存目录。
