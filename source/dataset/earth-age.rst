earth_age: 地球洋壳年龄数据
===========================

.. gmtplot::
   :show-code: false
   :width: 75%

   gmt begin earth-seafloor-age png,pdf
      gmt set MAP_TICK_LENGTH 2p MAP_ANNOT_OFFSET 2p MAP_FRAME_PEN 0.5p
      gmt grdimage @earth_age_06m -JQ180/6i -C@age_chrons_GTS2012_2020.cpt -B0 --MAP_FRAME_PEN=1p
      gmt colorbar -C@age_chrons_GTS2012_2020.cpt -G0/164.70  -Dn0.015/0.055+jBL+w5.8i/0.12c+h -S+c --FONT_ANNOT_PRIMARY=5p -F+gwhite+c0p/1p/2p/8p+pfaint
      gmt colorbar -C@age_chrons_GTS2012_2020.cpt -G0/164.70  -Dn0.015/0.055+jBL+w5.8i/0.12c+h+ma -S+n --FONT_ANNOT_PRIMARY=3.5p
   gmt end show

数据简介
--------

**earth_age** 数据是 GMT 提供的地球洋壳年龄数据。原始数据来源于公开数据，GMT 经过了一些预处理，
提供了不同分辨率和不同配准方式的网格数据，以满足用户的不同需求。
绘制 **earth_age** 数据时默认使用GMT缓存文件 *@age_chrons_GTS2012_2020.cpt* 作为 CPT 文件。

下表列出了 GMT 提供的 **earth_age** 数据的代码、配准方式、分辨率以及文件大小。

======= ========= ========= ========
代码    配准方式  分辨率     大小
======= ========= ========= ========
01d     g,p       1 弧度     125 KB
30m     g,p       30 弧分    402 KB
20m     g,p       20 弧分    827 KB
15m     g,p       15 弧分    1.4 MB
10m     g,p       10 弧分    2.9 MB
06m     g,p       6 弧分     7.3 MB
05m     g,p       5 弧分     10 MB
04m     g,p       4 弧分     15 MB
03m     g,p       3 弧分     26 MB
02m     g,p       2 弧分     56 MB
01m     g,p       1 弧分     188 MB
======= ========= ========= ========

- 代码中 **d**\ 、\ **m**\ 和 **s** 表示弧度、弧分和弧秒
- 配准方式中 **g** 和 **p** 分别表示网格线配准和像素配准

使用方法
--------

当需要使用地球洋壳年龄时，可以直接通过 **@earth_age_**\ *rru*\[_\ *reg*] 的形式调用这些地球洋壳年龄数据，
其中 *rru* 是网格文件的分辨率代码（上表第一列），\ *reg* 是要使用的配准方式代码（上表第二列）。
配准方式代码是可选的，若不指定，则默认返回像素配准的网格数据。如果命令中使用了 **-R** 选项，
则只会读取该区域内的地球洋壳年龄数据。

::

    # 查看 1 弧度分辨率（像素配准）的地球洋壳年龄的信息
    $ gmt grdinfo @earth_age_01d

    # 查看 30 弧分分辨率、网格线配准的地球洋壳年龄的信息
    $ gmt grdinfo @earth_age_30m_g

    # 使用 15 弧分地球洋壳年龄数据
    $ gmt grdimage -JH15c @earth_age_15m -pdf map

技术细节
--------

- 数据会自动下载并保存到 :file:`~/.gmt/server/earth/earth_age` 目录下
- 洋壳年龄数据的单位为 Myr（百万年），相对于 2012 地质年代表
- GMT 提供的洋壳年龄数据的最小单位是 0.01 Myr，低于原始模型中的不确定度
- GMT 对数据进行了缩放和偏移，以使得数据可以以短整型的形式保存到 netCDF 格式，
  极大的减小了数据所占的空间

数据来源及引用
--------------

- Seton et al., 2020, http://dx.doi.org/10.1029/2020GC009214
