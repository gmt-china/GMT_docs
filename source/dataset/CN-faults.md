# CN-faults: 中国断层数据

:贡献者: {{ 刘珠妹 }}, {{ 田冬冬 }}, {{ 陈箫翰 }}

---

CN-faults 数据来自于中国活断层数据库2023版（CAFDv2023），
于2024年7月由中国地震局地质研究所徐锡伟研究团队发布。
该数据库基于约110个活动断层测绘项目和20个城市地区活动断层勘探项目成果汇编更新而成，
反映了中国及邻区活断层调查综合成果。 CAFD（2023）是对第五代区划图成果CAFD(2015)的更新版本。

## 数据下载

- 项目主页： <https://github.com/gmt-china/china-geospatial-data>
- 下载地址： <https://github.com/gmt-china/china-geospatial-data/releases>

macOS/Linux 用户请下载数据 {file}`china-geospatial-data-UTF8.zip`（UTF8 编码），
Windows 用户请下载数据 {file}`china-geospatial-data-GB2312.zip`（GB2312 编码）。

数据包中的数据文件 {file}`CN-faults.gmt` 即为中国区域主要断层。

## 示例图

### 绘制全国断层

```{eval-rst}
.. gmtplot::
   :show-code: true
   :width: 75%

    gmt begin CN-faults
        gmt coast -JM15c -RCN -Baf -W0.5p,black -A10000
        gmt plot CN-faults.gmt -W1p,red
    gmt end show
```

### 绘制区域断层

```{eval-rst}
.. gmtplot::
   :show-code: true
   :width: 50%

    gmt begin CN-regional-faults
        gmt basemap -JM15c -R95/105/25/35 -Baf
        gmt plot CN-faults.gmt -W1p,red
    gmt end show
```

### 标注断层名

可以使用 {doc}`/module/plot` 模块的 **-Sq** 选项标注断层名。

```{eval-rst}
.. gmtplot::
    :show-code: true
    :width: 50%

    gmt begin CN-faults-labeling png
        # 设置中文字体配置文件 cidfmap 的目录，Windows 下无需此设置
        gmt set PS_CONVERT="C-I${HOME}/.gmt"
        # GMT 处理中文存在一些已知 BUG
        # 需要设置 PS_CHAR_ENCODING 为 Standard 以绕过这一BUG
        gmt set PS_CHAR_ENCODING Standard
        gmt coast -JM10c -RTW -Baf -W0.5p,black
        # -aL="断层名称": set the "L" value (i.e., label) in segment headers using "断层名称"
        # :+Lh: take the label text from the "L" value in the segment header
        gmt convert CN-faults.gmt -aL="断层名称" | gmt plot -Sqn1:+Lh+f6p,39
    gmt end show
```

### 根据属性信息提取数据

可以使用 **convert** 模块的 **-S** 选项提取指定属性的数据。
例如，下例中提取出“断层名称”为“红河断裂”的断层数据。

```{eval-rst}
.. gmtplot::
   :show-code: true
   :width: 50%

    gmt begin CN-single-fault png
        gmt basemap -R98/105/22/27 -JM15c -Ba
        # -S: output record contains specified field attribute
        gmt convert CN-faults.gmt -S"断层名称=红河断裂" | gmt plot
    gmt end show
```

### 根据空间范围提取数据

{doc}`/module/gmtselect` 模块，可实现矩形范围、缓冲区范围和多边形范围内空间数据的提取。
此处仅以缓冲区范围为例。

```{eval-rst}
.. gmtplot::
   :show-code: true
   :width: 50%

    gmt begin CN-buffer-fault
        gmt basemap -R109/113/34/37 -JM15c -Ba
        # draw a circle with a radius of 100 km
        echo 111 35.5 200k | gmt plot -SE- -Wblue -fg
        # extract faults within the circle
        gmt select CN-faults.gmt -C111/35.5+d100k -fg | gmt plot
    gmt end show
```

## 数据来源

[https://doi.org/10.12031/activefault.china.400.2023.db](https://doi.org/10.12031/activefault.china.400.2023.db)

## 数据属性说明

- FZN_Ch: Fracture zone name in simplified Chinese
- FZN_En: Fracture zone name in English
- FN_Ch: Fault name in simplified Chinese
- FN_En: Fault name in English
- FSN_Ch: Fault segment in simplified Chinese
- FSN_En: Fault segment in English
- Fea_Ch: Kinetic property and detectability of the fault segment in simplified Chinese
- Fea_En: Kinetic property and detectability of the fault segment in English
- AGE: Latest active age (code)
- AGE_Des: Latest active age
- RefE: Data source. It encompasses References, Work Content or Reference Scale.

## 数据引用

Wu, X., Xu, X., Yu, G., Ren, J., Yang, X., Chen, G., Xu, C., Du, K., Huang, X., Yang, H., Li, K., and Hao, H.: The China Active Faults Database (CAFD) and its web system, Earth Syst. Sci. Data, 16, 3391–3417, https://doi.org/10.5194/essd-16-3391-2024, 2024.