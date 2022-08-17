global_tectonics: 全球地质构造数据
==================================

global_tectonics 是一个较新的全球地质构造数据集，提供 shp, gmt, KML 格式数据的下载。

- 官方网站: https://github.com/dhasterok/global_tectonics
- gmt 格式数据下载: https://github.com/dhasterok/global_tectonics/tree/main/plates%26provinces/gmt

使用示例
--------

数据文件 ``boundaries.gmt`` 包含了7种类型的板块边界数据。提取不同类型板块边界，需要使用 ``gmtconvert -S`` 命令。
详细的数据说明请阅读参考文献。

.. gmtplot:: boundaries.sh
   :width: 80%

引用信息
--------

Hasterok, D., Halpin, J., Hand, M., Collins, A., Kreemer, C., Gard, M.G., Glorie, S., (revised) New maps of global geologic provinces and tectonic plates, Earth Science Reviews. Preprint available (EarthArXiv) https://doi.org/10.31223/X5TD1C
