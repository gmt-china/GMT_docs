# WSM_2016: 全球地应力数据

:撰写: {{ 陈箫翰 }}, {{ 田冬冬 }}
:最近更新日期: 2024-03-24

---

World Stress Map Database Release 2016 是一个全球地应力数据库，提供 csv、xlsx、KML 格式数据的下载。

- 官方网站: <https://doi.org/10.5880/WSM.2016.001>
- 数据下载: <https://datapub.gfz-potsdam.de/download/10.5880.WSM.2016.001/>

## 数据简介

WSM_2016 数据集包含了地壳上部40 km的42870条数据记录，提供了三个数据文件：

- `wsm2016.csv`: 以逗号分割的文本格式
- `wsm2016.xlsx`: Excel格式数据
- `wsm2016_google.zip`: 用于导入谷歌地球的格式

更详细的数据说明请阅读相同目录下的数据格式说明PDF文件。

## 使用示例

### wsm2016.csv

数据文件 `wsm2016.csv` 是可以直接使用GMT或Shell命令处理的数据格式，最为方便。
包含了数据点经纬度、深度、破裂类型等信息。不同列所代表的含义请阅读数据格式说明PDF文档。
下面的示例使用 `awk` Shell命令提取需要的不同类型数据并分别绘制：

```{eval-rst}
.. gmtplot:: WSM_2016.sh
   :width: 80%
```

## 引用信息

Heidbach, Oliver; Rajabi, Mojtaba; Reiter, Karsten; Ziegler, Moritz; WSM Team (2016): World Stress Map Database Release 2016. V. 1.1. GFZ Data Services. <https://doi.org/10.5880/WSM.2016.001>
