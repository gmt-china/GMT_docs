Windows 下的 GMT 中文支持
=========================

ghostscript 的中文支持
----------------------

如果没有正确配置 Ghostscript 的中文支持，GMT 生成的 PNG、PDF 等格式的图片中的中文将会出现乱码。
因此 Ghostscript 的中文支持对于希望使用中文的用户来说是必须进行配置的。

.. warning::

   GMT安装包中内置的 Ghostscript 不支持中文。
   若想要GMT支持中文，注意在安装GMT时不勾选Ghostscript组件，待GMT安装完成后再自行安装 Ghostscript。

   新手常常没有意识到自己安装GMT时勾选了Ghostscript组件，导致中文乱码出现。
   如果严格按照下列步骤配置，依然遇到了中文乱码问题，
   建议卸载GMT，并按照《 :doc:`/install/windows` 》章节的步骤与要求重新安装GMT与Ghostscript。
  
安装包下载地址:
  
- `gs9540w64.exe（64 位） <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/gs9540w64.exe>`__
- `gs9540w32.exe（32 位） <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/gs9540w32.exe>`__
   
.. warning::
 
   请注意 Ghostscript 的版本！
   由于 Ghostscript 自身的 bug，请勿使用 9.27、9.51 和 9.52 版本的 Ghostscript。

.. note::

   安装 Ghostscript 的过程中记得勾选 ``Generate cidfmap for Windows CJK TrueType fonts``
   以生成中文字体配置文件。

在安装 ghostscript 的过程中，会有一个生成 cidmap 的选项，选中该选项则表示会为当前系统自动
生成中文所需的 cidmap 文件。默认该选项是被选中的，一定 **不要** 将该选项取消。

为了能够在将PS文件转换为其他图片格式时也支持中文，需要设置环境变量 ``GS_FONTPATH``。
具体步骤如下：

1. 点击“计算机”->“属性”->“高级系统设置”->“环境变量”打开“环境变量”编辑工具
2. 在“系统变量”部分中，新建变量 ``GS_FONTPATH`` 并设置其值为 ``C:\Windows\fonts``

GMT 的中文支持
--------------

新建GMT自定义字体配置文件 ``C:\Users\用户名\.gmt\PSL_custom_fonts.txt``
（注意 ``用户名`` 应该替换为实际的用户名。
若不存在 ``C:\Users\用户名\.gmt`` 目录则需新建该目录。Windows的文件管理器无法新建
以 **.** 开头的文件夹，因而需要打开CMD，然后执行命令 ``mkdir .gmt`` 以创建该文件夹）。

.. note::

    Windows默认隐藏文件的扩展名。新手在新建这个字体配置文件时，
    常常将文件名错误写成 ``PSL_custom_fonts.txt.txt``，导致中文字体添加失败。
    因此强烈建议在\ **资源管理器** -> **查看**\ 中开启显示文件扩展名:


    .. image:: chinese-extension.png

向 GMT自定义字体配置文件 ``C:\Users\用户名\.gmt\PSL_custom_fonts.txt`` 中加入如下语句::

    STSong-Light--GB-EUC-H  0.700    1
    STFangsong-Light--GB-EUC-H  0.700    1
    STHeiti-Regular--GB-EUC-H   0.700   1
    STKaiti-Regular--GB-EUC-H   0.700   1
    STSong-Light--GB-EUC-V  0.700    1
    STFangsong-Light--GB-EUC-V  0.700    1
    STHeiti-Regular--GB-EUC-V   0.700   1
    STKaiti-Regular--GB-EUC-V   0.700   1

用 ``gmt text -L`` 查看 GMT 字体::

    $ gmt text -L
    Font #  Font Name
    ------------------------------------
    0   Helvetica
    1   Helvetica-Bold
    ...    ......
    39 STSong-Light--GB-EUC-H
    40 STFangsong-Light--GB-EUC-H
    41 STHeiti-Regular--GB-EUC-H
    42 STKaiti-Regular--GB-EUC-H
    43 STSong-Light--GB-EUC-V
    44 STFangsong-Light--GB-EUC-V
    45 STHeiti-Regular--GB-EUC-V
    46 STKaiti-Regular--GB-EUC-V

可以看到，新添加的四种中文字体对应的字体编号为 39 到 46。
其中 ``STSong-Light-GB-EUC-H`` 即为宋体，``GB-EUC`` 是文字编码方式，
``H`` 表示文字水平排列，``V`` 表示竖排文字。
强烈建议在执行测试脚本前确认自己的中文字体编号。

GMT 中文测试
------------

.. note::

   请自行确认你的中文字体编号。如果编号不是39到46，请自行修改以下测试脚本。

.. warning::

   目前发现 **Git Bash** 运行Bash脚本时， ``echo`` 生成文件使用的是 UTF8 编码，
   从而可能会导致中文乱码。建议在有中文需求时使用bat脚本，或者避免在Bash脚本
   中使用 ``echo`` 。

使用\ **记事本**\ 和 **Notepad++** 的用户，应注意含中文的bat文件和输入数据文件都应以 **ANSI** 编码保存，
使用其他编码方式则极可能出现乱码。Notepad++除了注意要选择 “ 编码 -> 使用ANSI编码 ” 以外，还应该选中
“ 设置 -> 首选项 -> 新建 -> 编码 -> ANSI ”。

**Visual Studio Code** 用户，应注意确保含中文的bat文件和输入数据文件都采用 **GB2312** 编码方式。
在Visual Studio Code右下角状态栏中可以查看并修改当前文件的编码方式。

.. literalinclude:: GMT_Chinese.bat

.. note::

    GMT 6.x 目前在Windows下处理中文时存在BUG，可能会出现某些中文正常显示，某些
    不正常显示的情况。使用::

        gmt set PS_CHAR_ENCODING Standard+

    可临时避免这一BUG。

成图效果如下：

.. figure:: GMT_Chinese.png
   :width: 100%
   :align: center
