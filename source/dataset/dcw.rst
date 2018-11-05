DCW: 世界数字图表
=================

DCW，全称 Digital Chart of the World，是一个内容广泛的数字地图，包含了行政边界、公路、铁路等等。
该数据于 2006 年免费公开，但 1992 年起就没有再更新过。
DCW 数据分为 2094 个区块，基本上一个区块代表 5 度 ×5 度的区域。
详细信息参考维基百科词条：`Digital Chart of the World <http://en.wikipedia.org/wiki/Digital_Chart_of_the_World>`_ 

这一节仅仅探讨其中行政边界的问题。
这里说的行政边界是指各大洲的边界，各个国家和地区的已定、未定的边界和一级行政区划的的边界。
所谓的一级行政区划是指一个国家最高级的行政划分区域，比如中国的省、自治区、直辖市和特别行政区，日本的都、道、府、县和西方国家的州。
下面为了叙述的简介，一级行政区划直接简称为省。国家和地区就简称为国家。

DCW-GMT
---------

DCW-GMT 是 DCW 的升级版，其特点在于：

#.  包含全球各国国界；
#.  包含部分国家的省界（目前只有 8 个比较大的国家，包括中国）；
#.  数据格式为 netCDF-4，可以直接在 GMT 中使用，也容易从中提取所需的边界数据；
#.  数据应该是比较新的，且有人维护，因而发现问题可以报告 Bug；

主页： <http://www.soest.hawaii.edu/wessel/dcw/>

GMT模块 `coast` 在使用 GSHHG 数据绘制国界（选项`-N1`）和省界（选项`-N2`）的时候无法选定特定的国家和省、州。
DCW-GMT 是为了解决这个问题而存在的，当你想绘制中国国界时，得到的就是干干净净的中国国界，而没有其他国家的国界的干扰。

DCW-GMT 包含了如下文件：

    .
    ├── COPYING.LESSERv3
    ├── COPYINGv3
    ├── dcw-countries.txt
    ├── dcw-gmt.nc
    ├── dcw-states.txt
    ├── LICENSE.TXT
    └── README.TXT

真正有用的文件包括 `dcw-countries.txt`、`dcw-gmt.nc`、`dcw-states.txt`。其中 dcw-gmt.nc 是 netCDF 格式的数据，其他两个 txt 文件为辅助文档。

dcw-contries
+++++++++++++

文件格式为 `大洲代码 国家代码 国家名` ，代码均为两位字符。
大洲代码包括 AF(非洲)、AN(南极洲)、AS(亚洲)、EU(欧洲)、OC(大洋洲)、NA(北美洲) 和 SA(南美洲)。
这个文件是 GMT 绘制国界时需要查找的文件，同时也是用户绘图边界时需要参考的文件。该文件共计 250 个国家。文件内容大致如下：

    AS BH Bahrain
    AS BN Brunei
    AS BT Bhutan
    AS CN China
    AS CX Christmas Island
    AS GE Georgia
    AS HK Hong Kong
    AS HM Heard Island and McDonald Islands
    AS ID Indonesia
    AS IL Israel
    AS IN India

dcw-states
+++++++++++++

文件格式为 `国家代码 省代码 省名`。
国家代码为两位，与 dcw-contries.txt 中对应。中国的省代码是数字，和中国居民身份证号码相同。
目前有 AR(阿根廷)、AU(澳大利亚)、BR(巴西)、CA(加拿大)、US(美国)、CN(中国)、IN(印度)、RU(俄罗斯) 八个国家的省界数据。

中国的数据，包括全部 34 个省级行政区域：23 个省（包括台湾省），5 个自治区，4 个直辖市，以及香港，澳门 2 个特别行政区。

    CN 11 Beijing
    CN 50 Chongqing
    CN 31 Shanghai
    CN 12 Tianjin
    CN 34 Anhui
    CN 35 Fujian
    CN 62 Gansu
    CN 44 Guangdong
    CN 52 Guizhou
    CN 46 Hainan
    CN 13 Hebei
    CN 23 Heilongjiang
    CN 41 Henan
    CN 42 Hubei
    CN 43 Hunan
    CN 32 Jiangsu
    CN 36 Jiangxi
    CN 22 Jilin
    CN 21 Liaoning
    CN 63 Qinghai
    CN 61 Shaanxi
    CN 37 Shandong
    CN 14 Shanxi
    CN 51 Sichuan
    CN 71 Taiwan
    CN 53 Yunnan
    CN 33 Zhejiang
    CN 45 Guangxi
    CN 15 Nei Mongol
    CN 64 Ningxia
    CN 65 Xinjiang
    CN 54 Xizang
    CN 91 Xianggang (Hong Kong)
    CN 92 Aomen (Macao)

如何使用 DCW 数据
-------------------

GMT 中，通过 `coast` 模块的 `-E` 选项调用 DCW 数据来绘制国界和省界。

    -Ecode1,code2,...[+l|L][+gfill][+ppen]

-.   `code1,code2,...` 为大洲、国家和省代码，用于设定要绘制边界的大洲、国家和省。
-.   大洲的 code 格式为大洲的代码前加 `=` 号，比如亚洲的 code 为 `=AS`
-.   国家的 code 格式直接就是国家代码，比如英国的 code 为 `GB`，即 Great Britain 的缩写
-.   省的 code 格式为 `country.state`，比如美国 Texas 州的 code 为 `US.TX`
-.   追加 **+l** 会列出国家名以及国家代码，不提取数据，也不绘图。（没试出效果）
-.   追加 **+L** 会列出州 / 省名，以及代码，只受用于美国、加拿大、巴西、澳大利亚和阿根廷
-.   追加 **+p***pen * 指定边界的线条属性；追加 **+g***fill * 指定填充属性。**如果是要画图，而不是输出数据（-M 选项），则 +p 和 +g 至少要选一个**
-.   一条命令可以出现多次 `-E` 选项


例 1
++++

绘制 - R70/150/10/60 范围内的全部亚洲国家的边界::

    $ gmt coast -R70/150/10/60 -JM20c -Baf -E=AS+p0.25p,red -png dataset_dcw_01

.. figure:: /images/dataset_dcw_01.png
   :width: 100%
   :align: center

例 2
++++

绘制中国大陆边界（不含台湾、香港、澳门），这里可以不使用 `-R` 选项::

    $ gmt coast -JM20c -Baf -ECN+p0.25p,red -png dataset_dcw_02

.. figure:: /images/dataset_dcw_02.png
   :width: 100%
   :align: center

例 3
++++

绘制内蒙古，并修改边界和填充颜色::

    $ gmt coast -JM20c -Baf -ECN.15+p1p,blue+gred -png dataset_dcw_03

.. figure:: /images/dataset_dcw_03.png
   :width: 100%
   :align: center

例 4
++++

导出内蒙古的边界数据::

    $ gmt pscoast -ECN.15 -M > neimenggu.dat

这里只需要使用 `-M` 选项即可。

例 5
++++

这个例子算是一个相对比较完整的中国地图，包含了必要的省界信息。

.. code-block:: bash

    #!/bin/bash

    gmt begin dataset_dcw_04 png
    for code in 11 12 13 14 15 21 22 23 31 32 33 34 35 36 37 41 42 43 44 45 46 50 51 52 53 54 61 62 63 64 65 71 91 92;
    do
        gmt coast -JM20c -R70/140/15/55 -Baf -ECN.$code+p1p,blue+gred
    done
    gmt end

.. figure:: /images/dataset_dcw_04.png
   :width: 100%
   :align: center

目前，中国政府尚未恢复对藏南、台澎金马和南海部分岛屿行使主权。
然而 DCW 一流的开放数据通常以实际控制为标准，所以将上述区域从中国划了出去。
另外，国界线可能发生变化，而数据没有更新。
比如与俄罗斯确定东部国界后，中国收回了半个黑瞎子岛，但这些数据还没有来得及更新。
国家的边界是一个国家主权的象征。
这些问题非常敏感，笔者的态度和中国政府保持一致，然而无力修复这些问题。

**我们在这里展示国界的初衷仅仅是使用数据的例子，这些地图不能作为划界的依据，也不代表笔者的政治观点。**