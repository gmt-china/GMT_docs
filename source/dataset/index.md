# 地学数据集

使用 GMT 绘图时，经常用到一些特定的地学数据，如国界线、地形起伏数据等。
这些数据一般不需要任何改动即可用在多种图件中。根据使用方法的不同，分为三类：

1. GMT 内置数据：GMT 官方整理的内置于 GMT 软件包中的数据
2. GMT 远程数据：GMT 官方整理的保存在远程 GMT 数据服务器中的数据
3. 自定义数据：用户自行准备的数据

```{rubric} GMT 内置数据
```

GMT 内置了如下数据，可以直接在 GMT 中使用：

- {doc}`gshhg`
- {doc}`dcw/index`

```{rubric} GMT 远程数据
```

GMT 远程数据位于 GMT 数据服务器，在 GMT 中使用时会自动下载。
以下列出了 GMT 提供的所有远程数据类型。默认情况下，所有数据均为最新版本，
但在原始数据发布新版本时，GMT 提供数据可能会稍有延迟。

| 数据类型                                                                                              | 数据名称                              | 单位  | 默认 CPT        | 说明                                                  |
|-------------------------------------------------------------------------------------------------------|---------------------------------------|-------|-----------------|-------------------------------------------------------|
| [地球地形起伏](https://www.generic-mapping-tools.org/remote-datasets/earth-relief.html)               | `earth_relief` 或 <br>`earth_synbath` | m     | geo             | 由 IGPP 对 Scripps SRTM15+V2.6 重采样得到             |
| [地球 GEBCO 地形起伏](https://www.generic-mapping-tools.org/remote-datasets/earth-gebco.html)         | `earth_gebco` 或 <br>`earth_gebcosi`  | m     | geo             | 海底地形部分来自 GEBCO 项目                           |
| [地球大地水准面](https://www.generic-mapping-tools.org/remote-datasets/earth-geoid.html)              | `earth_geoid`                         | m     | 无              | 来自 NGA 发布的 EGM2008 超高阶重力场模型              |
| [地球自由空气重力异常](https://www.generic-mapping-tools.org/remote-datasets/earth-faa.html)          | `earth_faa`                           | mGal  | @earth_faa      | 来自 IGPP，由 Sandwell 及其同事的海洋部分和 EGM2008 模型的陆地部分合成，范围：±80˚ |
| [地球自由空气重力异常误差](https://www.generic-mapping-tools.org/remote-datasets/earth-faaerror.html) | `earth_faaerror`                      | mgal  | @earth_faa      | 为 `earth_faa` 的伴随数据                             |
| [地球垂直重力梯度异常](https://www.generic-mapping-tools.org/remote-datasets/earth-vgg.html)          | `earth_vgg`                           | Eotvos| @earth_vgg      | 来自 IGPP，由 Sandwell 及其同事的海洋部分和 EGM2008 模型的陆地部分合成，范围：±80˚ |
| [地球垂线偏差东西向分量](https://www.generic-mapping-tools.org/remote-datasets/earth-edefl.html)      | `earth_edefl`                         | urad  | @earth_defl     | 来自 IGPP，由 Sandwell 及其同事的海洋部分和 EGM2008 模型的陆地部分合成，范围：±80˚ |
| [地球垂线偏差南北向分量](https://www.generic-mapping-tools.org/remote-datasets/earth-ndefl.html)      | `earth_ndefl`                         | urad  | @earth_defl     | 来自 IGPP，由 Sandwell 及其同事的海洋部分和 EGM2008 模型的陆地部分合成，范围：±80˚ |
| [地球磁异常](https://www.generic-mapping-tools.org/remote-datasets/earth-mag.html)                    | `earth_mag` 或 <br>`earth_mga4km`     | nTesla| @earth_mag      | EMAG2 模                                              |
| [地球数字磁异常](https://www.generic-mapping-tools.org/remote-datasets/earth-wdmam.html)              | `earth_wdmam`                         | nTesla| @earth_wdman    | 来自 WDMAM 项目                                       |
| [地球洋壳年龄](https://www.generic-mapping-tools.org/remote-datasets/earth-age.html)                  | `earth_age`                           | Myr   | @earth_age      | 来自 EarthByte                                        |
| [地球平均稳态海面地形](https://www.generic-mapping-tools.org/remote-datasets/earth-mdt.html)          | `earth_mdt`                           | m     | @earth_mdt      | CNES 发布，IGPP 重处理                                |
| [地球平均海平面](https://www.generic-mapping-tools.org/remote-datasets/earth-mss.html)                | `earth_mss`                           | m     | @earth_mss      | CNES 发布，IGPP 重处理                                |
| [地球水陆掩膜](https://www.generic-mapping-tools.org/remote-datasets/earth-mask.html)                 | `earth_mask`                          |       |                 | 由 {doc}`module/grdlandmask` 计算得到                 |
| [地球到海岸线距离](https://www.generic-mapping-tools.org/remote-datasets/earth-dist.html)             | `earth_dist`                          | km    | @earth_dist     | 由 {doc}`module/grdmath` 计算得到                     |
| [地球昼夜卫星影像](https://www.generic-mapping-tools.org/remote-datasets/earth-daynight.html)         | `earth_day` 或 <br>`earth_night`      |       |                 | 来自 NASA                                             |
| [火星地形起伏](https://www.generic-mapping-tools.org/remote-datasets/mars-relief.html)                | `mars_relief`                         | m     | @mars_relief    | 来自 NASA                                             |
| [水星地形起伏](https://www.generic-mapping-tools.org/remote-datasets/mercury-relief.html)             | `mercury_relief`                      | m     | @mercury_relief | 来自 USGS                                             |
| [月球地形起伏](https://www.generic-mapping-tools.org/remote-datasets/moon-relief.html)                | `moon_relief`                         | m     | @moon_relief    | 来自 USGS                                             |
| [冥王星地形起伏](https://www.generic-mapping-tools.org/remote-datasets/pluto-relief.html)             | `pluto_relief`                        | m     | @pluto_relief   | 来自 USGS                                             |
| [金星地形起伏](https://www.generic-mapping-tools.org/remote-datasets/venus-relief.html)               | `venus_relief`                        | m     | @venus_relief   | 来自 NASA                                             |


```{rubric} 自定义数据
```

用户可以自行在网络上找到更多地学数据，建立 GMT 数据库，供 GMT 使用。
GMT 中文社区整理了一些自定义数据，供用户选用：

- {doc}`gadm/index`
- {doc}`PB2002/index`
- {doc}`global_tectonics/index`
- {doc}`WSM_2016/index`

用户还可以在网上找到更多其他地学相关数据。可根据需求自行下载，并使用 GDAL 提供的
{ref}`ogr2ogr` 或 {ref}`gdal_translate` 命令转换为 GMT 可识别的数据格式。
下面列出一些地学数据的链接：

- 美国地质图：<https://mrdata.usgs.gov/geology/state/>
- 全球布格重力异常：<https://bgi.obs-mip.fr/grids-and-models-2/>
- 中国区域地表热流：<https://doi.org/10.1016/j.tecto.2019.01.006>
- 1:100万全国标准基础地理数据: <https://gmt-china.org/blog/national-geographic-database/>

```{toctree}
:hidden: true
:maxdepth: 1

usage
gshhg
dcw/index
gadm/index
PB2002/index
global_tectonics/index
WSM_2016/index
```
