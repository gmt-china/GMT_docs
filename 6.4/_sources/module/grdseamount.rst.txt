.. index:: ! grdseamount
.. include:: common_SYN_OPTs.rst_

grdseamount
===========

:贡献者: |周茂|
:最近更新日期: 2022-06-21

----

:官方文档: :doc:`gmt:supplements/potential/grdseamount`
:简介: 创建合成海山（包括高斯、抛物线、多项式、圆锥、圆盘形状的圆形或椭圆型海山）

**grdseamount** 使用给定的地形形状参数生成多种合成海山。输入数据中包括每个海山的
位置和大小，即 *lon*, *lat*, *radius*, *height* 。对于椭圆形的海山（ |-E|
），则包括 *lon*, *lat*, *azimuth*, *semi-major*, *semi-minor*, *height* 。
如果使用 |-F| 选项以生成平顶海山，但后面没有 *flattening* 参数，则输入数据的
最后一列为 *flattening* 参数。对于随时间变化的地形，可以使用 |-T| 选项，这样
输入数据的最后两列为海山的开始和停止时间。这种情况下，可以输出海山最终的累积
形状，也可以输出其中每个时间点的形状或变化（ |-Q| ）。如果海山存在滑坡（ |-S| ），
则输入数据中最后一列或者几列为滑坡参数。

.. gmtplot:: grdseamount/GMT_seamount_slide.sh
    :width: 60%
    :show-code: false

多项式平顶海山，其侧面存在两个滑坡。用户可以为海山的形成过程指定一个时间跨度，
并为单独的滑坡指定时间跨度。

语法
----

**gmt grdseamount** [ *table* ]
|-G|\ *outgrid*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-A|\ [*out*/*in*][**+s**\ *scale*] ]
[ |-C|\ [**c**\|\ **d**\|\ **g**\|\ **o**\|\ **p**] ]
[ |-D|\ *unit* ]
[ |-E| ]
[ |-F|\ [*flattening*] ]
[ |-H|\ *H*/*rho_l*/*rho_h*\ [**+d**\ *densify*][**+p**\ *power*] ]
[ |-K|\ [*densitymodel*] ]
[ |-L|\ [*hn*] ]
[ |-M|\ [*list*] ]
[ |-N|\ *norm* ]
[ |-Q|\ *bmode*\ [/*fmode*]\ [**+d**] ]
[ |-S|\ [**+a**\ [*az1*/*az2*]][**+b**\ [*beta*]][**+d**\ [*hc*]][**+h**\ [*h1*/*h2*]][**+p**\ [*power*]][**+t**\ [*t0*/*t1*]][**+u**\ [*u0*]][**+v**\ [*phi*]] ]
[ |-T|\ *t0*\ [/*t1*/*dt*]\ [**+l**] ]
[ |-Z|\ *level* ]
[ |SYN_OPT-V| ]
[ |-W|\ *avedensity* ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT--| ]

必选选项（如果不给定 |-L| 选项）
--------------------------------

.. include:: explain_intables.rst_

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*][**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**][:*driver*\ [*dataType*][**+c**\ *options*]]
    输出网格文件名，其中各子选项的含义见 
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__ 。
    如果使用 |-T| 选项，则需要使用 C 语言的语法指定输出格网序列的名称格式。
    如果输出文件名中包含 %s (单位名称) 或 %c (单位字母)，GMT 将会使用每个
    网格对应的时间生成文件名，否则会使用年作为时间生成文件名，见
    `网格文件名模版`_ 。

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-A:

**-A**\ [*out/in*][**+s**\ *scale*]
    创建一个 mask 网格以区分海山以及外部，分别用 *out* 和 *in* 表示内部和
    外部的值 [1/NaN]。海山的高度以及是否平顶不影响本选项，但 |-L| ，|-N| 
    和 |-Z| 选项不能和本选项同时使用。使用 **+s** 缩放海山的半径[1]。

.. _-C:

**-C**\ [**c**\|\ **d**\|\ **g**\|\ **o**\|\ **p**]
    选择海山的形状函数： **c** （圆锥）， **d** （圆盘）， **g** （高斯），
    **o** （多项式）和 **p** （抛物线） [默认为高斯]。除圆盘外，其他所有的
    海山都可以使用带 *f* 参数的 |-F| 选项来截断变成平顶海山。如果 |-C|
    选项没有任何追加的字母，则从输入的最后一列中读取海山形状。如果不使用
    **-C** 选项，默认为高斯海山。

.. gmtplot:: grdseamount/GMT_seamount_types.sh
    :width: 60%
    :show-code: false

在上述所有海山中， :math:`h_0` 是海山最大高度，:math:`r_0` 为基底半径，
:math:`h_n` 是相对于 |-L| [0] 指定的噪声基底的高度，*f* 是 |-F| 选项设置的
平顶海山相关的参数。平顶部分的半径为 :math:`r_t` , 对于圆盘形状海山，不存
在该参数。

.. _-D:

**-D**\ *unit*
    设置数据文件中的水平距离的单位。对于地理坐标（ |SYN_OPT-f| ），不需要该
    选项，在平地球的近似下，自动转换为 km

.. _-E:

**-E**
    设置海山的基地为椭圆形状。如果使用该选项，则海山数据数据格式应该为：
    *lon, lat, azimuth, semi-major, semi-minor, height* (后面三个单位为 m)
    [ 默认底部为圆，输入数据格式为 *lon, lat, radius, height* ]
    下图中的 :math:`\alpha` 即为 *azimuth*

.. gmtplot:: grdseamount/GMT_seamount_map.sh
    :width: 60%
    :show-code: false

.. _-F:

**-F**\ [*flattening*]
    该参数将海山截断为平顶海山。*flattening* 参数的范围从 0[不截断] 到 1，但不能为 1，
    如果不使用该选项，就默认在输入文件的最后一列读取该参数 [ 默认没有截断 ]。使用
    **-Cd** 选项时，忽略该选项。

.. _-H:

**-H**\ *H*/*rho_l*/*rho_h*\ [**+d**\ *densify*][**+p**\ *power*]
    设置参考海山密度相关的参数，该参数用于随深度变化的径向（即下图中的 r 轴向）密度函数。
    以 kg/m^3 或 g/cm^3 为单位设置海山的密度，以 m 为单位设置固定参考高度 *H* [0]。
    使用 **+d** 和 **+p** 选项改变水压驱动的侧面密度 *densify* ，以及可变密度的指数 
    *power* ，即下图中的 :math:`\Delta \rho_f` 和 *p* ，默认 *power* 为 1，即为线性
    变化。
    下图中，*h(r)* 是海山在 r 位置处的高度，*z(r)* 与 *h(r)* 含义相近，不过在海山
    内部。如果海山为平顶海山（见 |-F| ），*h(r)* 仍然为未截断的情况。
    **注** ：如果使用 |-W| 选项，将会报告每个海山的平均密度。径向密度函数的定义为
    :math:`\Delta \rho_s = \rho_h - \rho_l` ，其中 :math:`\rho_h` 即参数中的 *rho_h* ，
    :math:`\rho_l` 为参数中的 *rho_l* ，分别为密度的两个极值（high 和 low）。:math:`\Delta \rho_f`
    为参数中的 *densify* 

.. math::
    \rho(r,z) = \rho_l + \Delta \rho_f \left (\frac{H-h(r)}{H} \right ) + \Delta \rho_s \left ( \frac{h(r)-z(r)}{H} \right )^p

.. gmtplot:: grdseamount/GMT_seamount_density.sh
    :width: 60%
    :show-code: false

.. _-K:

**-K**\ *densitymodel*
    保存参考模型横截面的预测密度文件 *densitymodel* 。这里使用归一化的坐标，即
    半径 x 和高度 z 从 0 到 1，两者的增量都是 0.005，生成 201 x 201 大小的网格。
    **注** ：无需创建海山网格即可使用该选项，因此，|-R|，|-I|，|-G| 和
    |-D| 选项都不是必须的。

.. _-L:

**-L**\ [*hn*]
    输出海山的面积，体积和平均高度。不创建网格。
    使用 *hn* 参数来指定位于 *hn* 高度下的部分将不被统计以避免底部噪声的影响 [0]

.. _-M:

**-M**\ [*list*]
    在使用 |-T| 参数的前提下，将所有输出网格文件对应的时间和名字输出到
    *list* 文件中。不指定 *list* 时，输出到标准输出。第一列为时间，单位
    为年，最后一列为格式化的时间。使用 |-W| 可同时输出密度网格名。
    输出的序列将可以作为 :doc:`grdflexure` 模块的输入。
    使用 |-M| 参数后的输出网格文件名为 *time reliefgrid *\ [ *densitygrid* ] *timetag*

.. _-N:

**-N**\ *norm*
    标准化海山网格，使得网格的最大高度等于 *norm* 

.. _-Q:

**-Q**\ *bmode*/*fmode*\ [**+d**]
    只能和 |-T| 选项共同使用。*bmode* 和 *fmode* 用来设置如何处理海山的变化,
    默认为 **-Qc**\ /**g** 。

    *bmode* 用来设置海山演化使用累积结果还是增量结果，即海山的表面：
      
      - *c* 表示随时间累积的海山 [默认]

      - *i* 表示每个时间段海山演化的增量

    *fmode* 用来设置海山的变化率，即体积变化率：
        
      - *c* 表示常数变化率

      - *g* 表示高斯变化率 [默认]

    下图中展示了上述几种模式的区别。默认情况下，计算的海山的增量和累积量，
    使用 **+d** 选项可以将该增量或者累积量以等效圆盘的形式表达。

.. gmtplot:: grdseamount/GMT_seamount_inc.sh
    :width: 60%
    :show-code: false

*bmode* 两种情况下的海山图（高斯海山，没有平顶，体积线性变化），横坐标
为海山水平方向的尺度，纵坐标为海山的高度，以二维的变化来显示海山的演化。
左图为使用 **c** 的情况，表示使用实际地形，也就是随时间累积的地形；
右图为使用 **i** 的情况，显示了地形随时间变化的增量

.. gmtplot:: grdseamount/GMT_seamount_flux.sh
    :width: 60%
    :show-code: false

*fmode* 的两种情况，横坐标为相对时间，纵坐标为某时刻海山体积与初始海山体积
的比值。
虚线为设置为 **c** 的情况；粗实线为设置为 **g** 的结果。

.. _-S:


**-S**\ [**+a**\ [*az1*/*az2*]][**+b**\ [*beta*]][**+d**\ [*hc*]][**+h**\ [*h1*/*h2*]][**+p**\ [*power*]][**+t**\ [*t0*/*t1*]][**+u**\ [*u0*]][**+v**\ [*phi*]]
    设置参数来控制海山的扇形滑坡，参数适用于所有海山。如果指定了子选项而
    没有给定参数，则从输入文件的最后几列中读取，其顺序与子选项字母顺序一致，
    而不是与子选项出现的顺序一致。如果每个海山有多于一个的滑坡，则重复选项
    或者文件中的参数。子选项含义如下：

    - **+a** 设置扇形滑坡中扇形的角度 [0/360]

    - **+b** 为标准化的滑坡体积时间曲线 :math:`\psi(\tau) = \tau^\beta` 设置
      正指数系数 :math:`\beta` ，默认为线性，即为 1；:math:`\tau` 的定义见
      **+t**

    - **+d** 设置滑坡碎片沉积开始的高度，默认为 :math:`h_1/2`

    - **+h** 设置滑坡扇形区域的上下高度

    - **+p** 激活径向滑坡轮廓的角度变化，通过添加幂指数 p 来调节, p > 2。
      **注** ： 对于多个滑坡，可对某些滑坡设置单独的 p = 0，即关闭角度变化。

    - **+t** 通过 :math:`\psi(\tau)` (见 **+b**) 设置滑坡发展过程的时间跨度,
      其中，:math:`\tau = (t - t_0)/(t_1 - t_0)` 为归一化的时间，该选项需要
      |-T| 选项

    - **+u** 设置归一化的径向滑坡形状参数 :math:`u_0 > 0` [0.2]

    - **+v** 设置滑坡的体积相对于整个海山体积的百分比 

    其中部分参数可结合 `滑坡模拟细节`_ 理解。

.. gmtplot:: grdseamount/GMT_seamount_specs.sh
    :width: 60%
    :show-code: false

上图为自适应的近似滑坡几何图，其中使用了 **+d** ，**+h** 以及 **+a** 选项。
滑坡的体积（粉红色）在滑动的过程中将逐渐沉积在浅蓝色部分，沉积物从高度
:math:`h_c` 开始，线性变化到:math:`r_d` 时变为 0。其中与半径相关的参数
都是从海山的高度以及形状中计算得到的。**注** ： :math:`h_2 > h_1` ；
:math:`r_1 > r_2`

.. _-T:

**-T**\ *t0*\ [/*t1*/*dt*]\ [**+l**]
    设置海山演化序列的起始时间，终止时间和，时间间隔，分别为 *t0*, *t1*
    和 *dt* 。对于单个时间，只给定起始时间。默认时间单位是年，追加 *k* 
    表示千年，追加 *M* 表示百万年。
    使用 **+l** 选项以及将 *dt* 替换为 *n* 可以设置对数时间轴。或者，还
    可以设置一个文件 *file* ，文件中第一列为时间，其中的时间也追加单位，
    不追加时默认使用年。
    使用 |-T| 选项时，将对每个时刻的海山都输出一个网格。

.. _-W:

**-W**\ *avedensity*
    指定垂直平均密度的网格文件。如果设置了 |-T| 选项，*avedensity* 必须是
    具有 C 语言语法的模版名称。如果模版文件名中有 %s（单位名）或者 %c（单位
    字符），将使用 |-T| 选项对应的时间的网格文件，见 `网格文件名模版`_

.. _-Z:

**-Z**\ *level*
    指定背景海深 [0]。由于所有的海山具有向上的地形，设置较大的负的 *level* 
    可以将海山放在海洋里。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-e.rst_

|SYN_OPT-f|
    地理坐标网格的坐标将会使用平地球近似转换为 km

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

网格文件名模版
--------------

网格文件名允许使用一定的规则来定制模版：

    - 若将格式化的时间作为文件名的一部分，则使用单个 %s 作为模版的一部分
      （例如，smt_%s.grd）

    - 若想控制名称中数字的格式，但仍保留时间的单位，则可以使用 %f 和 %c
      的组合。例如：smt_%05.1f%c.grd 将会生成类似 smt_001.1M.grd 的文件名。
      时间将会进行缩放以适应设置的单位

    - 如果不想使用任何单位，则只需给丁一个浮点格式的模版，例如：
      smt_%05.1f_name.grd。时间的单位与原单位相同，即不使用缩放。

详细的格式信息，见 C 语言 `printf <https://en.wikipedia.org/wiki/Printf_format_string>`__
语法。

滑坡模拟细节
------------

通过 |-S| 选项来模拟滑坡并不是物理模型，而是通过简单的几个形状和函数来
近似滑坡的形状及其演变。下面的（1）和（2）分别为滑坡在剖面和正面两侧的
形状，（3）为滑坡随时间的变化。

（1）
径向滑坡高度为 ：

.. math::

    h_s(r) = h_s(u) = h_1 + (h_2 - h_1)q(u) = h_1 + (h_2 - h_1) u_0 \left (\frac{1 + u_0}{u + u_0} - 1\right )

式中，:math:`u = (r - r_2)/(r_1 - r_2)` 为发生滑坡的破裂面归一化的水平距离。
该形状可以通过 **+u** 子选项调节 :math:`u_0` 改变。

.. gmtplot:: grdseamount/GMT_seamount_u0.sh
    :width: 60%
    :show-code: false

上图为多种归一化的径向滑坡形状剖面曲线 :math:`q(u)` ，可通过 **+u** 改变。例如：
圆锥形海山的滑坡在上图虚线以下。较小的 :math:`u_0` 将会导致更深入地切入海山。

（2）
默认情况下，径向滑坡轮廓是固定的，不论滑坡位于海山的哪个侧面。但是，可以通过
下面的函数添加角度变化

.. math::

    s(\alpha) = s(\gamma) = 1 - \lvert \gamma \rvert ^p

其中， :math:`\gamma = 2 (\alpha - \alpha_1)/(\alpha_2 - \alpha_1) - 1` ，*p* 为
幂指数，可通过 **+p** 设置。启用该选项时，使用 :math:`s(\alpha)` 缩放径向滑坡剖面，
使其在两个扇形位置从 0 开始，然后在滑坡的扇形区域变速变化，较大的 p 值对应快速
增大，较小的 p 对应快速变小。该参数可以使滑坡扇形时更加平滑。

.. gmtplot:: grdseamount/GMT_seamount_azim.sh
    :width: 60%
    :show-code: false

上图为调节 **+p** 参数下的径向滑坡高度的振幅变化。这种变化会导致滑坡体积减少
:math:`1 - \bar{s}` （虚线）。例如：当 p 为 2 时，滑坡体积只有原本的 67%。

（3）
滑坡不可能时瞬时发生的，而是在一段时间内发生的。通过模拟的归一化体积变化为：

.. math::

    \psi(t) = \psi(\tau) = \tau^\beta = \left (\frac{t - t_0}{t_1 - t_0} \right )^\beta

其中，:math:`\tau` 为滑坡发生过程时间的归一化。使用该函数可计算给定时间滑坡
沉积的部分。**+b** 选项用来设置幂指数 :math:`\beta` 。


.. gmtplot:: grdseamount/GMT_seamount_psi.sh
    :width: 60%
    :show-code: false

通过上述函数，可以控制滑坡随时间演化的速度。线性的曲线意味着在质量在滑动期间
以恒定的速度沉积。调整 :math:`\beta` 可以调整质量变化集中的时间，
:math:`\beta < 1` 表示发生在总体时间的早期，:math:`\beta < 1` 表示发生在整个
过程的晚期。

注意事项
--------

因为高斯曲线在海山的底部（3 倍 sigma）的幅值为最大幅度的 1.11%。这里计算
高斯海山时，计算到 4 倍 sigma，使得振幅下降到最大幅度的 0.034%，从而避免
在海山底部出现明显的阶梯。

示例
----

创建位于 1 分网格里 在 1 W，2 S 处，基底半径为 30 km，高度为 4500 km 的海山::

    echo 1W 2S 30 4500 | gmt grdseamount -R1:30W/0:30W/2:30S/1:30S -I1m -Ggeo_circ_smt.nc
    gmt grdimage geo_circ_smt.nc -B -png circ

创建位于 1x1 的笛卡尔网格中的(200,400)处的椭圆形海山，基底长轴为 35，短轴为
20，长轴方位角为 29，高度为 3700 m，设置参数为 0.15 来获得平顶海山 ::

    echo 200 400 29 35 20 3700 | gmt grdseamount -R150/250/350/450 -I1 -E -F0.15 -Gcat_ell_smt.nc
    gmt grdview cat_ell_smt.nc -B -Qi -I+d -JZ2c -p195/20 -png ell

计算两个底部为椭圆型的高斯平顶海山的变化，演化时间分别为 3 Ma 到 2 Ma 以及
2.8 Ma 到 1.9 Ma，海山体积变化率为常数；从 3 Ma 到 1.9 Ma 平均每 0.1 Ma 输出一个
网格 ::
    
    cat << EOF > t.txt
    #lon lat azimuth, semi-major, semi-minor, height tstart tend
    0   0       -20     120     60      5000    3.0M    2M
    50  80      -40     110     50      4000    2.8M    1.9M
    EOF
    gmt grdseamount -R-1024/1022/-1122/924 -I2000 -Gsmt_%3.1f_%s.nc t.txt \
      -T3M/1.9M/0.1M -Qi/c -Dk -E -F0.2 -Cg -Ml.lis

:file:`l.lis` 文件中将包含时间，网格文件名和单位。

除上述示例外， `GMT 官方测试 <https://github.com/GenericMappingTools/gmt/tree/master/test/potential>`__
中还有其他示例，包括与 :doc:`grdflexure` 一起使用的示例。

参考文献
--------

Smith, J. R.  and Wessel, P., 2000, Isostatic consequences of giant landslides on the Hawaiian Ridge,
Pure Appl. Geophys., 157, 1097-1114,
`https://doi.org/10.1007/s000240050019 <https://doi.org/10.1007/s000240050019>`_.

相关模块
--------

:doc:`grdmath`,
:doc:`gravfft`,
:doc:`gmtflexure`,
:doc:`grdflexure`
