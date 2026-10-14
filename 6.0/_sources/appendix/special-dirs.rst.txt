目录参数
========

有一些环境变量以及GMT配置参数，可以用于指定某些特殊用途的目录。这些环境变量和
配置参数包括：

- ``$GMT_SHAREDIR`` GMT的share目录所在位置，通常不用设置，GMT会自动猜测其所在位置
- ``$GMT_DATADIR`` 或 :term:`DIR_DATA` 可以指向一个或多个目录，用于放置
  用户常用的数据文件。目录之间用逗号分隔。任何以斜杠 ``/`` 结尾的目录会被递归搜索
  （Windows不支持此功能）。若二者同时有值，以 :term:`DIR_DATA`
  的值优先
- ``$GMT_CACHEDIR`` 或 :term:`DIR_CACHE` 用于放置GMT模块从GMT服务器上
  下载的临时数据
- ``$GMT_USERDIR`` 用户放置自定义配置文件的地方，比如用户自定义的 :file:`gmt.conf`
  文件、自定义符号、CPT文件、数学宏、网格文件后缀文件等。若该变量未定义，则默认值为
  :file:`${HOME}/.gmt` 。
- ``$GMT_TMPDIR`` 临时文件（比如 :file:`gmt.history` 和 :file:`gmt.conf` ）放置的
  目录。若未设置，则默认为当前目录
- :term:`DIR_DCW` DCW数据放置的目录
- :term:`DIR_GSHHG` 海岸线数据放置的目录

当命令行中有文件需要读入时，GMT不仅仅会在当前目录下寻找文件，还会到这些特殊
变量中寻找。GMT会\ **依次**\ 到下列目录中寻找文件：

#. 当前目录
#. GMT参数 :term:`DIR_DATA` 所定义的目录
#. GMT参数 :term:`DIR_CACHE` 所定义的目录
#. 环境变量 ``$GMT_USERDIR`` 所定义的目录
#. 环境变量 ``$GMT_CACHEDIR`` 所定义的目录
#. 环境变量 ``$GMT_DATADIR`` 所定义的目录
