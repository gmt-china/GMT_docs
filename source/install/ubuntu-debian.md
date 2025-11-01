---
author: 田冬冬, 陈箫翰
date: 2025-11-01
---

# Ubuntu/Debian 下安装 GMT

Ubuntu/Debian 官方源提供了 GMT 二进制包，可直接使用 `apt` 安装，
但官方源提供的可能不是 GMT 最新版本。可以使用以下命令查询官方源提供的最高版本：

```
$ apt-cache madison gmt
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

3. 安装 GMT 依赖的其它软件

   GMT 的运行还依赖以下软件：

   - [Ghostscript](https://www.ghostscript.com/)：生成 PDF、JPG 等格式的图片 [**必须**]
   - [GDAL](https://gdal.org/)：地理空间数据格式转换工具 [**必须**]
   - `xgd-utils`：自动打开生成的图片需要 [**非必须但建议安装**]
   - [GraphicsMagick](http://www.graphicsmagick.org)：制作 GIF 格式的动画 [**可选**]
   - [FFmpeg](http://www.ffmpeg.org/)：生成 MP4 格式的动画 [**可选**]

   ```
   $ sudo apt install xdg-utils
   $ sudo apt install gdal-bin
   $ sudo apt install ghostscript
   $ sudo apt install graphicsmagick
   $ sudo apt install ffmpeg
   ```
