---
author: 陈箫翰, 田冬冬
date: 2026-02-05
---

# WSM_2025: 全球地应力数据

World Stress Map Database Release 2025 是一个全球地应力数据库，提供 csv、xlsx 格式数据的下载。

- 官方网站: <https://www.world-stress-map.org/>
- 数据下载: <https://datapub.gfz.de/download/10.5880.WSM.2025.001-Scbwez/>
- 格式说明: <https://doi.org/10.48440/wsm.2025.001>

## 数据简介

WSM_2025 数据集包含了地壳的100842条数据记录，提供了两个数据文件：

- `WSM_Database_2025.csv`: 以逗号分割的文本格式
- `WSM_Database_2025.xlsx`: Excel格式数据

更详细的数据说明请阅读数据格式说明 PDF 文件。

## 使用示例

数据包含了观测点经纬度、深度、破裂类型等信息。不同列所代表的含义请阅读数据格式说明 PDF 文档。
但原始数据文件包含引号包裹的逗号，例如 "Tanzania, United Republic of"，处理分隔符时不能简单地使用逗号。
并且数据中包含非 ASCII 字符，有些数据的经纬度等信息缺失。
用户在使用数据时，需要特别注意这些情况，必要时删除不用的数据列简化数据处理过程。
在以下的例子里，使用的不是原始数据，而是手动筛选之后的数据，只保留经纬度、方位角、类型四列：

```{eval-rst}
.. gmtplot:: WSM.sh
   :width: 80%
```

请注意，示例中没有绘制 geologic-volcanic vent alignment 和 anisotropy of seismic waves 两种类型的数据。

## 引用信息

Heidbach, Oliver; Rajabi, Mojtaba; Di Giacomo, Domenico; Harris, James; Lammers, Steffi; Morawietz, Sophia; Pierdominici, Simona; Reiter, Karsten; von Specht, Sebastian; Storchak, Dmitry; Ziegler, Moritz O. (2025): World Stress Map Database Release 2025. GFZ Data Services. https://doi.org/10.5880/WSM.2025.001
