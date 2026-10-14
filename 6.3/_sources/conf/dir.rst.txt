DIR参数
=======
   
可以使用 :doc:`/module/gmtset` 设定一些专用的目录位置，如数据文件和程序设置的目录。
这时，我们只需指定文件名，GMT 会自动去这些目录中找同名文件。下面列出所有与目录相关的配置参数：

.. glossary::

    **DIR_CACHE**
        指定从 GMT 服务器下载的临时文件（以 **@** 开头，如 :file:`@hotspots.txt`）的缓存目录。
   
        也可用环境变量 **$GMT_CACHEDIR** 指定。若同时设置了 **DIR_CACHE** 和 **$GMT_CACHEDIR**，
        则 GMT 只会使用 **DIR_CACHE** 指定的目录。若该配置参数和环境变量均未定义，
        则默认缓存目录为 :file:`~/.gmt/cache`。

        可以使用 ``gmt clear cache`` 命令清空缓存目录。

    **DIR_DATA**
        指定一个或多个存放常用数据文件的数据目录。
        
        也可用环境变量 **$GMT_DATADIR** 指定。若同时设置了 **DIR_DATA** 和 **$GMT_DATADIR**，
        则 GMT 只会使用 **DIR_DATA** 指定的目录。若该配置参数和环境变量均未定义，则数据目录默认为空。
 
        多个目录之间用逗号分隔；以斜杠 :kbd:`/` 结尾的目录都会被递归搜索（Windows 不支持此功能）。
 
    **DIR_DCW**
        :doc:`DCW 数据 </dataset/dcw/index>` 所在目录。该数据的默认目录为 **$GMT_SHAREDIR**\ /dcw 目录。

    **DIR_GSHHG**
        :doc:`GSHHG 数据 </dataset/gshhg>` 所在目录。该数据的默认目录为 **$GMT_SHAREDIR**\ /coast 目录。

可以参考\ :doc:`/basis/input-files`\ 了解搜索目录的顺序以及相关环境变量的定义。
