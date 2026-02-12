Windows 下安装 GMT
==================

使用Windows下的安装包进行安装
-----------------------------

GMT 为 Windows 用户提供了安装包，可以直接安装使用。Windows 下需要安装 GMT、
ghostscript，查看PS文件需要使用 GSview。日常数据处理需要Linux下的小工具。

.. warning::

   从 GMT 5.2.1 开始，GMT 提供的 Windows 下的安装包已经不再支持 Windows XP。

.. warning::

   GMT需要使用 ghostscript 生成PDF、JPG等格式的图片。但ghostscript 9.27存在
   严重bug，会导致生成的图片中有用信息被裁剪。请确保自己安装的不是 9.27 版本。

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

   .. note::

      某些情况下，运行 GMT 命令时会出现警告信息::

        gmt: Unable to create GMT User directory : /Users/用户名/.gmt
        gmt: Auto-downloading of earth_relief_##m|s.grd files has been disabled.

      解决办法:

      1. 打开 “我的电脑”->“属性”->“高级系统设置”->“环境变量”
      2. 新建 “系统变量”。变量名：\ ``HOME``\ ；变量值：\ ``C:\Users\用户名``

      重新执行命令检查问题是否得到解决。经过测试，\ ``HOME`` 变量的值可以取任意盘符中
      任何已存在的文件夹，正常情况下，执行脚本后会生成 ``%HOME%/.gmt/cache`` 空文件夹。

3. 安装ghostscript

   安装的过程没什么可说的，在最后一步，记得勾选
   ``Generate cidfmap for Windows CJK TrueType fonts``\ 。

4. 安装GSview

   双击直接安装即可。

5. 安装 UnixTools

   解压压缩包，并将解压得到的 exe 文件移动到 GMT 的 bin 目录即可。

如果想要同时使用 GMT4 和 GMT5，则需要在安装完 GMT4 和 GMT5 之后到 GMT5 的 bin
目录下，将该目录下的所有文件按照大小排序，所有大小为 6 KB 的都是 “符号链接”，
直接选中删除就好。

在 Windows Subsystem for Linux (WSL) 下安装 GMT
-----------------------------------------------

Windows 下使用 GMT 有诸多不便，主要在于Windows下的bat脚本功能太局限。基于同样的理由，
本手册和 GMT 中文社区均不提供 Windows 下的批处理示例脚本。

Windows 10 用户可以考虑使用 Windows Subsystem for Linux (WSL)。
WSL 是微软与 Canonical 公司合作开发的，为在 Windows 10 上能够原生运行 Linux 二进制可执行文件
而制作的兼容层，使得Windows 10 用户可以直接在 Windows 下使用 Linux 系统的所有工具及功能。

WSL 要求 Windows 10 且版本号为 Windows build 16215 或以上。如果不满足，则需要升级。

在确认自己的Windows 10支持WSL后，首先要开启WSL功能。在左下角的搜索里搜索 powershell，
右键点击以管理员权限打开，执行以下命令::

    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

然后，重启电脑。

访问“Windows 软件商店”，并下载安装 Ubuntu 或 Debian 等任一 Linux 发行版。下载及安装过程完全自动。
安装完成后，在开始菜单中即可看到 Ubuntu 或 Debian，点击即可启动 Linux。

启动Linux后，则可完全按照 :doc:`Linux下安装GMT </install/linux>` 的说明在WSL中安装GMT。

编译GMT源码
-----------

高级用户可以自行在Windows下编译GMT源码。

准备工作
~~~~~~~~

在Windows下编译GMT源码，需要满足如下条件：

#. Windows版本为Windows 7, Windows 8.1 或 Windows 10
#. 已安装 `Visual Studio 2015 Update 3 <https://visualstudio.microsoft.com/>`_ 或更新版本。
   需要注意，安装 Visual Studio 时要选中“Desktop development with C++”，即安装
   C/C++开发工具
#. 已安装 `git <https://git-scm.com/>`_
#. 已安装 `cmake <https://cmake.org/>`_
#. 安装ghostscript
#. 安装gsview

安装vcpkg
~~~~~~~~~

`vcpkg <https://github.com/microsoft/vcpkg>`_ 是微软开发的跨平台C/C++开发库管理工具。
这里安装vcpkg并通过vcpkg编译安装GMT所需的依赖库。

打开终端，执行如下命令以安装vcpkg。这里假定安装到 ``C:\vcpkg`` 目录下::

    cd C:\
    git clone https://github.com/microsoft/vcpkg.git
    cd C:\vcpkg
    .\bootstrap-vcpkg.bat

稍等片刻即安装完成。

安装依赖库
~~~~~~~~~~

vcpkg在编译库文件时，默认会编译两次，分别生成Release和Debug两个版本的库文件。
一般用户只需要Release版本的库文件即可，因而可以设置vcpkg只编译Release版本，以
节省将近一半的编译时间。具体做法为，在 ``C:\vcpkg\triplets\`` 目录下找到文件
``x64-windows.cmake`` 和 ``x86-windows.cmake``\ ，在两个文件的末尾加上
``set(VCPKG_BUILD_TYPE release)`` 即可。

设置完成后执行如下命令以安装依赖库::

    cd C:\vcpkg
    vcpkg install netcdf-c gdal pcre clapack openblas
    vcpkg integrate install

vcpkg会编译安装一堆库文件，这一过程较为耗时，大概需要30分钟到1小时。

安装的库文件位于 ``C:\vcpkg\installed\x64-windows`` 目录下，需要手动修改环境
变量将 ``C:\vcpkg\installed\x64-windows\bin`` 加到 PATH 中。

编译GMT
~~~~~~~

下载GMT源码包或者从GitHub获取开发版源码::

    git clone https://github.com/GenericMappingTools/gmt.git

下载GSHHG数据和DCW数据，并解压。

进入 gmt 源码目录，并在 ``cmake`` 目录下创建文件 ``ConfigUser.cmake``\ ,其内容为::

    set (CMAKE_INSTALL_PREFIX "C:/programs/gmt")
    set (GSHHG_ROOT "D:/datas/gshhg-gmt-2.2.7")
    set (DCW_ROOT "D:/datas/dcw-gmt-1.1.4")
    set (COPY_GSHHG true)
    set (COPY_DCW true)
    set (GMT_INSTALL_MODULE_LINKS FALSE)
    set (CMAKE_C_FLAGS "/D_CRT_SECURE_NO_WARNINGS /D_CRT_SECURE_NO_DEPRECATE ${CMAKE_C_FLAGS}")
    set (CMAKE_C_FLAGS "/D_CRT_NONSTDC_NO_DEPRECATE /D_SCL_SECURE_NO_DEPRECATE ${CMAKE_C_FLAGS}")

其中 ``CMAKE_INSTALL_PREFIX`` 是GMT安装路径，\ ``GSHHG_ROOT`` 和 ``DCW_ROOT`` 是
之前解压的GSHHG和DCW数据文件夹的路径。

修改为配置文件后。从程序中找到“Developer Command Prompt for VS 2017”并打开
（注意，不要使用CMD），并执行如下命令::

    cd gmt
    mkdir build
    cd build
    cmake .. -DCMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake
    cmake --build . --config Release
    cmake --build . --config Release --target install

安装完成后，需要将GMT安装目录的bin目录（即 ``C:\programs\gmt\bin`` ）手动添加到
环境变量PATH中。
