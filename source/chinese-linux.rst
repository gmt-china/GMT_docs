Linux 下的 GMT 中文支持
=================================

让 GMT 支持中文，需要修改 ghostscript 和 GMT 的配置文件。由于不同发行版对 ghostscript 的打包方式不同，不同的 ghostscript 版本之间的配置文件也有一些差异。

准备工作
------------------

安装gs中文配置文件
++++++++++++++++++

大多数发行版都已经默认安装了gs。除此之外，还需要安装简体中文配置文件。CentOS 7下中文配置文件可以通过如下命令安装::

    $ sudo yum install ghostscript-chinese-zh_CN

安装完成后，中文配置文件的路径为 `/usr/share/ghostscript/conf.d/cidfmap.zh_CN`，以下称为 ghostscript 中文配置文件。

GMT 字体配置文件
++++++++++++++++++

假定 GMT 的安装路径为 `/opt/GMT-5.2.1` ，则字体配置文件的路径为 `/opt/GMT-5.2.1/share/postscriptlight/PSL_standard_fonts.txt` 。

使 gs 支持中文
------------------

gs 中文配置文件
++++++++++++++++++

CentOS 7 中 ghostscript 中文配置文件的默认内容为:

    /BousungEG-Light-GB <</FileType /TrueType /Path (/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /GBZenKai-Medium    <</FileType /TrueType /Path (/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /MSungGBK-Light     /BousungEG-Light-GB ;
    /Adobe-GB1      /BousungEG-Light-GB ;

其中的细节可能看不懂，但是可以大概总（xia）结（cai）如下：

-   第一行定义了字体名为 `/BousungEG-Light-GB` ，对应的字体文件为   `/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc` ，也就是文泉驿正黑；
-   第二行定义了字体名为 `/GBZenKai-Medium`，对应的字体文件也是文泉驿正黑；
-   第三行和第四行分别定义了字体名 `/MSungGBK-Light` 和 `/Adobe-GB1`，这两种
    都对应于 `/BousungEG-Light-GB` ，相当于给字体定义了别名。

关于配置文件的几点说明：

-   字体名是任意的，比如字体名可以取为 `/ABC` ；
-   字体文件似乎只能是 `ttc` 或 `ttf` 格式的，当然修改参数也有可能可以使用其他格式的字体；
-   要注意确认字体文件是否存在，比如 CentOS7 下的 `wqy-zenhei.ttc` 字体实际上位于软件包
    `wqy-zenhei-fonts` 中。若字体不存在，则需要安装相应软件包。

测试 gs 对 Linux 默认字体的支持
++++++++++++++++++++++++++++++++

CentOS7 的 ghostscript 中文配置文件中，默认有四行，分别定义了四个字体名，尽管本质上这四个字体名都指向同一个字体。下面先测试一下如何让 gs 显示 Linux 的默认字体。

用**编辑器**新建一个 PS 文件（是的，PS 文件其中就是纯文本，可以直接用编辑器编辑!），名为`linux_fonts.ps` ，其内容为:

    %! PS-Adobe-3. 0
    /BousungEG-Light-GB--UniGB-UTF8-H findfont 20 scalefont setfont
    150 400 moveto
    (BousungEG 字体) show

    /GBZenKai-Medium--UniGB-UTF8-H findfont 20 scalefont setfont
    150 375 moveto
    (GBZenKai 字体) show

    /MSungGBK-Light--UniGB-UTF8-H findfont 20 scalefont setfont
    150 350 moveto
    (MSungGBK 字体) show

    /Adobe-GB1--UniGB-UTF8-H findfont 20 scalefont setfont
    150 325 moveto
    (Adobe 字体) show

    showpage
    %%Trailer
    %%EOF

简单解释一下，PS 文件中要使用某个中文字体，需要用 `FontName--CMap` 的格式来调用。其中 `FontName` 即 gs 中文配置文件中给定的字体名。CMap 可以取 `UniGB-UTF8-H` 和 `GB-EUC-H`， Linux 下一般用前者，Windows 下一般用后者，应该是用于指定汉字或中文字体的编码，具体原理不知。

用 gs 查看该 PS 文件，正常情况下显示如下图，表明 gs 可以正常显示 Linux 下的默认中文字体。



添加 Windows 中文字体
+++++++++++++++++++++++

Linux 的中文字体较少，所以这里使用 Windows 下中的中文字体，这里只考虑 Windows 下的宋体、仿宋、黑体和楷体四个基本字体。将这四个字体文件复制到 `/usr/share/fonts/winfonts/` 目录下，然后对 gs 的中文配置文件做如下修改:

    % 原内容保持不变
    /BousungEG-Light-GB <</FileType /TrueType /Path (/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /GBZenKai-Medium    <</FileType /TrueType /Path (/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /MSungGBK-Light     /BousungEG-Light-GB ;
    /Adobe-GB1      /BousungEG-Light-GB ;

    % 新增 Windows 字体的支持
    /STSong-Light <</FileType /TrueType /Path (/usr/share/fonts/winfonts/simsun.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /STFangsong-Light <</FileType /TrueType /Path (/usr/share/fonts/winfonts/simfang.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /STHeiti-Regular <</FileType /TrueType /Path (/usr/share/fonts/winfonts/simhei.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /STKaiti-Regular <</FileType /TrueType /Path (/usr/share/fonts/winfonts/simkai.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;

这里仅以 Windows 下的常用四大字体为例。对于 Windows 下的其他中文字体、Linux 的其他中文字体甚至日韩字体来说，方法类似。

测试 gs 对 Windows 中文字体的支持
++++++++++++++++++++++++++++++++++

用**编辑器**新建一个 PS 文件，名为 `windows_fonts.ps` ，其内容为:

    %! PS-Adobe-3. 0
    /STSong-Light--UniGB-UTF8-H findfont 20 scalefont setfont
    150 400 moveto
    (Song Typeface 宋体) show

    /STFangsong-Light--UniGB-UTF8-H findfont 20 scalefont setfont
    150 375 moveto
    (Fangsong Typeface 仿宋体) show

    /STHeiti-Regular--UniGB-UTF8-H findfont 20 scalefont setfont
    150 350 moveto
    (Hei Typeface 黑体) show

    /STKaiti-Regular--UniGB-UTF8-H findfont 20 scalefont setfont
    150 325 moveto
    (Kai Typeface 楷体) show

    showpage
    %%Trailer
    %%EOF

用 gs 查看该 PS 文件，若正确显示中文如下图，则表明 gs 已支持 Windows 字体。



使 GMT 支持中文
----------------------

修改 GMT 字体配置文件
++++++++++++++++++++++

打开 GMT 字体配置文件 `/opt/GMT-4.5.13/share/pslib/PS_font_info.d`，在文件最后加入如下语句（以 Windows 下的四大常用字体为例）:

    STSong-Light--UniGB-UTF8-H  0.700    1
    STFangsong-Light--UniGB-UTF8-H  0.700    1
    STHeiti-Regular--UniGB-UTF8-H   0.700   1
    STKaiti-Regular--UniGB-UTF8-H   0.700   1

第一列为字体名，第二列为字母 A 的高度，第三列与编码有关。

查看 GMT 当前支持的字体
++++++++++++++++++++++
用 `pstext -L` 命令查看 GMT 当前的字体配置::

    $ pstext -L
    Font #  Font Name
    ------------------------------------
    0   Helvetica
    1   Helvetica-Bold
    ...    ......
    32  Palatino-BoldItalic
    33  ZapfChancery-MediumItalic
    34  ZapfDingbats
    35 STSong-Light--UniGB-UTF8-H
    36 STFangsong-Light--UniGB-UTF8-H
    37 STHeiti-Regular--UniGB-UTF8-H
    38 STKaiti-Regular--UniGB-UTF8-H

其中 0-34 为 GMT/gs 默认支持的西文字体，35 至 38 为新添加的中文字体。

GMT 中文测试
++++++++++++++++++++++

GMT5 测试脚本：

``` bash
#!/bin/bash
gmt gmtset FONT_TITLE 40p,35,black

gmt pstext -R0/10/0/3 -JX15c/3c -Bafg -B+t"GMT中文支持" -F+a+c+f -P > gmt5_cn.ps << EOF
3 2.1 0 LM 35p,35,red   GMT宋体
3 0.9 0 LM 35p,36,blue  GMT仿宋
7 2.1 0 LM 35p,37,black GMT黑体
7 0.9 0 LM 35p,38,green GMT楷体
EOF

rm gmt.*
```

成图效果如下


对其他发行版的若干说明
----------------------

其他发行版与 CentOS 7 之间或多或少有一些区别，列举如下。

CentOS 6
++++++++++++++

1.  gs 中文配置文件需要用如下命令安装:

        sudo yum install cjkuni-fonts-ghostscript

    在安装配置文件的同时会安装中文字体 uming 和 ukai

2.  gs 中文配置文件中给定的字体路径： `/usr/share/fonts/cjkuni/uming.ttc`
    和 `/usr/share/fonts/cjkuni/ukai.ttc` 是错误的。正确的字体路径是
    `/usr/share/fonts/cjkui-uming/uming.ttc`\` 和
    `/usr/share/fonts/cjkuni-ukai/ukai.ttc` ，要注意改正。

Ubuntu 14.04/15.04
+++++++++++++++++++++++++

1.  gs 中文配置文件可以用如下命令安装（默认已安装）:

        sudo apt-get install poppler-data

2.  gs 中文配置文件路径为：`/etc/ghostscript/cidfmap.d/90gs-cjk-resource-gb1.conf`
3.  gs 中文配置文件中默认使用的 Linux 字体为 uming 和 ukai，需要通过如下命令安装:

        sudo apt-get install fonts-arphic-uming fonts-arphic-ukai

4.  gs 中文配置文件的默认内容为:

        /BousungEG-Light-GB <</FileType /TrueType /Path (/usr/share/fonts/truetype/arphic/uming.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /GBZenKai-Medium    <</FileType /TrueType /Path (/usr/share/fonts/truetype/arphic/ukai.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /Song-Medium /GBZenKai-Medium ;
        /STSong-Light /BousungEG-Light-GB ;
        /STFangsong-Light /BousungEG-Light-GB ;
        /STHeiti-Regular /BousungEG-Light-GB ;
        /STKaiti-Regular /BousungEG-Light-GB ;
        /Adobe-GB1      /BousungEG-Light-GB ;
        /Adobe-GB1-Bold /GBZenKai-Medium ;

    需要将该文件改成:

        % 原配置文件的内容，与 STSong-Light 等相关的四行必须删除
        /BousungEG-Light-GB <</FileType /TrueType /Path (/usr/share/fonts/truetype/arphic/uming.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /GBZenKai-Medium    <</FileType /TrueType /Path (/usr/share/fonts/truetype/arphic/ukai.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /Song-Medium /GBZenKai-Medium ;
        /Adobe-GB1      /BousungEG-Light-GB ;
        /Adobe-GB1-Bold /GBZenKai-Medium ;

        % 新增 Windows 字体的支持
        /STSong-Light <</FileType /TrueType /Path (/usr/share/fonts/winfonts/simsun.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /STFangsong-Light <</FileType /TrueType /Path (/usr/share/fonts/winfonts/simfang.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /STHeiti-Regular <</FileType /TrueType /Path (/usr/share/fonts/winfonts/simhei.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /STKaiti-Regular <</FileType /TrueType /Path (/usr/share/fonts/winfonts/simkai.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;

    修改完 gs 中文配置文件后，必须要执行如下命令:

        $ sudo update-gsfontmap

    该命令会将 `/etc/ghostscript/cidfmap.d/*.conf` 合并成单独的文件
    `/var/lib/ghostscript/fonts/cidfmap` 。gs 在需要中文字体时会读取
    `/var/lib/ghostscript/fonts/cidfmap` 而不是
    `/etc/ghostscript/cidfmap.d/*.conf`
    。这是 Ubuntu/Debian 和 CentOS 的一个很大不同。

Ubuntu 12.04
++++++++++++++++++++++

1.  gs 中文配置文件需要用如下命令安装:

        sudo apt-get install gs-cjk-resource

2.  其他部分未做测试，估计跟 Ubuntu 15.05 差不多。

可移植性的测试
--------------

-   本机：用 vi 打开 PS 文件，中文正常显示；
-   本机：gs 查看正常；
-   本机：ps2raster 转换为 PDF，用 evince、zathura 查看正常；
-   本机：ps2pdf 转换为 PDF，用 evince、zathura 查看正常；
-   复制到 Windows：用 gs 查看正常；

参考资料
--------

1.  GMT 软件显示汉字的技术原理与实现*，赵桂儒，《测绘通报》*
2.  [ghostscript 中文打印经验](http://guoyoooping.blog.163.com/blog/static/13570518320101291442176)
3.  [GMT 中文支持](http://xxqhome.blog.163.com/blog/static/1967330202011112810120598/)
4.  [GMT chinese support](http://hi.baidu.com/guyueshuiming/item/0052df53852ee4494fff20c3)
5.  [维基词条：PostScript](https://en.wikipedia.org/wiki/PostScript)
6.  [Debian Wiki](https://wiki.debian.org/gs-undefoma)

更新历史
--------

-   2013-05-15：修正了中文测试脚本的一个 bug。
-   2013-05-16：系统默认未安装 ghostscript 的中文字体包，conf.d 文件夹为空，通过安装相应中文包解决该问题。
-   2013-08-17：添加了字体以及 ghostscript 可能需要的几个安装包的信息；以及在新增字体后要重建字体缓存。
-   2014-10-14：重写整个文档，使其更具有普遍性；
-   2015-08-31：Ubuntu 下需要使用 `update-gsfontmap` 命令来更新中文配置文件；
