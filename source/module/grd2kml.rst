:author: 何星辰
:date: 2025-10-20

.. index:: ! grd2kml
.. program:: grd2kml
.. include:: common_SYN_OPTs.rst_

grd2kml
=======

:官方文档: :doc:`gmt:grd2kml`  
:简介: 从单个网格创建 KML 分级切片图像


**grd2kml** 读取一个二维网格文件，并使用所选的图块大小生成 PNG 或 JPG 图像
以及适用于 Google Earth 的 KML 文件四叉树（quadtree）。
我们根据四叉树的不同视图层级，对网格进行高斯滤波降采样（可通过选项选择其他滤波器）。
可选地，通过提供 ±1 范围内的强度网格文件，或自动从输入网格派生强度（见 |-I| ），
可添加光照效果。超出 ±1 范围的强度值将被裁剪。
地图颜色通过色标（CPT）查表定义，可选择是否叠加等值线。
如果选择生成纯图块（即未指定等值线），则 PNG 图像由 :doc:`grdimage` 直接输出；
否则将先生成 PostScript 图，再经 :doc:`psconvert` 转换为光栅图像。

语法
--------

**gmt grd2kml** *ingrid*
|-N|\ *prefix*
[ :option:`-A`\ **a**\|\ **g**\|\ **s**\ [*altitude*] ]
[ :option:`-C`\ [*section*/]\ *master*\|\ *cpt*\|\ *color*\ :math:`_1`,\ *color*\ :math:`_2`\ [,\ *color*\ :math:`_3`\ ,...]\ [**+h**\ [*hinge*]][**+i**\ *dz*][**+u**\|\ **U**\ *unit*][**+s**\ *fname*] ]
[ :option:`-E`\ *URL* ]
[ :option:`-F`\ *filtercode* ]
[ |-H|\ *scale* ]
[ |-I|\ [*file*\|\ *intens*\|\ **+a**\ *azimuth*][**+d**][**+m**\ *ambient*][**+n**\ *args*] ]
[ |-L|\ *tilesize* ]
[ |-S|\ [*extra*] ]
[ |-T|\ *title* ]
[ |-W|\ *cfile*\|\ *pen*\ [**+s**\ *scale*/*limit*] ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

.. include:: explain_grd_in.rst_

.. _-N:

**-N**\ *prefix*
    设置用于顶层 KML 文件名及输出目录名称的唯一前缀 [默认：GMT_Quadtree]。
    所有生成的 KML 文件和图像文件将存放在该目录下。

可选选项
------------------

.. _-A:

**-A**\ **a**\|\ **g**\|\ **s**\ [*altitude*]
    选择 Google Earth 支持的三种高度模式之一，确定图层的高度（单位：米）：
    **a** 表示绝对高度，**g** 表示相对于地面的高度，**s** 表示相对于海底的高度。
    若要固定在某一高度上绘制图层，可追加 altitude（米）。
    使用 0 表示将图层贴合到参考面（如地面或海面）。  
    [默认：图块贴合到地面或海面。]

.. _-C:

.. include:: use_cpt_grd.rst_

.. _-E:

**-E**\ *URL*
    若不希望将所有文件保存在本地，可指定远程站点的 URL 作为前缀。
    生成的顶层 *prefix*.kml 文件将通过该 URL 查找其引用的文件。
    构建完成后，需将整个 *prefix* 目录上传到该远程地址。
    这样，你可以通过邮件或下载方式分享 *prefix*.kml，
    用户在 Google Earth 中打开后将自动从远程服务器加载所需文件。

.. _-F:

**-F**\ *filtercode*
    指定用于网格降采样的滤波器。
    可选： **b** （Boxcar 方窗）、 **c** （余弦弓形）、 **g** （高斯）
    、 **m** （中值）[默认：Gaussian]。
    滤波宽度会自动随四叉树层级调整。

.. _-H:

**-H**\ *scale*
    设置传递给 :doc:`psconvert` 的亚像素平滑尺度，以提高光栅化质量
    （等同于 :doc:`psconvert` 的 |-H| 选项）[默认无平滑]。
    当未使用 |-W| 时，该选项被忽略。

.. _-I:

.. include:: explain_intense.rst_

.. _-L:

**-L**\ *tilesize*
    设置图块的固定尺寸。必须为 2 的整数幂。
    常用值：256 或 512 [默认 256]。
    **注意**：对于全球网格（即经度范围为 360° 的数据），若未指定 |-L|，
    则自动设置 *tilesize* = 360。

.. _-S:

**-S**\ [*extra*]
    增加超出原数据分辨率所需的额外层级 [默认无]。
    这样 GMT 将通过插值生成更高分辨率的图块，而不是让 Google Earth 自行插值。

.. _-T:

**-T**\ *title*
    设置顶层文档的标题（即其描述信息）。

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *cfile*\|\ *pen*\ [**+s**\ *scale*/*limit*]
    提供一个包含等值线值与画笔样式的文件，用于在影像上叠加等值线 [默认无等值线]。
    因此，使用 |-W| 时图块将通过 PostScript 渲染生成，速度较慢。
    若 *cfile* 无效，则认为输入为 *pen*，并依据 :option:`-C` 所定义的 *cpt* 自动绘制等值线。
    等值线通过 :doc:`grdcontour` 绘制。
    **注意**：画笔宽度指的是最高分辨率图块的宽度；
    对于低一层的图块，其宽度按比例 *scale* [默认 sqrt(2)] 缩减。
    若缩放后宽度小于 *limit* [默认 0.1] 点，则跳过该等值线
    （除非画笔宽度为 0 或 “faint”）。
    可通过 **+s** 修改这些值。

.. include:: explain_-f.rst_

.. include:: explain_-n.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

四叉树构建
----------

输入网格必须在经纬度方向上具有相同间距。若不满足此条件，可使用 :doc:`grdsample` 预处理。
我们通过 :doc:`grdcut` 扩展网格，使其形成可被连续二等分的正方形区域，
直到图块尺寸与原始网格分辨率相当。
对于全球网格（经度范围 360°），我们扩展至 360×360 的笛卡尔区域，
初始分辨率为 1°，这是第一个全局图块。
随后不断四分网格并减半分辨率，直到接近原始间隔。
对于局部或区域性网格，我们将其扩展至 *tilesize* × 网格间隔的 2 的整数倍。
仅输出含有非 NaN 数据的图块。
所有图块均为像素注册。
若输入为网格线注册，则在降采样时我们将其转换为像素注册网格，
并将滤波宽度乘以 sqrt(2)。
若检测到某图块中存在 NaN 值，则输出透明 PNG 图块；
否则输出不透明 JPG 图块。

轮廓叠加
--------

由于每个图块的像素尺寸固定（如 512×512 像素），
但每层级代表的数据量随层级增加而变化（每层×4），
因此无法在所有层级使用相同厚度的等值线笔宽。
输入的画笔宽度应视为最高分辨率层的宽度。
由于生成的图像分辨率（dpi）比常规 GMT 图低得多，
建议使用亚像素平滑（|-H|）以改善等值线外观。
生成 PostScript 图块及平滑处理均会显著增加计算时间。

备注
--------

强度网格可通过 :doc:`grdgradient` 从数据网格生成，
并可使用 :doc:`grdmath` 或 :doc:`grdhisteq` 进一步处理。
若使用多个不同光照角度的强度网格，可通过 :doc:`grdmath` 合并。
对于单一光照角度，也可使用自动光照模式。

示例
--------

.. include:: explain_example.rst_

若要测试低分辨率地形网格 earth_relief_06m 的四叉树影像表示，
使用自动配色及合适标题，可执行::

    gmt grd2kml @earth_relief_06m -NEarth6m -T"Earth Relief 6x6 arc minutes" -Cearth

若要对大型地形网格 ellice_basin.nc 生成四叉树影像，
自动根据地形生成阴影，使用 512×512 图块，设置标题，
并对无数据区域使用颜色遮罩，可执行::

    gmt grd2kml ellice_basin.nc -I+d -Nellice -L512 -T"Ellice Basin Bathymetry"

相关模块
--------

:doc:`gmt2kml`,
:doc:`grdgradient`,
:doc:`grdhisteq`,
:doc:`grdimage`,
:doc:`grdmath`,
:doc:`grdsample`,
:doc:`kml2gmt`,
:doc:`psconvert`
