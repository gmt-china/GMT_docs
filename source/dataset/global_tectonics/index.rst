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

引用信息
--------

Derrick Hasterok, Jacqueline A. Halpin, Alan S. Collins, Martin Hand, Corné Kreemer, Matthew G. Gard, Stijn Glorie, New Maps of Global Geological Provinces and Tectonic Plates, Earth-Science Reviews, Volume 231, 2022, 104069, ISSN 0012-8252, https://doi.org/10.1016/j.earscirev.2022.104069.
