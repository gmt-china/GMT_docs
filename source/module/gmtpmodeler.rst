:author: 何星辰
:date: 2025-10-19

.. index:: ! gmtpmodeler
.. include:: module_supplements_purpose.rst_
.. include:: common_SYN_OPTs.rst_

pmodeler
==============

:官方文档: :doc:`gmt:supplements/spotter/gmtpmodeler`  
:简介: 评估特定位置的板块运动模型

**pmodeler** 读取包含 *lon*, *lat*，以及可选 *age* 三列的表格文件，
并结合一个板块运动模型计算多种模型预测结果。
用户可以选择提供一个多段格式的裁剪多边形文件；
在这种情况下，仅使用多边形内部的点进行模型预测，
多边形外的点将被跳过。结果输出到标准输出。

语法
--------

**gmt pmodeler** *table*
|-E|\ *rot_file*\|\ *ID1-ID2*\|\ *lon*/*lat*/*angle*\ [**+i**]
**-S**\ *flags*
[ |-F|\ *polygonfile* ]
[ |-T|\ *age* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

*table*  
    包含地理坐标 (*lon, lat*)，以及可选的地壳年龄（Myr）的一个或多个表格文件名。  
    如果未指定文件，则从标准输入读取数据。

.. include:: explain_rots.rst_

.. _-S:

**-S**\ *flags*  
    指定要计算的模型预测类型，可附加一个或多个标识符：  
    - **a**：板块运动方位角（azimuth）  
    - **d**：当前位置与洋中脊生成点的球面距离（单位：km）  
    - **s**：板块运动模型阶段 ID（1 表示最年轻阶段）  
    - **v**：板块运动速率（mm/yr）  
    - **w**：板块旋转速率（度/Myr）  
    - **x**：相对于生成点的经度变化量  
    - **y**：相对于生成点的纬度变化量  
    - **X**：地壳生成时的经度  
    - **Y**：地壳生成时的纬度  

    如果未指定任何参数，则默认计算全部 [**adsvwxyXY**]。

可选选项
------------------

.. _-F:

**-F**\ *polygonfile*  
    指定一个多段闭合多边形文件，用于定义模型计算区域。  
    多边形外的点将被忽略。  
    [默认使用所有数据点。]

.. _-T:

**-T**\ *age*  
    使用固定年龄进行模型计算（即忽略输入表格中的年龄值）。  
    此选项可用于生成某一时刻的模型快照。  
    若输入表中未包含年龄列，则必须使用此选项。

.. include:: /explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_help.rst_

.. include:: explain_geodetic.rst_

.. include:: explain_inside.rst_

示例
--------

我们将使用一个包含太平洋地壳位置和年龄的表格 (pac\_age.txt)、一个板块运动
模型 (Pac\_APM.txt) 以及一个包含当前太平洋板块轮廓的多边形 (pac\_clip\_path.txt)。
要评估太平洋板块当前的板块运动方位角，请尝试::

    gmt pmodeler pac_age.txt -EPac_APM.txt -V -Fpac_clip_path.txt \
         -Sa -T0 > pac_dir_0.txt

要确定自地壳形成以来整个太平洋板块的纬度变化，请尝试::

    gmt pmodeler pac_age.txt -EPac_APM.txt -V -Fpac_clip_path.txt \
         -Sy > pac_dlat.txt

要确定太平洋地壳形成时的有效板块运动速度，请尝试::

    gmt pmodeler pac_age.txt -EPac_APM.txt -V -Fpac_clip_path.txt \
         -Sv > pac_vel.txt

要确定地壳自形成以来已经移动了多远，请尝试::

    gmt pmodeler pac_age.txt -EPac_APM.txt -V -Fpac_clip_path.txt \
         -Sd > pac_dist.txt

要保存地壳形成时的坐标，请尝试::

    gmt pmodeler pac_age.txt -EPac_APM.txt -V -Fpac_clip_path.txt \
         -SXY > ac_origin_xy.txt

备注
--------

GMT 发布了 EarthByte 旋转模型 Global\_EarthByte\_230-0Ma\_GK07\_AREPS.rot。
如需使用替代的旋转文件，请创建一个名为
**GPLATES\_ROTATIONS** 的环境变量，使其指向该替代的旋转文件。

相关模块
--------

:doc:`backtracker`,  
:doc:`grdpmodeler`,  
:doc:`grdrotater`,  
:doc:`grdspotter`,  
:doc:`hotspotter`,  
:doc:`originater`,  
:doc:`rotconverter`
