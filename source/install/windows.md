---
author: 田冬冬, 陈箫翰, 姚家园, 周茂
date: 2025-12-13
---

# Windows 下使用安装包安装 GMT

## 安装 GMT

1. 下载 GMT 安装包 [gmt-6.6.0-win64.exe](https://github.com/GenericMappingTools/gmt/releases/download/6.6.0/gmt-6.6.0-win64.exe)

   GMT 安装包中不仅包含了 GMT，还包含了运行 GMT 所需的如下软件：

   - [GDAL](https://gdal.org/)：用于多种地学数据格式的转换
   - [FFmpeg](https://ffmpeg.org/)：用于生成 mp4 或 webm 格式的动画
   - [Ghostscript](https://www.ghostscript.com/)：用于生成 PDF、JPG 等图片格式

2. 安装 GMT

   双击安装包即可安装。在 “Choose components” 页面应勾选全部选项。

   :::{note}
   安装过程中可能会出现如下警告:

   ```
   Warning! Failed to add GMT to PATH. Please add the GMT bin path to PATH manually.
   ```

   出现此警告的原因是系统的环境变量 **PATH** 太长，GMT 安装包无法直接修改。
   解决办法是先忽略这一警告，待安装完成后按照本节末尾常见问题中的步骤手动修改系统环境变量 **PATH**，
   添加 GMT 安装目录下的 `bin` 目录的路径，如 `C:\programs\gmt6\bin`。
   :::

3. 测试安装

   安装完成后，打开命令提示符 cmd，输入以下命令检查安装是否成功：

   ```doscon
   > where gmt
   c:\programs\gmt6\bin\gmt.exe
   > gmt --version
   6.6.0
   ```
   
   如果出现的安装路径和版本号符合预期，则表示 GMT 安装成功。
   失败的原因极有可能是杀毒软件/安全软件在 GMT 安装过程中拦截 **PATH** 环境变量的修改。
   用户需要按照章节最后常见问题中的步骤手动修改系统环境变量 **PATH**，添加 GMT 安装目录下的 `bin` 目录的路径。

4. 升级 GMT

   GMT 目前不具备自动更新功能。如果想要升级新版本，通常需要先卸载旧版本。
   卸载完成后，再下载并安装新版安装包以完成升级。

5. 卸载 GMT

   若想要卸载 GMT，可以进入系统的设置 -> 应用，或控制面板 -> 卸载程序进行卸载。
   偶尔会遇到卸载不干净的情况，可以等卸载程序执行完成后再手动删除 GMT 安装目录即可。

## 安装可选软件

### GraphicsMagick

GMT 的 {doc}`/module/movie` 模块在制作 GIF 格式的动画时需要使用
[GraphicsMagick](http://www.graphicsmagick.org/)。
如有制作 GIF 动画的需求，则可以安装这个软件，并将其 {file}`bin` 目录加入到系统环境变量 **PATH** 中，
以保证 GMT 可以找到其提供的 `gm` 命令。

## 安装 Bash 环境

GMT 可以直接在 Windows 下的 Batch 脚本中使用，但由于 Batch 脚本自身功能的局限性，无法完全发挥
GMT 的强大功能。因而，建议 Windows 用户安装 Bash 环境并编写 Bash 脚本来使用 GMT。

使用 Bash 环境的优势在于：

1. Bash 语法比 Batch 语法更丰富，提供了更多的功能
2. Bash 环境提供了多个可用于数据处理的命令行工具，为 GMT 数据处理和进一步绘图提供了支撑
3. 本教程中所有脚本均为 Bash 语法，读者可不做修改直接在 Bash 环境中执行

在 Windows 下使用 Bash 环境的方式有很多，如:

1. [Git for Windodws](https://gitforwindows.org/)
2. [Cygwin](https://cygwin.com/)
3. [MSYS2](https://www.msys2.org/)
4. [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/)

用户可以根据自己的喜欢选择合适的 Bash 环境。对于不熟悉 Bash 环境的用户，可以直接安装
Git for Windows。

## 常见问题

由于 Windows 系统的复杂性、各种杀毒软件/安全软件的拦截行为、以及用户之前安装的各种专业软件的兼容性问题，
直接使用安装包安装 GMT 可能无法正常运行使用。如果出现无法正常运行的情况，建议用户对系统环境进行如下检查。

### 用户主目录检查

打开命令提示符 cmd，输入以下命令检查你的 Windows 登录用户主目录：

```doscon
> echo %USERPROFILE%
你的当前登录用户主目录
```

GMT 只支持用户名为字母、数字、下划线的组合。如果登录用户主目录包含空格、中文或其他符号，将导致 GMT 运行出错。
如果不符合要求，请新建一个用户，然后使用新用户登录 Windows。
请注意更改用户名是无效操作，因为系统仅仅只是改变了显示的名字，用户主目录不会发生变化，仍然包含非法字符。
用户主目录是由第一次创建这个用户时输入的用户名决定的。

### PATH 环境变量检查

输入以下命令检查 **PATH**环境变量：

```doscon
> echo %PATH%| find /i "%SystemRoot%\System32" >nul && echo [√] || echo [X]
[√] 表示 PATH 中包含了 System32 目录
[X] 警告 PATH 中丢失了 System32 目录
```

如果 **PATH**环境变量中丢失了 System32 目录，那么将无法正常运行 bat 画图脚本。
出现这个问题的原因通常是杀毒软件/安全软件/电脑管家等所谓的“系统优化”的结果。
需要按照如下步骤手动添加系统环境变量 **PATH**：

1. 按键盘上的 `Win + R`打开运行窗口。
2. 输入 `sysdm.cpl`并回车。
3. 在弹出的“系统属性”窗口中，点击顶部的 “高级” 选项卡。
4. 点击底部的 “环境变量(N)...” 按钮。
5. 在弹出的窗口中：
 - 上面的框是“用户变量”（只对当前用户生效，无需管理员权限）。
 - 下面的框是“系统变量”（对所有用户生效，保存时需要管理员权限）。
6. 在对应的框中找到 Path 这一行双击，点击“新建”，粘贴 `C:\Windows\System32`。
7. 一路点击 “确定” 保存关闭。

修改完 **PATH**后，已经打开的 cmd 窗口不会自动更新。重新打开一个新的 cmd 窗口再次检查是否添加成功。

此外杀毒软件/安全软件同样会在 GMT 安装过程中拦截 **PATH** 环境变量的修改。请务必关闭安全软件之后再安装。

### 重复安装检查

输入以下命令检查是否已经存在 GMT 软件：

```doscon
> where gmt
```

如果有输出结果，则表明系统中已经安装过 GMT 了，也有可能是某些专业软件内置了 GMT。
同时安装多个 GMT 极易发生冲突，必要时需要卸载多余的 GMT 或专业软件。
