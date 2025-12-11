---
author: 陈箫翰, 田冬冬
date: 2025-12-11
---

# Linux/macOS 下的 GMT 中文支持

本文介绍如何让 GMT 在 Linux/macOS 下支持中文。

## ghostscript的中文支持

Linux 的中文字体较少，这里使用 Windows 下提供的四个基本字体：宋体、仿宋、黑体和楷体。
对于 Windows 和 Linux/macOS 的其他中文字体甚至日韩字体来说，方法类似。

首先新建目录，用于存放字体文件和配置文件:

```
$ mkdir -p ~/.gmt/winfonts
# -p 选项会自动创建 ~/.gmt 和 ~/.gmt/winfonts 两级目录
```

点击下载以下四种基本字体的字体文件：

- 宋体 {download}`simsun.ttc <https://github.com/ZMAlt/winfonts/raw/refs/heads/main/simsun.ttc>`
- 仿宋 {download}`simfang.ttf <https://github.com/ZMAlt/winfonts/raw/refs/heads/main/simfang.ttf>`
- 黑体 {download}`simhei.ttf <https://github.com/ZMAlt/winfonts/raw/refs/heads/main/simhei.ttf>`
- 楷体 {download}`simkai.ttf <https://github.com/ZMAlt/winfonts/raw/refs/heads/main/simkai.ttf>`

并复制到刚才新建的 `~/.gmt/winfonts/` 目录下。

用户也可以从 Windows 的系统字体目录（通常是 `C:\Windows\Fonts` ）中，找到这四种基本字体的字体文件。

在 `~/.gmt` 目录下创建[字体配置文件](https://ghostscript.readthedocs.io/en/latest/Fonts.html#fonts-html)
`cidfmap` （ghostscript无法直接识别 `${HOME}` 变量，所以请将下列语句复制粘贴到终端中执行）:

```
cat > ~/.gmt/cidfmap << EOF
/STSong-Light <</FileType /TrueType /Path (${HOME}/.gmt/winfonts/simsun.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
/STFangsong-Light <</FileType /TrueType /Path (${HOME}/.gmt/winfonts/simfang.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
/STHeiti-Regular <</FileType /TrueType /Path (${HOME}/.gmt/winfonts/simhei.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
/STKaiti-Regular <</FileType /TrueType /Path (${HOME}/.gmt/winfonts/simkai.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
EOF
```

ghostscript [查找文件时](https://ghostscript.readthedocs.io/en/latest/Use.html#how-ghostscript-finds-files)，
会搜寻系统环境变量 `$GS_LIB` 中指定的目录。打开终端，使用如下命令用文件编辑器打开 Shell 配置文件:

```
# Linux 用户
$ gedit ~/.bashrc

# macOS 用户
$ open ~/.zshrc
```

然后向文件末尾加入如下语句以修改环境变量。修改完成后保存文件并退出，
然后重启终端使其生效:

```
export GS_LIB=${HOME}/.gmt/
```

## GMT的中文支持

在 `~/.gmt`下创建字体配置文件 `PSL_custom_fonts.txt`:

```
$ touch ~/.gmt/PSL_custom_fonts.txt
# Linux系统
$ gedit ~/.gmt/PSL_custom_fonts.txt
# macOS系统
$ open ~/.gmt/PSL_custom_fonts.txt
```

打开 GMT 字体配置文件，在文件中加入如下语句:

```
STSong-Light--UniGB-UTF8-H  0.700    1
STFangsong-Light--UniGB-UTF8-H  0.700    1
STHeiti-Regular--UniGB-UTF8-H   0.700   1
STKaiti-Regular--UniGB-UTF8-H   0.700   1
STSong-Light--UniGB-UTF8-V  0.700    1
STFangsong-Light--UniGB-UTF8-V  0.700    1
STHeiti-Regular--UniGB-UTF8-V   0.700   1
STKaiti-Regular--UniGB-UTF8-V   0.700   1
```

这几句话分别添加了宋体、仿宋、黑体和楷体四种字体的横排（**H**）和竖排（**V**）两种方式。

用 `gmt text -L` 命令查看 GMT 当前的字体配置:

```
$ gmt text -L
Font #  Font Name
------------------------------------
0   Helvetica
1   Helvetica-Bold
...    ......
39 STSong-Light--UniGB-UTF8-H
40 STFangsong-Light--UniGB-UTF8-H
41 STHeiti-Regular--UniGB-UTF8-H
42 STKaiti-Regular--UniGB-UTF8-H
43 STSong-Light--UniGB-UTF8-V
44 STFangsong-Light--UniGB-UTF8-V
45 STHeiti-Regular--UniGB-UTF8-V
46 STKaiti-Regular--UniGB-UTF8-V
```

其中 39-46 号字体为新添加的中文字体。
以后要用中文字体时，需要用这些编号来指定字体，也许你的机器上的编号和这里不同。

## GMT 中文测试

:::{note}
GMT 6.x 目前在处理中文时存在 BUG，可能会出现某些中文正常显示，某些
不正常显示的情况。需要使用如下命令来避免这一 BUG:

```
gmt set PS_CHAR_ENCODING Standard+
```

请自行确认你的中文字体编号。如果编号不是 39 到 46，请自行修改以下测试脚本。
:::

测试脚本和成图效果如下：

```{eval-rst}
.. gmtplot:: GMT_Chinese.sh
    :show-code: true
    :width: 100%
```

:::{note}
生成的 PNG、JPG 格式的图片中可正常显示中文。
对于 PDF 格式，macOS 自带的预览工具无法正常显示中文，
Adobe PDF Reader 可以正常显示中文，但竖排字体可能出现错位。
:::
