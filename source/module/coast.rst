.. index:: ! coast
.. include:: common_SYN_OPTs.rst_

coast
=====

:官方文档: :doc:`gmt:coast`
:简介: 在地图上绘制海岸线、河流、国界线

**coast** 模块利用 GMT 自带的 :doc:`GSHHG数据</dataset/gshhg>` 和
:doc:`DCW数据 </dataset/dcw/index>` 绘制海岸线、河流、政治边界，
还可以裁剪陆地区域或水域，也可以将数据导出到文件中。

语法
----

**gmt coast** |-J|\ *parameters*
|SYN_OPT-R|
[ |SYN_OPT-Area| ]
[ |SYN_OPT-B| ]
[ |-C|\ *fill*\ [**+l**\|\ **+r**] ]
[ |-D|\ *resolution*\ [**+f**] ]
[ |-E|\ *dcw* ]
[ |-F|\ *box* ]
[ |-G|\ [*fill*] ]
[ |-I|\ *river*\ [/\ *pen*] ]
[ |-J|\ **z**\|\ **Z**\ *parameters* ]
[ |-L|\ *scalebar* ]
[ |-M| ]
[ |-N|\ *border*\ [/*pen*] ]
[ |-Q| ]
[ |-S|\ [*fill*] ]
[ |-T|\ *rose* ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*level*/]\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. include:: explain_-Rz.rst_

可选选项
--------

.. include:: explain_-A.rst_

.. include:: explain_-B.rst_

.. _-C:

**-C**\ *fill*\ [**+l**\|\ **+r**]
    设置湖泊与河流湖的颜色。

    默认情况下，湖泊与河流湖会被当做wet区域，直接使用 **-S** 指定的填充值。
    使用 **+l** 或 **+r** 可以为湖泊或河流湖单独指定颜色。

.. _-D:

**-D**\ *resolution*\ [**+f**]
    选择海岸线数据精度。

    GMT自带的GSHHG海岸线数据有5个不同精度的版本，从高到低依次为：full、high、
    intermediate、low和crude。GMT默认使用低精度数据。该选项可以指定要使用的
    数据精度，其中 **f**\|\ **h**\|\ **i**\|\ **l**\|\ **c**
    分别代表5种不同的数据精度。也可以用 **-Da** 选项，此时GMT会根据当前绘图区域的
    大小自动选择合适的数据精度 [默认使用 **-Da**]

    默认情况下，若找不到指定精度的海岸线数据，程序会自动报错退出。该选项中
    加上 **+f** 则命令在找不到当前指定的精度数据时，自动寻找更低精度的数据。

.. _-E:

**-E**\ *code1,code2,...*\ [**+l**\|\ **L**][**+g**\ *fill*][**+p**\ *pen*][**+z**]
    利用DCW数据绘制或导出行政区划边界（洲界、国界、省界）

    GMT自带了DCW（Digital Chart of World）数据，即全球的行政区划数据。
    其包含了全球各国国界和省界数据。该数据独立于GSHHG数据，因而 **-A** 和 **-D**
    选项对该数据无效。关于DCW数据及其用法的详细介绍见 :doc:`/dataset/dcw/index`。

    通过指定一个或多个以逗号分隔的区域代码 *code* 即可指定一个或多个行政区域。
    *code* 可以取如下几种形式：

    - 洲代码前加上 **=** 则绘制整个洲内所有国家边界。
      比如 **=AS** 会绘制所有亚洲国家的边界
    - 直接使用国界代码，则绘制国界边界。比如 **US** 绘制美国边界
    - 使用 *国家代码*.*州代码* 则绘制州（省）边界。比如 **US.TX** 绘制
      美国Texas州的边界

    可以使用如下子选项列出可使用的 *code*:

    - **+l** 仅列出所有国家及其对应代码，不绘制边界也不提取数据
    - **+L** 列出部分国界的省及其代码
    - **+z** 表示将地区代码以 **-Z**\ *code* 的形式写到数据的段头记录中

    通过加上子选项，可以进一步设置指定区域的边界属性或填充属性：

    - **+p**\ *pen* 表示绘制多边形轮廓 [默认无轮廓]
    - **+g**\ *fill* 表示设置多边形的填充色 [默认无填充色]

    若想要不同的区域有不同的画笔或填充属性，则需要多次使用 **-E** 选项，每次
    指定不同的区域以及不同的画笔或填充属性。

    若使用了 **-E** 但不指定 **-J** 和 **-M** 则会以 **-R**\ *w/e/s/n* 的
    形式输出对应行政区域的区域范围。

.. _-F:

**-F**\ [**l**\|\ **t**][**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]]
    控制比例尺和玫瑰图的背景边框

    若只使用 **-F** 而不使用其它子选项，则会在比例尺或方向玫瑰的周围绘制矩形边框。
    下面简单介绍各子选项，详细用法见 :doc:`/basis/embellishment`

    .. include:: explain_-F_box.rst_

    该选项默认会同时控制比例尺和方向玫瑰的背景边框。
    加上 **l**\|\ **t** 则表示只控制 **-L**\ 或 **-T** 选项绘制的特征。

.. _-G:

**-G**\ [*fill*]
    设置dry区域的填充色或裁剪dry区域

    **-G**\ *fill* 设置dry区域（一般指陆地）的填充色。
    若不指定 *fill* 则会将dry区域裁剪出来，使得接下来的绘图只有dry区域内的才会被绘制。

.. _-I:

**-I**\ *river*\ [/*pen*]
    绘制河流。

    河流 *river* 可以取：

    - 0 = Double-lined rivers (river-lakes)
    - 1 = Permanent major rivers
    - 2 = Additional major rivers
    - 3 = Additional rivers
    - 4 = Minor rivers
    - 5 = Intermittent rivers - major
    - 6 = Intermittent rivers - additional
    - 7 = Intermittent rivers - minor
    - 8 = Major canals
    - 9 = Minor canals
    - 10 = Irrigation canals
    - a = All rivers and canals (0-10)
    - A = All rivers and canals except river-lakes (1-10)
    - r = All permanent rivers (0-4)
    - R = All permanent rivers except river-lakes (1-4)
    - i = All intermittent rivers (5-7)
    - c = All canals (8-10)

    *pen* 的默认值为 **default,black,solid**，该选项可重复使用多次
    以分别指定不同等级河流的画笔属性。

.. include:: explain_-L_scale.rst_

.. _-M:

**-M**
    将边界数据以多段ASCII表或二进制表的形式导出到标准输出

    使用该选项，则只导出数据而不绘图。
    该选项需要与 **-E**, **-I**, **-N** 或 **-W** 选项一起使用。

.. _-N:

**-N**\ *border*\ [/*pen*]
    绘制政治边界。

    该选项在某些地方与 **-E** 选项有重叠。边界类型 *border* 可以取：

    - ``1`` ：国界
    - ``2`` ：州界；（目前只有美国、加拿大、澳大利亚以及南美各国的数据）
    - ``3`` ：Marine boundaries
    - ``a`` ：1-3的全部边界；

    *pen* 的默认属性为 **default,black,solid**。该选项可重复多次
    使用，以指定不同级别边界的不同画笔属性。

.. _-Q:

**-Q**
    关闭区域裁剪。

    使用 **-G** 和 **-S** 可以分别裁剪出dry区域和wet区域，接下来的其他绘图命令
    中只有在裁剪区域内的部分才会被绘制。在绘图结束后，需要关闭裁剪，就需要再次调用
    **coast**，并加上 **-Q** 选项。若在开启裁剪后使用了 **-X** 和 **-Y** 选项，
    则在关闭时也要记得使用 **-X** 和  **-Y**。

.. _-S:

**-S**\ [*fill*]
    设置wet区域的填充色或裁剪wet区域

    **-S**\ *fill* 设置wet区域（一般指海洋或湖泊）的填充色。
    若不指定 *fill* 则将wet区域裁剪出来，使得接下来的绘图只有wet区域内的才会被绘制。

.. include:: explain_-T_rose.rst_

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ [*level*/]\ *pen*
    绘制岸线（shoreline）

    shore指水与陆地交界的“岸”（如：海岸、湖岸、河岸等），是一个较为笼统的说法。

    GMT中岸线分成四个等级（*level* 取1-4）：

    #. coastline：海岸线
    #. lakeshore：湖泊与陆地的岸线
    #. island-in-lake shore：首先要有陆地，陆地中有个湖，湖里有个岛。即岛的岸线
    #. lake-in-island-in-lake shore：首先有陆地，陆地中有个湖，湖中有个岛，岛里
       又有个湖。这里指的是湖的岸线

    使用时需要注意：

    - 不使用 **-W** 选项，则不绘制任何shore
    - 使用 **-W** ，给定画笔属性 *pen*，但不给出 *level*，则绘制
      四个level的shore
    - 在同一个命令中可以多次使用 **-W**，以指定不同 *level* 的shore的画笔属性
    - **-W** 选项中 *level* 是可选的，而 *pen* 是必须的！因而 **-W2**
      会被解释为所有level的画笔属性，而不是level 2

.. include:: explain_-XY.rst_

.. include:: explain_-bo.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

示例
----

在入门教程 :doc:`/tutorial/coastline` 和 :doc:`/dataset/gshhg` 均提供了
一些 **coast** 的使用实例。

绘制非洲地图，并绘制河流、国界，以及设置不同的填充色::

    gmt coast -R-30/30/-40/40 -Jm0.1i -B5 -I1/1p,blue -N1/0.25p,- \
            -I2/0.25p,blue -W0.25p,white -Ggreen -Sblue -png africa

绘制Iceland地图，使用pattern #28做填充::

    gmt coast -RIS+r1 -Jm1c -B -Wthin -Gp28+r100 -pdf iceland

将非洲区域裁剪出来，并在其中的陆地部分绘制地形::

    gmt begin map png
        gmt coast -R-30/30/-40/40 -Jm0.1i -B -G
        gmt grdimage @earth_relief_05m
        gmt coast -Q
    gmt end show

绘制部分国家的国界线::

    gmt coast -JM6i -Baf -EGB,IT,FR+gblue+p0.25p,red -EES,PT,GR+gyellow -pdf map

提取冰岛的高精度海岸线数据::

    gmt coast -RIS -Dh -W -M > iceland.txt

FAQ
---

#. 错误消息::

       coast: low resolution shoreline data base not installed.

   出现该错误的原因有如下几种：

   #. 未安装GSHHG海岸线数据
   #. 安装了但路径不正确（建议的做法是把所有GSHHG的文件放在 ``$GMTHOME/share/coast`` 目录下）
   #. 安装的netCDF版本号为3.x而不是4.x
   #. 自行编译了netCDF 4.x，且编译时使用了 ``--disbale-netcdf4`` 选项

相关模块
--------

:doc:`grdlandmask`,
:doc:`basemap`
