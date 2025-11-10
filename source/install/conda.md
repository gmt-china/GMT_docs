---
author: 田冬冬, 姚家园, 陈箫翰
date: 2025-11-01
---

# 使用 conda 安装 GMT

[conda](https://docs.conda.io/en/latest/) 是一款可在 Linux、Windows 和 macOS 上使用的
跨平台软件包管理工具，可用于安装 GMT。

通常情况下，无法单独安装 `conda`。Miniforge 是一个轻量级的 Python 发行版，内置了 `conda` 管理器，
因此可以通过安装 Miniforge 来获取并使用 `conda`。
用户可参考《[conda 教程](https://seismo-learn.org/software/conda/)》安装 Miniforge，
并学习 `conda` 的基本用法。

1. 安装 GMT

   安装最新的 GMT 稳定版本:
   ```
   $ conda install gmt
   ```

   也可以安装 GMT 开发版本（该开发版本会每隔几周更新一次）:
   ```
   $ conda install gmt -c conda-forge/label/dev
   ```

2. 安装 GMT 依赖的其它软件

   GMT的运行还依赖以下软件：

   - [Ghostscript](https://www.ghostscript.com/)：生成 PDF、JPG 等格式的图片 [**必须**]
   - [GraphicsMagick](http://www.graphicsmagick.org)：制作 GIF 格式的动画 [**可选**]
   - [FFmpeg](http://www.ffmpeg.org/)：生成 MP4 格式的动画 [**可选**]

   安装 GMT 时已自动安装 Ghostscript。使用如下命令可安装其他依赖：
   ```
   $ conda install graphicsmagick
   $ conda install ffmpeg
   ```

3. 测试安装。打开终端，键入如下命令。若正确显示 GMT 版本号，则表示安装成功：

   ```
   $ gmt --version
   6.6.0
   ```

4. GMT 新版本发布后，若需要升级到新版本，可以执行如下命令：

   ```
   $ conda update gmt
   ```

5. 若需要卸载 GMT，可以执行如下命令：

   ```
   $ conda remove gmt
   ```
