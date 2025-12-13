:author: 朱邓达, 周茂, 田冬冬
:date: 2025-05-17

.. index:: ! grdtrack
.. include:: common_SYN_OPTs.rst_
.. program:: grdtrack

grdtrack
========

:官方文档: :doc:`gmt:grdtrack`
:简介: 在指定位置对一个或多个网格插值

语法
--------

**gmt grdtrack** [ *table* ] |-G|\ *grd1* [ |-G|\ *grd2* ... ]
[ |-A|\ [**f**\|\ **p**\|\ **m**\|\ **r**\|\ **R**][**+l**] ]
[ |-C|\ *length*/\ *ds*\ [*/spacing*][**+a**\|\ **v**][**d**\|\ **f**\ *value*][**l**\|\ **r**] ]
[ |-D|\ *dfile* ]
[ |-E|\ *table*\|\ *origin*\|\ *line*\ [,\ *line*\ ,...\ ][**+a**\ *az*][**+c**][**+d**][**+g**][**+i**\ *inc*][**+l**\ *length*][**+n**\ *np*][**+o**\ *az*][**+p**][**+r**\ *radius*][**+x**] ]
[ |-F|\ [**+b**][**+n**][**+r**][**+z**\ *z0*] ]
[ |-N| ]
[ |SYN_OPT-R| ]
[ |-S|\ [**a**\|\ **l**\|\ **L**\|\ **m**\|\ **p**\|\ **u**\|\ **U**][**+a**][**+c**\ *fact*][**+d**][**+r**][**+s**\ [*file*]] ]
[ |-T|\ [*radius*][**+e**\|\ **p**] ]
[ |-V|\ [*level*] ]
[ |-Z| ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-j| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-w| ]
[ **-:**\ [**i**\|\ **o**] ]
[ |SYN_OPT--| ]

描述
-----------    

**grdtrack** 读取一个或多个网格文件以及一个前两列（支持更多列）
为点位 *(x, y)* 或 *(lon, lat)* 的表数据（来自文件或标准输入，但 |-E| 例外）。**grdtrack** 
会在表数据提供的位置上插值网格值，并将插值结果输出到新的一列（或多列）。或者使用 |-C| 选项，
可将表数据认作线段，然后在每个线段节点上（或者沿着线段等距地）创建与之垂直的交叉测线，
再沿着这些测线插值网格。对于插值方法（见 :doc:`/option/n` ），可选择双三次(bicubic)（默认），
双线性(bilinear)，B样条(B-spline)和最近邻(nearest-neighbor)，且要求 **-n** 
指定网格的边界条件，默认使用自然边界条件（即边界法向二阶导数为0），
除非网格被自动识别为有周期性。


必选选项
------------------

*table*
    ASCII 格式文件（或者二进制，见 :doc:`/option/binary` ），前两列为用户设置的插值位置
    *(x, y)* 或 *(lon, lat)* 。如果不提供 *table* ，则从标准输入读取。
    如果设置了 |-E| 则不会读取输入表数据，因为 |-E| 会创建。

.. option:: -G

**-G**\ *gridfile*
    *gridfile* 为一个 2-D 网格。你可以多次使用 |-G| 或者使用 **-G+l**\ *list* 来传入多个网格，
    其中 *list* 为一个文本文件，网格名称在每行的第一个非数值列。
    网格插值结果顺序按照输入顺序。 
    
    **注：** 如果 *gridfile* 是一个远程文件，且未指定网格配准，
    **grdtrack** 默认使用网格线配准（而非像素点配准）
    以确保所有输入点都在网格区域内。


可选选项
------------------

.. option:: -A

**-A**\ [**f**\|\ **p**\|\ **m**\|\ **r**\|\ **R**][**+l**]
    关于沿测线进行采样（如果设置了 |-C| 或 |-E| ）的一些选项，在 |-A| 后追加：

    + **f** - 沿测线采样，保留原始点位，按需会适当插值线段中点（默认）。
    + **m** - 类似 **f** ，但测线变为阶梯状，先沿经度采样，再沿纬度采样。
    + **p** - 类似 **f** ，但测线变为阶梯状，先沿纬度采样，再沿经度采样。
    + **r** - 等距采样，此时输入的点位（尤其是端点）可能不会严格包括在输出结果中。
    + **R** - 类似 **r** ，但会适当调整采样点间距使输入点位都在输出结果中。
  
    最后，可以加上 **+l** 使地理距离的测量沿着恒向线（rhumb lines 或 loxodromes ，
    即沿着该方向行进时行进方向始终与经线保持相同夹角）而不是默认的大圆弧。
    **+l** 仅可与 |-C| 同时使用。

.. option:: -C

**-C**\ *length*/\ *ds*\ [*/spacing*][**+a**\|\ **v**][**d**\|\ **f**\ *value*][**l**\|\ **r**] 
    基于输入线段，创建一组等距采样点并插值。另外，可以计算与线段相交的交叉线段并插值。
    等距采样点以及交叉线段的设置包含如下三个参数，三者单位一致，但仅能在 *length* 后指定单位：
    
    + *length* - 交叉线段的长度，后跟单位。地理坐标下默认米(**e**)，在地理坐标下强烈建议手动指定单位。
    + *ds* - 交叉线段的采样间隔。
    + *spacing* - （可选）交叉线段间的距离，此时将沿着线段等距 *spacing* 创建交叉测线 [默认在每个线段节点上创建]。

    另外，可追加如下子选项：
    
    - **+a**，默认情况下，沿着线段前进方向看，所有交叉测线的点位顺序保持一致（从左到右），
      该选项使多条交叉测线的点位顺序交替变化。
    - **+v**， 同上，但使点位顺序根据交叉测线走向，大致呈现自西向东或自南向北。
    - **+l**，默认情况下，输出整条交叉测线，使用该选项仅保留左半支。
    - **+r**，同上，仅保留右半支。
    - **+d**\ *value* 为交叉测线的走向加上偏离角 *value* 
    - **+f**\ *value* 指定所有交叉测线为固定走向 *value* 。

    输出结果中每列为 *lon, lat, dist, azimuth, z1, z2, ..., zn* ，其中 *zi* 
    表示第 *i* 个网格在 *(lon, lat)* 位置的采样值。

    **注：** 

    + 如果使用了 |-C| 且设置了 *spacing* ，则 |-E| 设置的测线采样间隔将被覆盖。
    + 在地理坐标下， |-C| 和 |-E| 使用不同单位会存在bug
      （详见PR `#8728 <https://github.com/GenericMappingTools/gmt/pull/8728>`_ ），
      如果同时使用，请手动指定相同的距离单位。

.. option:: -D

**-D**\ *dfile*
    与 |-C| 一起使用，将原始线段（可能被重采样）保存到 *dfile* 文件中，
    否则仅输出交叉测线的结果到标准输出。输出 *dfile* 格式为
    *lon, lat, dist, azimuth, z1, z2, ..., zn* ，其中 *zi* 
    表示第 *i* 个网格在 *(lon, lat)* 位置的采样值。

.. include:: explain_lines.rst_

.. option:: -F

**-F**\ [**+b**][**+n**][**+r**][**+z**\ *z0*]
    搜索每条交叉测线的 z 值临界点作为沿测线距离的函数。该选项只能与 |-C| 以及单个网格同时使用。
    一条交叉测线的对应结果输出一行，每列按顺序包括
    
    + *dist, lonc, latc, distc, azimuthc, zc* - 最大 z 值的位置及相关量。
    + *lonl, latl, distl* - 交叉测线从左至右首个大于 *z0* 值的位置（左临界点）。
    + *lonr, latr, distr* - 交叉测线从右至左首个大于 *z0* 值的位置（右临界点）。
    + *width* - 左右临界点的间距。
    
    其中 *dist* 为该条交叉测线与主测线的交点在主测线上的距离（该交点也定义为交叉测线上测量距离的原点），
    其余12项为沿测线距离 *dist* 的函数。
    
    使用以下子选项可计算不同类型的临界点：
    
    - **+z**\ *z0* 上述默认计算的最大值为不受约束的最大值，设置 *z0* 为非负数可搜索不超过该值的最大值。
    - **+n** 搜索最小值，而不是最大值，与上述 **+z**\ *z0* 同时使用将输出受限制的最小值，其中 *z0* 仍为非负数，GMT 内部将取反处理。
    - **+b** 将交叉测线上的 z 值作为权重，计算交叉测线上距离的加权平均值所在位置(*lonc, latc*)
      （相当于将z值当作砝码，计算平衡点），左右临界点则为一倍标准差的位置，计算公式为 
      :math:`\sigma=\sqrt{\frac{\sum_i z_i \cdot \sum_i z_i d_i^2 - (\sum_i z_i d_i)^2}{(n-1/n) (\sum_i z_i)^2}}`。
    - **+r** 与 **+b** 类似，但此时 (*lonc, latc*) 为交叉测线距离原点 (*distc*\ ==0)，
      左右临界点为一倍距离加权 RMS 的位置，计算公式为 
      :math:`\text{RMS}=\sqrt{\frac{\sum_i z_i d_i^2}{\sum_i z_i}}` 。

    **注：** 以上临界点的位置取交叉测线上符合条件的最近节点位置，并未新增采样点。

.. option:: -N

**-N**
    不跳过超过网格范围的点（默认仅处理网格范围内的点）。

.. include:: explain_-R.rst_

.. option:: -S

**-S**\ [**a**\|\ **l**\|\ **L**\|\ **m**\|\ **p**\|\ **u**\|\ **U**][**+a**][**+c**\ *fact*][**+d**][**+r**][**+s**\ [*file*]]
    配合 |-C| 使用，根据所有交叉测线计算一条叠加测线。可指定以下叠加方法：

    + **a** - 计算平均数
    + **m** - 计算中位数
    + **p** - 使用半样本法估计连续数据的众数
    + **l** - 计算最小值
    + **L** - 计算最小正值
    + **u** - 计算最大值
    + **U** - 计算最大负值
    
    支持使用以下多个选项，在 |-C| 输出的所有交叉测线基础上在行末增加输出内容：

    + **+a** - 输出叠加结果
    + **+d** - 输出叠加偏差（统计意义上的 *deviation* ）
    + **+r** - 输出数据相对叠加值的残差 (*data* - *stack*)
    + **+s** - 将叠加测线结果单独保存到 *file* 文件 （默认为 stacked_profile.txt）
    + **+c** - 在叠加测线结果文件 *file* 中输出叠加测线的置信区间 *stack* ± *fact*\ \*\ *deviation* ，默认 *fact* = 2
    
    **注：** 
    
    + 偏差值 *deviation* 取决于使用哪种叠加方法， **a** 使用标准差， **m|p** 
      使用 L1 范数，即 1.4826 乘以中位数绝对偏差(Median Absolute Deviation, MAD)，
      **l|L|u|U** 使用最高值与最低值的差的一半。
    + 叠加测线结果可使用 **+s** 单独保存到文件 *file* 中，第一列为交叉测线在主测线上的距离，
      后面每一个网格结果形成 4 列（或 6 列），分别为叠加结果，叠加偏差，最小值和最大值，
      如果叠加方法为 **a|m|p** ，则再加上置信区间的下界和上界。
    + 对于在 |-C| 输出的基础上新增的列，始终按照叠加结果 (**+a**)，叠加偏差 (**+d**) 和残差 (**+r**) 的顺序，
      实际输出几列取决于是否使用对应选项。当输入多个网格时，结果按照该顺序为一组进行重复。
    
    该选项较为复杂，关于该选项的的使用示例见 `官方示例(33) <https://docs.generic-mapping-tools.org/dev/gallery/ex33.html>`_ 。

.. option:: -T

**-T**\ [*radius*][**+e**\|\ **p**]
    用于常规网格采样过程（即读取 *table* 表数据，不使用 |-C| 和 |-E| ），仅限于单个网格文件。
    采样过程中如果最近节点值为 NaN， 则向外扩展搜索最近的非 NaN 值。可设置 *radius* 作为搜索半径，
    地理坐标下默认单位为度 (**d**)，设置 *radius*\ =0（默认）则不限制半径。 
    
    - **+p** 表示将输出点位替换为最近非 NaN 节点的位置
    - **+e** 则增加三列输出，报告最近非 NaN 节点的位置及其与输入点位的距离。

.. include:: explain_-V.rst_

.. option:: -Z

**-Z**
    用于常规网格采样过程，只输出采样的 z 值（默认输出所有列）。 **注：** 如果和 :doc:`/option/s` 一起使用，
    **-s** 中的默认列变为 0 而不是 2。如果在 **-s** 中指定列索引，z 值所在列从 0 开始编号而不是 2。

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_distcalc.rst_

.. include:: explain_-n.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_precision.rst_

网格重采样的后果
-------------------

网格采样过程中可能会使用各种算法（见 :doc:`/option/n` ），导致采样值出现失真或意外值。
例如，使用样条插值可能会导致插值后的数据的最大最小值超过原始数据的最大最小值。
若这一结果不可接受，可以通过给 **-n** 选项加上 **+c** 以对超过原始数据最值的部分做裁剪。

提示
-------

如果采样点不在输入网格的节点上，则在该点周围的任何邻近节点上的 NaN 将导致插值结果为 NaN。
双三次插值（默认方法）产生连续的一阶导数，但需要 4 × 4 节点的邻域。双线性插值只使用 2 × 2 邻域，但只产生零阶连续性。
当平滑性很重要时，使用双三次插值。使用双线性插值可最小化 NaN 的传播，或 **-n** 中的 *threshold* 。

示例
-------

.. include:: explain_example.rst_

要从远程网格 @earth_relief_05m 采样(0, 0)到(20, 20)之间的大圆测线，并且只输出(dist, topo)记录::
    
    gmt grdtrack -G@earth_relief_05m -R0/20/0/20 -EBL/TR+d -o2,3 -fg > profile.txt

从网格 hawaii_topo.nc 中沿着 track_4.xyg 采样（一个ASCII格式的表数据，包括经度、纬度和基于SEASAT卫星的重力数据，
包含一行头段记录）::
    
    gmt grdtrack track_4.xyg -Ghawaii_topo.nc -h > track_4.xygt
    
沿着文件 cruise_track.xy 中提供的( *lon, lat* )坐标，对 Sandwell/Smith 海深文件 topo_19.1.nc
和年龄网格文件 age.3.2.nc (Muller et al.) 进行采样::
    
    gmt grdtrack cruise_track.xy -Gtopo_19.1.nc -Gage.3.2.nc > depths-age.txt
    
沿着文件 track.xy 定义的测线，每隔 25km 创建与之垂直的交叉测线，采样间隔为 3km，对 Sandwell/Smith
重力异常文件 grav_32.1.nc 采样::
    
    gmt grdtrack track.xy -Ggrav_32.1.nc -C100k/3/25 -Ar > xprofiles.txt

与上面类似，但确定沿测线的中心异常位置，阈值为 25 mGal ::
    
    gmt grdtrack track.xy -Ggrav_32.1.nc -C100k/3/25 -F+z25 > locations.txt
    
沿着网格文件 data.nc 的左下角到右上角进行采样，使用间距1km的测地线，输出包括距离::
    
    gmt grdtrack -ELB/RT+i1k+d -Gdata.nc -je > profiles.txt



相关
----
:doc:`convert`,
:doc:`text`,
:doc:`sample1d`,
:doc:`project`,
:doc:`surface`
