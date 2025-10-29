---
author: 王杰, 刘珠妹, 邓山泉, 陈箫翰
---

# CN-block: 中国大陆及周边活动地块数据

CN-block 数据提供了中国大陆及周边活动地块数据，是 GMT 中文社区由
*中国大陆及周边地区活动地块划分图*（王辉等（2003）中的图 1，即下图）矢量化而成，并做了一定的格式转换。

```{image} CN-block.jpg
:align: center
:width: 80%
```

## 数据下载

- 项目主页： <https://github.com/gmt-china/china-geospatial-data>
- 下载地址： <https://github.com/gmt-china/china-geospatial-data/releases>

macOS/Linux 用户请下载数据 {file}`china-geospatial-data-UTF8.zip`（UTF8 编码），
Windows 用户请下载数据 {file}`china-geospatial-data-GB2312.zip`（GB2312 编码）。

数据包中提供了三个地块有关的数据文件:

- {file}`CN-block-L1.gmt`：一级地块边界数据
- {file}`CN-block-L1-deduced.gmt`：一级地块推断边界数据
- {file}`CN-block-L2.gmt`：二级地块边界数据

## 示例图

```{eval-rst}
.. gmtplot:: CN-block.sh
   :show-code: true
   :width: 75%
```

## 数据来源与处理

该数据由用户王杰利用王辉等（2003）中的图 1 矢量化得到。

## 数据引用

- 张培震, 邓起东, 张国民, 等.
  中国大陆的强震活动与活动地块.
  中国科学D辑, 2003, 33(z1):12-20.
- 张国民, 马宏生, 王辉, 等.
  中国大陆活动地块边界带与强震活动.
  地球物理学报, 2005, (03):602-610.
- 王辉, 张国民, 吴云, 等.
  中国大陆活动地块变形与地震活动的关系.
  中国地震, 2003, (03):243-254.
