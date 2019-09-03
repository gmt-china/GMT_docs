.. index:: ! gmt

gmt
===

:官方文档: :doc:`gmt:gmt`
:说明: GMT主程序

GMT的数据处理和绘图功能均通过使用 **gmt** 调用相应模块来实现，其基本语法为：

**gmt** *module* *module-options*

其中 *module* 是GMT模块名，\ *module-options* 是模块所支持的选项。

除了调用模块外，GMT还有自己的一些选项可以使用：

- **gmt --help**\ ：列出GMT提供的所有模块名及其功能
- **gmt --new-script**\ ：生成GMT脚本模板
- **gmt --show-bindir**\ ：显示GMT的bin目录
- **gmt --show-cores**\ ：显示当前计算机可以使用的核数
- **gmt --show-datadir**\ ：显示GMT的数据目录，默认为空
- **gmt --show-dataserver**\ ：显示GMT远程数据服务器的网址
- **gmt --show-library**\ ：显示GMT共享库文件的路径
- **gmt --show-modules**\ ：列出GMT的所有模块名
- **gmt --show-plugindir**\ ：显示GMT的插件目录
- **gmt --show-sharedir**\ ：显示GMT的share目录
- **gmt --version**\ ：显示GMT版本
- **gmt** *module* **=**\ ：检测模块 *module* 是否存在，若存在则返回0，否则返回非零值

