.. index:: ! originater
.. include:: common_SYN_OPTs.rst_

originater
=============

:贡献者: |何星辰|, |田冬冬|
:最近更新日期: 2025-10-16

----

:官方文档: :doc:`gmt:supplements/spotter/originater`
:简介: 将海山与最近的热点点源关联起来

**originater** 从 *table* （或标准输入）中读取 
(*longitude*, *latitude*, *height*, *radius*, *crustal_age*) 数据记录，  
并使用给定的绝对板块运动（APM）阶段或整体重建旋转文件，以及热点位置列表，  
来确定每个海山最可能的起源（热点）。它通过计算随时间变化的流线，
并找出与所有热点的最近接点来实现这一点 [*Wessel*, 1999]。  
输出包含输入记录，并为每个最近的 *n_hs* 个热点附加四个额外字段：
热点 ID（例如 HWI）、最近流线段的阶段 ID、海山的伪年龄，
以及与热点的最近距离（单位 km）。参见选项 **-:** 了解如何读取
(*latitude*, *longitude*, *height*, *radius*, *crustal_age*) 格式的文件。

语法
--------

**gmt originater** [ *table* ]
|-E|\ *rot_file*\|\ *ID1-ID2*\|\ *lon*/*lat*/*angle*\ [**+i**]
|-F|\ *hs_file*\ [**+d**]
[ |-D|\ *d_km* ]
[ |-L|\ [**l**\|\ **t**\|\ **w**\| **L**\|\ **T**\|\ **W**] ]
[ |-N|\ *upper_age* ]
[ |-Q|\ *r/t* ]
[ |-S|\ [*n_hs*] ]
[ |-T| ]
[ |SYN_OPT-V| ]
[ |-W|\ *maxdist* ]
[ |-Z| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必需参数
------------------

.. include:: explain_intables.rst_

.. _-E:

**-E**\ *rot_file*\|\ *ID1-ID2*\|\ *lon*/*lat*/*angle*\ [**+i**]

    可以通过以下三种方式指定旋转：

    * **方式 1：提供一个包含旋转参数的文件。**
        该文件必须为每个旋转提供一条记录，每条记录应遵循以下格式：
    
        *lon lat tstart [tstop] angle* [ *khat a b c d e f g df* ]
    
        其中：
    
        * *tstart* 和 *tstop* 为阶段（stage）的起止年龄（单位为百万年 Myr）；
        * *lon*、*lat* 和 *angle* 分别表示经度、纬度和旋转角度（单位为度）。
        * *tstart* 与 *tstop* 分别代表阶段的老端和年轻端。
        * 若记录中未给出 *tstop*，则该记录表示一次**总重建旋转（total reconstruction rotation）**，
        此时 *tstop* 默认设置为 0，并且文件中所有记录都不应再指定 *tstop*。
        * 如果旋转具有协方差矩阵 **C**，可通过方括号中的 9 个可选参数指定。
            此时 **C** = (*g* / *khat*) × [ *a b d; b c e; d e f ]，
            即 **C** 由三个行向量组成。
        * 若拟合旋转的自由度 (*df*) 为 0 或未给出，则默认设为 10000。
        * 空行或以 `#` 开头的行将被忽略。

    * **方式 2：提供两个构造板块 ID 组成的文件名（例如 PAC-MBL）。**
        此时程序将从 **GPlates 旋转数据库** 中提取相应的旋转记录。
        若未找到匹配的旋转数据，将返回错误。

    * **方式 3：直接指定经度、纬度和旋转角度。**
        即以 *lon*/*lat*/*angle* 的形式（单位为度，并用 `/` 分隔）给出单个总重建旋转。
        无论使用哪种方式，都可以在参数末尾追加 **+i**，表示需要对旋转进行**反转（invert rotation）**。

.. _-F:

**-F**\ *hs_file*\ [**+d**]  
    指定包含热点位置的文件。  
    该文件必须为每个热点包含一条记录，每条记录的格式如下：

    lon lat hs_abbrev hs_id r t_off t_on create fit plot name

    例如，夏威夷的记录可能为：

    205 20 HWI 1 25 0 90 Y Y Y Hawaii

    大多数应用仅需前四列，即最小热点信息记录。  
    - *hs_abbrev* 为最长 3 个字符的热点缩写；  
    - *hs_id* 为 1–32 的整数；  
    - *r* 为热点位置不确定性（单位 km）；  
    - *t_off* 与 *t_on* 表示热点的活动时间范围；  
    - *create*、*fit*、*plot* 为 Y/N，分别表示是否参与 ID 网格计算、是否用于旋转拟合、是否用于绘图；  
    - *name* 为最长 32 字符的热点名称。  

    空行与以 `#` 开头的记录将被忽略。  

    若附加 **+d**，则会查找名为 *hs_abbrev*\_drift.txt 的热点漂移表，  
    文件可位于当前目录、*hs_file* 所在目录或 GMT_DATADIR 指定路径中。  
    若找到该文件，则会按时间插值得到热点随时间的位置 [默认固定]。

可选选项
------------------

.. _-D:

**-D**\ *d_km*  
    设置流线采样间隔（单位 km）[默认 5]。

.. _-L:

**-L**\ [**l**\|\ **t**\|\ **w**\| **L**\|\ **T**\|\ **W**]  
    仅输出最近热点的最近接点（忽略 |-S|）。  
    选项说明：  
    - **-Lt** → (*time*, *dist*, *z*) [默认]  
    - **-Lw** → (*omega*, *dist*, *z*)  
    - **-Ll** → (*lon*, *lat*, *time*, *dist*, *z*)  

    *dist* 默认单位为 km；若使用大写修饰符 **TWL**，则 *dist* 单位为球面度。

.. _-N:

**-N**\ *upper_age*  
    设置延伸到最老阶段的最大时间 [默认不延伸]。

.. _-Q:

**-Q**\ *r/t*  
    输入文件仅包含 (*x*, *y*, *z*) 时，指定常数 *r* 与 *t* 值以补充每条记录。

.. _-S:

**-S**\ [*n_hs*]  
    设置需报告的最近热点数量 [默认 1]。

.. _-T:

**-T**  
    截断超过 |-N| 指定上限年龄的海山年龄 [默认不截断]。

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *maxdist*  
    仅报告流线与任意热点最近距离小于 *maxdist* 的海山 [默认报告所有海山]。

.. _-Z:

**-Z**  
    在输出记录中使用热点编号而非名称标签。

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_-Rgeo.rst_

大地坐标与地心坐标
--------

所有球面旋转操作都在地心坐标下进行。
这意味着输入的数据点和网格被视为大地坐标，需要首先转换为地心坐标；
旋转操作完成后，重建得到的点会再转换回大地坐标。
如果将椭球体设置参数 **PROJ_ELLIPSOID** 改为 *Sphere*，则可以跳过这种默认行为。


示例
--------

若要根据文件 *seamounts.txt* 中的 (*x, y, z, r, tc*) 点，  
使用 *DC85.txt* 欧拉极文件与 *pac_hs.txt* 热点列表，  
求每个海山最可能的两个热点来源，可运行::

    gmt originater seamounts.txt -S2 -EDC85.txt -Fpac_hs.txt > origins.txt

若要根据海山位置、观测年龄和旋转模型计算预测年龄与到最近热点的距离，可运行::

    echo "1.55 -8.43 52.3" | gmt originater -FONeill_2005_hotspots.txt \
  -EOMS2005_APM_fixed.txt -Q1/120 -Lt

其中 52.3 Ma 为观测年龄。输出为：70 -95.486 52.3。若使用移动热点模型，命令为::

    echo "1.55 -8.43 52.3" | gmt originater -FONeill_2005_hotspots.txt+d \
  -EOMS2005_APM_smooth.txt -Q1/120 -Lt

输出为：80 -213.135 52.3负距离表示最近接点位于热点以东。

备注
--------

GMT 内置 EarthByte 旋转模型 `Global_EarthByte_230-0Ma_GK07_AREPS.rot`。  
若需使用其他旋转文件，可设置环境变量 **GPLATES_ROTATIONS** 指向该文件。

相关模块
--------


:doc:`grdrotater`,  
:doc:`grdspotter`,  
:doc:`project`,  
:doc:`mapproject `,  
:doc:`backtracker`,  
:doc:`gmtpmodeler`,  
:doc:`grdpmodeler`,  
:doc:`grdrotater`,  
:doc:`hotspotter`

参考文献
--------

Wessel, P., 1999, "Hotspotting" tools released, EOS Trans. AGU, 80 (29), p. 319.
