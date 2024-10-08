# OGR/GMT矢量数据格式

## 简介

地理空间数据有多种格式，按照类型划分，可以大致分为光栅型（raster）和矢量型（vector）。

- 光栅型数据格式不完整列表：<https://gdal.org/drivers/raster/index.html>
- 矢量型数据格式不完整列表：<https://gdal.org/drivers/vector/index.html>

简单的说，在GMT中，netCDF格式的网格文件属于光栅型地理空间数据，而一般的表数据则
属于矢量型地理空间数据。

[GDAL](http://www.gdal.org/) 是一个可以实现多种光栅型或矢量型地理空间数据
格式间互相转换的库/工具，其全称为Geospatial Data Abstraction Library。
历史上，GDAL仅用于处理光栅型数据格式，而OGR则仅用于处理矢量型数据格式。
从GDAL 2.0开始，二者相互集成在一起，即GDAL已经具备了处理光栅型和矢量型
地理空间数据格式的能力。本文中，提到OGR时，仅表示地理空间矢量数据格式。

一个矢量数据中，不仅仅有地理空间数据（地理坐标数据，点、线、多边形等），
也可以有非地理空间数据（城市名等）。老版本的GMT只能处理地理空间数据，
而不能利用非地理空间数据。GMT5定义了一种兼容OGR的GMT矢量数据格式，
通常称为OGR/GMT格式。这种格式中包含了地理空间和非地理空间数据，
所有的非地理空间数据都以注释的形式写到文件中，因而GMT4也可以正常读取
OGR/GMT格式的数据。OGR/GMT格式中包含了非空间数据，使得GMT的输出可以
很容易地被其他GIS或绘图软件所使用。

## OGR/GMT格式

OGR/GMT格式的一些重要性质列举如下：

- 所有非空间数据都以注释行的形式写到文件中，这些注释行在GMT4中会被直接忽略
- 非空间数据的各个字段之间用空格分隔，每个字段均以字符 **@** 作为前缀，
  紧接着一个用于表征该字段内容的字符。每个字段内部的多个字符串之间用字符 **|** 分隔
- 字符 `\` 作为转义字符，比如字符串内 `\n` 表示换行
- 文件中，非空间数据均保存在空间数据之前。因而GMT在处理地理空间数据之前，
  已经解析了非地理空间信息，这些非地理空间信息可能会影响到地理空间数据的处理
- 数据文件的第一个注释行必须指定OGR/GMT格式的版本号，即 **@VGMT1.0**
- 为了兼容其他GIS格式（比如shapefiles），OGR/GMT格式中显式包含了一个字段，
  用于指定接下来的地理空间数据是点、线还是多边形
- 每个文件有一个头段注释，其中指定了当前文件所包含的地理特征，
  以及每个特征所对应的非地理属性（比如区域范围，投影方式等）
- 同一个OGR/GMT格式的文件中，所有数据段必须具有相同类型的特征（都是点或线或多边形）

## OGR/GMT元数据

在OGR/GMT格式的文件头部，需要包含一系列元数据信息。元数据用于描述整个文件的
共同信息，比如版本号、几何类型、区域范围、投影方式、非空间数据的格式等信息。

### 格式版本号 **@V**

OGR/GMT格式的版本号用 **@V** 来指定。因而OGR/GMT格式的文件的第一行的内容必须是:

```
# @VGMT1.0
```

其中 **GMT1.0** 是OGR/GMT格式的版本号。

### 几何类型 **@G**

**@G** 用于指定当前数据文件的几何类型，其后接的参数可以是：

- **POINT**: 包含多个数据点（每个点都可以有自己的头段记录）
- **MULTIPOINT**: 多点数据（所有的点共用同一个头段记录）
- **LINESTRING**: 包含多个独立的线段（即GMT中的多段数据，每条线段可以有自己的头段记录）
- **MULTILINESTRING**: 多线数据（文件中的所有线段是一个特性，共用同一个头段记录）
- **POLYGON**: 包含多个闭合多边形（每个多边形可以有自己的头段记录）
- **MULTIPOLYGON**: 多个多边形数据（所有多边形共用同一个头段记录）

例如:

```
# @VGMT1.0 @GPOLYGON
```

### 区域范围 **@R**

**@R** 用于指定区域范围，其格式与 **-R** 选项一致。例如:

```
# @R150/190/-45/-54
```

### 投影信息 **@J**

投影信息用四个可选的字符串表示，每个字符串以 **@J** 开头。

- **@Je**: 投影的EPSG代码
- **@Jg**: GMT中所使用的投影参数
- **@Jp**: 投影参数的Proj.4表示
- **@Jw**: 投影参数的OGR WKT (well known text)表示

示例:

```
# @Je4326 @JgX @Jp"+proj=longlat +ellps=WGS84+datum=WGS84 +no_defs"
# @Jw"GEOGCS[\"WGS84\",DATUM[\"WGS_1984\",SPHEROID\"WGS84\",6378137,\
298.257223563,AUTHORITY[\"EPSG\",\"7030\"]],TOWGS84[0,0,0,0,0,0,0],
AUTHORITY[\"EPSG\",\"6326\"]],PRIMEM[\"Greenwich\",0,\
AUTHORITY[\"EPSG\",\"8901\"]],UNIT[\"degree\",0.01745329251994328,\
AUTHORITY[\"EPSG\",\"9122\"]],AUTHORITY[\"EPSG\",\"4326\"]]"
```

### 声明非空间字段 **@N**

**@N** 后接一个用于描述非空间字段名称的字符串，各个字段名称之间用 **|** 分隔。
若字段名称中有空格，则必须用引号括起来。**@N** 必须有一个与之对应的 **@T**。
其中 **@T** 用于指定每个字段名称的数据类型。可取的数据类型包括 **string**、
**interger**、**double**、**datetime** 和 **logical**。

示例:

```
# @VGMT1.0 @GPOLYGON @Nname|depth|id @Tstring|double|integer
```

表明数据文件中包含了多个多边形，每个多边形都可以有独立的头段记录以指定非空间信息，
非空间信息有三个，分别是name、depth和id，三个字段分别是字符串、浮点型和整型。

## OGR/GMT数据

元数据之后即是真正的数据，包括非空间数据和空间数据。

### 非空间数据

非空间数据用 **@D** 表示，紧跟着一系列以 **|** 分隔的字符串，每个字段的含义以及
格式由 **@N** 和 **@T** 决定。

非空间数据所在的注释行应放在每段数据的坐标数据前。对于几何类型为 **LINE**、
**POLYGON**、 **MULTILINE** 或 **MULTIPOLYGON** 的数据而言，每段数据之间用
特定的字符分隔，默认分隔符是 **>**。非空间数据紧跟在 **>** 行之后。
对于几何类型为 **POINT** 或 **MULTIPOINT** 的数据而言，则不需要分隔符。

**@N** 和 **@D** 中的字符串中若包含空格，则必须用双引号括起来。若字符串中本身
包含双引号或 **|**，则需要使用转义字符进行转义。若两个 **|** 之间为空，
则表示对应的字段为空值。

一个点数据的头段示例:

```
# @VGMT1.0 @GPOINT @Nname|depth|id @Tstring|double|integer
# @D"Point 1"|-34.5|1
```

一个多边形数据的头段示例:

```
# @VGMT1.0 @GPOLYGON @Nname|depth|id @Tstring|double|integer
>
# @D"Area 1"|-34.5|1
```

### 多边形拓扑

旧版本的GMT只支持常规的多边形，不支持一个多边形内有个洞的情况。

GMT通过在多边形数据前加上 **@P** 和 **@H** 来指定当前的数据段是外环还是内环，
即是真正的多边形，还是多边形内的洞。**@H** 必须紧跟在对应的 **@P** 之后。

**@H** 所指定的洞不应该有任何 **@D** 值，因为非空间数据适用于整个特性，
而 **@H** 所指定的多边形只是多边形的一部分，并不是一个新的多边形。

## 示例

点数据示例:

```
# @VGMT1.0 @GPOINT @Nname|depth|id
# @Tstring|double|integer
# @R178.43/178.5/-57.98/-34.5
# @Je4326
# @Jp"+proj=longlat +ellps=WGS84 +datum=WGS84+no_defs"
# FEATURE_DATA
# @D"point 1"|-34.5|1
178.5 -45.7
# @D"Point 2"|-57.98|2
178.43 -46.8
...
```

线数据示例:

```
# @VGMT1.0 @GLINESTRING @Nname|depth|id
# @Tstring|double|integer
# @R178.1/178.6/-48.7/-45.6
# @Jp"+proj=longlat +ellps=WGS84 +datum=WGS84+no_defs"
# FEATURE_DATA
> -W0.25p
# @D"Line 1"|-50|1
178.5 -45.7
178.6 -48.2
178.4 -48.7
178.1 -45.6
> -W0.25p
# @D"Line 2"|-57.98|$
178.43 -46.8
...
```

多边形数据示例:

```
# @VGMT1.0 @GPOLYGON @N"Polygon name"|substrate|id @Tstring|string|integer
# @R178.1/178.6/-48.7/-45.6
# @Jj@Jp"+proj=longlat +ellps=WGS84 +datum=WGS84+no_defs"
# FEATURE_DATA
> -Gblue -W0.25p
# @P
# @D"Area 1"|finesand|1
178.1 -45.6
178.1 -48.2
178.5 -48.2
178.5 -45.6
178.1 -45.6
>
# @H
# First hole in the preceding perimeter, so is technically still
# part of the same geometry, despite the preceding > character.
# No attribute data is provided, as this is inherited.
178.2 -45.4
178.2 -46.5
178.4 -46.5
178.4 -45.4
178.2 -45.4
>
# @P
...
```
