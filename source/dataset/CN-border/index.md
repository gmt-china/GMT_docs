# CN-border: 中国国界省界数据

:贡献者: {{ 刘珠妹 }}, {{ 田冬冬 }}, {{ 陈箫翰 }}

---

GMT 自带的国界线数据不符合中国领土主张。例如，阿克赛钦地区、藏南地区边界均存在明显差异，
其他地方也存在微小差异。在正式出版的中外期刊上发表带有中国国界的地图时需要格外注意。
2017 年国家测绘地理信息局发布的
《[“问题地图”清查工作指南](https://www.nwafu.edu.cn/docs/2017-09/20170907152504884294.pdf)》
中列出了绘图中应避免的若干错误。下面列出了绘制中国全图时的常见注意事项：

- 阿克赛钦地区正确表示
- 藏南地区正确表示
- 钓鱼岛、赤尾屿位置正确
- 南海诸岛各岛点位置正确
- 台湾省底色设置与大陆一致

为了避免绘制错误国界带来的一系列问题，最简单的方法就是只绘制海岸线不绘制国界。
若必须绘制国界，用户需要自己准备符合要求的国界数据。
CN-border 是 GMT 中文社区为用户提供的一套基本准确的数字化的国界、省界数据。
即便正确绘制了国界、省界，所绘地图如果要在境内公开展示，依然需要审图。
个人没有提交审图申请的资格，需要付费，委托给有资质的企事业单位代为提交审图申请。

:::{admonition} 免责声明
本数据仅供科研用途使用。GMT 中文社区不保证数据完全准确或可通过地图审核。
欢迎用户共享更准确的国界数据。
:::

## 数据下载

- 项目主页： <https://github.com/gmt-china/china-geospatial-data>
- 下载地址： <https://github.com/gmt-china/china-geospatial-data/releases>

macOS/Linux 用户请下载数据 {file}`china-geospatial-data-UTF8.zip`（UTF8 编码），
Windows 用户请下载数据 {file}`china-geospatial-data-GB2312.zip`（GB2312 编码）。

数据包中提供了三个数据文件：

- {file}`CN-border-La.gmt`：中国国界、省界、十段线以及南海诸岛数据
- {file}`CN-border-L1.gmt`：中国国界、十段线以及南海诸岛数据，不含省界数据
- {file}`ten-dash-line.gmt`：仅十段线数据

## 示例图

使用等距圆锥投影（**-JD**）绘制中国国界省界数据：

```{eval-rst}
.. gmtplot:: CN-border-JD.sh
   :show-code: true
   :width: 75%
```

使用墨卡托投影（**-JM**）绘制中国国界省界数据：

```{eval-rst}
.. gmtplot:: CN-border-JM.sh
   :show-code: true
   :width: 75%
```

## 绘制中国及临国国界

中国国界数据 {file}`CN-border-La.gmt` 和 {file}`CN-border-L1.gmt` 只提供了中国的国界和省界信息。
若需要同时绘制中国以及邻国国界，则由于 CN-border 数据与 GMT 内置的 DCW 数据的国界不一致
而出现问题。

为了同时绘制中国以及邻国国界，需要先使用 CN-border 数据将中国区域裁剪出来，在使用 GMT 内置
DCW 数据时只绘制中国区域以外的部分。具体示例脚本如下：

```{eval-rst}
.. gmtplot:: CN-border-neighbouring-countries.sh
    :show-code: true
    :width: 90%
```

## 数据来源与处理

CN-border 原始数据来自于 [1:100 万全国基础地理数据库 (2021 版)](https://www.webmap.cn/commres.do?method=result100W)，
并由[刘珠妹](https://github.com/liuzhumei)处理得到 GMT 可使用的数据。
**具体数据处理方式待补充**。

## 数据引用

CN-border 原始数据来自于[全国地理信息资源目录服务系统](https://www.webmap.cn)，
其[版权声明](https://www.webmap.cn/main.do?method=otherService&clickFlag=copyright)中要求：

> 转载或引用本网站所有之内容须注明“转自（或引自）全国地理信息资源目录服务系统”字样，并标明本网网址 www.webmap.cn。
