---
author: 田冬冬, 姚家园, 陈箫翰
date: 2025-11-01
---

# 使用 conda 安装 GMT

[conda](https://docs.conda.io/en/latest/) 是一个跨平台的包管理管理工具，其可以用于安装 GMT。

## 安装 conda

`conda` 一般无法直接安装。Miniforge 是一个轻量级的 Python 发行版，其内置了 `conda` 包管理器。
因而可以通过安装 Miniforge 来安装 `conda`。

用户可以参考《[conda 教程](https://seismo-learn.org/software/conda/)》安装 Miniforge 并学习
使用 `conda` 的基本功能。

## 安装 GMT

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

2. 测试安装

   ```
   $ gmt --version
   6.6.0
   ```

## 升级 GMT

GMT 新版本发布后，执行如下命令升级 GMT:

```
$ conda update gmt
```

## 卸载 GMT

执行如下命令可以卸载 GMT:

```
$ conda remove gmt
```
