.. index:: ! gmt2kml
.. include:: common_SYN_OPTs.rst_

gmt2kml
=============

:贡献者: |何星辰|
:最近更新日期: 2025-10-20

----

:官方文档: :doc:`gmt:gmt2kml`  
:简介: 将 GMT 数据表转换为 Google Earth KML 文件

**2kml** 读取一个或多个 GMT 表格文件，并将它们转换为使用
Google Earth KML 格式的单个输出文件。
数据可以表示点、线、面或波动，你可以指定额外属性，如标题、海拔模式、颜色、笔宽、透明度、
区域以及数据描述。还可以将特征延伸到底面（假设高于地面），并为点符号使用自定义图标。
最后，可以根据细节等级设置、海拔、区域控制可见性，包括在 Google Earth 加载时的状态，
以及随缩放变化的淡入淡出效果。输入文件应包含以下列：

*lon* *lat* [ *alt* ] [ *timestart* [ *timestop* ] ]

其中 *lon* 和 *lat* 对所有特征都是必需的，*alt* 对所有特征都是可选的
（参见 |-A| 和 |-C|），*timestart* 和 *timestop* 适用于事件和时间跨度特征。
对于波动，*alt* 列是必需的，但应表示沿轨迹的数据异常，例如重力、磁力等。
这些值将被缩放以产生沿线的偏移距离（以度为单位）。

语法
--------

**gmt 2kml** [ *table* ]
[ |-A|\ **a**\|\ **g**\|\ **s**\ [*alt*\|\ **x**\ *scale*] ]
[ |-C|\ *cpt* ]
[ |-D|\ *descriptfile* ]
[ |-E|\ [**+e**][**+s**] ]
[ |-F|\ **e**\|\ **l**\|\ **p**\|\ **s**\|\ **t**\|\ **w** ]
[ |-G|\ [*color*]\ [**+f**\|\ **n**] ]
[ |-I|\ *icon* ]
[ |-K| ]
[ |-L|\ *name1*,\ *name2*,... ]
[ |-N|\ [**t**\|\ *col*\|\ *name\_template*\|\ *name*] ]
[ |-O| ]
[ |-Q|\ **a**\|\ **i**\|\ **s**\ *arg* ]
[ |-R|\ **e**\|\ *w/e/s/n* ]
[ |-S|\ **c**\|\ **n**\ *scale*] ]
[ |-T|\ *title*\ [/*foldername*] ]
[ |SYN_OPT-V| ]
[ |-W|\ [*pen*][*attr*] ]
[ |-Z|\ [**+a**\ *alt_min/alt_max*]\ [**+f**\ *minfade/maxfade*]\ [**+l**\ *minLOD/maxLOD*]\ [**+o**][**+v**] ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]
[ > *output.kml* ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

.. include:: explain_intables.rst_

可选选项
------------------

.. _-A:

**-A**\ **a**\|\ **g**\|\ **s**\ [*alt*\|\ **x**\ *scale*]
    选择 Google Earth 认可的三种海拔模式之一，确定特征的高度（以米为单位）：
    **a** 绝对高度，**g** 相对地面高度，**s** 相对海底高度。
    要将特征绘制在固定海拔上，可附加高度 alt（单位：米）。
    使用 0 可将特征固定在选定参考面。或者附加  **x**\ *scale*  来按该比例缩放输入文件中的海拔。
    如果未附加值，则海拔（米）从输入文件第 3 列读取。[默认情况下，特征固定在海面或地面]。

.. _-C:

**-C**\ *cpt*
    使用 CPT 为符号、事件或时间跨度图标分配颜色，基于输入文件第 3 列的值。
    对于线或面，我们检查段头的 -Z<value> 声明，并通过 CPT 查找获取颜色。
    注意，仅可使用离散颜色。

.. _-D:

**-D**\ *descriptfile*
    包含 HTML 片段的文件，将作为 KML 文件的主要描述内容的一部分包含进去 [无描述]。
    参见 SEGMENT INFORMATION 下的特定特征描述。

.. _-E:

**-E**\ [**+e**][**+s**]
    控制线和面的 Google Earth 渲染方式。附加 **+e** 将特征延伸至地面 [默认不延伸]。
    附加 **+s** 用直线连接点（可能穿过地球表面并不可见） [铺设到表面]。

.. _-F:

**-F**\ **e**\|\ **l**\|\ **p**\|\ **s**\|\ **t**\|\ **w**
    设置特征类型。输入文件前两列应为 (*lon*, *lat*)。当需要高度或值（
    即未使用 |-A| 给出高度，或 |-C| 设置）时，
    第 3 列需要包含 altitude 或 value。选择以下指令：

    - **e**\ vent: 仅在特定 *time* 可见的符号，时间在下一列给出。
    - **l**\ ine: 使用 |-W| 设置的属性绘制线。
    - **p**\ olygon: 使用 |-G| 和 |-W| 设置的属性绘制面。
    - **s**\ ymbol: 永远可见的普通符号。
    - **t**\ imespan: 仅在下一两列指定的时间段内激活的符号（含 *timestart*, *timestop*）。使用 NaN 表示无限时间范围。
    - **w**\ iggle: 第 3 列必须包含数据异常。如果还需要绘制轨迹本身，则单独使用 **-Fl**。参见 |-Q| 获取附加参数。

    **注意**：如果使用时间，格式应为 ISO yyyy-mm-ddThh:mm:ss[.xxx] 或 
    GMT 相对时间格式（参见 **-f**）。对于指令 **e**\|\ **s**\|\ **t**，
    符号通过 |-I| 设置。


.. _-G:

**-G**\ [*color*]\ [**+f**\|\ **n**]
    设置填充颜色（**+f**，默认）或标签字体颜色（**+n**）。
    填充颜色应用于符号、延伸、面和正异常波动 [默认为 75% 透明浅橙色]。
    使用 **-G+f** 可关闭填充。文本标签：指定字体颜色 [默认白色]，
    使用 **-G+n** 可禁用标签。

.. _-I:

**-I**\ *icon*
    指定用于符号的替代图标 URL [默认 Google Earth 圆形]。若 URL 以 + 开头，
    则在名称前加 ``http://maps.google.com/mapfiles/kml/``。
    若完全关闭图标（例如只想使用文本标签），使用 **-I-**。

.. _-K:

**-K**
    允许后续追加更多 KML 代码 [完成 KML 文件]。

.. _-L:

**-L**\ *name1*,\ *name2*,...
    扩展数据。附加一列或多列名称，用逗号分隔。我们期望输入文件中存在对应数据列，
    并在 KML 文件中作为 Extended Data 编码，
    在 Google Earth 中选择项目时可在气球显示属性。
    如果可用数值列比扩展数据少 1，则将剩余文本作为最后一列扩展数据；
    否则，将文本拆分为单词作为单独列。

.. _-N:

**-N**\ [**t**\|\ *col*\|\ *name\_template*\|\ *name*]
    默认情况下，如果段头包含 **-L**"label string"，
    将用作 KML 特征名称（面、线段或符号集合）。
    默认名称为 "Line %d" 或 "Point Set %d"。每个点将按段名加序号命名。可选：


    1. *col*：从数据列格式化为字符串作为符号标签  
    2. **t**：用每条记录的尾随文本作为标签（仅 ASCII 文件可用）  
    3. 自定义字符串含 %d，为每个特征生成唯一编号  
    4. 无参数关闭符号标签，线段仍有名称


.. _-O:

**-O**
    将 KML 代码追加到现有 KML 文件 [初始化新文件]。

.. _-Q:

**-Qa**\|\ **i**\|\ **s**\ *arg*
    波动绘图可重复选项（需 **-Fw**）。控制正波动指向：
    - **-Qa**：附加方位角，定义正异常指向半圆  
    - **-Qi**：固定方位角  
    - **-Qs** *scale*：波动缩放（z 单位/地图度数）


.. _-R:

**-Re**\|\ *w/e/s/n*
    发出单个区域标签。附加 w/e/s/n 设置特定区域（忽略区域外点），
    或附加 **e** 自动确定数据域 [默认不发区域标签]。

.. _-S:

**-S**\ **c**\|\ **n**\ *scale*
    缩放图标或标签。**-Sc** 缩放符号图标，**-Sn** 缩放名称标签 [默认 1]。

.. _-T:

**-T**\ *title*\ [/*foldername*]
    设置文档标题 [默认未设置]。可附加 /*FolderName* 将特征分组到 KML 文件内文件夹。
    默认文件夹名为 "*Name* Features"。

.. include:: explain_-V.rst_

.. _-W:

**-W**\ [*pen*][*attr*] :ref:`(more ...) <-Wpen_attrib>`
    设置线、波动或面轮廓的笔属性 [默认：宽 0.25p, 颜色黑, 样式实线]。
    附加 **+cl** 从 CPT 获取颜色，**+cf** 从 CPT 设置符号填充，**+c** 两者皆用。
    KML 中笔宽以像素为单位。

.. _-Z:

**-Z**\ [**+a**\ *alt_min/alt_max*]\ [**+f**\ *minfade/maxfade*]\ [**+l**\ *minLOD/maxLOD*]\ [**+o**][**+v**]
    设置 Document 和 Region 标签属性。**+a** 设置可见高度范围，
    **+f** 设置淡入淡出范围， **+l** 设置细节等级范围（lod_max=-1 表示无限可见）
    ， **+o** 加载时打开文档， **+v** 加载时隐藏特征。

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
--------

.. include:: explain_example.rst_

要根据远程文件 @kml_pointsets.txt 的 CPT 绘制彩色符号，先生成 CPT，再创建 KML 文件::

    gmt makecpt -Ccategorical > categories.cpt
    gmt 2kml @kml_pointsets.txt -Ccategories.cpt > points.kml

将包含点位置 (*lon, lat*) 的文件转换为红色圆形符号的 KML 文件，尝试::

    gmt 2kml mypoints.txt -Gred+f -Fs > mypoints.kml

将多段线文件（*lon, lat*）转换为 KML，段头含 **-L** 标签，
使用粗白笔，并设置文档标题，尝试::

    gmt 2kml mylines.txt -Wthick,white -Fl -T"Lines from here to there" > mylines.kml

将多段面文件转换为 KML，段头含 **-L** 标签，使用粗黑笔和半透明黄色填充，
设置文档标题，并指定区域限制，尝试::

    gmt 2kml mypolygons.txt -Gyellow@50+f -Fp -T"My polygons" -R30/90/-20/40 > mypolygons.kml

将包含点位置 (*lon, lat, time*) 的文件转换为绿色圆形符号 KML 文件，
符号将在指定时间激活并一直显示，尝试::

    awk '{print $1, $2, $3, "NaN"}' mypoints.txt | gmt 2kml -Ggreen+f -Ft > mytimepoints.kml

从网格 temp.nc 中提取每 10 单位的等值线和标签，并以 75% 透明红色线和红色标签（不透明）绘制 KML，尝试::

    gmt grdcontour temp.nc -Jx1id -A10+tlabel.txt -C10 -Dcontours.txt
    gmt 2kml    contours.txt -Fl -W1p,red@75 -K > contours.kml
    gmt 2kml    -O -Nt -Fs -Sn2 -Gred@0+n label.txt -I- >> contours.kml

将等值线绘制为线并使用 CPT 文件 contours.cpt 上色，尝试::

    gmt 2kml contours.txt -Fl -Ccontours.cpt > contours.kml

沿轨迹绘制磁异常波动，正异常为橙色，波动线为 2p 黑色笔，
将磁异常（nT）缩放为地图上 1nm 对应 50 nT，并将波动置于海面 50m 以上，尝试::

    gmt 2kml magnetics_lon_lat_mag.txt -Fw -Gorange+f -W2p -Ag50 -Qs50n > wiggles.kml

局限
--------

Google Earth 在跨经线绘制填充面时存在问题。
目前必须手动将跨越日期变更线的多边形分成西、
东两部分并分别绘制。Google Earth 还有其他文件大小或线长的限制，未记录。
如特征未显示且无错误，可尝试通过拆分文件减小大小。

构建 KMZ 文件
-------------

使用 KMZ 格式更优，因为占用空间小。KMZ 是 KML 文件及其引用的图像、图标或数据文件的压缩包。
可将大数据集分组到 Folders 中。Document 可包含任意数量文件夹。
可用脚本和 **-K**、|-O| 选项创建复合 KML 文件。参见 |-T| 了解文件夹/文档切换。
gmt_shell_scripts.sh 中的 gmt_build_kmz 可协助将多个
KML 文件（及引用图片）打包为 KMZ 文件。
需先 source gmt_shell_scripts.sh。

KML 层级
--------

GMT 按特征类型（使用 |-O|、|-K| 或 **-T/**\ *foldername*）、
输入文件（非标准输入时）及线段（段头名称或 |-N|）将特征存入层级文件夹。
在 Google Earth 中可方便切换文档内容。示例：

[ KML header information; not present if |-O| was used ]

<Document><name>GMT Data Document</name>

<Folder><name>Point Features</name>

<!--This level of folder is inserted only when using -O, -K>

<Folder><name>file1.txt</name>

<!--One folder for each input file (not when standard input)>

<Folder><name>Point Set 0</name>

<!--One folder per line segment>

<!--Points from the first line segment in file file1.txt go here>

<Folder><name>Point Set 1</name>

<!--Points from the second line segment in file file1.txt go here>

</Folder>

</Folder>

<Folder><name>Line Features</name>

<Folder><name>file1.txt</name>

<!--One folder for each input file (not when standard input)>

<Placemark><name>Line 0</name>

<!--Here goes the first line segment>

</Placemark>

<Placemark><name>Line 1</name>

<!--Here goes the second line segment>

</Placemark>

</Folder>

<Folder>

</Document>

[ KML trailer information; not present if |-K| was used ]

分段信息
--------

**2kml** 会扫描段头中 **-L**"*some label*\ " [参见 |-N|] 和
**-T**"*some text description*\ "。如存在，将解析为当前特征的名称和描述标签。

相关模块
--------

:doc:`gmt_shell_functions.sh`,
:doc:`grd2kml`,
:doc:`img2google`,
:doc:`kml2gmt`,
:doc:`psconvert`
