# 地学数据集

使用 GMT 绘图时，经常用到一些特定的地学数据，如国界线、地形起伏数据等。
这些数据一般不需要任何改动即可用在多种图件中。根据数据来源的不同，
可分为 GMT 数据集和自定义数据两种。

## GMT 数据集

GMT 数据集包括两种：

1. GMT 内置数据：GMT 官方整理的内置于 GMT 软件包中的数据
2. GMT 远程数据：GMT 官方整理的保存在远程 GMT 数据服务器中的数据

```{rubric} GMT 内置数据
```

GMT 内置了如下数据，可以直接在 GMT 中使用：

```{toctree}
:maxdepth: 1

gshhg
dcw/index
```

```{rubric} GMT 远程数据
```

GMT 远程数据位于 GMT 数据服务器，在 GMT 中使用时会自动下载：

```{toctree}
:maxdepth: 1

remote-dataset
```


(setup-database)=
## 自定义数据

GMT 内置数据和远程数据并不能满足所有用户的需求，用户可在 GMT 中使用自己的数据并创建数据库。
GMT 中文社区收集并整理了部分全球地学数据集以及中国地理空间数据集，以供用户使用, 见后续章节。

使用自定义数据（即建立 GMT 数据库）的方法很简单，只要将数据集中放在任意一个目录下，
然后修改环境变量 **GMT_DATADIR** 使得其包含该目录即可。
在使用数据库里的数据时，就可以直接指定数据文件名，GMT 会自动到 **GMT_DATADIR**
所指定的目录中寻找该数据，而无需指定数据文件的完整路径。

Linux 和 macOS 用户可以把数据放在 {file}`~/GMTDB`目录下，
然后在 {file}`~/.bashrc` 中添加如下语句:

```
export GMT_DATADIR=~/GMTDB
```

Windows 用户可以把数据放在 **D:\\GMTDB** （路径最好不要有空格）目录下，
然后打开“我的电脑”->“属性”->“高级”->“环境变量”，添加环境变量，变量名为 **GMT_DATADIR**，
值为 **D:\\GMTDB**，最后可能需要重启电脑使得环境变量生效。

如果喜欢将不同的数据分类放在不同的目录下，则可以向 **GMT_DATADIR** 添加多个目录。
多个目录之间用逗号 **,** 分隔。例如:

```
export GMT_DATADIR=~/GMTDB/data1,~/GMTDB/data2
```

Linux 和 macOS 用户，可以进一步简化为:

```
export GMT_DATADIR=~/GMTDB/
```

**GMT_DATADIR** 中的目录若以 **/** 结尾，GMT 则会在 {file}`~/GMTDB` 及其子目录下递归地
寻找文件。注意，Windows 不支持这一功能。

## 全球地学数据集

GMT 中文社区整理了一些全球地学数据，供用户选用：

```{toctree}
:maxdepth: 1

gadm/index
PB2002/index
global_tectonics/index
WSM_2016/index
```

用户还可以在网上找到更多其他地学相关数据。可根据需求自行下载，并使用 GDAL 提供的
{ref}`ogr2ogr` 或 {ref}`gdal_translate` 命令转换为 GMT 可识别的数据格式。
下面列出一些地学数据的链接：

- 美国地质图：<https://mrdata.usgs.gov/geology/state/>
- 全球布格重力异常：<https://bgi.obs-mip.fr/grids-and-models-2/>


## 中国地理空间数据集

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

**其他中国地学数据**

下面列出了其他未经整理的中国地学数据集，用户可从对应网址中下载并使用：

- 中国区域地表热流：<https://doi.org/10.1016/j.tecto.2019.01.006>
- 1:100万全国标准基础地理数据: <https://gmt-china.org/blog/national-geographic-database/>

