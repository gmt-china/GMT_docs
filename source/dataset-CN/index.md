# 中国地理空间数据集

“中国地理空间数据集”包含了一系列中国区域的地理空间数据，可以直接用于 GMT 绘图。
数据由 GMT 用户提供，并由 GMT 中文社区收集和维护。

**数据列表**

```{toctree}
:maxdepth: 1

CN-border
CN-faults
CN-block/index
geo3al/index
```

**下载数据**

- 项目主页： <https://github.com/gmt-china/china-geospatial-data>
- 下载地址： <https://github.com/gmt-china/china-geospatial-data/releases>

macOS/Linux 用户请下载数据 {file}`china-geospatial-data-UTF8.zip`（UTF8 编码），
Windows 用户请下载数据 {file}`china-geospatial-data-GB2312.zip`（GB2312 编码）。

**使用数据**

推荐按照{ref}`自定义数据 <setup_database>`一节中介绍的方法构建一个 GMT 数据库目录，
并将压缩包内的所有文件解压至这个目录中。
然后就可以在 GMT 命令中直接使用该目录下的数据文件，而不用指定绝对路径。
请阅读本章其他小节以了解每个数据的具体用法与示例。

## 其他中国数据集

下面列出了其他未经整理的中国地学数据集，用户可从对应网址中下载并使用：

- 中国区域地表热流：<https://doi.org/10.1016/j.tecto.2019.01.006>
- 1:100万全国标准基础地理数据: <https://gmt-china.org/blog/national-geographic-database/>
