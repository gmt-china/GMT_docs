PB2002: 全球板块边界数据
========================

PB2002 是常用的一个全球板块边界数据，其包含了14个大板块和38个小板块，共计52个板块的边界数据。

- 官方网站: http://peterbird.name/publications/2003_PB2002/2003_PB2002.htm
- 原始数据下载地址: http://peterbird.name/oldFTP/PB2002/
- 数据格式说明: http://peterbird.name/oldFTP/PB2002/2001GC000252_readme.txt

数据下载
--------

原始数据的格式无法直接用于GMT绘图。这里我们从官方网站下载了 :file:`PB2002_plates.dig.txt`
和 :file:`PB2002_boundaries.dig.txt` 数据，并将其段头记录做了修改以供GMT用户使用。

可供GMT直接使用的数据下载地址：\ :download:`PB2002_plates.dig.txt` | :download:`PB2002_boundaries.dig.txt`

两个数据是等效的，区别在于：

- :file:`PB2002_plates.dig.txt`\ ：数据分为 52 段，每段数据对应一个板块边界闭合多边形，
  每段数据的段头记录为该段数据的板块名称缩写。
- :file:`PB2002_boundaries.dig.txt`\ ：数据分为 229 段，其将相邻板块的共同边界分为不同的段列出来。
  段头记录中包含了两个板块的名称缩写，以及板块数据来源的参考文献。

使用示例
--------

在绘图方面，两个数据没有区别。

.. gmtplot:: PB2002.sh
   :width: 80%

   PB2002 全球板块边界

引用信息
--------

Bird, P. (2003) An updated digital model of plate boundaries, *Geochemistry Geophysics Geosystems*, 4(3), 1027, doi:10.1029/2001GC000252.
