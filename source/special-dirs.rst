特殊目录
========

GMT定义了一些环境变量和GMT参数，用于指定某些特殊用途的目录。这些环境变量和参数包括：

- ``$GMT_SHAREDIR`` GMT的share目录所在位置，通常不用设置，GMT会自动猜测其所在位置
- ``$GMT_DATADIR`` 或 :ref:`DIR_DATA <DIR_DATA>` 可以指向一个或多个目录，常用户放置常用的数据文件。目录之间用冒号分隔（Windows下用分号分隔）。任何以斜杠 ``/`` 结尾的目录会被递归搜索（Windows下不会）。若二者同时有值，以 :ref:`DIR_DATA <DIR_DATA>` 的值优先
- ``$GMT_USERDIR`` 用户放置自定义配置文件的地方，比如用户自定义的 ``gmt.conf`` 文件、自定义符号、CPT文件、数学宏、网格文件后缀文件等。若该变量未定义，则默认值为 ``${HOME}/.gmt`` 。
- ``$GMT_TMPDIR`` 临时文件（比如 ``gmt.history`` 和 ``gmt.conf`` ）放置的目录。若未设置，则默认为当前目录
- :ref:`DIR_DCW <DIR_DCW>` DCW数据放置的目录
- :ref:`DIR_GSHHG <DIR_GSHHG>` 海岸线数据放置的目录

当命令行中有文件需要读入时，GMT不仅仅会在当前目录下寻找文件，还会到这些特殊变量中寻找。GMT会\ **依次**\ 到下列目录中寻找文件：

#. 当前目录
#. GMT参数 :ref:`DIR_DATA <DIR_DATA>` 所定义的目录
#. 环境变量 ``$GMT_DATADIR`` 所定义的目录
#. 环境变量 ``$GMT_USERDIR`` 所定义的目录
