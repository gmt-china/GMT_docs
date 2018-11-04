DCW: 世界数字图表
=================

DCW，全称 Digital Chart of the World，是一个内容广泛的数字地图，包含了国界、公路、铁路等等。
该数据于 2006 年免费公开，但是 1992 年起就没有再更新过。
DCW 数据分为 2094 个区块，基本上一个区块代表 5 度 ×5 度的区域。
详细信息参考维基百科词条：[Digital Chart of the World](http://en.wikipedia.org/wiki/Digital_Chart_of_the_World)

DCW-GMT
-----------------

DCW-GMT 是 DCW 的升级版，其特点在于：

-   包含全球各国国界；
-   包含部分国家的省界（目前只有 8 个比较大的国家，包括中国）；
-   数据格式为 netCDF-4，可以直接在 GMT 中使用，也容易从中提取所需的边界数据；
-   数据应该是比较新的，且有人维护，因而发现问题可以报告 Bug；

主页： <http://www.soest.hawaii.edu/wessel/dcw/>

GMT模块 `coast` 在使用 GSHHG 数据绘制国界（选项`-N1`）和省界（选项`-N2`）的时候无法选定特定的国家和省、州。
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

文件格式为 `大洲代码 国家代码 国家名` ，代码均为两位字符。
这里所说的国家不一定是主权国家，也可能是地区，比如香港。
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
++++++++++++++++++++

文件格式为 `国家代码 省代码 省名`。这里所说的省是各个国家的一级行政区划，不一定是省，也可能是西方国家的州和日韩的道。
国家代码为两位，与 dcw-contries.txt 中对应。中国的省代码是数字，和中国居民身份证号码相同。
目前有 AR(阿根廷)、AU(澳大利亚)、BR(巴西)、CA(加拿大)、US(美国)、CN(中国)、IN(印度)、RU(俄罗斯) 共计八个国家的省界数据。

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

    -Fcode1,code2,...[+l|L][+gfill][+ppen][+r|R[incs]]

-   想要绘制某个或某些国家的边界，可以使用 `code1,code2,...` 来选定，其中每个 code 代表不同的国家 2 位代码，用逗号分隔。
-   如果想要选择某个国家的某个省的边界，则 code 应该为 `country.state` 的格式，比如 `US.TX` 代表美国的 Texas 州。
-   如果想要选定整个大洲，则需要在洲代码 **前面** 加上等号，比如 `code` 为 `=AF` 则表示选择整个非洲的数据；
-   追加 **+l** 会列出国家名以及国家代码，不提取数据或绘图。（没试出效果）
-   追加 **+L** 会列出州 / 省名，以及代码；
-   追加 **+r** 会计算当前选择的边界数据的范围，并返回该范围；还可以加入 xinc/yinc 或者 winc/einc/sinc/ninc 来指定 - B 选项；（没理解）
-   追加 **+R** 会计算当前选择的边界数据的范围，并向外扩展 incs 的范围；（没理解）
-   追加 **+p***pen * 指定边界的线条属性；
-   追加 **+g***fill * 指定填充属性；
-   一条命令中只能出现一次 `-F` 选项，如有特殊需求，需多次调用 pscoast；
-   还有一些更复杂的规则，有些乱。。

例 1
+++++++++++++

绘制 - R70/150/10/60 范围内的全部亚洲国家的边界:

    gmt pscoast -R70/150/10/60 -JM20c -B10 -F=AS -U > asia.ps

![](/images/2013112103.jpg)

## 例 2
+++++++++++++

绘制中国大陆边界（不含台湾、香港、澳门）:

    gmt coast -B10 -R70/150/10/60 -JM20c -FCN -U -pdf china_mainland

![](/images/2013112104.jpg)

## 例 3
+++++++++++++

绘制内蒙古，并修改边界和填充颜色:

    gmt coast -B10 -R70/150/10/60 -JM20c -FCN.15+p1p,blue+gred -pdf neimenggu

![](/images/2013112105.jpg)

## 例 4
+++++++++++++

导出中国内蒙古的边界数据:

    gmt coast -FCN.15 -M -V > neimenggu.dat

这里只需要使用 `-M` 选项即可。

## 例 5
+++++++++++++

这个例子算是一个相对比较完整的中国地图，包含了必要的省界信息。

``` bash
#!/bin/bash

gmt begin pdf china
for code in 11 12 13 14 15 21 22 23 31 32 33 34 35 36 37 41 42 43 44 45 46 50 51 52 53 54 61 62 63 64 65 71 91 92;
do
    gmt coast -JM20c -R70/150/15/55 -B10 -FCN.$code
done
gmt end
```

![](/images/2013112106.jpg)

