---
author: 田冬冬
date: 2025-11-01
---

# Fedora 下安装 GMT

Fedora 官方源提供了 GMT 二进制包，可直接使用 `dnf` 安装，但官方源提供的可能不是 GMT
最新版本。为解决此问题，GMT 官方制作了一个 RPM 仓库，可用于安装 GMT 最新版本。

用户可以使用 `dnf info GMT` 命令查看官方源提供的 GMT 的版本。

## 使用 Fedora 官方源安装 GMT

1. 安装 GMT 及 GMT 内置数据包

   ```
   $ sudo dnf install GMT GMT-dev GMT-doc
   $ sudo dnf install dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high
   ```

2. 安装 GMT 依赖的其它软件

   GMT的运行还依赖以下软件：

   - [Ghostscript](https://www.ghostscript.com/)：生成 PDF、JPG 等格式的图片 [**必须**]
   - [GraphicsMagick](http://www.graphicsmagick.org)：制作 GIF 格式的动画 [**可选**]
   - [FFmpeg](http://www.ffmpeg.org/)：生成 MP4 格式的动画 [**可选**]

   ```
   $ sudo dnf install ghostscript
   $ sudo dnf install GraphicsMagick

   $ sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm
   $ sudo dnf install ffmpeg
   ```

3. 测试安装。打开终端，键入如下命令。若正确显示 GMT 版本号，则表示安装成功：

   ```
   $ gmt --version
   6.6.0
   ```

4. GMT 新版本发布后，若需要升级到新版本，可以执行如下命令：

   ```
   $ sudo dnf upgrade GMT GMT-dev GMT-doc
   ```

5. 若需要卸载 GMT，可以执行如下命令：

   ```
   $ sudo dnf remove GMT GMT-dev GMT-doc
   $ sudo dnf remove dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high
   ```

## 使用 GMT 官方 RPM 仓库安装 GMT

若 Fedora 官方源提供的 GMT 版本不是最新版，则可以启用
[GMT 官方 RPM 仓库](https://copr.fedorainfracloud.org/coprs/genericmappingtools/gmt/)
以安装 GMT 最新版本。

:::{note}
如果已经通过 Fedora 官方源安装了 GMT 软件包，则必须先使用以下命令卸载，
然后再使用 GMT 官方仓库提供的 GMT 安装包:

```
$ sudo dnf remove GMT dcw-gmt gshhg-gmt-nc4 gshhg-gmt-nc4-full gshhg-gmt-nc4-high
```
:::

1. 启用 GMT 官方 RPM 仓库：

   ```
   $ sudo dnf copr enable genericmappingtools/gmt
   ```

2. 安装最新版 GMT：

   ```
   $ sudo dnf install gmt
   ```

3. 安装 GMT 相关工具以增强 GMT 功能

   GMT 的运行还依赖以下软件：

   - [Ghostscript](https://www.ghostscript.com/)：生成 PDF、JPG 等格式的图片 [**必须**]
   - [GDAL](https://gdal.org/)：地理空间数据格式转换工具 [**必须**]
   - [GraphicsMagick](http://www.graphicsmagick.org)：制作 GIF 格式的动画 [**可选**]
   - [FFmpeg](http://www.ffmpeg.org/)：生成 MP4 格式的动画 [**可选**]

   ```
   $ sudo dnf install ghostscript
   $ sudo dnf install gdal
   $ sudo dnf install GraphicsMagick

   $ sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm
   $ sudo dnf install ffmpeg
   ```

4. GMT 新版本发布后，若需要升级到新版本，可以执行如下命令：

   ```
   $ sudo dnf upgrade gmt
   ```

5. 若需要卸载 GMT，可以执行如下命令：

   ```
   $ sudo dnf remove gmt dcw-gmt gshhg-gmt
   ```
