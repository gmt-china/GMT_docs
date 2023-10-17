地学数据集
##########

使用 GMT 绘图时，经常用到一些特定的地学数据，如国界线、地形起伏数据等。
这些数据一般不需要任何改动即可用在多种图件中。根据使用方法的不同，分为三类：

1. GMT 内置数据：GMT 官方整理的内置于 GMT 软件包中的数据
2. GMT 远程数据：GMT 官方整理的保存在远程 GMT 数据服务器中的数据
3. 自定义数据：用户自行准备的数据

.. rubric:: GMT 内置数据

GMT 内置数据是指在安装 GMT 时就已经安装了的数据，因而可以直接使用。
目前，GMT 提供了如下内置数据：

- :doc:`gshhg`
- :doc:`dcw/index`

.. rubric:: GMT 远程数据

GMT 远程数据是指保存在 GMT 数据服务器的数据。使用某个远程数据时，GMT 会自动下载到本地。
目前，GMT 提供了如下远程数据：

- `earth_age：EarthByte 全球洋壳年龄数据 <https://www.generic-mapping-tools.org/remote-datasets/earth-age.html>`__
- `earth_geoid：EGM2008 全球大地水准面 <https://www.generic-mapping-tools.org/remote-datasets/earth-geoid.html>`__
- `earth_mag：EMAG2 全球磁异常模型 <https://www.generic-mapping-tools.org/remote-datasets/earth-mag.html>`__
- `earth_relief：IGPP 全球地形起伏 <https://www.generic-mapping-tools.org/remote-datasets/earth-relief.html>`__
- `earth_mask：GSHHG 全球掩膜数据 <https://www.generic-mapping-tools.org/remote-datasets/earth-mask.html>`__
- `earth_faa：IGPP 全球自由空气异常 <https://www.generic-mapping-tools.org/remote-datasets/earth-faa.html>`__
- `earth_gebco：GEBCO 全球地形起伏 <https://www.generic-mapping-tools.org/remote-datasets/earth-gebco.html>`__
- `earth_vgg：IGPP 全球垂直重力梯度 <https://www.generic-mapping-tools.org/remote-datasets/earth-vgg.html>`__
- `earth_day & earth_night：NASA 全球昼夜影像 <https://www.generic-mapping-tools.org/remote-datasets/earth-daynight.html>`__
- `earth_wdmam：WDMAM 全球数字磁异常 <https://www.generic-mapping-tools.org/remote-datasets/earth-wdmam.html>`__

.. rubric:: 自定义数据

除了 GMT 官方提供的内置数据和远程数据外，用户还可以自行准备数据，建立 GMT 数据库，供 GMT 使用。
GMT 中文社区整理了一些自定义数据，供用户选用：

- :doc:`gadm/index`
- :doc:`PB2002/index`
- :doc:`global_tectonics/index`

.. rubric:: 其他数据

用户还可以在网上找到更多其他地学相关数据。可根据需求自行下载，并使用 GDAL 提供的
:ref:`ogr2ogr` 或 :ref:`gdal_translate` 命令转换为 GMT 可识别的数据格式。
下面列出一些地学数据的链接：

- 美国地质图：https://mrdata.usgs.gov/geology/state/
- 全球布格重力异常：https://bgi.obs-mip.fr/data-products/grids-and-models/wgm2012-global-model/
- 中国区域地表热流：https://doi.org/10.1016/j.tecto.2019.01.006
- 1:100万全国标准基础地理数据: https://gmt-china.org/blog/national-geographic-database/

.. toctree::
   :maxdepth: 1
   :hidden:

   usage
   gshhg
   dcw/index
   earth_age：EarthByte 全球洋壳年龄数据 <https://www.generic-mapping-tools.org/remote-datasets/earth-age.html>
   earth_geoid：EGM2008 全球大地水准面 <https://www.generic-mapping-tools.org/remote-datasets/earth-geoid.html>
   earth_mag：EMAG2 全球磁异常模型 <https://www.generic-mapping-tools.org/remote-datasets/earth-mag.html>
   earth_relief：IGPP 全球地形起伏 <https://www.generic-mapping-tools.org/remote-datasets/earth-relief.html>
   earth_mask：GSHHG 全球掩膜数据 <https://www.generic-mapping-tools.org/remote-datasets/earth-mask.html>
   earth_faa：IGPP 全球自由空气异常 <https://www.generic-mapping-tools.org/remote-datasets/earth-faa.html>
   earth_gebco：GEBCO 全球地形起伏 <https://www.generic-mapping-tools.org/remote-datasets/earth-gebco.html>
   earth_vgg：IGPP 全球垂直重力梯度 <https://www.generic-mapping-tools.org/remote-datasets/earth-vgg.html>
   earth_day & earth_night：NASA 全球昼夜影像 <https://www.generic-mapping-tools.org/remote-datasets/earth-daynight.html>
   earth_wdmam：WDMAM 全球数字磁异常 <https://www.generic-mapping-tools.org/remote-datasets/earth-wdmam.html>
   gadm/index
   PB2002/index
   global_tectonics/index
   /dataset-CN/index
