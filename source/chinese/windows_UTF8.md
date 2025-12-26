---
author: 田冬冬, 陈箫翰
date: 2025-12-12
---

# Windows 下的 GMT 中文支持（UTF8编码）

中文版 Windows 系统的默认使用 GB 编码。本篇通过将系统编码修改为 UTF8，实现 GMT 的中文支持。
如果不愿意修改系统的编码，则需要在每次画图时，修改 GMT 画图脚本以及数据文件为 GB 编码。
有这部分需求的用户请参考另一篇配置指南： {doc}`/chinese/windows`

## Ghostscript 的中文支持

GMT 需要使用 Ghostscript 将 PostScript 文件转换为 PDF、JPG 等格式的图片。
PostScript CID 字体（Character Identifier Font，字符标识符字体）是
Adobe Systems 为解决大字符集语言（主要是中文、日文、韩文，合称 CJK）的排版和打印问题而开发的一种字体格式架构，
专门为了让电脑和打印机能够高效处理成千上万个汉字。

但 GMT 安装包中内置的 Ghostscript 是一个精简的版本，缺失了支持 CID 字体的必要文件，因此 **不支持**中文。

若需要 GMT 支持中文，用户必须自行安装一个完整版的 Ghostscript。完整版安装包下载地址:

- [gs10051w64.exe（64 位）](https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10051/gs10051w64.exe)

:::{warning}
请注意 Ghostscript 的版本！
由于 Ghostscript 自身的 bug，请勿使用 9.27、9.51 和 9.52 版本的 Ghostscript。
此外某些 GMT 和 Ghostscript 的版本组合会造成半透明效果失效等等诸多问题，
对于 GMT 6.4.0 及其他较低版本，建议使用 Ghostscript 9.53-9.56；
对于 GMT 6.5.0 则建议使用 Ghostscript 10.03 之后的新版本。
:::

在安装 Ghostscript 的过程中，会有一个生成 cidfmap 的选项 `Generate cidfmap for Windows CJK TrueType fonts`。
选中该选项则表示会为当前系统自动生成中文所需的 cidfmap 文件。默认该选项是被选中的，一定 **不要** 将该选项取消。

GMT 默认会调用自带的精简版 Ghostscript。我们只需要简单将其重命名，就能让 GMT 调用完整版的 Ghostscript。
打开命令提示符 cmd，输入以下命令查找 GMT 的安装目录，进入该目录将精简版 Ghostscript 重命名即可：

```doscon
C:\Windows\system32> where gmt
c:\programs\gmt6\bin\gmt.exe
C:\Windows\system32> cd /d c:\programs\gmt6\bin\
c:\programs\gmt6\bin> ren gswin64c.exe gswin64c.exe.bak
c:\programs\gmt6\bin> where gswin64c
C:\Program Files\gs\gs10.05.1\bin\gswin64c.exe
```

请注意，如果 `where gmt` 或 `where gswin64c` 出现多个结果，说明系统中同时安装了多个 GMT 或 Ghostscript。
这种情况极易发生冲突，必要时需要卸载多余的 GMT 或 Ghostscript。

## GMT 的中文支持

打开命令提示符 cmd，输入以下命令创建 GMT 配置文件目录，并创建 GMT 自定义字体配置文件：

```doscon
C:\Windows\system32> cd /d %USERPROFILE%
C:\Users\当前用户名> mkdir .gmt
C:\Users\当前用户名> REM 注释：如果目录已存在会提示 A subdirectory or file .gmt already exists.
C:\Users\当前用户名> cd .gmt
C:\Users\当前用户名\.gmt> notepad PSL_custom_fonts.txt
```

向 GMT自定义字体配置文件 `C:\Users\当前用户名\.gmt\PSL_custom_fonts.txt` 中加入如下内容并保存:

```
dummy  0.700    1
STSong-Light--UniGB-UTF8-H  0.700    1
STFangsong-Light--UniGB-UTF8-H  0.700    1
STHeiti-Regular--UniGB-UTF8-H   0.700   1
STKaiti-Regular--UniGB-UTF8-H   0.700   1
STSong-Light--UniGB-UTF8-V  0.700    1
STFangsong-Light--UniGB-UTF8-V  0.700    1
STHeiti-Regular--UniGB-UTF8-V   0.700   1
STKaiti-Regular--UniGB-UTF8-V   0.700   1
```

用 `gmt text -L` 查看 GMT 字体:

```doscon
C:\Users\当前用户名\.gmt> gmt text -L
...    ......
39: dummy
40: STSong-Light--UniGB-UTF8-H
41: STFangsong-Light--UniGB-UTF8-H
42: STHeiti-Regular--UniGB-UTF8-H
43: STKaiti-Regular--UniGB-UTF8-H
44: STSong-Light--UniGB-UTF8-V
45: STFangsong-Light--UniGB-UTF8-V
46: STHeiti-Regular--UniGB-UTF8-V
47: STKaiti-Regular--UniGB-UTF8-V
```

Windows 平台的 GMT 目前存在一个 bug，自定义字体只有从编号40才开始生效。因此编号39需要用一个不存在的假字体占位。
新添加的四种中文字体对应的字体编号为 40 到 47。
其中 `STSong-Light--UniGB-UTF8-H` 即为宋体，`UniGB-UTF8` 是文字编码方式，
`H` 表示文字水平排列，`V` 表示竖排文字。
强烈建议在执行测试脚本前确认自己的中文字体编号。

## 将 Windows 的 ANSI 编码修改为 UTF-8

在 Windows 上，标准的C语言 `main(int argc, char *argv[])` 函数默认是从系统获取 ANSI 编码（在中文系统下就是 GBK）的参数，而不是 UTF-8。
为此我们需要开启 Windows 的 **Beta版: 使用 Unicode UTF-8 提供全球语言支持**，
这是 Windows 10/11 专门为解决标准的C语言程序不支持 UTF-8 而提供的系统级功能。
开启这个选项后，Windows 会把系统的“ANSI 代码页”强制改为 UTF-8。
所有使用 `main(int argc, char *argv[])` 接收参数的C语言程序，都会自动接收到 UTF-8 编码。

操作步骤：

1. 按下 `Win + R`，输入 `intl.cpl`，回车打开 “区域” 设置。
2. 点击 “管理” 标签页。
3. 点击 “更改系统区域设置...” 按钮。
4. 关键步骤： 勾选 **Beta 版: 使用 Unicode UTF-8 提供全球语言支持**。
5. 点击确定。注意必须 **重启电脑**后才能生效。

:::{warning}
副作用警告： 这个设置是全局的。开启后，某些非常古老的中文软件（例如十几年前的游戏或行业软件）可能会出现乱码。
如果发现其他软件乱码，取消勾选并重启即可恢复。

如果文件名过长，在FAT32格式的U盘中读写文件将出现报错：0x800700ea。用户可以修改文件名，或放弃本篇的配置方案。

此外，如果原本设置为GB编码的文件，用 Windows 自带的记事本打开会乱码。用支持任意切换编码的编辑器软件打开这些文件（例如 VScode），另存为 UTF-8 编码即可。
:::

## GMT 中文测试

:::{note}
请自行确认你的中文字体编号。如果编号不是40到47，请自行修改以下测试脚本。
:::

```{literalinclude} GMT_Chinese_UTF8.bat
:language: bat
```

成图效果如下：

:::{figure} GMT_Chinese.png
:align: center
:width: 100%
:::
