---
author: 田冬冬, 陈箫翰
date: 2025-12-27
---

# Windows 下的 GMT 中文支持（GB编码）

## Ghostscript 的中文支持

GMT 需要使用 Ghostscript 将 PostScript 文件转换为 PDF、JPG 等格式的图片。
PostScript CID 字体（Character Identifier Font，字符标识符字体）是
Adobe Systems 为解决大字符集语言（主要是中文、日文、韩文，合称 CJK）的排版和打印问题而开发的一种字体格式架构，
专门为了让电脑和打印机能够高效处理成千上万个汉字。
但 GMT 安装包中内置的 Ghostscript 是一个精简的版本，缺失了支持 CID 字体的必要文件，因此 **不支持**中文。

若需要 GMT 支持中文，则需要在安装 GMT 时不勾选 Ghostscript 组件，待安装完成后再自行安装一个完整版的 Ghostscript。
对于已安装 GMT 的用户，必须先卸载 GMT，再按照《{doc}`/install/windows`》一节的步骤重新安装 GMT，安装过程中注意
**不勾选** Ghostscript。

Ghostscript 完整版安装包下载地址:

- [gs10060w64.exe（64 位）](https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10060/gs10060w64.exe)

:::{warning}
请注意 Ghostscript 的版本！
由于 Ghostscript 自身的 bug，请勿使用 9.27、9.51 和 9.52 版本的 Ghostscript。
此外某些 GMT 和 Ghostscript 的版本组合会造成半透明效果失效等等诸多问题，
对于 GMT 6.4.0 及其他较低版本，建议使用 Ghostscript 9.53-9.56；
对于 GMT 6.5.0 则建议使用 Ghostscript 10.03 之后的新版本。
:::

在安装 Ghostscript 的过程中，会有一个生成 cidfmap 的选项 `Generate cidfmap for Windows CJK TrueType fonts`。
选中该选项则表示会为当前系统自动生成中文所需的 cidfmap 文件。默认该选项是被选中的，一定 **不要** 将该选项取消。

完成后打开命令提示符 cmd，输入以下命令。如果操作正常那么命令都只有一个输出结果：

```doscon
C:\Windows\system32> where gmt
c:\programs\gmt6\bin\gmt.exe
C:\Windows\system32> where gswin64c
C:\Program Files\gs\gs10.06.0\bin\gswin64c.exe
```

如果出现多个结果，说明系统中同时存在多个 GMT 或 Ghostscript。这种情况极易发生冲突和中文乱码。
用户需要仔细检查步骤是否有错漏，并卸载多余的软件。

## GMT 的中文支持

打开命令提示符 cmd，输入以下命令创建 GMT 配置文件目录，并创建 GMT 自定义字体配置文件：

```doscon
C:\Windows\system32> cd /d %USERPROFILE%
C:\Users\当前用户名> if not exist .gmt mkdir .gmt
C:\Users\当前用户名> cd .gmt
C:\Users\当前用户名\.gmt> notepad PSL_custom_fonts.txt
```

向 GMT自定义字体配置文件 `C:\Users\当前用户名\.gmt\PSL_custom_fonts.txt` 中加入如下内容并保存:

```
STSong-Light--GB-EUC-H  0.700    1
STFangsong-Light--GB-EUC-H  0.700    1
STHeiti-Regular--GB-EUC-H   0.700   1
STKaiti-Regular--GB-EUC-H   0.700   1
STSong-Light--GB-EUC-V  0.700    1
STFangsong-Light--GB-EUC-V  0.700    1
STHeiti-Regular--GB-EUC-V   0.700   1
STKaiti-Regular--GB-EUC-V   0.700   1
```

用 `gmt text -L` 查看 GMT 字体:

```
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
```

可以看到，新添加的四种中文字体对应的字体编号为 39 到 46。
其中 `STSong-Light-GB-EUC-H` 即为宋体，`GB-EUC` 是文字编码方式，
`H` 表示文字水平排列，`V` 表示竖排文字。
强烈建议在执行测试脚本前确认自己的中文字体编号。

## GMT 中文测试

:::{note}
请自行确认你的中文字体编号。如果编号不是39到46，请自行修改以下测试脚本。
:::

:::{warning}
目前发现 **Git Bash** 运行Bash脚本时， `echo` 生成文件使用的是 UTF8 编码，
从而可能会导致中文乱码。建议在有中文需求时使用bat脚本，或者避免在Bash脚本
中使用 `echo` 。
:::

使用**记事本**和 **Notepad++** 的用户，应注意含中文的bat文件和输入数据文件都应以 **ANSI** 编码保存，
使用其他编码方式则极可能出现乱码。Notepad++除了注意要选择 “ 编码 -> 使用ANSI编码 ” 以外，还应该选中
“ 设置 -> 首选项 -> 新建 -> 编码 -> ANSI ”。

**Visual Studio Code** 用户，应注意确保含中文的bat文件和输入数据文件都采用 **GB2312** 编码方式。
在Visual Studio Code右下角状态栏中可以查看并修改当前文件的编码方式。

```{literalinclude} GMT_Chinese.bat
```

:::{note}
GMT 6.x 目前在Windows下处理中文时存在BUG，可能会出现某些中文正常显示，某些
不正常显示的情况。使用:

```
gmt set PS_CHAR_ENCODING Standard+
```

可临时避免这一BUG。

此外，GMT 6.3 及之后的版本每句使用中文的命令之前，
以及使用echo命令输出含中文的文件之前，必须设置 `chcp 936` ，即 GB 编码。否则将出现乱码:

```
chcp 936
```
:::

成图效果如下：

:::{figure} GMT_Chinese.png
:align: center
:width: 100%
:::
