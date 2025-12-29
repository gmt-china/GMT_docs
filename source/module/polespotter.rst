:author: 何星辰
:date: 2025-10-20

.. index:: ! polespotter
.. program:: polespotter
.. include:: common_SYN_OPTs.rst_

polespotter
=============

:官方文档: :doc:`gmt:supplements/spotter/polespotter`  
:简介: 找到给定断裂带和深渊山脉的阶段极点

**polespotter** 读取线段（深海丘褶皱线和/或断裂带线）并执行三种类型的扫描之一。
在 spot 模式下，它为沿这些线的每个单独线段计算大圆。
断裂带的平分大圆与深海丘的延伸大圆预计在潜在的旋转极点处相交。
假设深海丘线相对于旋转极点为经线，而断裂带为纬线。
可以通过网格计算并返回线密度，大圆线可以通过标准输出返回，
而大圆的交点可以保存到文件中。在 line 模式下，
它将确定哪些线段与给定的试验极点相容，而在 pole 模式下，它将计算由网格定义的所有极点的卡方误差。

语法
--------

**gmt polespotter**
[ :option:`-A`\ *abyssalhills* ]
[ :option:`-D`\ *spacing* ]
[ :option:`-E`\ **a**\|\ **f**\ *sigma* ]
[ :option:`-F`\ *fracturezones* ]
[ :option:`-G`\ *outgrid* ]
[ :option:`-I`\ *increment* ]
[ :option:`-N` ]
[ :option:`-R`\ *region* ]
[ :option:`-S`\ **l**\|\ **p**\|\ **s**\ [*modifiers*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-r`\ *reg* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

可选选项
------------------

.. _-A:

**-A**\ *abyssalhills*
    含有多个深海丘线段的文件。这些线被认为反映了海底形成时指向旋转极点的大圆方向。

.. _-D:

**-D**\ *step*
    设置所有生成的大圆的线增量（单位：km）[默认 5]。实际间距将被调整为沿完整圆周的整数步数。

.. _-E:

**-E**
    为 **a**\ byssal hills 或 **f**\ racture zones 
    的方向提供不同的 1σ 角度不确定性（以度为单位）。
    使用 **-Ea**\ *sigma* 设置前者 [1]，使用 **-Ef**\ *sigma* 设置后者 [1]。
    这些 *sigma* 值随后用于形成权重 = 1/*sigma*。

.. _-F:

**-F**\ *fracturezones*
    含有多个断裂带线段的文件。这些线被认为反映了海底形成时围绕旋转极点的小圆。

.. include:: explain_grd_out.rst_

.. include:: explain_-I.rst_

.. _-N:

**-N**
    归一化网格，使最大值等于 1 [默认不归一化]。

.. |Add_-Rgeo| unicode:: 0x20 .. 仅为占位符
.. include:: explain_-Rgeo.rst_

.. _-S:

**-Sl**\|\ **p**\|\ **s**\ [*modifiers*]
    设置本次运行的扫描模式。从 **l**\ ines， **p**\ oles 或 **s**\ pots 中选择。
    根据模式不同，可能需要和可选参数如下所示：

**-Sl**\ *plon*\ /*plat*\ [**+m**]
    Line 模式表示我们接受一个 *plon*\ /*plat* 试验极点位置，
    并确定每个数据线段与小圆（针对断裂带）和经线（针对深海丘）的预测的相容性。
    默认情况下，我们报告每个线段的汇总统计数据（*chi2*、*table*、*segment*、*type*）。
    附加 **+m** 可改为报告沿所有多点线段的每个中点的误差信息
    （*mlon*、*mlat*、*del_angle*、*chi2*、*table*、*segment*、*type*）。
    信息写入标准输出。

**-Sp**
    Pole 模式表示我们搜索给定网格上的所有极点，并确定与所有给定线约束的加权卡方误差。
    此模式需要 :option:`-G`、:option:`-R`、:option:`-I` （可选 **-r** ）。

**-Ss**\ [**+c**\ *xfile*][**+l**]
    Spot 模式表示我们计算断裂带的平分线和沿深海丘的经线，并确定所有这些大圆的交点。
    可以附加两个修饰符：**+l** 将把生成的所有大圆输出到标准输出 [默认无输出]，
    **+c**\ *xfile* 将计算所有大圆的交点并将位置写入 *xfile*。
    此输出包含 5 列：*lon*、*lat*、*weight*、*cos*、*type*，
    其中 *weight* 是由两个生成线段组合得到的长度权重，*cos* 是相交线之间角度的余弦，
    *type* 分别为 0（AH 与 AH 相交）、1（AH 与 FZ 相交）、2（FZ 与 FZ 相交），
    其中 AH 表示深海丘大圆，FZ 表示断裂带平分大圆。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_geodetic.rst_

备注
--------

#. 每个输入线必须包含两个或多个点，每两个连续点定义一个大圆线段。
对于断裂带，这些点应被足够密集地数字化，以便两点间的大圆能近似小圆。
#. 所有线段具有相同的角度不确定性 [1，除非通过 :option:`-E` 改变]。
然而，单个线段可通过在段头中添加 **-D**\ *sigma* 参数（单位：度）来覆盖此权重。

示例
--------

要根据文件 *hills.txt* 和 *fractures.txt* 中的深海丘与断裂带结构（*lon, lat*）数据，
在北半球上以 1x1 度网格创建一个极点分布图，
沿大圆每 10 km 取样，并将大圆输出到标准输出，可尝试::

    gmt polespotter -Ahills.txt -Ffractures.txt -D10 -Gpoles.nc -R0/360/0/90 -I1 -V -Ss+l > lines.txt

然后可使用 :doc:`grdimage` 进行绘图。

相关模块
--------

:doc:`gmt`,
:doc:`grdimage`,
:doc:`grdrotater`,
:doc:`grdspotter`,
:doc:`project`,
:doc:`mapproject`,
:doc:`backtracker`,
:doc:`pmodeler`,
:doc:`vector`,
:doc:`grdpmodeler`,
:doc:`grdrotater`,
:doc:`originater`
