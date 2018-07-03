Linux 下的 GMT 中文支持
=======================

GMT 原生并不支持中文。为了让 GMT 支持中文，需要修改 ghostscript 和 GMT 的配置文件。
不同的 Linux 发行版下 GMT 中文支持的原理相同，但修改细节不同。
这里先介绍 CentOS 7 上的修改方法，非 CentOS 7 用户可以先看 CentOS 7 的方法原理，
再阅读后面的对其他发行版指导。

准备工作
--------

安装gs中文配置文件
++++++++++++++++++

大多数发行版都已经默认安装了gs。除此之外，还需要安装gs的简体中文配置文件。CentOS 7
下gs简体中文配置文件需要通过如下命令安装::

    $ sudo yum install ghostscript-chinese-zh_CN

安装完成后，中文配置文件的路径为 ``/usr/share/ghostscript/conf.d/cidfmap.zh_CN`` ，
以下称为 ghostscript 中文配置文件。

GMT 字体配置文件
++++++++++++++++

假定 GMT 的安装路径为 ``/opt/GMT-5.4.4`` ，则字体配置文件的路径为
``/opt/GMT-5.4.4/share/postscriptlight/PSL_custom_fonts.txt`` 。

使 gs 支持中文
--------------

gs 中文配置文件
+++++++++++++++

CentOS 7 中 ghostscript 中文配置文件的默认内容为::

    /BousungEG-Light-GB <</FileType /TrueType /Path (/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /GBZenKai-Medium    <</FileType /TrueType /Path (/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
    /MSungGBK-Light     /BousungEG-Light-GB ;
    /Adobe-GB1      /BousungEG-Light-GB ;

其中的细节可能看不懂，但是可以大概总结如下：

- 第一行定义了字体名为 ``/BousungEG-Light-GB`` ，对应的字体文件为 ``/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc`` ，也就是文泉驿正黑；
- 第二行定义了字体名为 ``/GBZenKai-Medium`` ，对应的字体文件也是文泉驿正黑；
- 第三行和第四行分别定义了字体名 ``/MSungGBK-Light`` 和 ``/Adobe-GB1`` ，这两种都对应于 ``/BousungEG-Light-GB`` ，相当于给字体定义了别名。

关于配置文件的几点说明：

- 字体名是任意的，比如字体名可以取为 ``/ABC`` ；
- 字体文件似乎只能是 ``ttc`` 或 ``ttf`` 格式的，当然修改参数也有可能可以使用其他格式的字体；
- 要注意确认字体文件是否存在，比如 CentOS7 下的 ``wqy-zenhei.ttc`` 字体实际上
  位于软件包 ``wqy-zenhei-fonts`` 中。若字体不存在，则需要安装相应软件包。

添加 Windows 中文字体
+++++++++++++++++++++

Linux 的中文字体较少，所以这里使用 Windows 下中的中文字体，这里只考虑 Windows 下的
宋体、仿宋、黑体和楷体四个基本字体。将这四个字体文件复制到 ``/usr/share/fonts/winfonts/``
目录下，然后对 gs 的中文配置文件做如下修改::

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

这里仅以 Windows 下的常用四大字体为例。对于 Windows 下的其他中文字体、Linux 的
其他中文字体甚至日韩字体来说，方法类似。

测试 gs 对 Windows 中文字体的支持
+++++++++++++++++++++++++++++++++

用 **编辑器** 新建一个 PS 文件，名为 ``windows_fonts.ps`` ，其内容为::

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

简单解释一下，PS 文件中要使用某个中文字体，需要用 ``FontName--CMap`` 的格式来调用。
其中 ``FontName`` 即 gs 中文配置文件中给定的字体名。CMap 可以取 ``UniGB-UTF8-H``
和 ``GB-EUC-H`` ， Linux 下一般用前者，Windows 下一般用后者，用于指定汉字或中文
字体的编码。

用 gs 查看该 PS 文件，若正确显示中文如下图，则表明 gs 已支持 Windows 字体。

.. figure:: /static_images/GMT_chinese_windows_fonts.png
   :width: 500px
   :align: center

使 GMT 支持中文
---------------

修改 GMT 字体配置文件
+++++++++++++++++++++

打开 GMT 字体配置文件，在文件最后加入如下语句（以 Windows 下的四大常用字体为例）::

    STSong-Light--UniGB-UTF8-H  0.700    1
    STFangsong-Light--UniGB-UTF8-H  0.700    1
    STHeiti-Regular--UniGB-UTF8-H   0.700   1
    STKaiti-Regular--UniGB-UTF8-H   0.700   1

第一列为字体名，第二列为字母 A 的高度，第三列与编码有关。

查看 GMT 当前支持的字体
+++++++++++++++++++++++

用 ``gmt pstext -L`` 命令查看 GMT 当前的字体配置::

    $ gmt pstext -L
    Font #  Font Name
    ------------------------------------
    0   Helvetica
    1   Helvetica-Bold
    ...    ......
    39 STSong-Light--UniGB-UTF8-H
    40 STFangsong-Light--UniGB-UTF8-H
    41 STHeiti-Regular--UniGB-UTF8-H
    42 STKaiti-Regular--UniGB-UTF8-H

其中 0-38 为 GMT/gs 默认支持的西文字体，39-42 为新添加的中文字体。
以后要用中文字体时，需要用这些编号来指定字体，也许你的机器上的编号和这里不同。

GMT 中文测试
++++++++++++

测试脚本：

.. code-block:: bash

   #!/bin/bash
   gmt set FONT_TITLE 30p,39,black
   gmt set FONT_LABEL 15p,39,black

   gmt pstext -R0/10/0/4 -JX15c/5c -Bxafg+l"X轴" -Byafg+l"Y轴" \
            -BWSen+t"中文标题" -F+f -P > cn.ps << EOF
   3 2.5 35p,39,black GMT宋体
   3 1.0 35p,40,blue GMT仿宋
   7 2.5 35p,41,yellow GMT黑体
   7 1.0 35p,42,green GMT楷体
   EOF

   rm gmt.history gmt.conf

成图效果如下：

.. figure:: /static_images/GMT_chinese.png
   :width: 400px
   :align: center

对其他发行版的若干说明
----------------------

其他发行版与 CentOS 7 之间或多或少有一些区别，列举如下。

CentOS 6
++++++++

1.  gs 中文配置文件需要用如下命令安装::

        sudo yum install cjkuni-fonts-ghostscript

    在安装配置文件的同时会安装中文字体 uming 和 ukai

2.  gs 中文配置文件中给定的字体路径： ``/usr/share/fonts/cjkuni/uming.ttc``
    和 ``/usr/share/fonts/cjkuni/ukai.ttc`` 是错误的。正确的字体路径是
    ``/usr/share/fonts/cjkui-uming/uming.ttc`` 和
    ``/usr/share/fonts/cjkuni-ukai/ukai.ttc`` ，要注意改正。

Ubuntu 14.04/15.04
++++++++++++++++++

1.  gs 中文配置文件可以用如下命令安装（默认已安装）::

        sudo apt-get install poppler-data

2.  gs 中文配置文件路径为： ``/etc/ghostscript/cidfmap.d/90gs-cjk-resource-gb1.conf``
3.  gs 中文配置文件中默认使用的 Linux 字体为 uming 和 ukai，需要通过如下命令安装::

        sudo apt-get install fonts-arphic-uming fonts-arphic-ukai

4.  gs 中文配置文件的默认内容为::

        /BousungEG-Light-GB <</FileType /TrueType /Path (/usr/share/fonts/truetype/arphic/uming.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /GBZenKai-Medium    <</FileType /TrueType /Path (/usr/share/fonts/truetype/arphic/ukai.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
        /Song-Medium /GBZenKai-Medium ;
        /STSong-Light /BousungEG-Light-GB ;
        /STFangsong-Light /BousungEG-Light-GB ;
        /STHeiti-Regular /BousungEG-Light-GB ;
        /STKaiti-Regular /BousungEG-Light-GB ;
        /Adobe-GB1      /BousungEG-Light-GB ;
        /Adobe-GB1-Bold /GBZenKai-Medium ;

    需要将该文件改成::

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

    修改完 gs 中文配置文件后，必须要执行如下命令::

        $ sudo update-gsfontmap

    该命令会将 ``/etc/ghostscript/cidfmap.d/*.conf`` 合并成单独的文件
    ``/var/lib/ghostscript/fonts/cidfmap`` 。gs 在需要中文字体时会读取
    ``/var/lib/ghostscript/fonts/cidfmap`` 而不是
    ``/etc/ghostscript/cidfmap.d/*.conf`` 。这是 Ubuntu/Debian 和 CentOS 的
    一个很大不同。

Ubuntu 12.04
++++++++++++

1.  gs 中文配置文件需要用如下命令安装::

        sudo apt-get install gs-cjk-resource

2.  其他部分未做测试，估计跟 Ubuntu 15.05 差不多。

参考资料
--------

1. GMT 软件显示汉字的技术原理与实现，赵桂儒，《测绘通报》
2. `ghostscript 中文打印经验 <http://guoyoooping.blog.163.com/blog/static/13570518320101291442176>`_
3. `GMT 中文支持 <http://xxqhome.blog.163.com/blog/static/1967330202011112810120598/>`_
4. `维基词条：PostScript <https://en.wikipedia.org/wiki/PostScript>`_
5. `Debian Wiki <https://wiki.debian.org/gs-undefoma>`_
