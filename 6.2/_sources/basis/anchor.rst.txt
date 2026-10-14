锚点
====

锚 ⚓是船舶停泊时固定船只使之不能漂走的工具。GMT中的锚点也具有类似的作用，用于
将某个元素固定在图中的某个位置。这一节将介绍GMT中锚点的概念，具体的使用场景
及使用方法将在下一节介绍。

对于任意一个矩形元素，GMT为其定义了9个锚点。每个锚点的位置用一个水平位置代码和
一个垂直位置代码组合定义得到。
水平位置代码可以取 **L**\|\ **C**\|\ **R**，分别表示左（Left）中（Center）右（Right）；
垂直位置代码可以取 **T**\|\ **M**\|\ **B**，分别表示上（Top）中（Middle）下（Bottom）。
3个水平位置代码与3个垂直位置代码自由组合，得到9个锚点，每个锚点均对应矩形元素的
某个特定位置，如下图中红点和红字所示。例如，锚点 **BL** 位于矩形元素的左下角，
而锚点 **MC** 则位于矩形元素的中心。

.. gmtplot::
    :show-code: false
    :width: 70%

    gmt begin anchor-1 png,pdf
    gmt set MAP_TICK_LENGTH_PRIMARY 20p MAP_TICK_PEN_PRIMARY 1p
    gmt basemap -R0/10/0/6 -JX10c/6c -BENlb -Bxf5 -Byf3
    gmt plot -Sc0.3c -Gred -N << EOF
    0 0
    0 3
    0 6
    5 0
    5 3
    5 6
    10 0
    10 3
    10 6
    EOF
    gmt text -F+f15p+j -Dj0.5c/0.5c -N << EOF
    10 6 ML @%1%T@%%op
    10 3 ML @%1%M@%%iddle
    10 0 ML @%1%B@%%ottom
    0  6 BC @%1%L@%%eft
    5  6 BC @%1%C@%%enter
    10 6 BC @%1%R@%%ight
    EOF
    gmt text -F+f15p,1,red+c+j -Dj0.5c/0.5c+v2p << EOF
    TL TL TL
    TC TC TC
    TR TR TR
    ML ML ML
    MC BL MC
    MR MR MR
    BL BL BL
    BC BC BC
    BR BR BR
    EOF
    gmt end

此处的矩形元素并不一定是一个真正的矩形，GMT中很多绘图元素都可以抽象为一个矩形元素。
例如常规的矩形底图、非矩形的地理底图、比例尺、色标、指南针、文本字符串等，
都可以抽象为一个矩形元素。

例如，对于一个非矩形的地理底图来说，其9个锚点的位置如下图所示：

.. gmtplot::
    :show-code: false
    :width: 70%

    gmt begin anchor-2 png,pdf
    gmt basemap -Rg -JH10c -B0
    gmt text -F+f15p,1,red+c+j -Dj0.5c/0.5c+v2p -N << EOF
    TL TL TL
    TC TC TC
    TR TR TR
    ML ML ML
    MC BL MC
    MR MR MR
    BL BL BL
    BC BC BC
    BR BR BR
    EOF

    gmt plot -R0/10/0/6 -JX10c/5c -Sc0.3c -Gred -N << EOF
    0 0
    0 3
    0 6
    5 0
    5 3
    5 6
    10 0
    10 3
    10 6
    EOF
    gmt end

指南针、比例尺、图例、色标、文本字符串等也可以抽象为一个矩形，也有自己的锚点。
下图展示了色标的9个锚点的位置：

.. gmtplot::
    :show-code: false
    :width: 70%

    gmt begin anchor-3 png,pdf
    gmt colorbar -D0c/0c+w10c/1.5c+h -B0 -Cpolar
    gmt basemap -R0/10/0/6 -JX10c/1.5c -B0
    gmt text -F+f15p,1,red+c+j -Dj0.5c/0.5c+v2p -N << EOF
    TL BR TL
    TC BC TC
    TR BL TR
    ML MR ML
    MC MR MC
    MR ML MR
    BL TR BL
    BC TC BC
    BR TL BR
    EOF

    gmt plot -Sc0.3c -Gred -N << EOF
    0 0
    0 3
    0 6
    5 0
    5 3
    5 6
    10 0
    10 3
    10 6
    EOF
    gmt end
