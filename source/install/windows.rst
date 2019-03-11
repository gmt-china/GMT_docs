Windows 下安装 GMT
==================

GMT 为 Windows 用户提供了安装包，可以直接安装使用。Windows 下需要安装 GMT、
ghostscript，查看PS文件需要使用 GSview。日常数据处理需要Linux下的小工具。

.. warning::

   从 GMT 5.2.1 开始，GMT 提供的 Windows 下的安装包已经不再支持 Windows XP。

1. 下载

   - GMT 5.4.5:
     `32位 <http://mirrors.ustc.edu.cn/gmt/bin/gmt-5.4.5-win32.exe>`__
     `64位 <http://mirrors.ustc.edu.cn/gmt/bin/gmt-5.4.5-win64.exe>`__
   - ghostscript 9.26:
     `32位 <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926aw32.exe>`__
     `64位 <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926aw64.exe>`__
   - GSview 5.0:
     `32位 <http://www.ghostgum.com.au/download/gsv50w32.exe>`__
     `64位 <http://www.ghostgum.com.au/download/gsv50w64.exe>`__
   - `UnixTools.zip <https://gmt-china.org/data/UnixTools.zip>`__

2. 安装GMT

   直接双击安装包即可安装，直接点击下一步，使用默认的选项即可，无须做任何修改。
   在“选择组件”页面，建议将四个选项都勾选上，然后点击下一步安装完成。

   .. note::

      安装过程中可能会出现如下警告::

        Warning! Failed to add GMT to PATH. Please add the GMT bin path to PATH manually.

      出现此警告的原因是系统的环境变量 ``PATH`` 太长，GMT安装包无法直接修改。

      解决办法是，先忽略这一警告，待安装完成后按照如下步骤手动修改系统环境变量 ``PATH``\ 。

      1. 点击“计算机”->“属性”->“高级系统设置”->“环境变量”打开“环境变量”编辑工具
      2. 在“系统变量”部分中，选中“Path”并点击“编辑”
      3. 在“变量值”的最后加上GMT的bin目录的路径，默认值为 ``C:\programs\gmt5\bin``\ 。
         需要注意“path”变量值中多个路径之间用英文分号分隔

   安装完成后，“开始”->“所有程序”->“附件”->“命令提示符”以启动cmd。在cmd窗口中执行::

       C:\Users\xxxx> gmt --version
       5.4.5

   即表示安装成功。

3. 安装ghostscript

   安装的过程没什么可说的，在最后一步，记得勾选
   ``Generate cidfmap for Windows CJK TrueType fonts``\ 。

4. 安装GSview

   双击直接安装即可。

5. 安装 UnixTools

   解压压缩包，并将解压得到的 exe 文件移动到 GMT 的 bin 目录即可。

某些情况下，运行 GMT 命令时会出现警告信息::

    gmt: Unable to create GMT User directory : /Users/用户名/.gmt
    gmt: Auto-downloading of earth_relief_##m|s.grd files has been disabled.

解决办法::

   1、打开 “我的电脑”->“属性”->“高级系统设置”->“环境变量”
   2、新建 “系统变量”
          变量名： HOME
          变量值： C:\Users\用户名

重新运行脚本检查问题是否得到解决。经过测试，\ ``HOME`` 变量的值可以取任意盘符中
任何已存在的文件夹，正常情况下，执行脚本后会生成 ``%HOME%/.gmt/cache`` 空文件夹。

如果想要同时使用 GMT4 和 GMT5，则需要在安装完 GMT4 和 GMT5 之后到 GMT5 的 bin
目录下，将该目录下的所有文件按照大小排序，所有大小为 6 KB 的都是 “符号链接”，
直接选中删除就好。
