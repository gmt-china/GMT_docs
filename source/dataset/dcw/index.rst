DCW: 世界数字图表
=================

.. figure:: dcw.*
   :width: 75%
   :align: center

   DCW: 世界数字图表

**DCW数据主页**： http://www.soest.hawaii.edu/wessel/dcw/

DCW，全称为 Digital Chart of the World，即世界数字图表。
GMT提供的DCW数据是在原始DCW数据的基础上修改得到的，其中包含了如下行政边界数据：

#.  七大洲的洲界
#.  全球250个国家或地区的边界
#.  8个大国的省界/州界

.. warning::

    DCW数据提供的中国国界数据不符合中国的领土主张，在正式刊物中发表使用此类国界
    数据的图件时都可能存在问题。

GMT的 :doc:`/module/coast` 模块可以直接绘制DCW数据中提供的行政边界数据，
也可以使用 :doc:`/module/coast` 的 **-M** 选项将边界数据导出为纯文本文件
供其它程序使用。除此之外，DCW数据中的信息也可以直接用在 **-R** 选项中以通过
区域代码的方式指定绘图范围。

GMT提供的DCW数据默认位于GMT安装目录下的 **share/dcw** 下，其中主要包含了三个文件：

- :file:`dcw-gmt.nc`: netCDF格式的DCW数据
- :download:`dcw-countries.txt`: 辅助文件，内含国家代码
- :download:`dcw-states.txt`: 辅助文件，内含省界代码

区域代码
--------

为了绘制某个特定行政区域的边界，首先需要知道这些行政区域的代码。

洲代码
++++++

七大洲都有各自的代码，其代码分别为:

- **AF**: 非洲（Africa）
- **AN**: 南极洲（Antarctica）
- **AS**: 亚洲（Asia）
- **EU**: 欧洲（Europe）
- **OC**: 大洋洲（Oceania）
- **NA**: 北美洲（North America）
- **SA**: 南美洲（South America）

国家代码
++++++++

每个国家都有一个国家代码，国家代码可以从如下三个途径查找：

#. 在维基百科页面 `ISO Country Codes <https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2>`_ 中查找
#. 使用命令 ``gmt coast -E+l`` 查看国家代码列表
#. 从DCW辅助文件 :download:`dcw-countries.txt` 中查找，其文件格式为::

    洲代码 国家代码 国家名

该文件共计约 250 个国家。文件内容大致如下::

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

其中可以看到，中国的国家代码为 **CN**。

省/州代码
+++++++++

目前有如下八个国家的省界/州界数据：

- **AR**: 阿根廷
- **AU**: 澳大利亚
- **BR**: 巴西
- **CA**: 加拿大
- **US**: 美国
- **CN**: 中国
- **IN**: 印度
- **RU**: 俄罗斯

省代码可以从 DCW 辅助文件 :download:`dcw-states.txt` 中查找到，其文件格式为::

    国家代码 省代码 省名

使用 ``gmt coast -E+L`` 命令可以列出 DCW 数据中的所有省代码。如果想进一步筛选出
某个国家（以中国 **CN** 为例）的省代码，则可以使用 ``gmt coast -E+L | grep CN`` 命令。

以中国的数据为例，其包括全部 34 个省级行政区域：23 个省（包括台湾省），
5 个自治区、4 个直辖市以及 2 个特别行政区（香港、澳门）。
每个省用两个字符表示（如 AH 表示安徽）::

    CN.AH	Anhui
    CN.BJ	Beijing
    CN.CQ	Chongqing
    CN.FJ	Fujian
    CN.GD	Guangdong
    CN.GS	Gansu
    CN.GX	Guangxi
    CN.GZ	Guizhou
    CN.HA	Henan
    CN.HB	Hubei
    CN.HE	Hebei
    CN.HI	Hainan
    CN.HK	Xianggang (Hong Kong)
    CN.HL	Heilongjiang
    CN.HN	Hunan
    CN.JL	Jilin
    CN.JS	Jiangsu
    CN.JX	Jiangxi
    CN.LN	Liaoning
    CN.MO	Aomen (Macao)
    CN.NM	Nei Mongol
    CN.NX	Ningxia
    CN.QH	Qinghai
    CN.SC	Sichuan
    CN.SD	Shandong
    CN.SH	Shanghai
    CN.SN	Shaanxi
    CN.SX	Shanxi
    CN.TJ	Tianjin
    CN.TW	Taiwan
    CN.XJ	Xinjiang
    CN.XZ	Xizang
    CN.YN	Yunnan
    CN.ZJ	Zhejiang

使用说明
--------

GMT中至少有两处会使用DCW数据：

#. :doc:`-R 选项 </option/R>` 中可以直接使用区域代码以间接指定绘图范围
#. :doc:`/module/coast` 模块 **-E**\ *code1*,\ *code2*,... 选项调用 DCW 数据绘制或导出国界/省界

洲代码、国家代码和省代码都由两个字符构成，为了避免可能的冲突，GMT通过如下方式区分：

-   在洲代码前加上 **=** 号表示某个大洲，比如 **=AS** 表示亚洲
-   国家代码不需要做任何处理格式，比如 **GB** 表示英国
-   省代码的格式为 *country*.\ *state*，即必须在省代码前加上国家代码才可以，比如 **US.TX** 表示美国 Texas 州

使用示例
--------

绘制洲界
++++++++

绘制主要大洋洲国家的边界：

.. gmtplot::
   :width: 60%

   gmt coast -R100/190/-50/10 -JM12c -Baf -E=OC+p0.25p,red -png dataset_dcw_01

绘制国界
++++++++

绘制澳大利亚边界：

.. gmtplot::
   :width: 60%

   gmt coast -JM12c -Baf -EAU+p0.25p,red -png dataset_dcw_02

绘制省/洲界
+++++++++++

绘制澳大利亚昆士兰州(Queensland)，并设置边界颜色和填充颜色。其中 **-R** 选项后
跟区域代码 **AU.QLD** 可间接指定该区域范围， **+R2** 表示在原有范围外扩大2度:

.. gmtplot::
   :width: 60%

   gmt coast -RAU.QLD+R2 -JM12c -Baf -EAU.QLD+p1p,blue+gred -png dataset_dcw_03

导出省/洲界数据
+++++++++++++++

导出昆士兰州的边界数据::

    gmt coast -EAU.QLD -M > Queensland.dat

这里只需要使用 **-M** 选项即可。
