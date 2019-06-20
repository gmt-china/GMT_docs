.. index:: ! gmt

gmt
===

:官方文档: :doc:`gmt:gmt`
:说明: GMT的主程序

GMT的所有功能通过如下语法调用::

    gmt <module> <module-options>

其中，\ ``<module>`` 是GMT模块名，\ ``<module-options>`` 是模块所支持的选项。

比如，想要调用GMT的 :doc:`/module/basemap` 模块::

    gmt basemap -JX10c/10c -R0/20/0/5 -Bafg -png test

除此之外，还有一些其他选项可以使用：

- ``gmt --help``\ ：列出GMT提供的所有模块名及其功能
- ``gmt --version``\ ：显示GMT版本
- ``gmt --show-bindir``\ ：显示GMT的bin目录
- ``gmt --show-datadir``\ ：显示GMT的数据目录，默认为空
- ``gmt --show-sharedir``\ ：显示GMT的share目录
- ``gmt --show-plugindir``\ ：显示GMT的插件目录
- ``gmt --show-modules``\ ：列出GMT的所有模块名
- ``gmt --show-cores``\ ：显示当前计算机可以使用的核数
- ``gmt <module> =``\ ：检测模块 ``<module>`` 是否存在，若存在则返回0，否则返回非零值
