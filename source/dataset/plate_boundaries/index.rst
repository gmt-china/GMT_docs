全球板块边界数据
================

PB2002 是常用的一个全球板块边界数据。

- 官方网站: http://peterbird.name/publications/2003_PB2002/2003_PB2002.htm
- 原始数据下载地址: http://peterbird.name/oldFTP/PB2002/

数据下载
--------

原始数据的格式无法直接用于GMT绘图。这里我们从官方网站下载了 ``PB2002_plates.dig.txt``
数据，并将其中每段数据的段头记录做了修改，以供GMT使用。

可供GMT直接使用的数据下载地址: :download:`PB2002_plates.dig.txt`

使用示例
--------

.. gmtplot:: PB2002.sh
   :width: 80%

   PB2002 全球板块边界

引用信息
--------

Bird, P. (2003) An updated digital model of plate boundaries, *Geochemistry Geophysics Geosystems*, 4(3), 1027, doi:10.1029/2001GC000252.
