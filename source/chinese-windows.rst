Windows 下的 GMT 中文支持
=========================

本文介绍如何让 GMT 在Windows下支持中文。

准备工作
--------

1. 安装 Windows 版 GMT；
2. 安装 ghostscript；

   需要注意在安装的最后，会有一个生成 cidmap 的选项，选中该选项则表示会为当前
   系统自动生成中文所需的 cidmap 文件。默认该选项是被选中的，一定 **不要** 将该选项取消；

3. 安装 gsview；

ghostscript 的中文支持
++++++++++++++++++++++

若 ghostscript 的安装没有问题，则在 ``C:\Program Files\gs\gs9.15\examples\cjk``
目录下可以找到文件 ``gscjk_ag.ps`` 。

启动 cmd，键入如下命令::

    cd "C:\Program Files\gs\gs9.16\bin"
    gswin64.exe ..\examples\cjk\gscjk_ag.ps

该命令用命令行版本的 ``gswin64c`` 打开 ``gscjk_ag.ps`` ，若能看到中文，则说明
ghostscript 是可以正常支持中文的。

gsview 的中文支持
+++++++++++++++++

安装好 gsview 之后，PS 格式会自动与 gsview 关联。一般情况下，直接双击 PS 文件，
就会用 gsview 打开该 PS 文件。

双击打开 ``gscjk_ag.ps`` ，一般情况下不会正确显示汉字。这是因为 gsview 在打开
PS 文件时没有找到汉字所对应的字体文件。

在 gsview 的 “选项”->“高级配置” 中，将 Ghostscript Options 由
``-dNOPLATFONTS -sFONTPATH="c:\psfonts"``
改成 ``-dNOPLATFONTS -sFONTPATH="C:\Windows\Fonts"`` ，
此时 gsview 在调用 gswin64 时会将选项传递给 gswin64，gswin64 则会在 ``FONTPATH``
中搜索字体。

配置完毕后，重新打开 ``gscjk_ag.ps`` ，若中文正常显示，则表示 gsview 已支持中文。

GMT 的中文支持
--------------

用 **编辑器** 打开 ``gscjk_ag.ps`` ，会看到如下内容::

    /STSong-Light--GB-EUC-H *findfont 20 scalefont setfont
    150 400 moveto
    (Song Typeface 宋体) show
    /STFangsong-Light--GB-EUC-H *findfont 20 scalefont setfont
    150 375 moveto
    (Fangsong Typeface 仿宋体) show
    /STHeiti-Regular--GB-EUC-H *findfont 20 scalefont setfont
    150 350 moveto
    (Hei Typeface 黑体) show
    /STKaiti-Regular--GB-EUC-H *findfont 20 scalefont setfont
    150 325 moveto
    (Kai Typeface 揩体) show
    %
    /Times-Roman findfont 13 scalefont setfont
    50 200 moveto
    (* Chinese translation of"Ghostscript" is merely associative \
    characters of these meanings.) show
    50 200 13 sub moveto
    (In Simplified Chinese articles, customarily we use just"Ghostscript" \
    as it is.) show

其中 ``STSong-Light--GB-EUC-H`` 即为宋体， ``GB-EUC`` 是文字编码方式，
``H`` 表示水平字体， ``V`` 表示垂直向字体，这里给出了四种常见字体的名称

1. ``STSong-Light--GB-EUC-H``
2. ``STFangsong-Light--GB-EUC-H``
3. ``STHeiti-Regular--GB-EUC-H``
4. ``STKaiti-Regular--GB-EUC-H``

将这四种中文字体添加到 GMT 的字体配置文件中，GMT 版本不同，配置文件的位置也不同：

-  GMT 5.1.2 及其之前版本： ``C:\programs\gmt5\share\pslib\PS_font_info.d``
-  GMT 5.2.1 及其之后版本： ``C:\programs\gmt5\share\postscriptlight\PSL_custom_fonts.txt``

将如下即行内容加入到字体配置文件中::

    STSong-Light--GB-EUC-H  0.700    1
    STFangsong-Light--GB-EUC-H  0.700    1
    STHeiti-Regular--GB-EUC-H   0.700   1
    STKaiti-Regular--GB-EUC-H   0.700   1

用 ``gmt pstext -L`` 查看 GMT 字体，可以看到，新添加的四种中文字体对应的字体编号为 35 到 38。

测试脚本
--------

.. code-block:: bash

    gmt gmtset FONT_TITLE 40p,35,black

    echo 3.5 5 0 LM 45p,35,red  GMT 宋体 > tmp
    echo 3.5 4 0 LM 45p,36,blue GMT 仿宋 >> tmp
    echo 3.5 3 0 LM 45p,37,yellow GMT 黑体 >> tmp
    echo 3.5 2 0 LM 45p,38,green GMT 楷体 >> tmp

    gmt pstext tmp -R0/7/0/7 -JX6i/6i -Bafg -B+t"GMT 中文" -F+a+c+f -P > cn.ps

若生成的 PS 文件正常显示汉字，则表示 GMT 已经可以支持中文。

需要注意，若使用记事本编辑 bat 文件，则保存时应注意编码方式为 ANSI、Unicode 或
Unicode big endian，若使用 UTF-8 编码则会出现乱码；另外，很多编辑器默认将文本
文件以 UTF-8 编码保存，因而可能需要修改编辑器的默认编码。
