.. index:: ! grdview

*******
grdview
*******

:官方文档: :doc:`gmt:grdview`
:简介: 利用网格文件绘制3D视角图或表面网格图

语法
--------

.. include:: common_SYN_OPTs.rst_

**gmt grdview** *reliefgrid* |-J|\ *parameters*
[ |SYN_OPT-B| ]
[ |-C|\ [*cpt*]]
[ |-G|\ *drapegrid* \| |-G|\ *grd_r* |-G|\ *grd_g* |-G|\ *grd_b* ]
[ |-I|\ [*intensgrid*\|\ *intensity*\|\ *modifiers*] ]
[ |-Jz|\ \|\ **Z**\ *parameters* ]
[ |-N|\ *level*\ [**+g**\ *fill*] ]
[ |-Q|\ *args*\ [**+m**] ]
[ |SYN_OPT-Rz| ]
[ |-S|\ *smooth* ]
[ |-T|\ [**+o**\ [*pen*]][**+s**] ]
[ |SYN_OPT-U| ]
[ |-W|\ **c|m|f**\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

描述
-----------

**grdview** 读取一个二维grid网格文件，绘制出三维视角图。可以实现的效果有：
根据数据大小对表面进行拉伸，形成起伏效果、在表面绘制等值线、三维表面贴图、应用光照效果等等。

必选选项
------------------

*reliefgrid*
    二维grid网格文件文件名。

.. include:: explain_-J.rst_

.. _-Jz:

**-Jz**\|\ **Z**\ *parameters*
    设置Z轴的缩放比例，设置方式与 -Jx|X 相同。若忽略此选项将生成平面图。
    
可选选项
------------------

.. include:: explain_-B.rst_

.. include:: use_cpt_grd.rst_

.. include:: explain_intense.rst_

.. _-N:

**-N**\ *level*\ [**+g**\ *fill*]
    在 *z=level* 位置处绘制一个平面， **+g** 设置平面和数据曲面之间截面的填充色。

.. _-G:

|-G|\ *drapegrid* \| |-G|\ *grd_r* |-G|\ *grd_g* |-G|\ *grd_b*
    在三维表面上贴图。该贴图可以是一个彩色图片，也可以是三个单波段文件，分别代表R、G、B的强度值，每个文件像素值范围是0-255。

.. _-Q:

**-Q**\ *args*\ [**+m**]
    #. **-Qm** 表示生成网格线图（mesh，默认）。也可以用 **-Qm**\ *color* 的形式生成不同底色的网格线。
    #. **-Qmx** 或 **-Qmy** 生成仅有x或y方向线条的瀑布图（waterfall）。同样可以指定底色。
    #. **-Qs** 生成表面图（surface），颜色由 |-C| 选项指定。**-Qsm** 则在表面图上叠加格网线。
    #. **-Qi** 生成图像（image），与 |-G| 选项一同使用绘制三维贴图。后面可加dpi参数（默认dpi=100）。
    #. **-Qc** 与 **-Qi** 类似，不同的是 **-Qc** 将 Z=NaN 的节点透明化。
    
    **+m** 表示强制转化为灰度图像，适用于 **-Qs**。

.. include:: explain_-R.rst_

.. include:: explain_-Rz.rst_

.. _-W:

**-W**\ **c**\|\ **m**\|\ **f**\ *pen*

    **-Wc**
        在顶部绘制等值线， *pen* 设置等值线的线型。 [默认: width = 0.75p, color =
        black, style = solid]。
    **-Wm**
        设置mesh网格的线型。 [默认: width = 0.25p, color = black, style = solid]。
        只有使用了 **-Qm** 或 **-Qsm** 才会绘制mesh网格线。
    **-Wf**
        如果设置了 |-N| 绘制平面，该选项设置平面和数据曲面之间截面的轮廓的线型。 
        [默认: width = 0.25p, color = black, style = solid]。
        
.. include:: explain_perspective.rst_

.. include:: macos_preview_issue.rst_

示例
--------

将数据文件 hawaii_grav.nc 绘制成mesh网格，并根据CPT文件 hawaii.cpt 绘制等值线。
并以西南方向、高度30度的视角观察图像。

   ::

    gmt grdview hawaii_grav.nc -Jl18/24/1.5c -Chawaii.cpt -Jz0.05c -Qm -N-100 -p225/30 -Wc

将数据文件 image.nc 绘制为起伏表面，使用CPT文件 color.cpt，并利用 intens.nc 加光照。

   ::

    gmt grdview image.nc -Jx10c -Ccolor.cpt -Qs -p135/30 -Iintens.nc

To make the same plot using the rastering option with dpi = 50, use

   ::

    gmt grdview image.nc -Jx10c -Ccolor.cpt -Qi50 -p135/30 -Iintens.nc
