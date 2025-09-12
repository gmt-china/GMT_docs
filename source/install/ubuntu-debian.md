---
author: 田冬冬, 陈箫翰
date: 2025-09-12
---

# Ubuntu/Debian 下安装 GMT

Ubuntu/Debian 官方源提供了 GMT 二进制包，可直接使用 `apt` 安装，
但官方源提供的可能不是 GMT 最新版本。截止 2025-09-12，各个发行版提供的 GMT 版本如下：

```{eval-rst}
.. table::
   :align: center

   +-----------------+-----------+
   | 发行版           |  GMT 版本  |
   +=================+===========+
   | Ubuntu 22.04LTS | 6.3.0     |
   +-----------------+-----------+
   | Ubuntu 24.04LTS | 6.5.0     |
   +-----------------+-----------+
   | Ubuntu 24.10    | 6.5.0     |
   +-----------------+-----------+
   | Ubuntu 25.04    | 6.5.0     |
   +-----------------+-----------+
   | Debian 13       | 6.5.0     |
   +-----------------+-----------+
   | Debian 12       | 6.4.0     |
   +-----------------+-----------+
   | Debian 11       | 6.1.1     |
   +-----------------+-----------+

```

用户如果想使用最新版本的 GMT ，可以选择其他安装方式：
1. {doc}`conda` [**推荐**]
2. {doc}`build-source-unix` 

下面是使用 Ubuntu/Debian 官方源安装 GMT 的步骤：

1. 更新软件包列表:

   ```
   $ sudo apt update
   ```

2. 安装 GMT:

   ```
   $ sudo apt install gmt gmt-dcw gmt-gshhg
   ```

3. 安装 GMT 相关工具

   生成 PDF、JPG 等图片格式需要 [Ghostscript](https://www.ghostscript.com/) [**必须**]:

   ```
   $ sudo apt install ghostscript
   ```

   自动打开生成的图片需要 `xdg-utils`:

   ```
   $ sudo apt install xdg-utils
   ```

   地理空间数据格式转换工具 [GDAL](https://gdal.org/) [**必须**]:

   ```
   $ sudo apt install gdal-bin
   ```

   制作 GIF 格式的动画需要 [GraphicsMagick](http://www.graphicsmagick.org/) [**可选**]:

   ```
   $ sudo apt install graphicsmagick
   ```

   制作 MP4、WebM 格式的动画需要 [FFmpeg](https://ffmpeg.org/) [**可选**]:

   ```
   $ sudo apt install ffmpeg
   ```
