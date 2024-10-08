# 网格文件格式

GMT 支持的网格数据格式主要分为四大类，这四大类也可细分为更多的数据格式：

1. netCDF4 标准网格文件格式
2. netCDF3 “旧”网格文件格式
3. GMT 自定义二进制文件
4. 其它网格文件格式

netCDF4 标准网格文件格式是最常见的，也最推荐使用的网格数据格式。
它也是 GMT 默认的网格数据格式，一般以 `.nc` 或 `.grd` 作为文件后缀。
本章也将只对 netCDF 格式做重点介绍。

GMT 所支持的所有网格文件格式在下表列出，每种网格文件格式均对应一个两字符 ID。

:::{table} GMT 支持的网格文件格式
:align: center

| ID   | 说明                                                        |
| ---- | ----------------------------------------------------------- |
|      | *GMT netCDF4 标准格式*                                      |
| `nb` | GMT netCDF format (8-bit integer, COARDS, CF-1.5)           |
| `ns` | GMT netCDF format (16-bit integer, COARDS, CF-1.5)          |
| `ni` | GMT netCDF format (32-bit integer, COARDS, CF-1.5)          |
| `nf` | GMT netCDF format (32-bit float, COARDS, CF-1.5)            |
| `nd` | GMT netCDF format (64-bit float, COARDS, CF-1.5)            |
|      | *GMT netCDF3 “旧”格式*                                      |
| `cb` | GMT netCDF format (8-bit integer, depreciated)              |
| `cs` | GMT netCDF format (16-bit integer, depreciated)             |
| `ci` | GMT netCDF format (32-bit integer, depreciated)             |
| `cf` | GMT netCDF format (32-bit float, depreciated)               |
| `cd` | GMT netCDF format (64-bit float, depreciated)               |
|      | *GMT 自定义二进制格式*                                      |
| `bm` | GMT native, C-binary format (bit-mask)                      |
| `bb` | GMT native, C-binary format (8-bit integer)                 |
| `bs` | GMT native, C-binary format (16-bit integer)                |
| `bi` | GMT native, C-binary format (32-bit integer)                |
| `bf` | GMT native, C-binary format (32-bit float)                  |
| `bd` | GMT native, C-binary format (64-bit float)                  |
|      | *其他网格文件格式*                                          |
| `rb` | SUN raster file format (8-bit standard)                     |
| `rf` | GEODAS grid format GRD98 (NGDC)                             |
| `sf` | Golden Software Surfer format 6 (32-bit float)              |
| `sd` | Golden Software Surfer format 7 (64-bit float)              |
| `af` | Atlantic Geoscience Center AGC (32-bit float)               |
| `ei` | ESRI Arc/Info ASCII Grid Interchange format (ASCII integer) |
| `ef` | ESRI Arc/Info ASCII Grid Interchange format (ASCII float)   |
| `gd` | Import/export via GDAL                                      |
:::

除了上面列出的网格文件格式之外，有C编程经验的高级用户还可以自己自定义网格文件
格式，并将读写该格式的子程序链接到GMT函数库中，使得GMT可以支持自定义网格文件
格式的读取。详情见GMT源码中的 `gmt_customio.c`。

## netCDF 格式

GMT保存2D网格时默认使用与COARDS兼容的netCDF格式。COARDS，全称为
Cooperative Ocean/Atmosphere Research Data Service，是一个海洋和大气科学相关
机构分发网格数据时所采用的一个共同标准。GMT的网格数据兼容COARDS标准，因而
GMT可以读取这些机构分发的网格数据，同时，GMT生成的网格数据也可以被其它软件
所读取。

netCDF格式中除了包含数据外，还包含了很多其它属性。

:::{table} GMT 中 netCDF 格式的属性
:align: center

| **属性**                       | **说明**                                                         |
| ------------------------------ | ---------------------------------------------------------------- |
|                                | *全局属性*                                                       |
| Conventions                    | COARDS, CF-1.5 (可选)                                            |
| title                          | 标题 (可选)                                                      |
| source                         | 文件是如何创建的 (可选)                                          |
| node_offset                    | 网格配准方式，0 表示网格线配置（默认值），1 表示像素配准         |
|                                | *X 和 Y 变量属性*                                                |
| long_name                      | 坐标名称 (如 "Longitude" 和 "Latitude")                          |
| units                          | 坐标单位 (如, "degrees_east" 和 "degrees_north")                 |
| actual range (or valid range)  | *x* 和 *y* 的最小最大值                                          |
|                                | *Z 变量属性*                                                     |
| long_name                      | Z变量名称 (默认为 "z")                                           |
| units                          | Z变量单位                                                        |
| scale_factor                   | *z* 值要乘以的因子 (默认值: 1)                                   |
| add_offset                     | *z* 值乘以因子后的额外偏移量 (默认值: 0)                         |
| actual_range                   | Z值的最小最大值                                                  |
| \_FillValue (or missing_value) | 数据缺失或无效数据对应的值。若未指定，则根据数据类型自动设置该值 |
:::

## GMT 自定义二进制文件

GMT在老版本中并没有使用netCDF作为其网格文件标准格式，而是自定义了一种网格文件格式。
该格式已不推荐使用。该格式的文件包含了一个892个字节的头段，以及数据。下标列出了
头段中所保存的所有信息。

| **参数**                          | **描述**                                               |
| --------------------------------- | ------------------------------------------------------ |
| **int** *n_columns*               | Number of nodes in the *x*-dimension                   |
| **int** *n_rows*                  | Number of nodes in the *y*-dimension                   |
| **int** *registration*            | 0 for grid line registration, 1 for pixel registration |
| **double** *x_min*                | Minimum *x*-value of region                            |
| **double** *x_max*                | Maximum *x*-value of region                            |
| **double** *y_min*                | Minimum *y*-value of region                            |
| **double** *y_max*                | Maximum *y*-value of region                            |
| **double** *z_min*                | Minimum *z*-value in data set                          |
| **double** *z_max*                | Maximum *z*-value in data set                          |
| **double** *x_inc*                | Node spacing in *x*-dimension                          |
| **double** *y_inc*                | Node spacing in *y*-dimension                          |
| **double** *z_scale_factor*       | Factor to multiply *z*-values after read               |
| **double** *z_add_offset*         | Offset to add to scaled *z*-values                     |
| **char** *x_units*\[80\]          | Units of the *x*-dimension                             |
| **char** *y_units*\[80\]          | Units of the *y*-dimension                             |
| **char** *z_units*\[80\]          | Units of the *z*-dimension                             |
| **char** *title*\[80\]            | Descriptive title of the data set                      |
| **char** *command*\[320\]         | Command line that produced the grid file               |
| **char** *remark*\[160\]          | Any additional comments                                |
| **TYPE** *z*\[n_columns\*n_rows\] | 1-D array with *z*-values in scanline format           |

## 其它网格文件格式

除了netCDF和GMT自定义格式外，GMT还支持其它几种网格文件格式。更重要的是，
GMT支持通过GDAL读取数据，因而几乎可以读取任意格式的网格文件。

GDAL所支持的光栅格式列表见: <https://gdal.org/drivers/raster/index.html>
