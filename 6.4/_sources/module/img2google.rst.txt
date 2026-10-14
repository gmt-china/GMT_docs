.. index:: ! img2google
.. include:: common_SYN_OPTs.rst_

img2google
==========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/img/img2google`
:简介: 由测深墨卡托 img 网格文件创建谷歌地球 KML 文件

**img2google** 是一个 shell 脚本。脚本读取 1x1 分的墨卡托 img 文件，
并为指定区域创建一个谷歌地球 KML 文件和相关的 PNG 切片。如果没有给定输入
文件，该模块自动使用 topo.18.1.img。

语法
----

**img2google**
|SYN_OPT-R|
[ *imgfile* ]
[ |-A|\ *mode*\ [*altitude*] ]
[ |-C| ]
[ |-F|\ *fademin/fademax* ]
[ |-G|\ *prefix* ]
[ |-L|\ *LODmin/LODmax* ]
[ |-N|\ *layername* ]
[ |-T|\ *doctitle* ]
[ |-U|\ *URL* ]
[ |SYN_OPT-V| ]
[ |-Z|\ [+] ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_-R.rst_

可选选项
--------

*imgfile*
    Img 格式的测深/地形文件，比如由 Sandwell 和 Smith 创建的海底地形文件。
    如果当前文件夹中不存在该文件并且用户已经设置了环境变量 **$GMT_DATADIR**，
    :doc:`gmt:supplements/img/img2grd` 将从 **$GMT_DATADIR** 中寻找 *imgfile*。

.. _-A:

**-A**\ *mode*\ [*altitude*]
    从谷歌地球可识别的 5 种高度模式中选择一种来确定生成的图像的高度（单位为 m）：
    **G** 为固定到地面，**g** 为相对地面一定高度，**a** 为绝对高度，**s** 为相对于海底
    的高度，**S** 为固定到海底[默认]。

.. _-C:

**-C**
    打开裁剪以在图像中只显示在海平面以下的部分。

.. _-F:

**-F**\ *fademin/fademax*
    设置几何体渐变从不透明到完全透明的距离。斜率值用屏幕像素表示，并分别应用于 LOD
    （可见度）限制的最小值和最大值。

.. _-G:

**-G**\ *prefix*
    设置输出的图像的前缀（扩展名为自动设置）。默认使用命名方式为
    topoN\|S\ *<north>*\ E\|W<*west*\ >。

.. _-L:

**-L**\ *LODmin/LODmax*
    以像素为单位设置细节 (LOD，可见度）的级别。
    以屏幕像素为单位的测量值，可以用来确定给定区域的最小可见范围，以设置细节的级别。
    当投影到屏幕上的时候，谷歌地球会计算给定区域的大小。然后计算区域面积的平方根
    （如果区域是正方形，视角在区域的正上方，并且区域没有倾斜，这个测量值就等于投影区域的宽度）。
    如果这个测量值在 *LODmin* 和 *LODmax* 定义的范围内（并且该区域处于视野中），
    则该区域处于激活状态。如果测量值不在上述范围内，相关的几何体就会被认为离用户的
    视角太远而不能被绘制。*LODmax* 表示一个给定的区域的可视范围的最大极限。
    默认值为 1，表示 "激活区域为无限大"。

.. _-N:

**-N**\ *layername*
    指定图层名（如果字符串中包含空格，使用双引号括起来）
    [默认为 topoN\|S<*north*>\ E\|W<*west*>]。

.. _-T:

**-T**\ *doctitle*
    指定文档标题（如果字符串中包含空格，使用双引号括起来）
    [默认为 "Predicted bathymetry"]。

.. _-U:

**-U**\ *URL*
    指定图像的远程 URL。默认图像和本地的 KML 文件对应。使用 **-U**
    可以设置图像的远程 URL。

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ [+]
    使用 zip（需预先安装）创建一个 \*.kmz 文件以方便分发；追加 **+**
    可以在压缩后删除对应的 KML 和 PNG 文件。

示例
----

使用 *topo.18.1.img*，在 **-R**\ 170/180/20/30 区域创建一个 10x10
度的谷歌地球 KML 切片，输出文件名为默认::

    img2google -R170/180/20/30

使用早期的墨卡托测深文件，例如 topo.15.1.img，在详细模式中生成相同的切片，
通过裁剪以仅显示海洋，将输出命名为 *oldimage*，直接设置 KML 文件元数据
（包括设置图像高度为 10km），并制作单个 \*.kmz 文件::

    img2google topo.15.1.img -R170/180/20/30 -Aa10000 -C -Goldimage \
    -N"My KML title" -T"My KML title" -Uhttp://my.server.com/images -V -Z

数据集
------

topo.18.1.img 和其他由 Sandwell/Smith 使用卫星测高数据构建的墨卡托格网，参见
https://topex.ucsd.edu

相关模块
--------

:doc:`gmt:supplements/img/img2grd`,
:doc:`psconvert`
