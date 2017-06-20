Windows 下安装 GMT
==================

GMT 最初是在类 Unix 系统上开发的，尽管已经移植到了 Windows 上，但还是建议尽可能在类 Unix 系统上使用。

在 Windows 下使用 GMT 有如下几种途径：

#. 使用 GMT 提供的 Windows 安装包
#. 在 `cygwin <https://www.cygwin.com/>`_ 中安装 GMT
#. 在 `MSYS2 <http://msys2.github.io/>`_ 中安装 GMT
#. 在 `MinGW-w64 <https://mingw-w64.org/doku.php>`_ 中安装GMT
#. 使用 Windows 10 提供的 Bash on Ubuntu on Windows

Windows下的GMT安装包
--------------------

GMT 为 Windows 用户提供了安装包，可以直接安装使用。Windows 下需要安装 GMT、ghostscript 和 gsview。

.. warning::

   从 GMT 5.2.1 开始，GMT 提供的 Windows 下的安装包已经不再支持 Windows XP。

1. 下载

   到社区主页的 `下载页面 <http://gmt-china.org/download/>`_ 下载所需要的安装包。

2. 安装GMT

   直接双击安装包即可安装，直接点击下一步，使用默认的选项即可，无须做任何修改。在“选择组件”页面，建议将四个选项都勾选上，然后点击下一步安装完成。

   .. note::

      安装过程中可能会出现“Warning! PATH too long installer unable to modify PATH!”的警告。
      出现此警告的原因是系统的环境变量 ``PATH`` 太长，GMT安装包无法直接修改。

      解决办法是，先忽略这一警告，待安装完成后按照如下步骤自行修改系统环境变量 ``PATH`` 。

      1. 点击“计算机”->“属性”->“高级系统设置”->“环境变量”打开“环境变量”编辑工具
      2. 在“系统变量”部分中，选中“Path”并点击“编辑”
      3. 在“变量值”的最后加上GMT的安装路径。需要注意“path”变量值中多个路径之间用英文分号分隔

   安装完成后，“开始”->“所有程序”->“附件”->“命令提示符”以启动cmd。在cmd窗口中执行::

       C:\Users\xxxx> gmt --version
       5.4.1

   即表示安装成功。

2. 安装ghostscript

   安装的过程没什么可说的，在最后一步，记得勾选“Generate cidfmap for Windows CJK TrueType fonts”。

3. 安装gsview

   双击直接安装即可。
 
4. 安装 UnixTools

   解压压缩包，并将解压得到的 exe 文件移动到 GMT 的 bin 目录即可。

在 cygwin 中安装
----------------

欢迎补充，请参考：

#. http://gmt.soest.hawaii.edu/doc/5.4.1/GMT_Docs.html#cygwin-and-gmt
#. http://gmt.soest.hawaii.edu/projects/gmt/wiki/BuildingGMT#Cygwin

在 MSYS2 中安装
---------------

1. 下载并安装 `MSYS2 <http://msys2.github.io/>`_

欢迎补充

在 MinGW-w64 中安装
-------------------

欢迎补充

Bash on Ubuntu on Windows
-------------------------

欢迎补充
