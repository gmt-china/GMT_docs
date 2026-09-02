---
author: 田冬冬, 姚家园
date: 2025-11-01
---

# macOS 下使用 Homebrew 安装 GMT

[Homebrew](https://brew.sh/) 是 macOS 下的第三方软件包管理工具。
未安装 Homebrew 的用户，可以参考
《[macOS 配置指南](https://seismo-learn.org/seismology101/computer/macos-setup/#homebrew)》了解如何安装与使用。

1. 安装 GMT

   更新 Homebrew 以及软件包描述文件，并更新所有已安装的软件包:

   ```
   $ brew update && brew upgrade
   ```

   安装最新的 GMT 稳定版本:

   ```
   $ brew install gmt
   ```

   也可以安装 GMT 开发版本（即 GMT 源码的 master 分支）:

   ```
   $ brew install gmt --HEAD
   ```

2. 安装 GMT 依赖的其它软件

   GMT 的运行还依赖以下软件：

   - [Ghostscript](https://www.ghostscript.com/)：生成 PDF、JPG 等格式的图片 [**必须**]
   - [GraphicsMagick](http://www.graphicsmagick.org)：制作 GIF 格式的动画 [**可选**]
   - [FFmpeg](http://www.ffmpeg.org/)：生成 MP4 格式的动画 [**可选**]

   ```
   $ brew install ghostscript
   $ brew install graphicsmagick
   $ brew install ffmpeg
   ```

3. 测试安装。打开终端，键入如下命令。若正确显示 GMT 版本号，则表示安装成功：

   ```
   $ gmt --version
   6.6.0
   ```

4. GMT 新版本发布后，若需要升级到新版本，可以执行如下命令：

   ```
   $ brew upgrade gmt
   ```

5. 若需要卸载 GMT，可以执行如下命令：

   ```
   $ brew uninstall gmt
   ```
