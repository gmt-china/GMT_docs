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
根据数据大小对表面进行拉伸，形成起伏效果、在表面绘制等值线、应用光照效果等等。

必选选项
------------------

*reliefgrid*
    二维grid网格文件文件名。

.. include:: explain_-J.rst_

可选选项
------------------

.. include:: explain_-B.rst_

.. _-C:

**-C**\ [*cpt* \| *master*\ [**+i**\ *zinc*] \| *color1,color2*\ [,\ *color3*\ ,...]]
    绘制网格文件所使用的CPT。

    也可以直接使用GMT自带的CPT文件名，此时GMT会自动根据网格文件的Z值范围将
    自带的CPT采样成16级的连续CPT文件。也可以通过 **-C**\ *color1*,\ *color2*\[,\ *color3*,..]
    的语法构建一个线性连续CPT文件。

.. _-I:

**-I**\ [*intensfile*\|\ *intensity*\|\ *modifiers*]
    增加光照效果

    可以通过三种方式设置光照效果:

    #. 给定一个Z值范围为(-1,1)的网格文件，该文件可以用 ``grdgradient`` 生成
    #. 给定一个常数作为光照强度
    #. 不指定光照强度文件，只使用 ``-I+`` 则会自动调用 ``grdgradient``
       并使用参数 ``-A-45 -Nt1`` 计算输入网格数据的梯度作为光照强度文件。用户
       可以使用 ``+a<azimuth>+n<args>`` 以自定义 grdgradient 的 -A 和 -N 选项

.. _-Jz:

**-Jz**\|\ **Z**\ *parameters*
    设置Z轴的尺度，设置方式与 ``-Jx|X`` 相同。

.. _-N:

**-N**\ *level*\ [**+g**\ *fill*]
    在 *z=level* 位置处绘制一个平面， **+g** 设置平面和数据曲面之间截面的填充色。

.. _-Q:

**-Q**\ *args*\ [**+m**]
    Select one of following settings. For any of these choices, you may force
    a monochrome image by appending the modifier **+m**. Colors are then
    converted to shades of gray using the (monochrome television) YIQ transformation

    #. Specify **m** for mesh plot [Default], and optionally append *color* for a different mesh paint [white].
    #. Specify **mx** or **my** for waterfall plots (row or column profiles). Specify color as for plain **m**
    #. Specify **s** for surface plot, and optionally append **m** to have mesh lines drawn on top of surface.
    #. Specify **i** for image plot, and optionally append the effective dpi resolution for the rasterization [100].
    #. Specify **c**. Same as **-Qi** but will make nodes with z = NaN transparent, using the colormasking
       feature in PostScript Level 3 (the PS device must support PS Level 3). .

    **Note**: If the CPT is categorical then only **-Qm** is available (but see **-T**).

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
        如果设置了 **-N** 绘制平面，该选项设置平面和数据曲面之间截面的轮廓的线型。 
        [默认: width = 0.25p, color = black, style = solid]。
        
.. include:: explain_perspective.rst_

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
