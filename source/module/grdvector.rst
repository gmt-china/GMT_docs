:author: 朱邓达, 田冬冬
:date: 2026-01-03

.. index:: ! grdvector
.. program:: grdvector

grdvector
=========

:官方文档: :doc:`gmt:grdvector`
:简介: 根据两个网格文件绘制矢量场

该命令会读取两个 2D 网格文件并绘制矢量场。两个网格文件分别代表 :math:`(x,y)` 平面内矢量场的
X 分量和 Y 分量，最终矢量场用不同长度和方向的箭头表示。两个网格文件，也可以分别
是极坐标下 :math:`(r,\theta)` 的分量 （见 :option:`-A` 和 :option:`-Z` ）。

语法
--------

**gmt grdvector**
*grid1* *grid2*
:option:`-J`\ *parameters*
[ :option:`-A` ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ [*section*/]\ *master*\|\ *cpt*\|\ *color*\ :math:`_1`,\ *color*\ :math:`_2`\ [,\ *color*\ :math:`_3`\ ,...]\ [**+h**\ [*hinge*]][**+i**\ *dz*][**+u**\|\ **U**\ *unit*][**+s**\ *fname*] ]
[ :option:`-G`\ *fill* ]
[ :option:`-I`\ [**x**]\ *dx*\ [/*dy*] ]
[ :option:`-N` ]
[ :option:`-Q`\ *parameters* ]
[ :option:`-R`\ *region* ]
[ :option:`-S`\ [**i**\|\ **l**]\ *scale*\ [**+c**\ [[*slon*/]\ *slat*]][**+s**\ *refsize*] ]
[ :option:`-T` ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *pen*\ [**+c**] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-Z` ]
[ :option:`-f`\ *flags* ]
[ :option:`-l`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

*grid1*
    矢量场的 X 分量网格文件

*grid2*
    矢量场的 Y 分量网格文件

两个网格文件顺序很重要，对于 :math:`(x,y)` ，两个文件分别为 X 分量和 Y 分量。
对于 :math:`(r,\theta)` ，两个文件分别为大小 :math:`r` 和 角度 :math:`\theta` ，
其中角度可以是方向角（ :option:`-A` ， 从东向逆时针测量）或方位角（ :option:`-Z` ， 从北向顺时针测量）。

必须选项
--------

.. include:: explain_-J.rst_

可选选项
--------

.. option:: -A

**-A**
    输入数据为极坐标表示。即网格文件包含的是 :math:`(r,\theta)` 分量而不是 :math:`(x,y)` 分量。
    如果 :math:`\theta` 表示方位角，请查阅 :option:`-Z`。

.. include:: explain_-B.rst_

.. include:: use_cpt_grd.rst_

.. option:: -G

**-G**\ *fill*
    设置矢量头填充色 *fill* （默认不填充）。 *fill* 也可通过 :option:`-Q` 指定。

.. option:: -I

**-I**\ [**x**]\ *dx*\ [/*dy*]
    每隔 *dx* 和 *dy* 绘制一个矢量。其中 *dx* 和 *dy* 必须是
    原始网格间隔的整数倍， *dx* 和 *dy* 后加上 **m** 表示分，加上 **s** 表示秒。
    也可以使用 **-Ix**\ *multx*\ [/*multy*] ，此时 *multx* 和 *multy* 表示倍数。
    默认绘制每个节点上的矢量。

.. option:: -N

**-N**
    不裁剪地图边界外的矢量（默认裁剪）。

.. option:: -Q

**-Q**\ *parameters*
    修改矢量的属性，使用 :option:`-Q`\ *size* 指定矢量头的大小 *size* （默认为 0 ，即仅绘制线条）。
    更多矢量属性控制详见 :doc:`/basis/vector` 一节。

.. include:: explain_-R.rst_

.. option:: -S

**-S**\ [**i**\|\ **l**]\ *scale*\ [**+c**\ [[*slon*/]\ *slat*]][**+s**\ *refsize*]
    设置矢量长度的缩放比例 *scale* 。

    对于笛卡尔数据而言，缩放比例 *scale* 即单位绘图距离所对应的实际数据的多少。
    可以加上 **c|i|p** 以指定绘图单位，若不指定则使用 :term:`PROJ_LENGTH_UNIT` 。
    通过绘图单位缩放转换的矢量长度将绘制为直线笛卡尔矢量，其长度不受地图投影和坐标位置的影响。
    例如 **-S5c** 表示大小为 5 的矢量在图上为 1 cm。

    对于地理数据而言，缩放比例 *scale* 表示单位地理距离（见 `距离单位`_ ）所对应的实际数据的多少。
    矢量大小（即实际数据）被缩放到给定距离单位中的地理距离，最后投影到地球上以给出绘图距离。
    这些是沿着大圆路径的地理矢量，它们的长度可能受到地图投影及坐标的影响。
    例如 **-S10k** 表示大小为 10 的矢量在地图为 1 km。

    - **-Si**\ *scale* - 缩放比例 *scale* 表示单位实际数据所对应的绘图距离或地理距离。

    - **-Sl**\ *length* - 所有矢量拥有固定的绘图长度 *length*。

    更详细的解释见 `矢量缩放与单位的影响`_ 。

    使用 :option:`-V` 可以报告所有绘制矢量的最小值、最大值和平均值，以及所有绘制矢量的绘制长度。
    如果使用 :option:`-l` 自动生成图例，则需要以下一到两个子选项：

    - **+c**\ [[*slon*/]\ *slat*] - 控制地图上地理矢量的参考长度。笛卡尔矢量不可用该选项。
      参考长度选择在纬度 *slat* 位置，也可指定经度 *slon* 作倾斜投影（默认为中央经线）。
      如果使用 **+c** 但无参数，则选择地图中点的矢量长度作为参考长度。

    - **+s**\ *refsize* - 使用实际数据作为矢量的参考大小。例如，选择板块运动速率 25 mm/yr
      作为参考，使用 **+s25** ，对应 :option:`-l` 指定 :option:`-l`\ "Velocity (25 mm/yr)"。
      如果不指定 *refsize* ，则默认为上述的 *scale* 参数。

.. option:: -T

**-T**
    该选项意味着笛卡尔数据的方位角会根据 X 和 Y 方向符号而改变（默认不改变）。
    这个选项对于坐标反向时很有用，例如 **-JX5c/-2.5c** ，Y 轴向下为正，
    只有使用 :option:`-T` 才能正确处理矢量的方位角，见下方示例。

    .. gmtplot::
        :show-code: false
        :width: 500 px
        :caption: 在正向和反向的 X, Y 方向下，使用 :option:`-T` （蓝线）和不使用 :option:`-T` （红线）的结果。

        # 脚本参考自官方源码 test/grdvector/cartvec.sh，改编为现代模式
        gmt xyz2grd -R-1/1/-2/2 -I1 -Gr.nc << EOF
        0	0	1
        0	-1	0.5
        EOF
        gmt xyz2grd -R-1/1/-2/2 -I1 -Gaz.nc << EOF
        0	0	60
        0	-1	-100
        EOF
        gmt begin grdvector-T png
        gmt subplot begin 2x2 -Fs2.5i/2.5i -M0.3i -Bafg -BWSne -A+JTC+o0/0.1i -Rr.nc
            gmt subplot set 0 -A"(a) ORIG"
            gmt basemap -JX? -Bx+l"X" -By+l"Y"
            gmt grdvector r.nc az.nc -A -Q0.3i+e  -W3p,red -Gred -Si1i
            gmt grdvector r.nc az.nc -A -Q0.1i+ec -W1p,blue -Gblue -Si1i -T
            gmt subplot set 1 -A"(b) NEG X"
            gmt basemap -JX-2.5i/2.5i -Bx+l"\035X" -By+l"Y"
            gmt grdvector r.nc az.nc -A -Q0.3i+e  -W3p,red -Gred -Si1i
            gmt grdvector r.nc az.nc -A -Q0.1i+ec -W1p,blue -Gblue -Si1i -T
            gmt subplot set 2 -A"(c) NEG Y"
            gmt basemap -JX2.5i/-2.5i -Bx+l"X" -By+l"\035Y"
            gmt grdvector r.nc az.nc -A -Q0.3i+e  -W3p,red -Gred -Si1i
            gmt grdvector r.nc az.nc -A -Q0.1i+ec -W1p,blue -Gblue -Si1i -T
            gmt subplot set 3 -A"(d) NEG X,Y"
            gmt basemap -JX-2.5i/-2.5i -Bx+l"\035X" -By+l"\035Y"
            gmt grdvector r.nc az.nc -A -Q0.3i+e  -W3p,red -Gred -Si1i
            gmt grdvector r.nc az.nc -A -Q0.1i+ec -W1p,blue -Gblue -Si1i -T
        gmt subplot end
        gmt end show

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *pen*\ [**+c**\]
    设置矢量轮廓的画笔属性。如果加上 **+c** ，则矢量头颜色和线条由 CPT 指定 （见 :option:`-C` ）。

.. include:: explain_-XY.rst_

.. option:: -Z

**-Z**
    输入的 :math:`\theta` 分量数据表示方位角（正北开始顺时针旋转的角度）而不是方向角（正东开始逆时针旋转的角度），
    使用本选项会自动使用 :option:`-A`。

.. include:: explain_-f.rst_

.. include:: explain_-l.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

.. include:: explain_example.rst_

对矢量长度进行缩放，使得图上1英寸代表实际的10个数据单位::

    gmt grdvector r.nc theta.nc -Jx5c -A -Q0.1i+e+jc -S10i -pdf gradient

绘制地理数据，缩放比例为每个数据单位对应200 km，每隔3个网格点绘制一个矢量::

    gmt grdvector comp_x.nc comp_y.nc -Ix3 -JH0/20c -Q0.1i+e+jc -S200 -pdf globe

矢量缩放与单位的影响
--------------------

使用 :option:`-S` 指定矢量缩放需要仔细思考，因为看起来可能有些反直觉。如 :option:`-S` 中所解释的，
其指定的是每个绘图单位或地理距离单位所对应的实际数据多少。
所选择的绘图或距离单位将影响所选择的矢量类型。通常，程序会首先计算每个节点上矢量的大小
:math:`r` （极坐标数据直接提取）。矢量大小可以是任何单位，
这里假设我们的网格记录地球水平磁场的长期变化，单位为 nTesla/year，
在某特定节点上，其值为 28 nTesla/year（在某个方向上）。
如果你指定缩放因子 *scale* 的单位为绘图单位 **c|i|p** 则表明你选择了 **笛卡尔矢量** 。
我们进一步假设你设置了 :option:`-S`\ *10c* ，这表明你希望 10 nTesla/year
的数据对应绘制 1 cm 长度。在程序内部，模块会将该缩放因子转为绘图比例
1/10 = 0.1 每 nTesla/year。对于大小为 28 nTesla/year 的矢量，模块会将其乘以绘图比例，
最终得到图上 2.8 cm 长的矢量。最终不会加入实际数据单位。
如果我们希望在图例中绘制一条 10 nTesla/year 的参考矢量，则其绘制长度 10 x 0.1 = 1 cm ，
因为笛卡尔矢量缩放后的长度是恒定的，不依赖于投影和矢量位置，
即 10 nTesla/year 的矢量在图上各处均为 1 cm。

让我们将这种效果与使用地理距离单位的情况进行对比，假设使用 :option:`-S`\ *0.5k*
（0.5 nTesla/year 每千米），这表明你选择了 **地理矢量** 。
在程序内部，模块会将该缩放因子转为地图比例 2 km 每 nTesta/year。
对于大小为 28 nTesla/year 的矢量，其在地图上的长度为 28 x 2 km = 56 km。
同样，最终不会加入实际数据单位。现在，需要将这 56 km 长的矢量投影到地球上，
而由于地图投影产生的扭曲，56 km 长的矢量长度在绘图上将是地图投影、地图比例和矢量位置的函数。
例如在墨卡托地图上，赤道正东 56 公里的矢量基本等于 0.5 度经度，
但在北纬 60 度，它更像是 1 度经度。
这种影响的结果是，当用户想要在图例中添加 10 nTesla/year 的参考向量时，
就会面临该问题：绘制的长度通常取决于纬度，因此参考比例尺只在对应纬度附近有用。

也可以使用相反的设置， **-Si**\ *scale* 。当提供 *scale* 倒数更方便时，这个变式很有用。
对于笛卡尔矢量，我们可替换为 **-Si**\ *0.1c* 表明想绘制 0.1 cm 每 nTesta/year。
同样的，对于地理矢量，我们也可替换为 **-Si**\ *2k* 表明想绘制 2 km 每 nTesta/year。
随着 **-Si** 的参数变大，绘制的矢量也变长，而随着 :option:`-S` 的参数变大，绘制的矢量变短。

注意
-----

请注意，使用 :option:`-I` 可能会导致混叠，除非网格在新的间隔上平滑变化。
通常最好对网格进行滤波，并以更大的网格间隔重新采样，再使用这些网格而不是原始网格。

相关模块
----------

:doc:`grdcontour`,
:doc:`plot`
