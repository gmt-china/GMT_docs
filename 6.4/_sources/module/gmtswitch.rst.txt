.. index:: ! gmtswitch

gmtswitch
==========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:gmtswitch`
:说明: 在不同的 GMT 版本之间切换

**gmtswitch** 用来实现在多个已经安装 GMT 版本中切换环境。其实现方式为，在
家目录下维护一个版本配置文件 :file:`~/.gmtversions` ，其中包含每个版本的
目录列表，通过一个建立符号链接来指向不同版本的可执行文件目录实现。Windows 下的工作方式
请参见 `Windows`_

语法
----

**gmtswitch** [ D \| *version* ]

必选选项
--------

无。如果不指定任何参数，运行该命令将会看到一个已经安装的 GMT 版本的列表，
从 1 到 n，可指定想切换的版本。

可选选项
--------

**D**
    切换到 GMT 默认版本，即 :file:`~/.gmtversions` 中的第一个条目指向
    的版本

*version*
    在 :file:`~/.gmtversions` 中执行搜索，获取匹配的版本，如果只搜索到
    一个条目，则切换到对应的环境，否则，报错。

设置
----

如果用户已经安装了官方版本，则第一次运行 **gmtswitch** 时，会默认从根目录
开始检索，寻找 GMT4，GMT5 等版本，但不会检索子文件夹或其他指定目录。也可
在执行中指定检索的顶层目录。

正常情况下，应按如下步骤进行设置：

#. 编辑/创建 :file:`~/.gmtversions` 文件，并将所有的 GMT 安装目录添加到文件中。
   其中每个版本占一行，为安装的顶层文件夹，例如

   /Users/pwessel/UH/RESEARCH/PROJECTS/GMTdev/gmt-4.5.18

#. 在 .bashrc 或其他正在使用的 shell resource 文件中，删除环境变量 PATH 中已经
   添加的 GMT 的路径，并添加新的路径 ``$HOME/this_gmt/bin`` (在 csh 中为 HOME
   为 home)，需要注意的是，this_gmt 会在 **smgswitch** 执行过程中，被替换为
   对应的版本的路径，因此这里只需直接添加上述字符串到 PATH 中即可。此外，用户
   可能通过 conda 或者 brew 等包管理器已经安装了 GMT，删除其环境变量较为复杂，
   因此，在将 ``$HOME/this_gmt/bin`` 添加到 PATH 中时，应放在前面，即
   ``export PATH=$HOME/this_gmt/bin:${PATH}`` 以保证 **gmtswitch** 设置的版本
   为优先版本。

#. 确保新的 PATH 可工作，即重启终端或执行 ``source ~/.bashrc`` 以更新 PATH

#. 运行 **gmtswitch** ，并选择对应的版本

注意事项
--------

GMT 会记住第一次安装的位置，并使用该目录寻找默认的 GMT share directory。如果
在编译后移动了 GMT 的安装位置，则必须设置 **GMT_SHAREDIR** 指向对应的 share
directory。因此，最好不要在安装后移动东西。

示例
----

切换到 GMT 4.5.18（假定已安装，且非包管理器安装）::

    gmtswitch gmt-4.5.18

切换为默认 GMT 版本::

    gmtswitch D

Windows
-------

在 Windows 下，GMT 使用 gmtswitch.bat 批处理脚本来修改 Windows 的 PATH 变量，
使 gmtswitch 切换的版本总是位于最前面。该脚本运行方式包括两种：

1. **永久模式**

永久模式使用开源的可执行程序 **EditPath** 来修改注册表中的用户路径。之所以
被称为永久模式，是因为这些修改会一直保持到下一次修改，请见

http://www.softpedia.com/get/Tweak/Registry-Tweak/EditPath.shtml

其中 *editpath.exe* 必须已经添加到 Windows 的路径中。

.. note::

    路径的修改在当前 cmd 中是不可见的，必须打开一个新的 cmd 使其生效

2. **临时模式**

该模式通过脚本将 GMT 的二进制文件路径添加到以前的路径中，当 cmd 窗口关闭时，
修改就会失效


用户还必须将下述的 G4_32 到 G5_64 的内容设置为安装不同 GMT 版本的二进制文件
所在的路径，但这四个文件并不是强制要求必须存在的，对于不存在的条目，则指向
空即可，例如::

    set G4_32=
    set G4_64=
    set G5_32=xxxx
    set G5_64=xxxx

.. note::
    
    目前 gmtswitch.bat 脚本中并未包含 GMT6 版本，用户可手动编辑 ``gmt --show-bindir``
    下的该文件，添加相应的变量并做一定其他修改

永久模式是默认模式，运行临时模式需要指定第二个参数。例如，永久切换为 GMT5 64 位版本::

    gmtswitch g5_64

临时切换为 GMT4 32 位版本, 2 为临时模式，1 或者不指定均为永久模式::

    gmtswitch g4_32 2

不指定任何参数，可以查看帮助手册。

