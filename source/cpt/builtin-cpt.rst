内置CPT
=======

GMT内置了一个分类型CPT和几十个常规型CPT文件。这一节仅展示GMT内置CPT的配色，
具体如何使用这些内置CPT文件会在后面做进一步介绍。

下面列出了 GMT 内置的 CPT 文件的具体配色以及 CPT 文件名（位于图下方）。
用户可以参阅 :gmt-docs:`官方手册 <cookbook/cpts.html>` 了解更多内置CPT配色文件。
内置CPT根据其来源可以分为以下几个大类（以下称为 `section` ）：

* **gmt**: GMT 开发者制作的 CPT 文件;
* **SCM**: 由 Fabio Crameri 制作的科学配图用CPT文件;
* **cmocean**: 由 Kirsten Thyng 制作的海洋专用CPT文件;
* **cpt-city**: 从 cpt-city 引入的CPT文件;
* **google**: 由 Google 开发的CPT文件;
* **matlab**: 从 Matlab 引入的CPT文件;
* **matplotlib**: 从 matplotlib 引入的CPT文件;
* **panoply**: 从 Panoply 引入的CPT文件.

使用某个内置CPT文件时，完整的引用格式是 **-C**\ [*section*/] *cpt* 。其中 *cpt* 是某个 *section* 以下具体的CPT名字
（注意不需要 **.cpt** 扩展名）。如果省略 *section* 则会自动遍历查找，使用第一个找到的 *cpt* 。
例如 **-Cglobe** 等同于 **-Cgmt/globe** 。

每张图中有两个色标，上面的色标是原始的CPT文件，可以使用如下命令绘制得到
（将选项 **-C**\ *section/cpt* 中的 *section/cpt* 替换为相应的CPT即可）::

    gmt colorbar -Dx0c/0c+w10c/1c+h -B0 -Csection/cpt -pdf CPT

下面的色标是利用 :doc:`/module/makecpt` 对原始CPT文件做离散处理得到的单色型
CPT文件，可以用如下命令绘制得到（将选项 **-C**\ *section/cpt* 中的 *section/cpt* 替换为相应的CPT即可）
::

    gmt begin CPT
    gmt makecpt -Csection/cpt -T-1/1/0.25
    gmt colorbar -Dx0c/0c+w10c/1c+h -B0
    gmt end show

图中黑色三角和白色三角分别表示该CPT拥有一个HARD HINGE或SOFT HINGE。
关于HARD和SOFT HINGE的定义会在下一节详细介绍。

+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/acton.*             | .. figure:: cpt/SCM/actonS.*            | .. figure:: cpt/SCM/bam.*               |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/acton                            |    SCM/actonS                           |    SCM/bam                              |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/bamO.*              | .. figure:: cpt/SCM/bamako.*            | .. figure:: cpt/SCM/bamakoS.*           |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/bamO                             |    SCM/bamako                           |    SCM/bamakoS                          |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/batlow.*            | .. figure:: cpt/SCM/batlowK.*           | .. figure:: cpt/SCM/batlowS.*           |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/batlow                           |    SCM/batlowK                          |    SCM/batlowS                          |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/batlowW.*           | .. figure:: cpt/SCM/berlin.*            | .. figure:: cpt/SCM/bilbao.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/batlowW                          |    SCM/berlin                           |    SCM/bilbao                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/bilbaoS.*           | .. figure:: cpt/SCM/broc.*              | .. figure:: cpt/SCM/brocO.*             |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/bilbaoS                          |    SCM/broc                             |    SCM/brocO                            |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/buda.*              | .. figure:: cpt/SCM/budaS.*             | .. figure:: cpt/SCM/bukavu.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/buda                             |    SCM/budaS                            |    SCM/bukavu                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/cork.*              | .. figure:: cpt/SCM/corkO.*             | .. figure:: cpt/SCM/davos.*             |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/cork                             |    SCM/corkO                            |    SCM/davos                            |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/davosS.*            | .. figure:: cpt/SCM/devon.*             | .. figure:: cpt/SCM/devonS.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/davosS                           |    SCM/devon                            |    SCM/devonS                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/fes.*               | .. figure:: cpt/SCM/grayC.*             | .. figure:: cpt/SCM/grayCS.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/fes                              |    SCM/grayC                            |    SCM/grayCS                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/hawaii.*            | .. figure:: cpt/SCM/hawaiiS.*           | .. figure:: cpt/SCM/imola.*             |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/hawaii                           |    SCM/hawaiiS                          |    SCM/imola                            |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/imolaS.*            | .. figure:: cpt/SCM/lajolla.*           | .. figure:: cpt/SCM/lajollaS.*          |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/imolaS                           |    SCM/lajolla                          |    SCM/lajollaS                         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/lapaz.*             | .. figure:: cpt/SCM/lapazS.*            | .. figure:: cpt/SCM/lisbon.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/lapaz                            |    SCM/lapazS                           |    SCM/lisbon                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/nuuk.*              | .. figure:: cpt/SCM/nuukS.*             | .. figure:: cpt/SCM/oleron.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/nuuk                             |    SCM/nuukS                            |    SCM/oleron                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/oslo.*              | .. figure:: cpt/SCM/osloS.*             | .. figure:: cpt/SCM/roma.*              |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/oslo                             |    SCM/osloS                            |    SCM/roma                             |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/romaO.*             | .. figure:: cpt/SCM/tofino.*            | .. figure:: cpt/SCM/tokyo.*             |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/romaO                            |    SCM/tofino                           |    SCM/tokyo                            |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/tokyoS.*            | .. figure:: cpt/SCM/turku.*             | .. figure:: cpt/SCM/turkuS.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/tokyoS                           |    SCM/turku                            |    SCM/turkuS                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/SCM/vanimo.*            | .. figure:: cpt/SCM/vik.*               | .. figure:: cpt/SCM/vikO.*              |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    SCM/vanimo                           |    SCM/vik                              |    SCM/vikO                             |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cmocean/algae.*         | .. figure:: cpt/cmocean/amp.*           | .. figure:: cpt/cmocean/balance.*       |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cmocean/algae                        |    cmocean/amp                          |    cmocean/balance                      |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cmocean/curl.*          | .. figure:: cpt/cmocean/deep.*          | .. figure:: cpt/cmocean/delta.*         |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cmocean/curl                         |    cmocean/deep                         |    cmocean/delta                        |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cmocean/dense.*         | .. figure:: cpt/cmocean/diff.*          | .. figure:: cpt/cmocean/gray.*          |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cmocean/dense                        |    cmocean/diff                         |    cmocean/gray                         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cmocean/haline.*        | .. figure:: cpt/cmocean/ice.*           | .. figure:: cpt/cmocean/matter.*        |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cmocean/haline                       |    cmocean/ice                          |    cmocean/matter                       |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cmocean/oxy.*           | .. figure:: cpt/cmocean/phase.*         | .. figure:: cpt/cmocean/rain.*          |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cmocean/oxy                          |    cmocean/phase                        |    cmocean/rain                         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cmocean/solar.*         | .. figure:: cpt/cmocean/speed.*         | .. figure:: cpt/cmocean/tarn.*          |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cmocean/solar                        |    cmocean/speed                        |    cmocean/tarn                         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cmocean/tempo.*         | .. figure:: cpt/cmocean/thermal.*       | .. figure:: cpt/cmocean/topo.*          |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cmocean/tempo                        |    cmocean/thermal                      |    cmocean/topo                         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cmocean/turbid.*        | .. figure:: cpt/cpt-city/cubhelix.*     | .. figure:: cpt/cpt-city/dem1.*         |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cmocean/turbid                       |    cpt-city/cubhelix                    |    cpt-city/dem1                        |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/cpt-city/dem4.*         | .. figure:: cpt/cpt-city/elevation.*    | .. figure:: cpt/gmt/abyss.*             |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    cpt-city/dem4                        |    cpt-city/elevation                   |    gmt/abyss                            |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/bathy.*             | .. figure:: cpt/gmt/categorical.*       | .. figure:: cpt/gmt/cyclic.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/bathy                            |    gmt/categorical                      |    gmt/cyclic                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/dem2.*              | .. figure:: cpt/gmt/dem3.*              | .. figure:: cpt/gmt/drywet.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/dem2                             |    gmt/dem3                             |    gmt/drywet                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/earth.*             | .. figure:: cpt/gmt/etopo1.*            | .. figure:: cpt/gmt/gebco.*             |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/earth                            |    gmt/etopo1                           |    gmt/gebco                            |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/geo.*               | .. figure:: cpt/gmt/globe.*             | .. figure:: cpt/gmt/gray.*              |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/geo                              |    gmt/globe                            |    gmt/gray                             |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/haxby.*             | .. figure:: cpt/gmt/ibcso.*             | .. figure:: cpt/gmt/mag.*               |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/haxby                            |    gmt/ibcso                            |    gmt/mag                              |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/nighttime.*         | .. figure:: cpt/gmt/no_green.*          | .. figure:: cpt/gmt/ocean.*             |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/nighttime                        |    gmt/no_green                         |    gmt/ocean                            |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/paired.*            | .. figure:: cpt/gmt/rainbow.*           | .. figure:: cpt/gmt/red2green.*         |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/paired                           |    gmt/rainbow                          |    gmt/red2green                        |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/relief.*            | .. figure:: cpt/gmt/seafloor.*          | .. figure:: cpt/gmt/sealand.*           |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/relief                           |    gmt/seafloor                         |    gmt/sealand                          |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/seis.*              | .. figure:: cpt/gmt/split.*             | .. figure:: cpt/gmt/srtm.*              |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/seis                             |    gmt/split                            |    gmt/srtm                             |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/terra.*             | .. figure:: cpt/gmt/topo.*              | .. figure:: cpt/gmt/world.*             |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/terra                            |    gmt/topo                             |    gmt/world                            |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/gmt/wysiwyg.*           | .. figure:: cpt/google/turbo.*          | .. figure:: cpt/matlab/cool.*           |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    gmt/wysiwyg                          |    google/turbo                         |    matlab/cool                          |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/matlab/copper.*         | .. figure:: cpt/matlab/hot.*            | .. figure:: cpt/matlab/jet.*            |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    matlab/copper                        |    matlab/hot                           |    matlab/jet                           |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/matlab/polar.*          | .. figure:: cpt/matplotlib/inferno.*    | .. figure:: cpt/matplotlib/magma.*      |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    matlab/polar                         |    matplotlib/inferno                   |    matplotlib/magma                     |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| .. figure:: cpt/matplotlib/plasma.*     | .. figure:: cpt/matplotlib/viridis.*    | .. figure:: cpt/panoply/panoply.*       |
|    :align: center                       |    :align: center                       |    :align: center                       |
|                                         |                                         |                                         |
|    matplotlib/plasma                    |    matplotlib/viridis                   |    panoply/panoply                      |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+

GMT内置CPT文件中，某些是针对特定的需求设计的，因而常用于特定的图件中：

#. 海深：abyss、bathy、gebco、ibcso
#. 陆地高程：elevation
#. 全球地形起伏：dem1、dem2、dem3、dem4、earth、etopo1、geo、globe、oleron
   relief、terra、topo、world
#. 地震成像：seis、polar
#. 分类型数据：categorical
