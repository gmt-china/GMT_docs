.. index:: ! grdlandmask
.. include:: common_SYN_OPTs.rst_

grdlandmask
===========

:官方文档: :doc:`gmt:grdlandmask`
:简介: 根据海岸线数据创建陆地-海洋的mask网格文件

**grdlandmask** 模块读取指定的海岸线数据，用于确定网格内的每个节点是位于陆地还是
水域，并给不同类型的节点赋予不同的值，以生成掩膜文件。生成的掩膜文件可进一步
用在 :doc:`grdmath` 中以掩盖掉位于陆地或水域中的数据点。

语法
----

**gmt grdlandmask**
|-G|\ *mask_grd_file*
|SYN_OPT-I|
|SYN_OPT-R|
[ |SYN_OPT-Area| ]
[ |-D|\ *resolution*\ [**+f**] ]
[ |-E|\ [*bordervalues*] ]
[ |-N|\ *maskvalues* ]
[ |-V|\ [*level*] ] [ |SYN_OPT-r| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT--| ]

必选选项
--------

.. _-G:

**-G**\ *mask_grd_file*
    生成的掩膜网格文件的文件名

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. include:: explain_-A.rst_

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
    选项海岸线数据的精度，见 :doc:`coast` 中的介绍。

.. _-E:

**-E**\ [*bordervalues*]
    恰好落在海岸线多边形边界上的数据的处理方式。

    默认情况下，恰好位于海岸线多边形边界上的节点当作是在多边形的内部，使用该选项
    则会将其认为是在多边形的外部。

    此外，还可以在 **-E** 选项后加上四个值 *cborder/lborder/iborder/pborder* 或
    一个值 *bordervalue* （表示四个值具有相同的值），以启用线段追踪模式。
    在根据 **-N** 设置掩膜值之后，会进一步修改所有线段穿过的网格单元的值。
    例如，海岸线穿过的网格单元值将被修改为 *cborder*\ ；同理，
    岛边界、湖内岛、湖内岛中的小湖边界穿过的网格单元值会被依次修改为
    *lborder*\ 、\ *iborder*\ 、\ *pborder* 的值。

.. _-N:

**-N**\ *maskvalues*
    设置网格节点的值。可以是数字，也可以是NaN。该选项可以取两种格式：

    - **-N**\ *wet/dry* ：分别为水域和陆地设置不同的值
    - **-N**\ *ocean/land/lake/island/pond* ：分别为海洋、陆地、湖泊、岛屿、池塘设置不同的值

    默认值为 **0/1/0/1/0** （即 **0/1**\ ），即将水域内的网格设置为0，将陆地内的
    网格设置为1。

.. include:: explain_-V.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_core.rst_

.. include:: explain_help.rst_

注意事项
--------

**grdlandmask** 生成的掩膜网格文件属于 **分类型** 数据，即所有数据只能取几个固定的
值，比如 **-N0/1** 会将水域内的网格值设置为0，将陆地内的网格值设置为1。
在这种情况下，对这种数据用标准方法（比如样条）进行插值通常会得到无意义的结果，
使用时需要小心。

然而，当你直接绘制该掩膜网格文件时，网格数据会被重新投影使得在投影后的坐标下
变成一个矩形。这个过程中涉及到了网格插值，默认使用的插值算法是样条插值，因而
可能会在图中产生假象。因而建议在使用 :doc:`grdimage` 绘制此类数据时使用 **-nn**
选项即 nearest neighbor 插值算法以避免这一问题。

示例
----

将所有陆地上的节点设置为NaN，水域上的节点设置为1::

    gmt grdlandmask -R-60/-40/-40/-30 -Dh -I5m -N1/NaN -Gland_mask.nc -V

生成全球1x1度的网格，并将不同性质的区域设置成不同的值::

    gmt grdlandmask -R0/360/-90/90 -Dl -I1 -N0/1/2/3/4 -Glevels.nc -V

相关模块
--------

:doc:`grdmath`,
:doc:`grdclip`,
:doc:`mask`,
:doc:`clip`,
:doc:`coast`
