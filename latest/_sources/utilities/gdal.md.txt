# GDAL

:审核: {{ 陈箫翰 }}
:撰写: {{ 田冬冬 }}, {{ 姚家园 }}
:最近更新日期: 2023-09-21

---

[GDAL](https://gdal.org/)（**G**eospatial **D**ata **A**bstraction **L**ibrary）
是光栅（raster）和矢量（vector）地理空间数据格式的转换库/工具，
支持多种光栅或矢量地理空间数据格式的互相转换和处理。

历史上，GDAL 仅用于处理光栅地理空间数据，而 OGR 则仅用于处理矢量地理空间数据。
自 GDAL 2.0 开始，二者集成在一起了，一般统称为 GDAL 或 GDAL/OGR。
因此，GDAL 现在具备了处理光栅和矢量地理空间数据格式的能力。

:::{note}
若无显式说明，本手册提到 GDAL 和 GDAL/OGR 时，表示同一个意思；
提到 OGR 时，仅表示地理空间矢量数据格式。
:::

GDAL/OGR 有两个核心部分：

- GDAL 部分：支持多种光栅地理空间数据格式的互相转换，
  如常见的 netCDF、GeoTiff、HDF5、XYZ 等，
  详见[光栅格式列表](https://gdal.org/drivers/raster/index.html)
- OGR 部分：支持多种矢量数据格式的互相转换，
  如常见的 OGR/GMT（即 GMT）、Shapefile 、KML、MapInfo、Excel 等，
  详见[矢量格式列表](https://gdal.org/drivers/vector/index.html)

GDAL 提供了几十个不同功能的程序，这里仅介绍比较常用的几个程序。更完整的程序列表见
<https://gdal.org/programs/index.html>。

(ogr2ogr)=

## ogr2ogr

GDAL 提供的 `ogr2ogr` 命令可以实现几十种地理矢量数据格式之间的互相转换。
因而，可以用其将任意地理矢量数据格式转换为 GMT 可识别的 OGR/GMT 格式，供 GMT 直接使用。
该命令的详细用法请参考 [ogr2ogr 官方文档](https://gdal.org/programs/ogr2ogr.html)。

该命令的基本用法是:

```
ogr2ogr -f GMT 输出数据文件名 输入数据文件名
```

当输出文件名为空（即 `""`）时，则输出数据与输入数据的文件名相同，仅后缀不同。

```{rubric} 示例
```

1. 将 Shapefile 格式的数据文件 {file}`gadm41_USA_0.shp` 转换为 GMT 格式:

   ```
   $ ogr2ogr -f GMT "" gadm41_USA_0.shp
   ```

2. 将 GeoJSON 格式的数据文件 {file}`gadm41_USA_0.json` 转换为 GMT 格式:

   ```
   $ ogr2ogr -f GMT "" gadm41_USA_0.json
   ```

3. 将 Geopackage 格式的数据文件 {file}`gadm41_USA.gpkg` 转换为 GMT 格式。

   与 Shapefile 和 GeoJSON 格式不同的是，Geopackage 格式中可以包含多个 layer 的
   数据，因而在转换时需要指定提取哪个 layer 的数据。
   使用 `ogrinfo` 命令可以查看数据的基本属性:

   ```
   $ ogrinfo gadm41_USA.gpkg
   INFO: Open of `gadm41_USA.gpkg'
         using driver `GPKG' successful.
   1: ADM_ADM_0 (Multi Polygon)
   2: ADM_ADM_1 (Multi Polygon)
   3: ADM_ADM_2 (Multi Polygon)
   ```

   可以看到该数据中包含了三层，即 `ADM_ADM_0`、`ADM_ADM_1` 和
   `ADM_ADM_2`。因而，可以使用如下命令分别提取三层数据:

   ```
   $ ogr2ogr -f GMT "" gadm41_USA.gpkg ADM_ADM_0
   $ ogr2ogr -f GMT "" gadm41_USA.gpkg ADM_ADM_1
   $ ogr2ogr -f GMT "" gadm41_USA.gpkg ADM_ADM_2
   ```

   三个命令分别生成文件 `ADM_ADM_0.gmt`、`ADM_ADM_1.gmt` 和 `ADM_ADM_2.gmt`。

(gdal-translate)=

## gdal_translate

GDAL 提供的 `gdal_translate` 命令可以实现多种地理空间光栅数据格式之间的互相转换。
该命令的详细用法请参考 [gdal_translate 官方文档](https://gdal.org/programs/gdal_translate.html)，
这里只介绍该命令的基本用法:

```
gdal_translate -of 格式 输入数据文件名 输出数据文件名
```

例如，将 GeoTiff 格式的数据文件数据 {file}`srtm_56_05.tif` 转换为 GMT 使用的 netCDF 格式:

```
gdal_translate -of netCDF srtm_56_05.tif srtm_56_05.nc
```
