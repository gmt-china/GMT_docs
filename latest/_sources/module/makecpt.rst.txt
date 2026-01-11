:author: 周茂, 田冬冬, 陈箫翰, `Liming Li <https://github.com/cugliming>`_
:date: 2026-01-04

.. index:: ! makecpt
.. program:: makecpt

makecpt
=======

:官方文档: :doc:`gmt:makecpt`
:简介: 制作 CPT 文件

**makecpt** 是一个帮助制作 CPT 文件的模块。在经典模式中，CPT 文件的内容会输出到屏幕标准输出中。
而在现代模式中，该命令不会生成显式的 CPT 文件，而是隐式地将其自动设置为后续命令的默认 CPT 文件。
因此无法使用经典的 ``gmt makecpt xxx > cpt`` 方式生成 CPT 文件。如果需要在现代模式中生成 CPT 文件，
则可以使用 :option:`-H` 选项： ``gmt makecpt xxx -H > cpt`` 。
关于经典模式和现代模式的语法区别，建议阅读 :doc:`/migrating/classic2modern` 章节。

该命令基于主 CPT 创建用户所需的 CPT，获得的 CPT 可以是离散或连续的，颜色也可相对
主 CPT 反转。如果需使用 GMT 之外的 CPT 作为主 CPT，可在
`cpt-city <http://seaviewsensing.com/pub/cpt-city/index.html>`_ 中查询。

:option:`-T` 选项所指定的 z 值范围以外的数值，分别使用 3 种颜色来表示，分别为：

    - 背景色 (B，background color), 表示低于最小 z 值时所对应的颜色
    - 前景色 (F，foreground color), 表示高于最大 z 值时所对应的颜色
    - 以及 NaN 值颜色 (N)，表示 z 值被定义为 NaN 时对应的颜色，即 z 值未定义的情况

默认情况下，这三种颜色会沿用 :option:`-C` 选项所指定的主 CPT 文件的设置，但也可以使用 :option:`-D` 、
:option:`-M` 以及 :option:`-N` 选项修改。或者使用 :doc:`set` 命令对 :term:`COLOR_BACKGROUND`\、
\ :term:`COLOR_FOREGROUND` 与 :term:`COLOR_NAN` 进行自定义修改。需注意，选项总会覆盖
自定义参数值。

颜色模式 (RGB, HSV, CMYK) 会沿用 :option:`-C` 选项所指定的主 CPT 文件的设置。
或者使用 :doc:`set` 命令对 :term:`COLOR_MODEL` 进行自定义修改。

语法
----

**gmt makecpt**
[ *table* ]
[ :option:`-A`\ *transparency*\ [**+a**] ]
[ :option:`-C`\ *cpt* ]
[ :option:`-D`\ [**i**\|\ **o**] ]
[ :option:`-E`\ [*nlevels*] ]
[ :option:`-F`\ [**R**\|\ **c**\|\ **g**\|\ **h**\|\ **r**\|\ **x**][**+c**\ [*label*]][**+k**\ *keys*] ]
[ :option:`-G`\ *zlo*\ /\ *zhi* ]
[ :option:`-H` ]
[ :option:`-I`\ [**c**][**z**] ]
[ :option:`-M` ]
[ :option:`-N` ]
[ :option:`-Q` ]
[ :option:`-S`\ *mode* ]
[ :option:`-T`\ [*min*/*max*/*inc*\ [**+b**\|\ **i**\|\ **l**\|\ **n**]\|\ *file*\|\ *list*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [**w**] ]
[ :option:`-Z` ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

.. include:: explain_intables.rst_
..

    **注意：** 输入数据只能和 :option:`-E` 或 :option:`-S` 选项一起配合使用。不使用这些选项时，不需要指定输入数据。

可选选项
--------

.. option:: -A

**-A**\ *transparency*\ [**+a**]
    设置透明度，*transparency* 的取值范围是 0 到 100。
    加上 **+a** 则将该透明度同时应用于前景色、背景色和 NaN 颜色
    [默认不透明, 即 *transparency* 为 0]。

.. include:: create_cpt.rst_

.. option:: -D

**-D**\ [**i**\|\ **o**]
    不使用参数的 **-D** 等效于 **-Do** ，作用是将背景色和前景色分别设置为输出生成的 CPT 文件中最小值和最大值对应的颜色。
    **-Di** 则为使用 :option:`-C` 指定的主 CPT 文件中最小值和最大值对应的颜色。
    不设置本项时，GMT 默认使用主 CPT 文件规定的背景色与前景色，或是采用配置参数
    :term:`COLOR_BACKGROUND`\、:term:`COLOR_FOREGROUND` 的设置。

.. option:: -E

**-E**\ [*nlevels*]
    读取输入数据 *table*，最后一列为数据的 z 值范围。本选项会生成输出一个适用于该数据文件的 CPT 文件，
    数据的 z 值范围会被划分为 *nlevels* 个等间距颜色区间。如果不给定 *nlevels* 参数，则默认其等于主 CPT 中的层级数。
    本选项根据数据文件自动确定最大最小值，可以替代需要手动设置参数的 :option:`-T` 选项。

    使用 :option:`-i` 选项可选择其他列决定数据 z 值范围，二进制文件则需同时使用 :option:`-bi` 。

.. option:: -F

**-F**\ [**R**\|\ **r**\|\ **h**\|\ **c**\|\ **x**][**+c**\ [*label*]][**+k**\ *keys*]
    - **-FR** ，输出的 CPT 以 r/g/b 灰度值，或名称指定颜色[默认]；
    - **-Fr** ，输出的 CPT 以 r/g/b 方式指定颜色；
    - **-Fh** ，输出的 CPT 以 h-s-v 方式指定颜色；
    - **-Fc** ，输出的 CPT 以 c/m/y/k 方式指定颜色；

    附加 **+c** 以分类格式输出离散型 CPT。如果追加 *label* ，则在绘制 CPT 时，每个
    分类均创建标签。标签的格式可以是逗号分隔的列表（中间可通过不指定名称来跳过类别），
    也可以通过 *start*\ [-] 来指定以 *start* 为首，依次递增的标签。追加 **-** 则表示
    标签的范围为 *start* 到 *start+1*。注意，存在以下特殊情况：

    - 如果使用 **+cM** 且类别数为 12，则 GMT 会自动创建月份名称列表
    - 如果使用 **+cD** 且类别数为 7，则创建一周内每天名称列表

    上述两种情况，标签的格式受 :term:`FORMAT_TIME_PRIMARY_MAP`，:term:`GMT_LANGUAGE`
    和 :term:`TIME_WEEK_START` 参数影响。

    附加 **+k**\ *keys* 选项表示使用字符而不是数字设置分类 CPT 的键值。*keys* 可以是
    一个文件，其中包含键值列表；*keys* 也可以是单个字符，例如：D，则键值列表为 D、E、F...。
    如果是逗号分隔的键值列表，则应使用 :option:`-T` 选项，而不是该选项。

.. option:: -G

**-G**\ *zlo*\ /\ *zhi*
    截断主 CPT 文件，将主 CPT 的最小和最大 z 值分别限制为 *zlo* 与 *zhi*。上述两值
    若设置为 NaN，则仍旧使用原本的最值。截断的操作发生在重采样之前。译注：该选项
    通常用于地形、深度等具有实际意义的 CPT。

.. option:: -H

**-H**
    仅限现代模式。
    默认情况下是将 CPT 保存为隐藏的当前 CPT，加上该选项会显式地将 CPT 写入标准输出。
    在写制作动画的脚本时，需要传递显式命名的 CPT 文件，因此需要使用本功能。
    建议阅读 :doc:`/migrating/classic2modern` 。

.. option:: -I

**-I**\ [**c**][**z**]
    - **-Ic** [默认]：反转颜色的顺序，同时也会交换前景色和背景色以及 :term:`COLOR_FOREGROUND` 和
      :term:`COLOR_BACKGROUND` 参数设置的前景色和背景色。详细用法和说明见 :doc:`/cpt/makecpt` 。

    - **-Iz** ：反转 CPT 的 *z* 值正负号（不包括前景色、背景色）。该操作发生于 :option:`-G` 和 :option:`-T`
      选项之前，因此使用上述两选项时，需先考虑 **-Iz** 操作后的 *z* 值的实际范围。

.. option:: -M

**-M**
    使用配置参数 :term:`COLOR_FOREGROUND` 、 :term:`COLOR_BACKGROUND` 
    和 :term:`COLOR_NAN` 覆盖主 CPT 中的前景色、背景色和 NaN 值的颜色。
    如果和 :option:`-D` 同时使用，则 :option:`-D` 中的前景色和背景色设置优先，
    本选项只会让 :term:`COLOR_NAN` 有效。

.. option:: -N

**-N**
    不在生成的 CPT 中写入前景色，背景色和 NaN 值的颜色[默认写入]。

.. option:: -Q

**-Q**
    对于 :option:`-T` 选项给出的 z 值线性一维数组，首先计算它的对数值 :math:`\log_{10}(z)`。
    每个颜色区间根据 z 值的对数值分配颜色，但颜色区间仍用 z 值表示。

.. option:: -S

**-S**\ *mode*
    读取输入数据 *table*，最后一列为数据的 z 值，自动确定适合 :option:`-T` 选项的范围。
    可以选择的模式有：

    - **-Sr** ：使用数据的最小/最大值作为范围
    - **-S**\ *inc*\ [**+d**] ：将数据的最小/最大值进行取整，让新范围可以是 *inc* 的整数倍。附加 **+d** 生成离散 CPT。
    - **-Sa**\ *scl* ：以平均值为对称中心，±\ *scl* * *sigma* 的对称范围
    - **-Sm**\ *scl* ：以中位数为对称中心，±\ *scl* * *L1_scale* 的对称范围
    - **-Sp**\ *scl* ：以众数为对称中心（即 LMS；最小二乘中位数），±\ *scl* * *LMS_scale* 的对称范围
    - **-Sq**\ *low/high* ：从低分位数到高分位数（百分比格式）的范围

    使用 :option:`-i` 选项可选择其他列决定数据 z 值范围，二进制文件则需同时使用 :option:`-bi` 。

.. option:: -T

**-T**\ *min*/*max*/*inc*\ [**+b**\|\ **i**\|\ **l**\|\ **n**]

**-T**\ *file*\|\ *list*
    定义要生成的 CPT 文件的 z 值范围 *min/max* 及颜色区间间隔 *inc*。
    如果不使用本选项，则原样使用主 CPT 中的现有范围和间隔。
    附加 **+n** 则将 *inc* 解释为颜色区间的数目而不是间隔。其他附加选项的含义详见 `生成一维数组`_ 。

    也可以读取一个文件 *file*，文件第一列代表的一维数组定义了每个颜色区间的边界。
    或者直接给出一个以逗号分隔的一维数组 *list*。
    若要设置带有字符串键的分类 CPT， *list* 则为以逗号分隔的字符串列表。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [**w**]
    不插值主 CPT ，而是从 CPT 的开头开始选取输出颜色，直到所有区间的颜色都被分配完。
    这在与分类 CPT 同时使用时非常有用。使用 **-Ww** 可生成一个无限重复范围的循环（周期性） CPT。

.. option:: -Z

**-Z**
    生成连续 CPT 文件。默认生成不连续 CPT 文件，即每个 Z 值切片内为同一颜色。

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_help.rst_

.. include:: explain_transparency.rst_

.. include:: explain_array.rst_

颜色铰链
--------

某些 GMT 动态 CPT 是两个独立的 CPT 合成的，合成位置称为铰链值。铰链两侧
的颜色通常会有较大的变化，用于两个不同的方面（例如，陆地和海洋的高程和深度）。
一般情况下，颜色的动态变化不受铰链的影响，将整个颜色范围拉伸得到最终的 CPT。
但激活铰链值时，CPT 铰链两侧的部分将分别拉伸到所需的范围。铰链分为硬铰链和软
铰链，铰链必须通过在 CPT 后追加 **+h**\ [*hinge*] 激活。如果设定的拉伸范围
不包括铰链值，则只在 CPT 中选取与范围相关的一半重新采样颜色。

离散 CPT 和连续 CPT
-------------------

所有的 CPT 都可以拉伸，但只建议使用连续 CPT 在 :option:`-T` 指定的新节点上采样，如果
使用离散 CPT 采样，则会警告，但仍可使用。GMT 这样做的原因是防止重采样
原始 CPT 导致混叠。

示例
----

以 polar CPT 为主 CPT，创建一个范围为 -200 到 200，间距为 25 的离散 CPT ::

    gmt makecpt -Cpolar -T-200/200/25 > colors.cpt

使用默认的 turbo CPT 为主 CPT，创建一个范围为 -2 到 6 的等距 CPT ::

    gmt makecpt -T-2/6 > colors.cpt

在 gebco 的基础上，创建一个适用于 v3206_06.txt 数据文件的 CPT，颜色区间
个数为 24 个 ::

    gmt makecpt -Cgebco @v3206_06.txt -E24 > my_depths.cpt

创建一个震源深度 CPT 文件，红色表示深度为 0-100 km，绿色表示 100-300 km，
蓝色表示 300-1000 km ::

    gmt makecpt -Cred,green,blue -T0,80,300,1000 -N > seis.cpt

创建一个连续 CPT，从 3-10 变化时，颜色从白色过度到蓝色 ::

    gmt makecpt -Cwhite,blue -T3/10 > cold.cpt

创建一个 0-500 范围的循环 CPT，如果值范围超过 500 或小于 0，则使用循环
后的值，而不是 NaN 对应的颜色 ::

    gmt makecpt -Cjet -T0/500 -Ww > wrapped.cpt

创建一个拥有三个类别的分类 CPT，并指定类别名 ::

    gmt makecpt -Ccubhelix -T0/2/1 -F+cClouds,Trees,Water > cat.cpt

创建一个拥有 10 个类别的分类 CPT，类别名从 A、B、C 等开始编号 ::

    gmt makecpt -Cjet -T0/10/1 -F+cA

使用字符串键值创建一个分类 CPT ::

    gmt makecpt -Ccategorical -Twood,water,gold

相关模块
--------

:doc:`grd2cpt`
