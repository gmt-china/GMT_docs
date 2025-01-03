# 使用 miniforge 安装 GMT

:撰写: {{ 田冬冬 }}, {{ 姚家园 }}, {{ 陈箫翰 }}
:最近更新日期: 2023-09-11

---

[conda](https://docs.conda.io/en/latest/) 是一个跨平台的包管理、环境管理工具。
[conda-forge](https://conda-forge.org/) 频道提供了 GMT 安装包，可以使用 miniforge 安装.

## 安装 miniforge

用户可以参考 https://mirror.nju.edu.cn/help/miniforge 
安装 miniforge，选择安装 Mambaforge-* 系列的包。

## 安装 GMT

1. 安装 GMT

   安装最新的 GMT 稳定版本:

   ```
   $ mamba install gmt -c conda-forge
   ```

   也可以安装 GMT 开发版本（该开发版本会每隔几周更新一次）:

   ```
   $ mamba install gmt -c conda-forge/label/dev
   ```

   制作 GIF 格式的动画需要 [GraphicsMagick](http://www.graphicsmagick.org/)（**可选**）:

   ```
   $ mamba install graphicsmagick -c conda-forge
   ```

   制作 MP4、WebM 格式的动画需要 [FFmpeg](https://ffmpeg.org/)（**可选**）:

   ```
   $ mamba install ffmpeg -c conda-forge
   ```

2. 测试安装

   ```
   $ gmt --version
   6.5.0
   ```

## 升级 GMT

GMT 新版本发布后，执行如下命令升级 GMT:

```
$ mamba update gmt
```

## 卸载 GMT

执行如下命令可以卸载 GMT:

```
$ mamba remove gmt
```
