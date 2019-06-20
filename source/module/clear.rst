.. index:: ! clear

clear
=====

:官方文档: :doc:`gmt:clear`
:简介: 删除当前的历史文件、配置文件、CPT文件、缓存、数据目录、会话目录

语法
----

::

    gmt clear [all | cache | conf | cpt | data | history | sessions ]

可选选项
--------

``all``
    删除所有项目，包括历史文件、配置文件、CPT、缓存文件、数据目录和会话目录

``conf``
    删除现代模式下的当前 gmt.conf 配置文件

``cpt``
    删除现代模式下的当前及隐藏CPT文件

``cache``
    删除GMT缓存目录

``data``
    删除GMT数据下载目录及其内容

``history``
    删除现代模式下的当前历史文件 ``gmt.history``

``sessions``
    删除用户的会话目录

示例
----

完全清空GMT缓存目录::

    gmt clear cache
