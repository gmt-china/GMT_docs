输入文件的搜索目录
==================

GMT 命令行经常需要读入文件。如果指定了文件的完整路径，GMT 会直接读入。
否则，GMT 会\ **依次**\ 到下列目录中寻找文件，直到找到文件为止：

#. 当前目录
#. GMT 参数 :term:`DIR_DATA`
#. GMT 参数 :term:`DIR_CACHE`
#. 环境变量 **$GMT_USERDIR** 所定义的目录
#. 环境变量 **$GMT_CACHEDIR** 所定义的目录
#. 环境变量 **$GMT_DATADIR** 所定义的目录

以上 GMT 配置参数或环境变量用于指定某些特殊用途的目录，具体用途如下：

.. glossary::

    **$GMT_SHAREDIR**
        GMT 的 :file:`share` 目录。若未设置[默认]，GMT 自动猜测其所在位置（如 :file:`${GMTHOME}/share`\ ）。
        通常，此环境变量不需设置，且推荐仅在特殊需求时设置。

    **$GMT_DATADIR** 或 :term:`DIR_DATA`
        指向一个或多个存放常用数据文件的目录。多个目录之间用逗号分隔。
        以斜杠 :kbd:`/` 结尾的目录都会被递归搜索（Windows 不支持此功能）。

        配置参数 :term:`DIR_DATA` 的值优先于且会覆盖环境变量 **$GMT_DATADIR** 的值。

    **$GMT_USERDIR**
        用户自定义配置文件的存放目录。例如，用户自定义的 :file:`gmt.conf` 文件、
        自定义符号、CPT 文件、数学宏、网格文件后缀文件等。
        若该变量未定义，则默认值为 **${HOME}**/.gmt。

    **$GMT_CACHEDIR**
        存放从 GMT 服务器上下载的临时数据的缓存目录。
        若该变量未定义，则默认为 :file:`${HOME}/.gmt/cache`\ 。
        可以使用 ``gmt clear cache`` 命令清空缓存目录。

    **$GMT_TMPDIR**
        GMT 状态参数文件（如 :file:`gmt.history` 和 :file:`gmt.conf` ）的存放目录。
        若未设置，则默认为会话目录。

    :term:`DIR_DCW`
        :doc:`DCW数据 </dataset/dcw/index>` 所在目录。

    :term:`DIR_GSHHG`
        :doc:`GSHHG 数据 </dataset/gshhg>` 所在目录。
        若该参数为空，则默认为 **$GMT_SHAREDIR**\ /coast 目录。
