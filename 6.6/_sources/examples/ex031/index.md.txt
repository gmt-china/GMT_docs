---
author: 朱邓达
date: 2025-09-29
---

# 绘制三维速度模型的任意垂直切片

{doc}`/module/grdinterpolate` 模块从三维网格中计算任意点位下方不同层处的值。
以地震学中的三维速度模型为例，三维网格水平方向为 (*lon, lat*)，深度方向为 *depth* ，
其中沿深度方向网格分为 *nz* 层，网格节点值以速度为例，
{doc}`/module/grdinterpolate` 模块采样流程为

1. 通过 **-S** 给定地表某点位坐标 (*lon0, lat0*) ，使用 {doc}`/module/grdtrack` 
   模块采样每层二维网格中该点位的值，共得到 *nz* 个值。
2. 如果使用了 **-T** 自定义深度范围和间距，则使用 {doc}`/module/sample1d`
   模块将上一步得到的数据采样到自定义深度。
3. 使用 **-E** 定义测线则切片输出为网格文件，
   使用 **-S** 定义点位则切片输出为ASCII表格文件。

由于目前难以导出通过 **-E** 选项生成的测线，为了更灵活地自定义测线，
这里使用 {doc}`/module/project` 模块先生成测线，使用 **grdinterpolate -S** 计算切片，
再使用 {doc}`/module/xyz2grd` 模块将结果转为网格文件。

```{eval-rst}
.. gmtplot:: ex031.sh
    :width: 80%
    :show-code: true
```
