DCW: 世界数字图表
=================

DCW，全称 Digital Chart of the World，是一个内容广泛的数字地图，包含了国界、公路、铁路等等。
该数据于 2006 年免费公开，但是 1992 年起就没有再更新过。
DCW 数据被分为 2094 个区块，基本上一个区块代表 5 度 ×5 度的区域。DCW 数据中包含了国界、公路、铁路等等。
详细信息参考维基百科词条：[Digital Chart of the World](http://en.wikipedia.org/wiki/Digital_Chart_of_the_World)

DCW-GMT
-----------------

DCW-GMT 是 DCW 的升级版，其特点在于：

-   包含全球各国国界；
-   包含部分国家的省界（目前只有 8 个比较大的国家，包括中国）；
-   数据格式为 netCDF-4，可以直接在 GMT 中使用，也容易从中提取所需的边界数据；
-   数据应该是比较新的，且有人维护，因而发现问题可以报告 Bug；

主页： <http://www.soest.hawaii.edu/wessel/dcw/>

为什么又是国界呢？
在 GMT 中，可以用 `coast` 的 `-N1` 选项来绘制国界， `-N2` 选项来绘制省界（仅美国、加拿大等国）。
这样绘制的国界有什么问题呢？比如，设定绘图区域为中国，然后使用 `coast -N1` 加入国界，得到的结果里将不仅仅是中国的国界，还有俄罗斯、日本、印度等的国界。
即 GSHHG 的国界数据是完全的，但是并不能区分每段数据属于哪个国家。
DCW-GMT 是为了解决这个问题而存在的，当你想绘制中国国界时，得到的就是干干净净的中国国界，而没有其他国家的国界的干扰。
不过，其数据本身并不完全符合中国政府的领土主张。

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
+++++++++++++++++++

文件格式为 `大洲代码 国家、地区代码 国家地区名` ，代码均为两位字符。
大洲代码包括 AF(非洲)、AN(南极洲)、AS(亚洲)、EU(欧洲)、OC(大洋洲)、NA(北美洲) 和 SA(南美洲)。
国家、地区代码就更多了，比如中国大陆是 CN。
这个文件是 GMT 绘制国界时需要查找的文件，同时也是用户绘图边界时需要参考的文件。该文件共计 250 个国家、地区。文件内容大致如下：

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
++++++++++++++++++++

文件格式为 `国家、地区代码 省、州代码 省名`。国家代码为两位，与 dcw-contries.txt 中对应。中国的省代码是数字，和中国居民身份证号码相同。
目前有 AR(阿根廷)、AU(澳大利亚)、BR(巴西)、CA(加拿大)、US(美国)、CN(中国)、IN(印度)、RU(俄罗斯) 共计八个国家的省、州界数据。

只关心中国的数据，包括全部 34 个省级行政区域：23 个省（包括台湾省），5 个自治区，4 个直辖市，以及香港，澳门 2 个特别行政区。

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

GMT 中，通过 `coast` 模块的 `-F` 选项调用 DCW 数据来绘制国界和省界。
