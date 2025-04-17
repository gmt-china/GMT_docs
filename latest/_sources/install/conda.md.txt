# 使用 conda 安装 GMT

:撰写: {{ 田冬冬 }}, {{ 姚家园 }}, {{ 陈箫翰 }}
:最近更新日期: 2025-01-03

---

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

   制作 GIF 格式的动画需要 [GraphicsMagick](http://www.graphicsmagick.org/)（**可选**）:

   ```
   $ conda install graphicsmagick
   ```

   制作 MP4、WebM 格式的动画需要 [FFmpeg](https://ffmpeg.org/)（**可选**）:

   ```
   $ conda install ffmpeg
   ```

2. 测试安装

   ```
   $ gmt --version
   6.5.0
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
