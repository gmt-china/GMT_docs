---
author: 陈箫翰
---

#  不等间隔数据插值网格化绘图

在实际的科研工作中，另一类经常会接触到的数据类型是以散点形式在空间上不等间隔分布的数据。
例如利用地震台站记录的地震波形，使用接收函数方法计算出的各个地震台站下方的 Moho 厚度以及地壳波速比数据。
某些情况下我们希望利用这些以散点形式不等间隔分布的数据点，插值并绘制出这一片区域的数据分布图。
但是 {doc}`/module/xyz2grd` 模块对于不等间隔的数据并不具备插值功能。
处理不等间隔的数据，可以使用模块
{doc}`/module/surface`、
{doc}`/module/greenspline`、
{doc}`/module/nearneighbor`
或 {doc}`/module/triangulate`。

本章节我们将以 {doc}`/module/surface` 模块为例，介绍对不等间隔数据插值并进行网格化后绘图的方法。

## 示例数据

示例数据下载 {download}`Table_5_11.txt </tutorial/surface/Table_5_11.txt>`

```
# 笛卡尔座标系：X座标 Y座标 Z值
# 地理座标系：经度 纬度 数值

# 数据点散点分布，不等间隔
0.3	6.1	870
1.4	6.2	793
2.4	6.1	755
...
```

下图简单描绘了数据点的分布，以及标注了每个数据点位数值的大小：

```{eval-rst}
.. gmtplot:: surface_ex1.sh
    :width: 80%
```

## 数据插值并网格化

我们使用 {doc}`/module/surface` 模块对数据进行插值，并转化为 *grid* 网格文件。以下命令可以在终端中单独运行：

```
gmt surface Table_5_11.txt -R-0.2/6.6/-0.2/6.6 -I0.05 -Gtmp.grd
```

其中 **-R** 选项规定了想要进行插值的空间范围。
**-I** 选项设置了插值后网格文件的数据间隔，可以分别设置X和Y方向的网格间隔。对于地理坐标，可以指定网格间隔单位（默认单位为度）。
**-G** 选项设置了输出文件的文件名。

用户可以使用 {doc}`/module/grdinfo` 模块获取网格文件的基本信息：

```
$ gmt grdinfo tmp.grd 
tmp.grd: Title: Data gridded with continuous surface splines in tension
tmp.grd: Command: gmt surface Table_5_11.txt -R-0.2/6.6/-0.2/6.6 -I0.05 -Gtmp.grd
tmp.grd: Remark: 
tmp.grd: Gridline node registration used [Cartesian grid]
tmp.grd: Grid file format: nf = GMT netCDF format (32-bit float), CF-1.7
tmp.grd: x_min: -0.2 x_max: 6.6 x_inc: 0.05 name: x n_columns: 137
tmp.grd: y_min: -0.2 y_max: 6.6 y_inc: 0.05 name: y n_rows: 137
tmp.grd: v_min: 678.153747559 v_max: 1008.02862549 name: z
tmp.grd: scale_factor: 1 add_offset: 0
tmp.grd: format: netCDF-4 chunk_size: 137,137 shuffle: on deflation_level: 3
tmp.grd: Default CPT: 
```

## 网格文件绘图

我们同样使用 {doc}`/module/grdimage` 模块读取网格文件绘制图片。上面获取到的网格文件基本信息，可以帮助我们确定 {doc}`/module/makecpt` 中 **-T** 选项的参数。
代码可以整合为：

```{eval-rst}
.. gmtplot:: surface_ex2.sh
    :width: 80%
```
