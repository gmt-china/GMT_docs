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
- **gmt --new-script**\ [=\ *L*\]\ ：生成现代模式模板脚本。默认会根据当前Shell环境确定脚本语言，
  用户也可以自行指定脚本语言 *L* （可以取 **bash**\ 、\ **csh**\ 或 **batch**\ ）
- **gmt --show-bindir**\ ：显示GMT的bin目录
- **gmt --show-citation**\ ：显示GMT的参考文献引用信息
- **gmt --show-cores**\ ：显示当前计算机可以使用的核数
- **gmt --show-datadir**\ ：显示GMT的数据目录，默认为空
- **gmt --show-dataserver**\ ：显示GMT远程数据服务器的网址
- **gmt --show-doi**\ ：显示当前版本的DOI
- **gmt --show-library**\ ：显示GMT共享库文件的路径
- **gmt --show-modules**\ ：列出GMT的所有模块名
- **gmt --show-plugindir**\ ：显示GMT的插件目录
- **gmt --show-sharedir**\ ：显示GMT的share目录
- **gmt --version**\ ：显示GMT版本
- **gmt** *module* **=**\ ：检测模块 *module* 是否存在，若存在则返回0，否则返回非零值

示例
----

使用 **gmt --new-script** 会根据用户当前使用的SHELL环境生成对应的模板脚本。例如，
在Bash环境下可以使用如下命令生成模板脚本::

    gmt --new-script > plot.sh

在Windows DOS下默认会生成 batch脚本。可以直接指定要生成某种脚本语言的模板::

    gmt --new-script=bash > plot.sh
