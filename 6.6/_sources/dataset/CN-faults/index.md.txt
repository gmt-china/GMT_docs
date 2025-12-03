---
author: 刘珠妹, 田冬冬, 陈箫翰
date: 2025-11-23
---

# CN-faults: 中国断层数据

CN-faults 数据来自于中国活断层数据库2023版（CAFDv2023），
于2024年7月由中国地震局地质研究所徐锡伟研究团队发布。
该数据库基于约110个活动断层测绘项目和20个城市地区活动断层勘探项目成果汇编更新而成，
反映了中国及邻区活断层调查综合成果。 CAFD（2023）是对第五代区划图成果CAFD(2015)的更新版本。

## 数据下载

- 项目主页： <https://github.com/gmt-china/china-geospatial-data>
- 下载地址： <https://github.com/gmt-china/china-geospatial-data/releases>

macOS/Linux 用户请下载数据 {file}`china-geospatial-data-UTF8.zip`（UTF8 编码），
Windows 用户请下载数据 {file}`china-geospatial-data-GB2312.zip`（GB2312 编码）。

数据包中的数据文件 {file}`CN-faults.gmt` 即为中国区域主要断层。

## 示例图

### 绘制全国断层

```{eval-rst}
.. gmtplot:: CN-faults.sh
   :show-code: true
   :width: 75%
```

### 绘制区域断层

```{eval-rst}
.. gmtplot:: CN-regional-faults.sh
   :show-code: true
   :width: 50%
```

### 标注断层名

使用 {doc}`/module/convert` 模块提取数据并修改段头记录信息。
其中 `-aL="FN_Ch"` 使用OGR/GMT矢量数据格式文件中的 `FN_Ch` 字段，将它的值设置为数据段头记录中标签信息（即 `-L` ）。
详细说明请参考 {doc}`/option/a` 和 {ref}`table-ascii-attrs` 。

```
$ gmt convert CN-faults.gmt -aL="FN_Ch"
> -L招远—黄墩断裂
119.237289736   35.50975368     0
119.277799736   35.55371168     0
119.318480736   35.61789268     0
119.377370736   35.70849468     0
119.418367736   35.75389168     0
> -L百尺河断裂
119.360213473   36.138556029    0
119.596289331   36.123075645    0
119.647890612   36.119205548    0
...
```

提取出的数据使用 Shell 管道 `|` 传送给 {doc}`/module/plot` 模块，并用 **-Sq** 选项标注断层名。

```{eval-rst}
.. gmtplot:: CN-faults-labeling.sh
    :show-code: true
    :width: 50%
```

### 根据属性信息提取数据

使用 {doc}`/module/convert` 模块的 **-S** 选项提取指定属性的数据。
例如，下例中提取出“断层名称”为“红河断裂”的断层数据：

```{eval-rst}
.. gmtplot:: CN-single-fault.sh
   :show-code: true
   :width: 50%
```

提取出“断层名称”为“红河断裂”的断层数据，并标注断层英文名：

```{eval-rst}
.. gmtplot:: CN-single-fault-labeling.sh
   :show-code: true
   :width: 50%
```

### 根据空间范围提取数据

{doc}`/module/select` 模块，可实现矩形范围、缓冲区范围和多边形范围内空间数据的提取。
此处仅以缓冲区范围为例。

```{eval-rst}
.. gmtplot:: CN-buffer-fault.sh
   :show-code: true
   :width: 50%
```

## 数据来源

[https://doi.org/10.12031/activefault.china.400.2023.db](https://doi.org/10.12031/activefault.china.400.2023.db)

## 数据处理说明

由于原始数据存在少量几何要素为空的错误记录，gmt在直接读取shp文件时会中断报错，
导致绘图数据不完整。因此本社区提供的数据文件经过了如下处理步骤：

1. 在gis软件中剔除3个几何错误要素（FID编号分别为5784、6429、8424）

2. 通过ogr2ogr命令，将原始shp文件转为OGR_GMT格式：

```
ogr2ogr -f "OGR_GMT" CAFD400_V2023_1.gmt CAFD400_V2023_1.shp
```

## 数据属性说明

- FZN_Ch: 中文断裂带名称  
- FZN_En: 英文断裂带名称  
- FN_Ch: 中文断层名称  
- FN_En: 英文断层名称  
- FSN_Ch: 中文断层分段
- FSN_En: 英文断层分段
- Fea_Ch: 中文断层分段运动学性质和可探测性
- Fea_En: 英文断层分段运动学性质和可探测性
- AGE: 最近活动时代（代码）  
- AGE_Des: 最近活动时代
- RefE: 数据来源，包括参考文献、工作内容或参考规模。

## 数据引用

Wu, X., Xu, X., Yu, G., Ren, J., Yang, X., Chen, G., Xu, C., Du, K., Huang, X., Yang, H., Li, K., and Hao, H.: The China Active Faults Database (CAFD) and its web system, Earth Syst. Sci. Data, 16, 3391–3417, https://doi.org/10.5194/essd-16-3391-2024, 2024.
