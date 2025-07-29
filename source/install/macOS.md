---
author: 田冬冬, 姚家园
date: 2025-07-28
---

# macOS 下安装 GMT

macOS 下安装 GMT 有多种方式：

1. [使用 Homebrew 安装](macos-homebrew) [**推荐**]
2. [使用 MacPorts 安装](macos-macports)
3. {doc}`conda`

(macos-homebrew)=
## 使用 Homebrew 安装

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

   生成 PDF、JPG 等图片格式需要 [Ghostscript](https://www.ghostscript.com/)（**必须**）:

   ```
   $ brew install ghostscript
   ```

   制作 GIF 格式的动画需要 [GraphicsMagick](http://www.graphicsmagick.org/)（**可选**）:

   ```
   $ brew install graphicsmagick
   ```

   制作 MP4、WebM 格式的动画需要 [FFmpeg](https://ffmpeg.org/)（**可选**）:

   ```
   $ brew install ffmpeg
   ```

3. 测试安装

   重新打开一个终端，键入如下命令，若正确显示 GMT 版本号，则表示安装成功:

   ```
   $ gmt --version
   6.6.0
   ```

4. 升级 GMT

   GMT 新版本发布后，执行如下命令升级 GMT:

   ```
   $ brew upgrade gmt
   ```

5. 卸载 GMT

   可以执行如下命令卸载 GMT:

   ```
   $ brew uninstall gmt
   ```

(macos-macports)=
## 使用 MacPorts 安装

[MacPorts](https://www.macports.org/) 是 macOS 下的第三方软件包管理工具。

1. 安装 GMT:

   ```
   $ sudo port install gdal +hdf5 +netcdf +openjpeg
   $ sudo port install gmt6
   ```

2. GMT 会安装在 {file}`/opt/local/lib/gmt6/` 目录下，需要将其 {file}`bin` 目录添加至
   环境变量 **PATH** 中:

   ```
   $ echo 'export PATH=/opt/local/lib/gmt6/bin:$PATH' >> ~/.zshrc
   ```

3. 安装 GMT 依赖的其他软件

   制作 GIF 格式的动画需要 [GraphicsMagick](http://www.graphicsmagick.org/)（**可选**）:

   ```
   $ sudo port install graphicsmagick
   ```

   制作 MP4、WebM 格式的动画需要 [FFmpeg](https://ffmpeg.org/)（**可选**）:

   ```
   $ sudo port install ffmpeg
   ```

4. 重新打开一个终端，检测安装是否成功:

   ```
   $ gmt --version
   6.6.0
   ```

5. 升级 GMT。当有新版本发布时，可以执行如下命令升级 GMT:

   ```
   $ sudo port selfupdate
   $ sudo port upgrade gmt6
   ```

6. 如果需要卸载 GMT，可以执行如下命令:

   ```
   $ sudo port uninstall gmt6
   ```
