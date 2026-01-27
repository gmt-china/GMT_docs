:author: 田冬冬, 陈箫翰, 王亮, 姚家园, 朱邓达
:date: 2026-01-09

.. index:: ! project
.. program:: project

project
=======

:官方文档: :doc:`gmt:project`
:简介: 生成测线、将数据点投影到测线上

该模块具有三个主要功能：

#. 生成测线
#. 指定测线和数据点，得到该点在测线坐标系下的坐标，即下文中提及的 *p* 和 *q*
#. 指定测线和数据点，得到该点在测线上的投影点的坐标，即下文中提及的 *r* 和 *s*

以上三个功能均要求用户首先定义测线，测线可以用如下三种方式中的任意一种来定义：

#. 用 :option:`-C` 选项定义测线的起点，并用 :option:`-A` 定义测线方位角。
#. 用 :option:`-C` 选项定义测线的起点，并用 :option:`-E` 选项定义测线的结束点。
#. 用 :option:`-C` 选项定义测线的中心，并用 :option:`-T` 选项定义旋转极点的位置。当使用 :option:`-N` 设置笛卡尔坐标变换时，不允许使用此方式。

**project** 可以从输入数据中读取 (:math:`x, y [,\ z]`) 坐标数据，并输出 (:math:`x, y, z, p, q, r, s`) 的任意组合。其中：

- *x* 和 *y* 是数据在原坐标系下的坐标
- *z* 是输入数据中的其余所有列
- *p* 和 *q* 是数据点 (x,y) 在测线坐标系下的坐标
- *r* 和 *s* 是数据点 (x,y) 在测线上的投影点在原坐标系下的坐标

可以使用 :option:`-F` 选项设置要输出哪些变量。

或者使用 :option:`-G` 选项生成测线，输出测线上的点的坐标。 **project** 可以沿剖面以等间距 *dist* 输出 (:math:`r, s, p`) 。在这种情况下，不需要读取任何输入数据。

为了将数据沿大圆路径进行球面投影，会创建一个斜坐标系，其赤道沿该路径，且零经度线通过 *cx/cy*。
此时，斜经度 (:math:`p`) 对应于沿大圆路径距离 *cx/cy* 的距离，斜纬度 (:math:`q`) 对应于垂直于大圆路径的距离。
当向 (:math:`p`) 增加的方向（即由 :option:`-A`\ *azimuth* 设定的方向）移动时，正 (:math:`q`) 方向位于左侧。
如果通过 :option:`-T` 指定了极点，则正 (:math:`q`) 方向指向极点。

若要指定斜投影，请使用 :option:`-T` 选项设置极点。此时投影的赤道已经确定，通过 :option:`-C` 选项来定位 :math:`p = 0` 的经线。
中心点 *cx/cy* 将被视为 :math:`p = 0` 经线所通过的一个点。如果不需要选择特定的点，请使用南极点（*cx* = 0, *cy* = -90）。

可以使用 :option:`-L` 和 :option:`-W` 选项对数据进行过滤。
如果使用 :option:`-W`，则仅输出 :math:`w_{min} < q < w_{max}` 的点。
如果设置了 :option:`-L`，则仅输出 :math:`l_{min} < p < l_{max}` 的点。

下面详细解释一下这些变量的物理意义。

.. gmtplot:: project/project_sketch.sh
   :width: 60%
   :show-code: false

   project 示意图1

图中的红点就是给出的点(x,y)。绿色粗线为测线。
测线上有 3 个点，蓝色和绿色两个点为测线的起点和终点。
以测线起点为原点，以测线为P轴，在测线起点按右手螺旋法则做垂直于P轴的Q轴，构成测线坐标系。
点(x,y)在测线坐标系的坐标即为(p,q)。
紫色点为点(x,y)在测线上的投影点，坐标为(r,s)。

.. gmtplot:: project/project_setup.sh
   :width: 60%
   :show-code: false

   project 示意图2

输入数据（红色圆圈）在原始的 :math:`x\text{-}y` （或经纬度 :math:`lon\text{-}lat` ）坐标系中给出，
并被投影到由起点 (**C**) 以及终点 (**E**) 或方位角 (:math:`\alpha`) 定义的 :math:`p\text{-}q` 测线坐标系中。
蓝色点的投影坐标为 :math:`(p, 0)`，在原始坐标系中为 :math:`(r, s)`。
选项 :option:`-L` （限制 :math:`p` 的范围）和 :option:`-W` （限制 :math:`q` 的范围）可用于排除指定范围之外的数据（浅灰色区域）。

对于特定的大圆和大地距离计算，或反方位角/方位角的计算，最好使用 :doc:`mapproject`，因为 **project** 仅严格遵循球面计算。

语法
--------

**gmt project**
[ *table* ]
:option:`-C`\ *cx*/*cy*
[ :option:`-A`\ *azimuth* ]
[ :option:`-E`\ *bx*/*by* ]
[ :option:`-F`\ *flags* ]
[ :option:`-G`\ *dist*\ [*unit*][/*colat*][**+c**][**+h**][**+n**] ]
[ :option:`-L`\ [**w**\|\ *lmin*/*lmax*] ]
[ :option:`-N` ]
[ :option:`-Q` ]
[ :option:`-S` ]
[ :option:`-T`\ *px*/*py* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *wmin*/*wmax* ]
[ :option:`-Z`\ *major*\ [*unit*][/*minor*/*azimuth*][**+e**] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-bo`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
------------------

.. include:: explain_intables.rst_

必须选项
--------

.. option:: -C

**-C**\ *cx*/*cy*
    当与 :option:`-A` 或 :option:`-E` 结合使用时，设置测线的起点 *cx/cy*。
    当与 :option:`-T` 结合使用时，设置斜零经线 (:math:`p = 0`) 所通过的点 *cx/cy* 的坐标。*cx/cy* 并不要求必须位于距离极点 90 度的位置。

可选选项
--------

.. option:: -A

**-A**\ *azimuth*
    定义1中用于指定测线的方位角。参数 *azimuth* 定义为正北开始的顺时针旋转角。

.. option:: -E

**-E**\ *bx*/*by*
    定义2中用于指定测线的终点

.. option:: -F

**-F**\ *flags*
    指定输出格式 *flags* 。使用 *xypqrsz* 的任意组合按任意顺序指定所需的输出格式 [默认输出格式为 *xypqrsz*]。
    如果输出格式为 ASCII，则 *z* 还包含任何尾随文本（无论 *z* 在 *flags* 中的顺序如何，文本均放置在记录的末尾）。必须使用小写字母且不要在字母之间添加空格。
    **注意**：如果使用了 :option:`-G`，则输出顺序固定为 *rsp*，并且此时 :option:`-F` 选项无效。

.. option:: -G

**-G**\ *dist*\ [*unit*][/*colat*][**+c**][**+h**][**+n**]
    该选项用于生成测线，此时不需要输入文件 **table** 。
    输出数据有三列：经度、纬度以及当前点离测线起点的距离，即 (*r*, *s*, *p*) ，测点的距离间隔为 *dist* 。

    - 不使用 :option:`-Q` 选项时， *unit* 的设置无效。 (*r*, *s*, *p*) 和 *dist* 的单位强制为弧度。
    - 而使用 :option:`-Q` 选项时， *r*、*s* 的单位是弧度， *p* 和 *dist* 的单位默认为km。可以设置 *unit* 为其他长度单位，例如 **e** 表示为m。

    可以使用以下附加选项：

    * 附加 /*colat* 使用小圆路径 [默认余纬为 90，即按照大圆路径生成测线]。注意，当使用 :option:`-C` 和 :option:`-E` 指定测线的两个端点时，起点和终点之间的距离不能超过 :math:`2|colat|`。
    * 在使用 :option:`-T` 时附加 **+c**，以计算使小圆经过中心点 *cx/cy* 的余纬。
    * 在使用 :option:`-T` 时附加 **+h**，以在段头中报告极点的位置 [默认无文件头]。
    * 附加 **+n** 则 *dist* 不再表示为距离间隔，而是测点的总数。需要 :option:`-C` 和 :option:`-E` 或 :option:`-Z`，以便计算长度。

.. option:: -L

**-L**\ [**w**\|\ *lmin*/*lmax*]
    只输出坐标满足 :math:`l_{min} < p < l_{max}` 的数据，单位规定见 :option:`-Q` 选项。
    若使用了 :option:`-E` 选项，则可以简单使用 **-Lw** 表示只选取 *p* 在测线起点和终点之间的数据。

.. option:: -N

**-N**
    指定展平地球，在平面内使用笛卡尔坐标变换。不使用本选项默认使用球面三角。
    **注意：** 即使使用了本选项，方位角 *azimuth* 也是定义为从正北开始的顺时针旋转角， **不是** 通常笛卡尔坐标系中的 theta（从 :math:`x` 轴开始的逆时针旋转角）。
    即：:math:`azimuth = 90 - theta`。

.. option:: -Q

**-Q**
    指定原坐标系下 *x*、*y*、*r*、*s* 的单位是弧度，
    测线坐标系下 *p*、 *q*、 *dist*、 *lmin*、 *lmax*、 *wmin*、 *wmax* 的单位是km。
    若不使用本选项，则以上所有量都默认为相同的单位（球面三角中默认全部为弧度）。

.. option:: -S

**-S**
    将输出按照 *p* 增序排列。在原数据坐标随机分布时较为有用。

.. option:: -T

**-T**\ *px*/*py*
    将投影旋转极点的位置设置为 :math:`px/py`。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *wmin*/*wmax*
    只输出坐标满足 :math:`w_{min} < q < w_{max}` 的数据，单位规定见 :option:`-Q` 选项。

.. option:: -Z

**-Z**\ *major*\ [*unit*][/*minor*/*azimuth*][**+e**]
    创建长轴为 :math:`major`、短轴为 :math:`minor` 的椭圆坐标。轴长单位默认为 km，长轴方位角 :math:`azimuth` 的单位为度。
    此功能需与 :option:`-C` 和 :option:`-G` 结合使用。

    **注意**：对于笛卡尔椭圆（使用 :option:`-N` ），则应该给出相对于水平方向逆时针旋转的 :math:`direction` （方向），而非 :math:`azimuth` （方位角）。
    地理椭圆的 :math:`major` 长轴可以通过附加单位后缀来指定所需的单位 [默认为 km]。短轴 :math:`minor` 和 :option:`-G` 的 *dist* 也使用相同的单位。
    对于退化为正圆的椭圆，可以仅提供单个 :math:`diameter` （直径）。

    附加 **+e** 调整 :option:`-G` 设置的增量 *dist* ，使椭圆具有相等的距离增量 [默认使用给定的增量并闭合椭圆]。

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

示例
----

把数据文件ship_03.txt（格式为lon,lat,depth）投影到由两点（330,-18）、（53,21）定义的大圆路径上，并进行排序，只输出距离 *p* 和深度。 *p* 的单位是千米::

    gmt project ship_03.txt -C330/-18 -T53/21 -S -Fpz -Q > ship_proj.txt

指定测线的起点和终点，在测线上每隔10千米生成一个点。距离测线起点的距离单位为千米::

    gmt project -C-50/10 -E-10/30 -G10 -Q > great_circle_points.xyp

指定测线的起点和终点，沿着colatitude=60的小圆上，每隔10千米生成一个点::

    gmt project -C-50/10 -E-10/30 -G10/60 -Q > small_circle_points.xyp

利用 :option:`-F` 选项指定输出坐标 *r*, *s* 来得到某点在某测线上的投影点::

    echo 102 30 | gmt project -C103/31 -A225 -L0/500 -Frs -Q

已知某点，根据方位角和大圆距离计算另一点。已知一点(120, 25)，根据方位角 45 度，大圆距离 123 千米的点位置 ::

    gmt project -C120/25 -A45 -L0/123 -G123 -Q | tail -1

根据地震目录数据，将地震事件投影到深度剖面并绘制：

.. gmtplot:: project/project_ex.sh
   :show-code: true
   :width: 80%

相关模块
--------

:doc:`fitcircle`,
:doc:`vector`,
:doc:`grdtrack`,
:doc:`mapproject`,
:doc:`grdproject`