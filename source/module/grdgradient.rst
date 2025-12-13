:author: 朱邓达
:date: 2025-05-12

.. index:: ! grdgradient

************
grdgradient
************

:官方文档: :doc:`gmt:grdgradient`
:简介: 从网格文件中计算方向导数（光照强度）或梯度

语法
--------

.. include:: common_SYN_OPTs.rst_

**gmt grdgradient** *ingrid*
|-G|\ *outgrid*
[ |-A|\ *azim*\ [/\ *azim2*] ]
[ |-D|\ [**a**][**c**][**n**][**o**] ]
[ |-E|\ [**m**][**s**][**p**]\ *azim*\ /\ *elev*\ [**+a**\ *ambient*][**+d**\ *diffuse*][**+p**\ *specular*][**+s**\ *shine*] ]
[ |-N|\ [**e**][**t**][\ *amp*][**+a**\ *ambient*][**+s**\ *sigma*][**+o**\ *offset*] ]
[ |-Q|\ **c**\|\ **r**\|\ **R**\ [**+f**\ *file*] ]
[ |SYN_OPT-Rz| ]
[ |-S|\ *slopfile* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT--| ]


描述
-----------

**grdgradient** 从网格文件中计算给定方向的方向导数(\ |-A|)，或梯度的方向(\ |-D|)和大小(\ |-S|)。

边界的梯度计算取决于网格的边界条件（详见中文文档 :doc:`/option/n` 或官方文档 |SYN_OPT-n| ）。

必选选项
------------------

.. include:: explain_grd_in.rst_

.. include:: explain_grd_out.rst_


可选选项
------------------

.. option:: -A

**-A**\ *azim*\ [/\ *azim2*] 
    给定光源方位角，计算方向导数。 *azim* 为方位角（度），
    在 *x-y* 平面从正北(*+y*)向着正东(*+x*)顺时针方向测量。
    实际计算的是方向导数的相反数， 
    :math:`-\left( \frac{dz}{dx}\sin(a) + \frac{dz}{dy}\cos(a) \right)`，
    其中 :math:`a` 为方位角 *azim* 。这使得 :math:`z(x,y)` 在沿着 :math:`a` 方向下降时能输出正值，
    这符合在 *x-y* 平面上方从 :math:`a` 方向对图像照明产生的阴影
    （见 :doc:`/module/grdimage` 和 :doc:`/module/grdview` ）。
    你也可以指定两个方位角， **-A**\ *azim*\ [/\ *azim2*]，此时计算两个方向的方向导数，
    每个节点取方向导数幅值较大的方向导数。这对于照明具有两个方向的线性结构的数据是有用的，
    例如 **-A**\ *0/270* 表示从正北(top)和正西(left)两个方向照明。
    最后，如果 *azim* 是一个和 *ingrid* 相同区域、间隔、配准的网格文件，
    则计算方向导数时每个节点有各自的方位角。

.. option:: -D

**-D**\ [**a**][**c**][**n**][**o**]
    不指定方向(\ |-A|)，而是计算每个节点的正梯度（上升）的方向。支持以下选项：

    + **a** - 计算负梯度（下降）的方向。
    + **c** - 使用传统的笛卡尔角度，从正东(*+x*)方向逆时针测量。默认从正北顺时针测量（ |-A| 中的 *azim* 一致）。
    + **n** - 对所有输出角度增加90度（例如获得表面的局部走向）。
    + **o** - 输出角度范围使用半圆定向（0~180度）而不是默认的全圆定向（0~360度）。
      例如全圆定向的30°和210°在半圆定向中均为30°，因为其位于同一延长线上。

.. option:: -E

**-E**\ [**m**][**s**][**p**]\ *azim*\ /\ *elev*\ [**+a**\ *ambient*][**+d**\ *diffuse*][**+p**\ *specular*][**+s**\ *shine*]
    计算朗伯辐射(Lambertian radiance)以用于 :doc:`/module/grdimage` 和 :doc:`/module/grdview` 。
    朗伯反射(Lambertian Reflection)又称理想散射，其假设一个理想的表面，它能反射所有照射到它的光，
    并且从各个方向看，表面亮度不变。*azim* 和 *elev* 分别为光照的方位角和仰角。
    以下选项可控制表面反射性质，中括号内为默认值，

    + **+a**\ *ambient* - 环境光系数 [0.55]。
    + **+d**\ *diffuse* - 漫反射系数 [0.6]。
    + **+p**\ *specular* - 镜面反射系数 [0.4]。
    + **+s**\ *shine* - 镜面高光度 [10]。
    
    **s|p|m** 指令可使用简化算法：

    + **s** - 简易朗伯算法（只要求 *azim* 和 *elev* ）。
    + **p** - 普克(Peucker)分段线性近似 （简易但高效），
      此时 *azim* 和 *elev* 分别固定为315和45，忽略用户设置。
    + **m** - 与ESRI的hillshade算法类似，但更快。

.. option:: -N

**-N**\ [**e**][**t**][\ *amp*][**+a**\ *ambient*][**+s**\ *sigma*][**+o**\ *offset*] 
    归一化（默认不做归一化）。实际梯度 :math:`g` 被偏移和缩放成 :math:`g_n` ，幅值为 *amp* 。
    如果 *amp* 未给定，默认 *amp* = 1。如果偏移 *offset* 未给定，则设置为 :math:`g` 的平均值。
    支持以下选项，其中 :math:`o` 为 *offset* ， :math:`a` 为 *amp* ，

    + **-N** - 根据 :math:`g_n = a\cdot \frac{g-o}{\max{|g-o|}}` 进行归一化。
    + **-Ne** - 使用类似于拉普拉斯分布的累积分布函数 
      :math:`g_n = a\cdot\left( 1 - \exp{\left( \sqrt{2} \frac{g-o}{\sigma}\right)} \right)` 
      进行归一化，其中 :math:`\sigma` 为 *sigma* ，如果未给定则使用 :math:`(g-o)` 的L1范数。
    + **-Nt** - 使用类似于柯西分布的累计分布函数
      :math:`g_n = \frac{2a}{\pi} \tan^{-1} \left(\frac{g-o}{\sigma}\right)` 进行归一化，
      其中 :math:`\sigma` 为 *sigma* ，如果未给定则使用 :math:`(g-o)` 的L2范数。
      
    为了继续使用之前运行该命令计算的 :math:`o` 和/或 :math:`\sigma`，可不指定对应的具体数值，
    详见 |-Q| 。最后，可使用 **+a**\ *ambient* 给归一化之后的梯度整体加上 
    *ambient* 。

.. option:: -Q
    
**-Q**\ **c**\|\ **r**\|\ **R**\ [**+f**\ *file*]
    控制 |-N| 的归一化。当需要对多个网格进行相同的归一化处理（即相同的偏移 *offset* 和标准差 *sigma*），
    用户必须使用 |-N| 传入这些值。然而，用户从网格中计算出这些值并不方便。
    可使用 **-Qc** 将计算的 *offset* 和 *sigma* 保存到一个统计文件中，如果这时不需要输出网格文件，
    可不指定 |-G| 。后续运行该命令时，可只使用 **-Qr** 来读取这些值。
    使用 **-QR** 则读取后删除该统计文件。
    也可以加上 **+f**\ *file* 来指定读/写特定文件（默认为当前系统TMP目录下的grdgradient.stat文件）。

.. include:: explain_-R.rst_

.. option:: -S

**-S**\ *slopfile*
    将梯度矢量的大小输出到网格文件 *slopfile* 。要求和 |-D| 使用，此时 |-G| 变为可选项。

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_-n.rst_

.. include:: explain_help.rst_


网格距离单位
--------------

详见官方文档关于 `+u <https://docs.generic-mapping-tools.org/latest/reference/features.html#modifiers-for-changing-units-of-grid-coordinates>`_ 的说明。

+ 对于笛卡尔坐标系的网格，如果网格在水平方向的单位不为米，则使用 **+u**\ *unit* 指定输入单位，并在计算中自动转换为米。
+ 对于地理坐标系的网格，使用 **-fg** 根据当前的椭球参数的“展平地球”将网格单位转换为米。


提示
------------

+ 如果你不知道怎么设置 |-N| 来为 :doc:`/module/grdimage` 和 :doc:`/module/grdview` 创建光照强度文件，
  **-Ne**\ 0.6 是一个不错的尝试。
+ 通常，255个色调对于可视化的目的来说已经足够了。可在输出文件名 *outgrid* 后面加上 *=nb/a* ，
  这可以节省75%的磁盘空间。 *=nb/a* 效果是输出网格文件格式为8-bit的整数，包含缩放因子。
+ 如果你想为一个大数据集的子区域制作多个光照图，且要求在所有地图上保持一致的照明效果，
  使用 |-N| 选项并为每个地图提供相同的 *sigma* 和 *offset* 。一个不错的尝试是 *offset* = 0， 
  *sigma* 通过 :doc:`/module/grdinfo` **-L2** 或 **-L1** 应用于未归一化的梯度网格得到。
+ 如果您只需要网格的x或y导数，请使用 :doc:`/module/grdmath` 。


分块处理
-----------

针对超大规模数据集（或超大尺寸绘图），您可能需要将任务分解为多个区块处理。此时需特别注意：
每个区块的光照强度归一化处理应保持一致。默认情况下，程序会为每个区块单独重新计算偏移量( *offset* )和标准差( *sigma* )。
这会导致同一大型网格中的不同区块计算出不同的偏移量和标准差，最终使得相同方向的光照强度值在整张地图上呈现不一致。
此类问题可能导致区块拼接处出现肉眼可见的色差/明暗变化。有以下两种解决方法：

(1) 手动指定参数。使用 |-N| 强制指定相同的 *offset* 和 *sigma* ，这适用于已知标准化参数的情况。

(2) 自动传递参数（推荐工作流）。首先对完整网格（或计算机能处理的最大网格分区）运行 :doc:`/module/grdgradient` **-Qc** ，
    该操作会生成包含全局 *offset* 和 *sigma* 的隐藏统计文件。然后在后续各区块计算时，在 |-N| 后添加无参数的
    **+o** 和/或 **-s** ，同时指定 **-Qr** 以从统计文件中读取参数。在处理最后一个区块时可改用 **-QR** 
    使程序读取统计文件后自动删除。
    

环境光
-----------

环境光 *ambient* 偏移用于使光照强度整体变暗或变亮。这个设置通常用于通过从所有光照强度中减去一个常数来使整个图像变暗。
例如，如果你使用 **+a**\-0.5，那么你从所有光照强度中减去0.5，使它们更负，从而使图像变暗。


特效
-------------

如果用户希望只突出显示网格的一个区域，我们鼓励创造性地使用 :doc:`/module/grdmath`
中的大量运算符和 :doc:`/module/grdmask` 和 :doc:`/module/grdclip` 中的网格裁剪方案。
通过 :doc:`/module/grdmath` 中的各种网格代数和布尔运算符，可以将多个独立的光照强度网格组合成一个网格。
天空才是极限。


示例
------------

.. include:: explain_example.rst_

在远程文件 @earth_relief_05m 中使用指数归一化梯度在[-0.6,0.6]范围内模拟北、西方向的光源，
制作一个文件来照亮部分数据::

    gmt grdgradient @earth_relief_05m -R0/20/0/20 -A0/270 -Ggradients.nc -Ne0.6 -V

基于地形文件 topo.nc 确定海底构造(seafloor fabric)的走向::

    gmt grdgradient topo.nc -Dno -Gazimuths.nc -V

保存对 topo.nc 的光照强度值进行归一化的 *offset* 和 *sigma* ::

    gmt grdgradient topo.nc -A30 -Nt0.6 -Qc -V

其中没有指定 |-G| ，不会有网格文件输出，仅创建隐藏的统计文件。

使用先前确定的 *offset* 和 *sigma* 对 tile_3.nc 的光照强度进行归一化::

    gmt grdgradient tile_3.nc -A30 -Nt0.6+o+s -Qr -V -Gtile_3_int.nc

参考文献
--------

Horn, B.K.P., Hill-Shading and the Reflectance Map, Proceedings of the
IEEE, Vol. 69, No. 1, January 1981, pp. 14-47.
(https://www.researchgate.net/publication/2996084_Hill_shading_and_the_reflectance_map)


相关模块
--------

:doc:`gmt`,
:doc:`gmt:grdhisteq`,
:doc:`grdinfo`,
:doc:`grdmath`,
:doc:`grdimage`,
:doc:`grdview`,
:doc:`grdvector`
