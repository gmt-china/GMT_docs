:author: 田冬冬, 朱邓达, 陈箫翰
:date: 2026-01-03

.. index:: ! grdview
.. program:: grdview

grdview
==========

:官方文档: :doc:`gmt:grdview`
:简介: 利用网格文件绘制3D视角图或表面网格图

**grdview** 读取一个二维网格文件，绘制出三维视角图。可以实现的效果有：
根据数据大小对表面进行拉伸，形成起伏效果、在表面绘制等值线、三维表面贴图、应用光照效果等等。

语法
--------

**gmt grdview** 
*reliefgrid* 
:option:`-J`\ *parameters*
:option:`-Jz|Z`\ *parameters*
:option:`-R`\ *west*/*east*/*south*/*north*\ [/*zmin*/*zmax*][**+r**][**+u**\ *unit*]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ [*cpt*]]
[ :option:`-G`\ *drapegrid*\|\ *drapeimage* ]
[ :option:`-I`\ [*file*\|\ *intens*\|\ **+a**\ *azimuth*][**+d**][**+m**\ *ambient*][**+n**\ *args*] ]
[ :option:`-N`\ *level*\ [**+g**\ *fill*] ]
[ :option:`-Q`\ **c**\|\ **i**\|\ **m**\ [**x**\|\ **y**]\|\ **s**\ [**m**]\|\ **g**\ [**m**]\ [*color*][**+m**] ]
[ :option:`-S`\ *smooth* ]
[ :option:`-T`\ [**+o**\ [*pen*]][**+s**] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ **c|m|f**\ *pen* ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-f`\ *flags* ]
[ :option:`-n`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

*reliefgrid*
    二维网格文件文件名。

必须选项
------------------

.. include:: explain_-J.rst_

.. include:: explain_-Jz.rst_

.. include:: explain_-Rz.rst_
..

    此选项用于指示用于三维轴的范围。
    
可选选项
------------------

.. include:: explain_-B.rst_

.. include:: use_cpt_grd.rst_

.. option:: -G

:option:`-G`\ *drapegrid*\|\ *drapeimage*
    将 *drapegrid* 中的表面覆盖在 *reliefgrid* 提供的地形之上。
    *drapegrid* 提供与颜色相关的信息，如果它是一个网格文件，将通过 :option:`-C` 确定颜色。
    此外也可以提供一个图片文件 *drapeimage* 覆盖在表面上，在这种情况下，不需要使用 :option:`-C` 选项。

    请注意， :option:`-Jz|Z` 和 :option:`-N` 与本选项参数涉及的文件无关。

.. include:: explain_intense.rst_

.. option:: -N

**-N**\ *level*\ [**+g**\ *fill*]
    在 *z=level* 位置处绘制一个平面， **+g** 设置平面和数据曲面之间截面的填充色 *fill*。
    :option:`-W`\ **f** 设置轮廓画笔属性。如果未设置 *level*，则默认使用 *reliefgrid* 中的最小值。
    但是如果 :option:`-R` 选项设置了 *zmin/zmax* ，且该值小于网格最小值，则使用该值。

.. option:: -Q

**-Q**\ **c**\ \|\ **g**\ [**m**]\ [**a**]\ \|\ **i**\ \|\ **m**\ [**x**\ \|\ **y**]\ \|\ **s**\ [**m**]\ [*color*]\ [**+m**]
    #. **-Qm** 表示生成网格线图（mesh，默认）。也可以用 **-Qm**\ *color* 的形式生成不同底色的网格线 [默认为白色]。
    #. **-Qmx** 或 **-Qmy** 生成仅有x或y方向线条的瀑布图（waterfall）。颜色指定方式与普通 **-Qm** 相同。
    #. **-Qs** 生成表面图（surface），颜色由 :option:`-C` 选项指定。 **-Qsm** 则在表面图上叠加格网线，网格线画笔属性使用 :option:`-W`\ **m** 设置。
    #. **-Qi** 生成图像（image），与 :option:`-G` 选项一同使用绘制三维贴图。后面可加参数：有效每单位点数分辨率（dots-per-unit） [默认值为 :term:`GMT_GRAPHICS_DPU`]。
    #. **-Qc** 与 **-Qi** 类似，不同的是 **-Qc** 将 *z* = NaN 的节点透明化。
    #. **-Qg** 绘制 Gouraud 着色表面，具有基于顶点的平滑颜色渐变。附加 **m** 在表面顶部绘制网格线。在将切片分割为三角形时，附加 **a** 使用交替的对角线。
       Gouraud 着色比 **-Qs** 产生的颜色过渡更平滑，且生成的 PostScript 文件明显更小、处理更快。
       不过，当等值线水平处需要精确的颜色过渡时（即制作 `contourf` 类型的图形，参见 **-Wc**），仍应使用 **-Qs** 选项，因为 Gouraud 着色不像 **-Qs** 那样会沿等值线切割切片。
    
    **+m** 表示使用（单色电视）YIQ 变换将颜色转换为灰度。

    **注意**：如果 CPT 是分类（categorical）类型的，则仅 **-Qm** 可用（参见 :option:`-T`）。

.. option:: -S

**-S**\ *smooth*
    在绘图前对等值线进行平滑处理（参见 :doc:`grdcontour`）[默认不进行平滑]。

.. option:: -T

**-T**\ [**+o**\ [*pen*]][**+s**]
    绘图时不进行任何插值。这涉及将每个以节点为中心的像元转换为多边形，然后分别进行着色。此选项适用于分类数据，因为此类数据插值是无意义的。
    附加 **+s** 跳过 z = NaN 的节点。附加 **+o** 绘制切片轮廓，可以指定自定义画笔属性 *pen*。
    由于此选项生成的是平面，因此不能与 :option:`-Jz|Z` 一起使用。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ **c**\|\ **m**\|\ **f**\ *pen*

    **-Wc**
        在顶部绘制等值线， *pen* 设置等值线的线型。 [默认: width = 0.75p, color =
        black, style = solid]。
    **-Wm**
        设置mesh网格的线型。 [默认: width = 0.25p, color = black, style = solid]。
        只有使用了 **-Qm** 或 **-Qsm** 才会绘制mesh网格线。
    **-Wf**
        如果设置了 :option:`-N` 绘制平面，该选项设置平面和数据曲面之间截面的轮廓的线型。 
        [默认: width = 0.25p, color = black, style = solid]。
        
.. include:: explain_-XY.rst_

.. include:: explain_-f.rst_

.. include:: explain_-n.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_grdresample.rst_

示例
--------

利用 hawaii_grav.nc 文件制作网格图（mesh plot），并在兰勃特地图（标准纬线为 18 和 24，比例尺 1.5 cm/度）上绘制 CPT 文件 hawaii.cpt 中给出的等值线，
设置垂直比例尺为 20 mgal/cm，并从西南方向、仰角 30 度观察该表面::

    gmt grdview hawaii_grav.nc -Jl202/21/18/24/1.5c -Chawaii.cpt -Jz0.05c -Qm -N-100 -p225/30 -Wc -pdf hawaii_grav_image

使用网格数据集 image.nc 创建带光照的彩色透视图，使用 CPT color.cpt，线性比例尺为 10 cm/单位长度，每 5 个单位绘制刻度，
光照强度由 intens.nc 文件提供，并从东南方向观察::

    gmt grdview image.nc -Jx10c -Ccolor.cpt -Qs -p135/30 -Iintens.nc -pdf image3D

使用栅格化选项（分辨率为 50 dots/cm）制作相同的图形::

    gmt grdview image.nc -Jx10c -Ccolor.cpt -Qi50c -p135/30 -Iintens.nc -pdf image3D

使用网格数据集 magnetics.nc 创建彩色透视图，使用 CPT mag_intens.cpt，将其覆盖在 topography.nc 文件提供的地形之上，
墨卡托投影地图宽度为 6 英寸，每 1 度绘制刻度，光照强度由 topo_intens.nc 提供，并从东南方向观察::

    gmt grdview topography.nc -JM6i -Gmagnetics.nc -Cmag_intens.cpt -Qs -p140/30 -Itopo_intens.nc -pdf draped3D

注意事项
---------------

对于 **-Qs** 选项：PostScript 语言没有在多边形内部平滑改变颜色的机制，因此颜色只能在多边形之间变化。
为了通过这种方式获得平滑的图像，可以使用 :doc:`grdsample` 对网格文件进行重采样，
或者在运行 :doc:`surface` 或 :doc:`nearneighbor` 等网格化程序时使用更细的网格间距。但这会产生巨大的 PostScript 文件。
另一种方法是使用 **-Qi** 选项，它通过扫描线转换（scanline conversion）对多边形进行成像，从而在多边形内部计算双线性或双三次连续颜色变化。

.. include:: macos_preview_issue.rst_

相关模块
---------------

:doc:`grdcontour`,
:doc:`grdimage`,
:doc:`grdsample`,
:doc:`nearneighbor`,
:doc:`basemap`,
:doc:`contour`,
:doc:`text`,
:doc:`surface`