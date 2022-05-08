.. index:: ! grdflexure
.. include:: common_SYN_OPTs.rst_

grdflexure
==========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/potential/grdflexure`
:简介: 计算 3-D 载荷产生的挠曲变形

目前均衡研究中主要存在 3 种模型，分别为 Pratt 模型，Airy 模型以及挠曲模型。
**grdflexure** 即为挠曲均衡模型，其可计算地形载荷 :math:`h(\mathbf{x})` 在
5 种不同流体基础上引起的变形，所有情况中承载地形的板（通常为地壳或者岩石圈）
的厚度都认为是相同的，以下为 5 中流变基础：

1. 弹性板覆盖在无粘性的板上

2. 弹性板覆盖在粘性板上（Firmoviscous 或者 Kelvin-Voigt）

3. 弹性板覆盖在粘性

4. 粘弹性板覆盖在无粘性板上

5. 线性粘弹性模型，已知初始和结束时的弹性板厚度，弹性板覆盖在无粘性板上

五种流变基础分别对应均衡研究中对岩石圈/地壳的五种假设，其对应的响应函数分别为
*elastic* [1; :math:`\Phi_e(\mathbf{k})`]，
*firmoviscous* [2,3; :math:`\Phi_{fv}(\mathbf{k},t)`]，
*viscoelastic* [4; :math:`\Phi_{ve}(\mathbf{k},t)`]，
和 *general linear* (viscoelastic)  [5; :math:`\Phi_{gl}(\mathbf{k},t)`]。如果
（粘）弹性板消失（厚度为 0），则退化为 Airy 均衡模型（1,4）或者纯粘性模型（2，3）。
还可为模型提供等间隔的网格以研究随时间变化的结果；此外还可为模型制定相关的流体
基础和常熟，包括板内力。

语法
----

**gmt grdflexure** *topogrd*
|-D|\ *rm*/*rl*\ [/*ri*]\ /*rw*
|-E|\ [*Te*\ [**k**][/*Te2*\ [**k**]]]
|-G|\ *outgrid*
[ |-A|\ *Nx*/*Ny*/*Nxy* ]
[ |-C|\ **p**\|\ **y**\ *value* ]
[ |-F|\ *nu_a*\ [/*h_a*\ [**k**]/*nu_m*] ]
[ |-L|\ *list* ]
[ |-M|\ *tm* ]
[ |-N|\ *params* ]
[ |-Q| ]
[ |-S|\ *beta* ]
[ |-T|\ *t0*\ [/*t1*/*dt*\ [**+l**]]\ \|\ *file* ]
[ |SYN_OPT-V| ]
[ |-W|\ *wd*]\ [**k**]
[ |-Z|\ *zm*]\ [**k**]
[ |SYN_OPT-f| ]
[ |SYN_OPT--| ]

必选选项
--------

*topogrd*
    地形网格载荷，单位为 m。如果使用 **-T** 选项，*topogrd* 可以是一个 C
    语言语法形式的模版名，将为每个时间加载不同的地形网格。因此，加载时间
    必须与 **-T** 给出的时间一致（但并非所有的时间都需要对应的文件）。或者，
    可以将 *topogrd* 指定为 *=flist* ，其中 *flist* 为本文文件，其中每条记录
    均包含一个 topogrd 文件名和对应的加载时间（例如 :doc:`grdseamount` 的 
    **-M** 选项生成的列表）。加载的时间可以和 **-T** 给出的
    时间不同，参见 **-T** 。**注** ：如果 *flist* 文件中包含第三列，则该列为
    加载地形的密度，此密度可以覆盖 **-D** 选项设置的固定密度 *rl* 。

.. _-D:

**-D**\ *rm*/*rl*\ [/*ri*]\ /*rw*
    分别设置地慢，载荷，填充物和水（或空气）的密度。如果 *ri* 和 *rl* 不同，
    则确定一个近似解。如果 *ri* 没有指定，则默认其等于 *rl* 。密度的单位可以是
    km/m^3 或 g/cm^3

.. _-E:

**-E**\ [*Te*\ [**k**][/*Te2*\ [**k**]]
    设置弹性板厚度（单位为 m）, **k** 表示单位为 km。如果弹性板厚度的值超过
    了 1e10，认为该值超过岩石圈有效弹性厚度的实际范围，GMT 将其认为是抗挠刚度
    ，而不是弹性板厚度 *D* （默认情况下 *D* 由有效弹性厚度 *Te* ，杨氏模量
    和泊松比计算，见 **-C** 参数）。如果 **-E** 后不加任何参数且和 **-F**
    同时适应，则表明不设置弹性板，GMT 将返回带有软流圈或者不含软流圈的粘性
    响应。通过给定初始的弹性厚度 *Te* 和最终弹性厚度 *Te2* , 可以选择设置为
    线性粘弹性响应，这时需要同时使用 **-M** 选项。

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]

    输出网格文件名，其中各子选项的含义见 
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__ 
    如果使用 |-T| 选项，则需要使用 C 语言的语法指定输出格网序列的名称格式。
    如果输出文件名中包含 %s (单位名称) 或 %c (单位字母)，GMT 将会使用每个
    网格对应的时间生成文件名，否则会使用年作为时间生成文件名。

可选选项
--------

.. _-A:

**-A**\ *Nx*/*Ny*/*Nxy*
    指定 x 和 y 方向的压力或者拉力以及任意剪应力。压力用负值表示，拉力用
    正值表示，由于 **N** 为深度积分的水平应力，所以单位为 Pa·m。

.. _-C:

**-C**\ **p**\|\ **y**\ *value*
    分别使用 **p** 和 **y** 修改泊松比的默认值 [0.25] 和杨氏模量的默认值
    [7.0e10 N/m^2]

.. _-F:

**-F**\ *nu_a*\ [\ /*h_a*\ [**k**]/*nu_m*]
    

.. include:: explain_fft.rst_

.. _-M:

**-M**\ *tm*



.. _-Q:

**-Q**


.. _-S:

**-S**\ *beta*



.. _-T:

**-T**\ *t0*\ [/*t1*/*dt*\ [**+l**]]\ \|\ *file*


.. _-W:

**-W**\ *wd*\ [**k**]

.. _-Z:

**-Z**\ *zm*\ [**k**]

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

网格距离单位
------------

如果输入的笛卡尔网格的水平方向距离的单位不是米，可以通过对输入文件名
**+u**\ *unit* 来将指定的单位转换为米。例如：对输入文件 **+uk** 将会把
输入网格的 x 和 y 坐标的单位从 km 转换为 m。如果输入网格为地理网格，可以
通过 |SYN_OPT-f| 将单位转换为米。

注意事项
--------

本模块使用笛卡尔 FFT 计算。如果用户计算区域接近极点，则应该考虑使用笛卡尔
坐标；从地理坐标到笛卡尔坐标的转换可以使用 :doc:`grdproject` 模块实现。

转换函数
--------


示例
----

响应函数理论
------------

由地形 :math:`h(\mathbf{x})` 引起的变形 :math:`w(\mathbf{x})` 随时间的变化在傅立叶域（波数域）
中可由下式得到：

.. math::

    W(\mathbf{k},t) = \gamma \left (\frac{\rho_l - \rho_w}{\rho_m - \rho_l} \right ) H(\mathbf{k}) \Phi(\mathbf{k},t)
    = \gamma A H(\mathbf{k}) \Phi(\mathbf{k},t)

式中，:math:`\mathbf{k} = (k_x, k_y)` 为波数向量，:math:`k_r` 为其幅值，:math:`H(\mathbf{k})`
为波数域中的地形载荷，即 :math:`h(\mathbf{x})` 的傅立叶变换，:math:`A` 为 Airy 密度比，
:math:`\gamma` 常数，取决于填充物密度，:math:`\Phi(\mathbf{k},t)` 为所选流体基础的响应函数。
**grdflexure** 读取一个或者多个载荷 :math:`h(\mathbf{x})` ，将其转换为 :math:`H(\mathbf{k})` ，
计算响应函数，并计算最终的变形 :math:`W(\mathbf{k},t)` ，经过 IFFT 后即得到一个或者多个载荷
引起的形变 :math:`w(\mathbf{x})` 。

填充物密度
~~~~~~~~~~

如果 :math:`\rho_i = \rho_l` ，则 :math:`\gamma = 1` ，如果填充物的密度随空间变化，则无法求解。


弹性响应函数
~~~~~~~~~~~~

粘弹性响应函数
~~~~~~~~~~~~~~

Airy 和粘性响应函数
~~~~~~~~~~~~~~~~~~~

Maxwell 粘弹性响应函数
~~~~~~~~~~~~~~~~~~~~~~

线性粘弹性响应函数
~~~~~~~~~~~~~~~~~~


参考文献
--------

Cathles, L. M., 1975, *The viscosity of the earth's mantle*, Princeton University Press.

Karner, G. D., 1982, Spectral representation of isostatic models, *BMR J. Australian Geology & Geophysics, 7*, 55-62.

Nakada, M., 1986, Holocene sea levels in oceanic islands: Implications for the rheological
structure of the Earth's mantle, *Tectonophysics, 121*, 263–276,
`https://doi.org/10.1016/0040-1951(86)90047-8 <https://doi.org/10.1016/0040-1951(86)90047-8>`_.

Watts, A. B., 2001, *Isostasy and Flexure of the Lithosphere*, 458 pp., Cambridge University Press.

Wessel. P., 2001, Global distribution of seamounts inferred from gridded Geosat/ERS-1 altimetry,
J. Geophys. Res., 106(B9), 19,431-19,441,
`https://doi.org/10.1029/2000JB000083 <https://doi.org/10.1029/2000JB000083>`_.

Wessel, P., 2016, Regional–residual separation of bathymetry and revised estimates of Hawaii plume flux,
*Geophys. J. Int., 204(2)*, 932-947, `https://doi.org/10.1093/gji/ggv472 <https://doi.org/10.1093/gji/ggv472>`_.

相关模块
--------

:doc:`gmtflexure`,
:doc:`grdfft`,
:doc:`gravfft`,
:doc:`grdmath`,
:doc:`grdseamount`
