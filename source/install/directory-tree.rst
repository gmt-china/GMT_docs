目录结构
========

安装好GMT之后，可以看看GMT安装路径下的目录结构，看看GMT究竟安装了哪些东西。

本文用 ``$GMTHOME`` 表示GMT的安装路径，在Linux下一般是 :file:`/usr/local/GMT5`
或 :file:`/opt/GMT5` ，在Windows下一般是 ``C:\programs\gmt5`` 。

``$GMTHOME`` 中包含了GMT的全部文件。下面列出了 ``$GMTHOME`` 的目录树，并对其中
重要的文件及目录做简单解释。以下内容以Linux系统为准，Windows系统有微小差异::

    .
    |-- bin
    |-- include
    |-- lib64
    `-- share

``bin`` 目录
------------

``bin`` 目录下包含如下文件::


    bin
    |-- gmt                         # GMT主程序
    |-- isogmt                      # GMT主程序（隔离模式）
    |-- gmt-config                  # GMT安装信息获取工具
    |-- gmt_shell_functions.sh      # bash辅助脚本（仅使用于Linux/macOS）
    |-- gmtswitch                   # GMT版本切换工具
    |-- gmt.m                       # GMT/MATLAB工具包（仅限于Windows）
    `-- *.dll                       # 动态库文件（仅限于Windows）

几点注意事项：

#. bin目录下除了上面提到的文件之外，可能还有很多类似 ``psxy`` 、 ``grdimage``
   这样的文件，其本质上是指向二进制文件 ``gmt`` 的软链接。这些软链接的目的
   是为了部分兼容GMT4的语法，所以这些软链接都可以手动删除；
#. bin目录下需要使用的只有 ``gmt`` ，即 ``gmt`` 可以认为是GMT5中唯一的一个命令。

``include`` 目录
----------------

``inlcude`` 目录下有 ``gmt`` 子目录， ``gmt`` 子目录中包含了GMT的头文件::

    include
    `-- gmt

仅当自己写程序调用GMT函数库时才需要使用这些头文件，因而一般用户不需要关注。

``lib`` 目录
------------

32位系统下目录名为 ``lib`` ，64位系统下目录名为 ``lib64`` 或 ``lib`` ，以下统称
为 ``lib`` 目录。 ``lib`` 目录下包含了GMT的动态库文件::

    lib
    |-- gmt
    |   `-- plugins
    |       `-- supplements.so          # GMT扩展函数库
    |-- libgmt.so                       # GMT主函数库
    `-- libpostscriptlight.so           # PSL绘图函数库

仅当自己写代码调用GMT函数库时才需要使用，因而一般用户不需要关注。

``share`` 目录
--------------

share目录中包含了GMT运行所需的众多辅助文件::

    share
    |-- VERSION                     # GMT版本号
    |-- coast                       # 含海岸线数据
    |-- cpt                         # 含全局CPT文件
    |-- custom                      # 包含GMT自定义符号的def文件
    |   `-- gmt_custom_symbols.conf     # 用户自定义符号的配置文件
    |-- dbase                       # 含grdraster命令所使用的数据库（默认无数据）
    |   `-- grdraster.info              # grdraster命令的配置文件
    |-- dcw                         # 含国界、省界数据
    |-- doc                         # 官方文档
    |   |-- examples                    # 官方示例
    |   |-- html                        # 官方文档网页版
    |   |-- pdf                         # 官方文档PDF版
    |   |-- supplements                 # 补充包的说明文档
    |   `-- tutorial                    # GMT教程中所使用的数据
    |-- localization                # 不同语言的时间定义
    |-- man                         # man格式文档
    |-- postscriptlight             # PS所需要的文件
    |   |-- PSL_custom_media.conf   # 用户自定义的纸张大小
    |   `-- PSL_custom_fonts.txt    # 用户自定义的PS字体
    |-- spotter                     # 板块运动相关数据
    |-- tools                       # GMT辅助工具
    |-- mgd77                       # mgd77辅助文件
    |-- mgg                         # mgg辅助文件
    `-- x2sys                       # x2sys辅助文件
