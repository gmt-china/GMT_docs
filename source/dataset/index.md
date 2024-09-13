(setup-database)=
# 自定义数据

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

# 全球地学数据集

用户可以自行在网络上找到更多地学数据，建立 GMT 数据库，供 GMT 使用。
GMT 中文社区整理了一些自定义数据，供用户选用：

- {doc}`gadm/index`
- {doc}`PB2002/index`
- {doc}`global_tectonics/index`
- {doc}`WSM_2016/index`

用户还可以在网上找到更多其他地学相关数据。可根据需求自行下载，并使用 GDAL 提供的
{ref}`ogr2ogr` 或 {ref}`gdal_translate` 命令转换为 GMT 可识别的数据格式。
下面列出一些地学数据的链接：

- 美国地质图：<https://mrdata.usgs.gov/geology/state/>
- 全球布格重力异常：<https://bgi.obs-mip.fr/grids-and-models-2/>

```{toctree}
:hidden: true
:maxdepth: 1

gadm/index
PB2002/index
global_tectonics/index
WSM_2016/index
```
