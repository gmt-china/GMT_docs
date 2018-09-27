自定义字体
==========

GMT默认支持了35种字体，如果想要使用额外的字体，则需要自己配置。可以修改 
:file:`${GMTHOME}/share/postscriptlight/PSL_custom_fonts.txt` 文件或在当前目录
下新建配置文件 :file:`PSL_custom_fonts.txt` 。

文件中每行包含三列数据，分别是：PS字体名、字体的高度（单位为 ``p`` ）以及
布尔值0或1告诉GMT是否要对文字重新编码。例如::

    LinBiolinumO      0.700    0
    LinLibertineOB    0.700    0

使用 ``gmt pstext -L`` 可查看所有字体对应的编号，在GMT中即可直接使用这些编号指定字体。

实际使用的时候有几个问题需要注意：

#. 第一列是PostScript Name，与字体文件的文件名不同，但尚不清楚如何提取某个字体文件的PS文件名
#. 是否要对文字进行编码？取0还是1，这个尚不确定
#. 调用该字体生成PS文件后，直接用 ``gs`` 打开会看不到效果，需要给 ``gs`` 加上 
   ``-sFONTPATH=dirname`` 选项指定字体文件名，或指定系统环境变量 ``$GS_FONTPATH``
#. 在用 ``psconvert`` 将PS文件转换成其他格式时，需要使用 ``-C-sFONTPATH=dirname`` 
   将自定义字体的路径传递给gs，使得字体可以被嵌入到新格式中