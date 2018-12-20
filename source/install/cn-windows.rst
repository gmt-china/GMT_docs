Windows 下的 GMT 中文支持
=========================

ghostscript 的中文支持
----------------------

通常，在 ``C:\Program Files\gs\gs9.15\examples\cjk`` 目录下可以找到文件 ``gscjk_ag.ps``\ 。

.. note::

   如果找不到该文件，请尝试重新安装ghostscript。在安装的过程中，会有一个生成
   cidmap 的选项，选中该选项则表示会为当前系统自动生成中文所需的 cidmap 文件。
   默认该选项是被选中的，一定 **不要** 将该选项取消；

启动 cmd，键入如下命令::

    cd "C:\Program Files\gs\gs9.16\bin"
    gswin64.exe ..\examples\cjk\gscjk_ag.ps

该命令用命令行版本的 ``gswin64c`` 打开 ``gscjk_ag.ps``\ ，若能看到中文，则说明
ghostscript 是可以正常支持中文的。

gsview 的中文支持
-----------------

如果你需要用gsview查看PS文件，则需要为gsview配置中文显示。否则，则可以跳过这一部分。

安装好 gsview 之后，PS 格式会自动与 gsview 关联。一般情况下，直接双击 PS 文件，
就会用 gsview 打开该 PS 文件。

双击打开 ``gscjk_ag.ps``\ ，一般情况下不会正确显示汉字。这是因为 gsview 在打开
PS 文件时没有找到汉字所对应的字体文件。

在 gsview 的 “选项”->“高级配置” 中，将 Ghostscript Options 由
``-dNOPLATFONTS -sFONTPATH="c:\psfonts"``
改成 ``-dNOPLATFONTS -sFONTPATH="C:\Windows\Fonts"``\ ，
此时 gsview 在调用 gswin64 时会将选项传递给 gswin64，gswin64 则会在 ``FONTPATH``
中搜索字体。

配置完毕后，重新打开 ``gscjk_ag.ps``\ ，若中文正常显示，则表示 gsview 已支持中文。

GMT 的中文支持
--------------

新建GMT自定义字体配置文件 ``C:\Users\XXX\.gmt\PSL_custom_fonts.txt``
（若不存在 ``C:\Users\XXX\.gmt`` 目录则需新建该目录）。

向 GMT自定义字体配置文件 ``C:\Users\XXX\.gmt\PSL_custom_fonts.txt`` 中加入如下语句::

    STSong-Light--GB-EUC-H  0.700    1
    STFangsong-Light--GB-EUC-H  0.700    1
    STHeiti-Regular--GB-EUC-H   0.700   1
    STKaiti-Regular--GB-EUC-H   0.700   1

用 ``gmt pstext -L`` 查看 GMT 字体，可以看到，新添加的四种中文字体对应的字体编号为 39 到 42。
其中 ``STSong-Light--GB-EUC-H`` 即为宋体，\ ``GB-EUC`` 是文字编码方式，
``H`` 表示文字水平排列。

强烈建议在执行测试脚本前确认自己的中文字体编号。

测试脚本
--------

.. note::

   请自行确认你的中文字体编号。如果编号不是39到42，请自行修改以下测试脚本。

.. code-block:: batch

   gmt set FONT_TITLE 30p,39,black
   gmt set FONT_LABEL 15p,39,black

   echo 3 2.5 35p,39,black GMT宋体 > tmp
   echo 3 1.0 35p,40,blue GMT仿宋 >> tmp
   echo 7 2.5 35p,41,yellow GMT黑体 >> tmp
   echo 7 1.0 35p,42,green GMT楷体 >> tmp

   gmt pstext tmp -R0/10/0/4 -JX15c/5c -Bxafg+l"X轴" -Byafg+l"Y轴" -BWSen+t"中文标题" -F+f > GMT_chinese.ps
   gmt psconvert GMT_chinese.ps -C-sFONTPATH=C:\windows\fonts -Tg -A -P -E300
   del gmt.* tmp

成图效果如下：

.. figure:: /static_images/GMT_chinese.png
   :width: 100%
   :align: center

需要注意，若使用记事本编辑 bat 文件，则保存时应注意编码方式为 ANSI、Unicode 或
Unicode big endian，若使用 UTF-8 编码则会出现乱码；另外，很多编辑器默认将文本
文件以 UTF-8 编码保存，因而可能需要修改编辑器的默认编码。
