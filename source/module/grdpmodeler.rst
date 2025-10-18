.. index:: ! grdpmodeler
.. include:: module_supplements_purpose.rst_
.. include:: common_SYN_OPTs.rst_

grdpmodeler
=============

:贡献者: |何星辰|
:最近更新日期: 2025-10-18

----

:官方文档: :doc:`gmt:supplements/spotter/grdpmodeler`  
:简介: 评估地理网格上的板块运动模型

**grdpmodeler** 读取一个地质年龄网格和一个板块运动模型，并计算若干种模型预测结果。
用户还可以选择提供一个多段格式的裁剪多边形文件；在这种情况下，
仅使用多边形内部的网格部分来计算模型预测，外部区域的网格值将被设置为 NaN。

语法
--------

**gmt grdpmodeler**
[ *agegrdfile* ]
|-E|\ *rot_file*\|\ *ID1-ID2*\|\ *lon*/*lat*/*angle*\ [**+i**]
**-S**\ *flags*
[ |-F|\ *polygonfile* ]
[ |-G|\ *outgrid* ]
[ |SYN_OPT-I| ]
[ |SYN_OPT-R| ]
[ |-T|\ *age* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

.. include:: explain_rots.rst_

.. _-S:

**-S**\ *flags*
    指定要计算的模型预测类型，可附加一个或多个标识符：
    - **a**：板块运动方位角（azimuth）
    - **d**：当前位置与洋中脊生成点的球面距离（单位：km）
    - **s**：板块运动阶段 ID（1 表示最年轻阶段）
    - **v**：板块运动速度（mm/yr）
    - **w**：板块旋转速率（度/Myr）
    - **x**：相对于生成点的经度变化量
    - **y**：相对于生成点的纬度变化量
    - **X**：地壳生成时的经度
    - **Y**：地壳生成时的纬度

如果未指定任何参数，则默认计算全部 [**adsvwxyXY**]。

可选选项
------------------

*ingrid*
    输入的地理网格文件名（经度、纬度坐标），其数值为地壳年龄（单位：Myr）。
    如果未提供网格文件，可使用 |-R|、|-I| 和可选的 **-r** 定义计算域。

.. _-F:

**-F**\ *polygonfile*
    指定一个多段闭合多边形文件，描述模型计算的区域内部。
    多边形外部的网格将被设为 NaN。
    [默认对整个网格进行模型计算。]

.. include:: explain_grd_out.rst_

.. include:: explain_-I.rst_

.. include:: explain_-Rgeo.rst_

.. _-T:

**-T**\ *age*
    使用固定年龄进行模型计算（即忽略输入年龄网格中的年龄值）。
    此选项可用于生成某一时刻的模型快照。
    若未提供年龄网格，则必须指定该选项。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-d.rst_

.. include:: explain_-h.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_help.rst_

.. include:: explain_geodetic.rst_

.. include:: explain_inside.rst_

示例
--------

我们将使用一个太平洋地壳年龄的网格 (pac\_age.nc)、一个板块运动
模型 (Pac\_APM.txt) 以及一个包含当前太平洋板块轮廓的多边形 (pac\_clip\_path.txt)。
要评估太平洋板块当前的板块运动方位角，请尝试::

    gmt grdpmodeler pac_age.nc -EPac_APM.txt -V -Fpac_clip_path.txt \
                -Gpac_dir_0.nc -Sa -T0

要确定自地壳形成以来整个太平洋板块的纬度变化，请尝试::

    gmt grdpmodeler pac_age.nc -EPac_APM.txt -V -Fpac_clip_path.txt \
         -Gpac_dlat.nc -Sy

要确定太平洋地壳形成时的有效板块运动速度，请尝试::

    gmt grdpmodeler pac_age.nc -EPac_APM.txt -V -Fpac_clip_path.txt \
         -Gpac_vel.nc -Sv

要确定地壳自形成以来已经移动了多远，请尝试::

    gmt grdpmodeler pac_age.nc -EPac_APM.txt -V -Fpac_clip_path.txt \
         -Gpac_dist.nc -Sd

要将地壳形成时的坐标保存到单独的网格中，请尝试::

    gmt grdpmodeler pac_age.nc -EPac_APM.txt -V -Fpac_clip_path.txt \
         -Gpac_origin_%s.nc -SXY

要重复相同的练习，但将输出的 *lon, lat, age, xorigin, yorigin* 保存到一个表格中，请使用::

    gmt grdpmodeler pac_age.nc -EPac_APM.txt -V -Fpac_clip_path.txt -SXY > origin.txt


备注
--------

GMT 发布了 EarthByte 旋转模型 Global\_EarthByte\_230-0Ma\_GK07\_AREPS.rot。
如需使用替代的旋转文件，请创建一个名为
**GPLATES\_ROTATIONS** 的环境变量，使其指向该替代的C旋转文件。

相关模块
--------

:doc:`backtracker`,
:doc:`gmtpmodeler`,
:doc:`grdrotater`,
:doc:`grdspotter`,
:doc:`hotspotter`,
:doc:`originater`,
:doc:`rotconverter`
