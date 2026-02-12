DIR参数
=======
   
可以使用 :doc:`/module/gmtset` 设定一些专用的目录位置，如数据文件和程序设置的目录。
这时，我们只需指定文件名，GMT 会自动去这些目录中找同名文件。
其中一些目录也可以使用环境变量（\ **$GMT_SHAREDIR**\ 、\ **$GMT_DATADIR**\ 、\ 
**$GMT_USERDIR** 和 **$GMT_TMPDIR**\ ）进行设置。
GMT 配置文件 :file:`gmt.conf` 中的参数设置优先于环境变量，推荐用户使用配置文件进行配置。
下面列出所有与目录相关的参数，参数的默认值在中括号内列出。

.. glossary::

    **DIR_CACHE**
        从 GMT 服务器下载的临时文件（以 **@** 开头，如 :file:`@hotspots.txt`\ ）的存储目录 [:file:`~/.gmt/cache`]

    **DIR_DATA**
        数据文件的存放目录，默认值为空。覆盖环境变量 **$GMT_DATADIR** 的值。

        GMT 在命令中遇到文件名时，首先在当前目录下寻找该文件。
        若找不到，则会到参数 **DIR_DATA** 指定的目录中寻找。
        若依然找不到，则到环境变量 **$GMT_DATADIR** 指定的目录中寻找。

    **DIR_DCW**
        :doc:`DCW数据 </dataset/dcw/index>` 所在路径，默认值为空。GMT 会自动猜测合理的路径值。

    **DIR_GSHHG**
        :doc:`GSHHG 数据 </dataset/gshhg>` 所在路径。若该参数为空，则路径默认为 **$GMT_SHAREDIR**\ /coast 目录。
