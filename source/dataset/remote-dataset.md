# GMT 远程数据

GMT 远程数据位于 GMT 数据服务器，在 GMT 中使用时会自动下载。
以下列出了 GMT 提供的所有远程数据类型。默认情况下，所有数据均为最新版本，
但在原始数据发布新版本时，GMT 提供数据可能会稍有延迟。

| 数据类型                                                                                              | 数据名称                              | 默认 CPT        | 说明                                      |
|-------------------------------------------------------------------------------------------------------|---------------------------------------|-----------------|-------------------------------------------|
| [地球地形起伏](https://www.generic-mapping-tools.org/remote-datasets/earth-relief.html)               | `earth_relief` 或 <br>`earth_synbath` | geo             | 由 IGPP 对 Scripps SRTM15+V2.6 重采样得到 |
| [地球 GEBCO 地形起伏](https://www.generic-mapping-tools.org/remote-datasets/earth-gebco.html)         | `earth_gebco` 或 <br>`earth_gebcosi`  | geo             | 海底地形部分来自 GEBCO 项目               |
| [地球大地水准面](https://www.generic-mapping-tools.org/remote-datasets/earth-geoid.html)              | `earth_geoid`                         | 无              | 来自 NGA 发布的 EGM2008 超高阶重力场模型  |
| [地球自由空气重力异常](https://www.generic-mapping-tools.org/remote-datasets/earth-faa.html)          | `earth_faa`                           | @earth_faa      | 来自 IGPP，范围：±80˚                     |
| [地球自由空气重力异常误差](https://www.generic-mapping-tools.org/remote-datasets/earth-faaerror.html) | `earth_faaerror`                      | @earth_faa      | 为 `earth_faa` 的伴随数据                 |
| [地球垂直重力梯度异常](https://www.generic-mapping-tools.org/remote-datasets/earth-vgg.html)          | `earth_vgg`                           | @earth_vgg      | 来自 IGPP，范围：±80˚                     |
| [地球垂线偏差东西向分量](https://www.generic-mapping-tools.org/remote-datasets/earth-edefl.html)      | `earth_edefl`                         | @earth_defl     | 来自 IGPP，范围：±80˚                     |
| [地球垂线偏差南北向分量](https://www.generic-mapping-tools.org/remote-datasets/earth-ndefl.html)      | `earth_ndefl`                         | @earth_defl     | 来自 IGPP，范围：±80˚                     |
| [地球磁异常](https://www.generic-mapping-tools.org/remote-datasets/earth-mag.html)                    | `earth_mag` 或 <br>`earth_mga4km`     | @earth_mag      | EMAG2 模型                                |
| [地球数字磁异常](https://www.generic-mapping-tools.org/remote-datasets/earth-wdmam.html)              | `earth_wdmam`                         | @earth_wdman    | 来自 WDMAM 项目                           |
| [地球洋壳年龄](https://www.generic-mapping-tools.org/remote-datasets/earth-age.html)                  | `earth_age`                           | @earth_age      | 来自 EarthByte                            |
| [地球平均稳态海面地形](https://www.generic-mapping-tools.org/remote-datasets/earth-mdt.html)          | `earth_mdt`                           | @earth_mdt      | CNES 发布，IGPP 重处理                    |
| [地球平均海平面](https://www.generic-mapping-tools.org/remote-datasets/earth-mss.html)                | `earth_mss`                           | @earth_mss      | CNES 发布，IGPP 重处理                    |
| [地球水陆掩膜](https://www.generic-mapping-tools.org/remote-datasets/earth-mask.html)                 | `earth_mask`                          |                 | 由 {doc}`/module/grdlandmask` 计算得到    |
| [地球到海岸线距离](https://www.generic-mapping-tools.org/remote-datasets/earth-dist.html)             | `earth_dist`                          | @earth_dist     | 由 {doc}`/module/grdmath` 计算得到        |
| [地球昼夜卫星影像](https://www.generic-mapping-tools.org/remote-datasets/earth-daynight.html)         | `earth_day` 或 <br>`earth_night`      |                 | 来自 NASA                                 |
| [火星地形起伏](https://www.generic-mapping-tools.org/remote-datasets/mars-relief.html)                | `mars_relief`                         | @mars_relief    | 来自 NASA                                 |
| [水星地形起伏](https://www.generic-mapping-tools.org/remote-datasets/mercury-relief.html)             | `mercury_relief`                      | @mercury_relief | 来自 USGS                                 |
| [月球地形起伏](https://www.generic-mapping-tools.org/remote-datasets/moon-relief.html)                | `moon_relief`                         | @moon_relief    | 来自 USGS                                 |
| [冥王星地形起伏](https://www.generic-mapping-tools.org/remote-datasets/pluto-relief.html)             | `pluto_relief`                        | @pluto_relief   | 来自 USGS                                 |
| [金星地形起伏](https://www.generic-mapping-tools.org/remote-datasets/venus-relief.html)               | `venus_relief`                        | @venus_relief   | 来自 NASA                                 |

## 使用方式

上述 GMT 数据均为网格形式，GMT 为每种远程数据都提供了不同的分辨率和配准方式的数据，
具体信息在查阅各个数据对应的文档。所有 GMT 远程数据都可以通过指定特殊文件名的方式来使用：
**@**_remote_name_\_*rr*_u_\_*reg*

- **@** 符号用于告诉 GMT 这是一个远程数据
- *remote_name* 是远程数据的具体名字
- *rr* 是一个两位整数，用于指定要使用的数据分辨率，单位由 *u* 指定。
  单位 *u* 可以取为 **d**、**m** 或 **s** 分别表示度、分和秒
- *reg* 指定了数据的网格配准方式，可以取 **g** 或 **p**，分别表示网格线配准或像素配准。
  该项是可选的，若不指定 *reg*，则默认返回网格线配准的网格数据（除非不存在网格线配准的数据）。

除此之外，某些远程数据还有一个默认的 CPT 文件，若用户不指定 CPT 文件，则在绘制数据
时会使用该默认 CPT 文件。

:::{note}
关于每个数据的具体名称、分辨率、默认配准方式，在各个数据的官方网页中会详细列出。
:::

例如，若需要使用 30 分的网格线配准的地形数据，则可以直接指定文件名:

```
gmt grdimage @earth_relief_30m_g -pdf map
```

如果想要将某个区域的数据以单个文件的形式保存，并供其它
软件或命令使用，可以使用 {doc}`/module/grdcut` 命令实现。例如:

```
gmt grdcut @earth_relief_02m_g -Gearth_at_2m.grd
```

## 参数设置

你可以通过多个参数和命令进一步控制远程数据的获取过程以及数据在本地所占据的硬盘空间：

1. 通过参数 {term}`GMT_DATA_SERVER` 设置使用离你最近的GMT数据服务器以加快下载速度
2. 通过参数 {term}`GMT_DATA_SERVER_LIMIT` 设置允许下载的远程数据的文件大小，默认无限制
3. 使用参数 {term}`GMT_AUTO_DOWNLOAD` 彻底关闭数据自动下载功能。
   若关闭，你将无法再下载或更新远程数据，但已下载到本地的数据依然可以使用。
4. 通过参数 {term}`GMT_DATA_UPDATE_INTERVAL` 控制检查远程数据是否更新的频率 \[默认为每天检查一次\]
5. 通过 {doc}`/module/clear` 命令清理整个 *server* 目录下的远程数据或部分数据

:::{note}
GMT数据服务器目前在全球范围内有多个镜像。详细的镜像列表见
<https://www.generic-mapping-tools.org/mirrors> 页面。

对于国内用户，建议直接使用中科大LUG提供的国内镜像。修改方式为:

```
gmt set GMT_DATA_SERVER https://mirrors.ustc.edu.cn/gmtdata
```

然后将生成的 {file}`gmt.conf` 文件复制到GMT用户目录 {file}`~/.gmt` (Linux/macOS)
或 {file}`C:\\Users\\XXX\\.gmt`（Windows）下。

请注意GMT 6.4 及其之前的版本，都无法正常使用科大镜像下载数据。因此强烈建议国内用户使用GMT 6.5 及其以上版本。
:::

## 离线使用

如果你即将有一段无网络或低网速的时间，或者你不希望在第一次需要某个数据等待数据的
下载，你可以使用 {doc}`/module/gmtget` 模块将数据提前下载到本地。

你可以下载所有远程数据:

```
gmt get -Ddata
```

也可以只下载地球相关数据:

```
gmt get -Ddata=earth
```

或者只下载某一类或某几类数据:

```
gmt get -Ddata=earth_relief,earth_mask
```

高分辨率数据的数据量大，你也可以只下载低分辨率的数据。比如只需要低于1分分辨率的地形数据:

```
gmt get -Ddata=earth_relief -I1m
```

更多功能，见 {doc}`/module/gmtget` 模块文档。

(setup-database)=

## 工作原理及技术细节

经过一些数据处理，GMT官方把一些公开数据处理成不同分辨率、不同配准方式的数据，
并保存在GMT专门的数据服务器上。当用户**第一次**使用某个分辨率的某个数据时，
GMT会自动从服务器上下载该数据文件，并保存到GMT用户目录下的特定子目录下
（默认为 {file}`~/.gmt/server` 目录的子目录），然后再读取该文件。
当用户再次使用该数据时，GMT会自动从本地GMT用户目录下读取该数据文件，
而无需再次从服务器下载。

### 数据分辨率

通常，公开数据提供者只提供一个原始分辨率版本。但有些时候用户不需要原始分辨率。
GMT对原始数据做笛卡尔高斯滤波以进行减采样，提供了多种
不同分辨率以及不同配准方式的版本，以满足不同的用户需求。

### 数据分块

通常，一个分辨率、一个配准方式的数据以单个文件的形式保存在GMT服务器中。
但，对于高分辨率的数据，这会导致单个文件的大小变得很大，使得网络下载变得困难。
为了解决这一问题，对于高分辨率的数据，GMT官方将其分割成若干个小区块，
每个区块以单独的文件保存在服务器上，通常每个区块对应的文件大小约5 MB或更小。
当用户需要某个区域的高分辨率数据时，可以通过 **-R** 选项指定区域，
GMT会自动下载该区域的所有区块的数据，然后自动合并成单个网格数据供用户使用。
这样可以极大减小数据下载量。例如，想要用3秒的数据绘制2度x2度的区域，GMT只需要
下载该区域几MB的网格数据，而无需下载整个7 GB的3秒数据，极大的节省了下载时间。

### 数据压缩

GMT以无损且高压缩率的netCDF-4短整型格式保存单个网格数据，使得GMT提供的数据比
原始数据占据更小的硬盘空间，而不丢失任何分辨率信息。对于分区块的高分辨率数据，
GMT将数据以 JPEG2000 格式保存在GMT服务器中。该格式具有超高的压缩率，因而可以
极大减小数据下载量。当将这些 JPEG2000 格式的数据下载到本地后，GMT会自动将其
转换为短整型 netCDF4 格式。转换过程中使用了GDAL的功能，因而要求GMT支持GDAL。

### 数据更新

当原始数据发布了新版本，或GMT提供的数据被发现存在问题时，GMT会对数据服务器上的数据
进行不定时的更新。GMT只提供数据的最新版本。如果你需要老版本的数据，需要自行到
数据提供者的官方网站下载数据并自行处理。

GMT检查数据更新的机制是：

1. 第一次使用任一远程数据时，GMT会从数据服务器下载一个几十 KB 的文本文件
   {file}`gmt_data_server.txt` 并保存到用户的 {file}`~/.gmt/server` 目录下
2. 当再次使用任一远程数据时，GMT会检查本地文件 {file}`gmt_data_server.txt` 的日期，
   若其日期比当前时间差一天（该时间阈值用户可自行控制）以上，则再次从GMT服务器
   下载文件 {file}`gmt_data_server.txt` 并替换本地的老文件
3. 读取 {file}`gmt_data_server.txt` 文件的内容，根据其内容确定GMT数据服务器上的
   远程数据是否有更新。若本地的数据文件比GMT数据服务器上的数据老，则
   GMT会自动将本地已下载的数据文件删除，并重新从GMT服务器下载。由此使用远程数据的
   更新。

