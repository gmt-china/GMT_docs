global_tectonics: 全球地质构造数据
==================================

global_tectonics 是一个较新的全球地质构造数据集，提供 shp, gmt, KML 格式数据的下载。

- 官方网站: https://github.com/dhasterok/global_tectonics
- gmt 格式数据下载: https://github.com/dhasterok/global_tectonics/tree/main/plates%26provinces/gmt

使用示例
--------

数据文件 ``boundaries.gmt`` 包含了7种类型的板块边界数据。提取不同类型板块边界，需要使用 :doc:`/module/gmtconvert` 模块的 **-S** 选项。
详细的数据说明请阅读参考文献。

.. gmtplot:: boundaries.sh
   :width: 80%
   
   
数据文件 ``plates.gmt`` 的头段记录中包含了每个板块的名字、属性、性质、面积等数据。使用 :doc:`/module/gmtconvert` 模块可以提取出特定板块的数据进行绘图。
下面的例子展示了如何根据头段记录提取大陆地壳板块、变形带板块，以及提取青藏高原板块、华北板块。关于头段记录的详细说明请阅读官网和参考文献。

.. gmtplot:: plates.sh
   :width: 80%

引用信息
--------

Hasterok, D., Halpin, J. A., Collins, A. S., Hand, M., Kreemer, C., Gard, M. G., & Glorie, S. (2022). New Maps of Global Geological Provinces and Tectonic Plates. Earth-Science Reviews, 231, 104069. https://doi.org/10.1016/j.earscirev.2022.104069
