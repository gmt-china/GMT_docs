# global_tectonics: 全球地质构造数据

:撰写: {{ 陈箫翰 }}, {{ 田冬冬 }}
:最近更新日期: 2025-07-30

---

global_tectonics 是一个全球地质构造数据集，提供 Shapefile、GMT、KML 格式数据的下载。

- 官方网站: <https://github.com/dhasterok/global_tectonics>

## 数据简介与GMT格式下载

global_tectonics 数据集中提供了四个数据文件：

- `boundaries.gmt` : [板块边界数据](https://raw.githubusercontent.com/dhasterok/global_tectonics/2376efe78a148643dc7f6867f6ee87d62c1bccc0/plates%26provinces/gmt/boundaries.gmt)
- `plates.gmt` : [板块数据](https://raw.githubusercontent.com/dhasterok/global_tectonics/2376efe78a148643dc7f6867f6ee87d62c1bccc0/plates%26provinces/gmt/plates.gmt)
- `global_gprv.gmt` : [地质块体数据](https://raw.githubusercontent.com/dhasterok/global_tectonics/2376efe78a148643dc7f6867f6ee87d62c1bccc0/plates%26provinces/gmt/global_gprv.gmt)
- `oc_boundaries.gmt` : [海陆边界线](https://raw.githubusercontent.com/dhasterok/global_tectonics/2376efe78a148643dc7f6867f6ee87d62c1bccc0/plates%26provinces/gmt/oc_boundaries.gmt)

更详细的数据说明请阅读数据的参考文献。

## 使用示例

### boundaries.gmt

数据文件 `boundaries.gmt` 包含了 7 种类型的板块边界数据。每段数据的头段记录中
包含了板块边界的名称、板块边界类型、相邻的两个板块名以及长度等信息。
下面的示例使用 {doc}`/module/convert` 模块的 **-S** 选项提取不同类型的板块
边界并分别绘制：

```{eval-rst}
.. gmtplot:: boundaries.sh
   :width: 80%
```

### plates.gmt

数据文件 `plates.gmt` 包含了各个板块的多边形数据。每段数据的头段记录中包含了板块名字、属性、性质、面积等数据。
使用 {doc}`/module/convert` 模块可以提取出特定板块的数据进行绘图。
下面的例子展示了如何根据头段记录提取大陆地壳板块、变形带板块，以及提取青藏高原板块、
华北板块。

```{eval-rst}
.. gmtplot:: plates.sh
   :width: 80%
```

### global_gprv.gmt

数据文件 `global_gprv.gmt` 的头段记录中包含了不同地质区域的名字、属性、地质历史事件、
面积等数据。使用 {doc}`/module/convert` 模块可以提取出特定地质区域的数据进行绘图。
下面的例子展示了如何根据从头段记录 `prov_type` 提取克拉通、地盾、被动边缘，
从 `lastorogen` 提取阿尔卑斯-喜马拉雅造山事件的区域，以及从 `prov_name` 中
提取南海盆地和鄂尔多斯地块的数据。

```{eval-rst}
.. gmtplot:: global_gprv.sh
   :width: 80%
```

### oc_boundaries.gmt

数据文件 `oc_boundaries.gmt` 包含了全球的海陆边界线。

```{eval-rst}
.. gmtplot:: oc_boundaries.sh
   :width: 80%
```

## 引用信息

Hasterok, D., Halpin, J. A., Collins, A. S., Hand, M., Kreemer, C., Gard, M. G., & Glorie, S. (2022). New Maps of Global Geological Provinces and Tectonic Plates. Earth-Science Reviews, 231, 104069. <https://doi.org/10.1016/j.earscirev.2022.104069>
