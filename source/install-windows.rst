Windows 下安装 GMT
==================

GMT 为 Windows 用户提供了安装包，可以直接安装使用。Windows 下需要安装 GMT、ghostscript 和 gsview。

.. warning::

   从 GMT 5.2.1 开始，GMT 已经不再支持 Windows XP。

1. 下载

   到社区主页的 `下载页面 <http://gmt-china.org/download/>`_ 下载所需要的安装包。

2. 安装GMT

   直接双击安装包即可安装，直接点击下一步，使用默认的选项即可，无须做任何修改。在“选择组件”页面，建议将四个选项都勾选上，然后点击下一步安装完成。

   安装完成后，“开始”->“所有程序”->“附件”->“命令提示符”以启动cmd。在cmd窗口中执行::

       C:\Users\xxxx> gmt --version
       5.3.1

   即表示安装成功。

2. 安装ghostscript

   安装的过程没什么可说的，在最后一步，记得勾选“Generate cidfmap for Windows CJK TrueType fonts”。

3. 安装gsview

   双击直接安装即可。
