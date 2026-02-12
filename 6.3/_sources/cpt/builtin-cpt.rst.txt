内置CPT
=======

GMT内置了一个分类型CPT和几十个常规型CPT文件。这一节仅展示GMT内置CPT的配色，
具体如何使用这些内置CPT文件会在后面做进一步介绍。

下面列出了GMT内置的若干个CPT文件的具体配色以及CPT文件名（位于图下方）。
每张图中有两个色标，上面的色标是原始的CPT文件，可以使用如下命令绘制得到
（将选项 **-C**\ *cpt* 中的 *cpt* 替换为相应的CPT即可）::

    gmt colorbar -Dx0c/0c+w10c/1c+h -B0 -Ccpt -pdf CPT

下面的色标是利用 :doc:`/module/makecpt` 对原始CPT文件做离散处理得到的单色型
CPT文件，可以用如下命令绘制得到（将选项 **-C**\ *cpt* 中的 *cpt* 替换为相应的CPT即可）
::

    gmt begin CPT
    gmt makecpt -Ccpt -T-1/1/0.25
    gmt colorbar -Dx0c/0c+w10c/1c+h -B0
    gmt end show

图中黑色三角和白色三角分别表示该CPT拥有一个HARD HINGE或SOFT HINGE。
关于HARD和SOFT HINGE的定义会在下一节详细介绍。

+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/abyss.*        | .. figure:: cpt/acton.*        | .. figure:: cpt/bamako.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    abyss                       |    acton                       |    bamako                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/bathy.*        | .. figure:: cpt/batlow.*       | .. figure:: cpt/berlin.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    bathy                       |    batlow                      |    berlin                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/bilbao.*       | .. figure:: cpt/broc.*         | .. figure:: cpt/brocO.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    bilbao                      |    broc                        |    brocO                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/buda.*         | .. figure:: cpt/categorical.*  | .. figure:: cpt/cool.*         |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    buda                        |    categorical                 |    cool                        |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/copper.*       | .. figure:: cpt/cork.*         | .. figure:: cpt/corkO.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    copper                      |    cork                        |    corkO                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/cubhelix.*     | .. figure:: cpt/cyclic.*       | .. figure:: cpt/davos.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    cubhelix                    |    cyclic                      |    davos                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/dem1.*         | .. figure:: cpt/dem2.*         | .. figure:: cpt/dem3.*         |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    dem1                        |    dem2                        |    dem3                        |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/dem4.*         | .. figure:: cpt/devon.*        | .. figure:: cpt/drywet.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    dem4                        |    devon                       |    drywet                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/earth.*        | .. figure:: cpt/elevation.*    | .. figure:: cpt/etopo1.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    earth                       |    elevation                   |    etopo1                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/gebco.*        | .. figure:: cpt/geo.*          | .. figure:: cpt/globe.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    gebco                       |    geo                         |    globe                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/gray.*         | .. figure:: cpt/grayC.*        | .. figure:: cpt/hawaii.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    gray                        |    grayC                       |    hawaii                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/haxby.*        | .. figure:: cpt/hot.*          | .. figure:: cpt/ibcso.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    haxby                       |    hot                         |    ibcso                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/imola.*        | .. figure:: cpt/inferno.*      | .. figure:: cpt/jet.*          |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    imola                       |    inferno                     |    jet                         |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/lajolla.*      | .. figure:: cpt/lapaz.*        | .. figure:: cpt/lisbon.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    lajolla                     |    lapaz                       |    lisbon                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/mag.*          | .. figure:: cpt/magma.*        | .. figure:: cpt/nighttime.*    |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    mag                         |    magma                       |    nighttime                   |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/no_green.*     | .. figure:: cpt/nuuk.*         | .. figure:: cpt/ocean.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    no_green                    |    nuuk                        |    ocean                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/oleron.*       | .. figure:: cpt/oslo.*         | .. figure:: cpt/paired.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    oleron                      |    oslo                        |    paired                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/panoply.*      | .. figure:: cpt/plasma.*       | .. figure:: cpt/polar.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    panoply                     |    plasma                      |    polar                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/rainbow.*      | .. figure:: cpt/red2green.*    | .. figure:: cpt/relief.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    rainbow                     |    red2green                   |    relief                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/roma.*         | .. figure:: cpt/romaO.*        | .. figure:: cpt/seafloor.*     |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    roma                        |    romaO                       |    seafloor                    |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/sealand.*      | .. figure:: cpt/seis.*         | .. figure:: cpt/split.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    sealand                     |    seis                        |    split                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/srtm.*         | .. figure:: cpt/terra.*        | .. figure:: cpt/tofino.*       |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    srtm                        |    terra                       |    tofino                      |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/tokyo.*        | .. figure:: cpt/topo.*         | .. figure:: cpt/turbo.*        |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    tokyo                       |    topo                        |    turbo                       |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/turku.*        | .. figure:: cpt/vik.*          | .. figure:: cpt/vikO.*         |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    turku                       |    vik                         |    vikO                        |
+--------------------------------+--------------------------------+--------------------------------+
| .. figure:: cpt/viridis.*      | .. figure:: cpt/world.*        | .. figure:: cpt/wysiwyg.*      |
|    :align: center              |    :align: center              |    :align: center              |
|                                |                                |                                |
|    viridis                     |    world                       |    wysiwyg                     |
+--------------------------------+--------------------------------+--------------------------------+

GMT内置CPT文件中，某些是针对特定的需求设计的，因而常用于特定的图件中：

#. 海深：abyss、bathy、gebco、ibcso
#. 陆地高程：elevation
#. 全球地形起伏：dem1、dem2、dem3、dem4、earth、etopo1、geo、globe、oleron
   relief、terra、topo、world
#. 地震成像：seis、polar
#. 分类型数据：categorical
