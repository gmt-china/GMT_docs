# 等值线标注和“线条标注”

GMT 中可以使用采用 `grdcontour` 和 `pscontour` 模块来绘制等值线，
每条等值线都可以附加一个标注。GMT 中 `plot` 和 `plot3d` 模块也可以使用
`-Sq` 选项绘制带有标注的线段。

在需要为等值线/线段附加标注的时候，如何优化标注的位置是一个很困难的主题。
GMT提供了不同的算法确定标注的位置，并且可以自由地指定标注的属性。
本章总结了标注的属性和位置确定方法，并给出了一些应用实例。

## 标注的位置

GMT 中提供了5种算法来自动确定标注的位置。对于 `grdcontour` 和 `pscontour` 模块，
可以通过 `-G` 选项指定使用哪种标注定位算法，对于 `plot` 和 `plot3d` 模块，
则可以通过 `-Sq` 选项指定使用哪种标注定位算法。

不管是 `-G` 还是 `-Sq`，其所需要的信息是完全相同的，采用 `<code><info>`
的格式来指定算法和相应参数，其中 `<code>` 取不同的值代表不同的算法，`<info>`
则是各个算法所对应的参数。

下述内容给出了不同 `<code>` 对应的算法和相应的参数：

d:

: 完整的语法为 `d<dist>[c|i|p][/frac]`

  根据地图上的投影距离确定标注的位置，可以指定长度单位或采用默认值
  \[{term}`PROJ_LENGTH_UNIT`\]。
  从等值线的起始位置开始，以 `<dist>` 为步长，沿着等值线布置标注。
  为了保证可以标注总长度小于 `<dist>` 的封闭曲线，可以指定 `<frac>` 参数，
  将第一个标注放置在距封闭曲线起点 d = \<dist> * \<frac> 的
  位置上，`frac` 的默认值为0.25。

D:

: 完整的语法为 `D<dist>[d|m|s|e|f|k|M|n][/<frac>]`

  与 `d` 相似，但是其输入数据必须是地理坐标（同时必须选择地图投影），
  距离为沿等值线的地表真实距离。可以附加距离的单位，其中 `d|m|s|e|f|k|M|n`
  各个单位的含义见 {doc}`/basis/unit` 一节。其它参数的意义与 `d` 相同。

f:

: 完整的语法为 `f<fix.txt>[/<slop>[c|i|p]]`

  其中，ASCII文件 `<fix.txt>` 中每条记录的前两列（坐标）指定了标注的位置。
  当文件中的坐标与等值线的距离小于 `<slop>`
  （附加单位或使用默认值 {term}`PROJ_LENGTH_UNIT` ）时，
  才会显示标注。`<slope>` 的默认值为0，即文件中的坐标必须与线段上的坐标
  完全匹配。

l:

: 完整的语法为 `l<line1>[,<line2>[, ...]]`

  指定一个或多个以逗号分隔的直线段，在这些直线段与等值线的交点位置放置
  标注。
  通过起点 `<start>` 和终点 `<stop>` 的坐标来定义每个直线段 `<line>` 。
  起点和终点的坐标可以是常规坐标，如斜杠分隔的经纬度，或与地图区域
  相关的2个字母组合成的子选项。
  这些字母的取值与 `pstext` 中对齐方式的取值相同，即 `[L|C|R][B|M|T]`

  第一个字母代表横坐标 `<x>`，第二个字母代表纵坐标 `<y>`，如 ``` LB` 代表
  地图的左下角。
  在模块 ``grdcontour ``` 中还可以使用子选项 `Z+` 、 `Z-` 代表
  网格数据中全局最大值点或最小值点的坐标。
  例如，直线段 line `LT/RB` 代表地图左上角到右下角的对角线，
  `Z-/135W/15S` 代表网格数据中最小值点与 (135ºW, 15ºS)之间的直线段。

L:

: 除起点与终点之间的线段为大圆弧外，其余内容与子选项 `l` 相同。

n:

: 完整的语法为 `n<number>[/<minlength>[c|i|p]]`

  沿等值线放置 `<number>` 个标注，即将等值线分割为 `<number>` 段，
  标注位于每段的中心位置。
  还可以通过指定最小距离 `<minlength>` 来保证相邻标注之间的距离不小于  `<minlength>` 。

N:

: 完整的语法为 `N<number>[/<minlength>[c|i|p]]`

  除标注位于每段终点位置外（ `<number> >= 2` ），与子选项 `n` 类似。当 number=-1 时，标注位于等值线的起点；当 number=+1 时，标注位于等值线的终点。

x:

: 完整的语法为 `x<cross.d>`

  ASCII文件 `<cross.d>` 内给出了多段数据，这些线段与等值线的交点即是
  标注的位置。

X:

: 除了ASCII文件中定义的线段为大圆弧外，与子选项 `x` 的类似。

每调用一次等值线绘制模块，只能指定一种确定标注位置的算法。

## 标注的属性

确定标注的位置之后，还需要指定标注的属性。
对于等值线绘制模块，在 `-A` 选项后以 `+<code>[<参数>]` 的格式定义
不同的属性；对于线条绘制模块中，则是在 `-Sq` 选项后用冒号 `:` 来分隔
标注的属性和标注的位置。

部分属性只能用于线条绘制模块，因此，首先列出了两个模块通用的属性。
这些属性包括：

+a:

: 控制标注的角度和线条的角度间的相互关系：

  1. 后面加上 **n** 表示二者相互垂直；
  2. 后面加上 **p** 表示二者之间相互平行，调用 `grdcontour` 模块时，还可以附加 **u** 或 **d** 表示标注的上边缘指向更高或更低的等值线；
  3. 给定角度 `<angle>` 表示自水平方向开始逆时针方向旋转的角度

+c:

: 每个标注周围存在一个假想的文本框，等值线在这个区域内是不可见的。
  默认的文本框精确的围限了标注，可以指定水平向和竖直向的间隙
  （相对于标注的基线）。若水平向和竖直向的间隙值不同，需要以斜杠分隔，可以在间隙值后附加
  长度单位（ `c|i|m|p` ），也可以指定间隙与标注所采用字体的
  百分比，默认值为15% 。

+d:

: Debug 模式。标注所在位置也会绘制等值线，用来测试等值线的位置。

+d:

: 延迟模式, 延迟标注文字的绘制。

+f:

: 指定标注文字的字体、大小和颜色等，可参考 `pstext` 。
  字体的默认值参见 {term}`FONT_ANNOT_PRIMARY` 。

+g:

: 指定文本框的填充效果，颜色的默认值与 {term}`PS_PAGE_COLOR` 相同。

+j:

: 指定标注内容与标注位置之间的对齐方式，默认值为 **CM** ，
  指定值可以覆盖默认值，参数值由2个字母组成，
  取值范围分别为 `[L|C|R][B|M|T]` 。
  对于弯曲的标注文字 (**+v**)，只有竖直向对齐方式起作用。

+o:

: 指定文本框的形状为圆角矩形，只有对文本框进行填充或显示轮廓时才起作用。
  对于弯曲的标注文字 (**+v**)不起作用。

+p:

: 指定文本框轮廓线的线条属性，默认值为\[0.25p,black\] 。

+r:

: 当曲率半径低于给定值时，不放置标注，可以指定曲率半径的单位，默认值为0。

+u:

: 在标注后加单位 `<unit>` 。
  通常在单位和标注之间有一个空格，若想去掉这个间隔，
  需要在单位前加连字符(-)。
  调用 `grdcontour` 模块时，若给出这个属性，却不指定单位时，
  则使用网格头段中 *z* 值的单位。

+v:

: 根据线条摆动情况放置弯曲的标注，当标注长度较大时，该属性尤其有用。
  默认值为给定角度的不可见的直线段。

+w:

: 标注所在位置处等值线的角度，是对附近的 *width* 个点，
  进行最小二乘拟合计算的，*width* 的默认值为10。

+=:

: 与 **+u** 非常相似，用于指定 *prefix* 的单位。

对于等值线绘制模块，
标注的内容为等值线的数值(可以通过 **+u** 或 **+=** 属性来修改)。
对于线条绘制模块来说，还可以指定下述属性：

+l:

: 在标注位置放置相同的内容，如果标注内容包含空格，
  则需要用引号括起来。

+L:

: 通过附加 *子选项* 指定标注的内容，可用的子选项包括：

  +Lh:

  : 采用多段数据的头记录作为标注内容(假设输入为多段数据，
    如果不是多段数据，则采用文件头记录)。
    首先扫描 `-L<子选项>` 属性，若没有指定该选项，
    则采用数据段头记录首字符(默认为 > )后的第一个单词。

  +Ld:

  : 采用笛卡尔坐标系内的距离作为标注内容的距离单位，
    可以指定单位，如 `c|i|p`，
    默认值为
    \[{term}`PROJ_LENGTH_UNIT`\]。
    标注内容的格式参见:term:`FORMAT_FLOAT_OUT` 。

  +LD:

  : 采用真实地表距离计算标注内容，可以指定单位，如
    `d|e|f|k|m|M|n|s`，
    默认值为度 **d** 。

  +Lf:

  : 采用ASCII文件 *fix.txt* 中第2列数据之后的所有文字作为标注
    的内容，显然，该属性需要在指定标注位置
    算法(**f**) 的前提下，才能起作用。

  +Ln:

  : 采用多段数据中当前数据段的顺序号作为标注内容。

  +LN:

  : 采用斜杠分隔的文件号--当前数据段顺序号作为标注内容。

  +Lx:

  : 与属性 **h** 类似，多段数据头记录的来源为 *cross.d* 文件。
    显然，该属性需要在指定标注位置算法(**x|X**)的前提下，
    才能起作用。

## 等值线标注位置实例

本节通过一些简单的实例说明等值线标注位置选项的作用。
首先，在实例1中，采用部分全球大地水准面数据(geoid)，绘制了等值线。
所选择的区域包含了大地水准面的两级，Indian Low和New Guinea High。

示例数据下载 {download}`geoid.nc` 、 {download}`transect.txt` 、 {download}`cross.txt`

### 等距离放置标注

第1个实例使用标注位置算法的默认值，沿等值线每1.5英寸放置一个标注:

```{eval-rst}
.. gmtplot:: contour-anno1.sh

   通过指定 **-Gd** 选项的参数，确定了标注的位置(等值线上相距1.5英寸的点)
```

### 给定标注个数

现在指定每条等值线上标注的个数。
每条等值线上只放置1个标注，并且要求等值线的长度不小于1英寸，

```{eval-rst}
.. gmtplot:: contour-anno2.sh

   通过指定 **-Gn** 选项的参数，确定了标注的位置(每条长度超过1英寸的等值线的中心位置)
```

### 给定标注位置

给定标注所在位置的坐标，由于坐标不是严格位于等值线上，
指定了非0距离值，即标注位置与等值线距离的上限。

根据等值线的几何形状，自动计算标注的角度。
为了帮助理解，通过指定选项 **-A** 中的 **+d** 属性，
采用了debug模式，即在每个给定位置上绘制了一个小圆圈。

```{eval-rst}
.. gmtplot:: contour-anno3.sh

   通过指定 **-Gf** 选项的参数，确定了标注的位置(等值线上与给定点距离最小的点)
```

### 线段与等值线交点处放置标注

通过指定 **-Gl** 或 **-GL** 选项的参数来定义线段，
将标注放置在直线段与等值线的交点。

```{eval-rst}
.. gmtplot:: contour-anno4.sh

   通过指定 **-GL** 选项的参数确定了标注的位置(大圆弧与等值线的交点)
```

图中的标注位于数据极值点连线(**Z-/Z+**)与等值线的交点。
图中极值点连线为两点之间的大圆弧，
在其与等值线交点位置处放置了标注。
同一幅地图中，可以分别指定多条线段。

### 广义的线段与等值线相交算法

如果需要指定的与等值线相交的线段比较多，或线段数据来自其他数据集，
可以使用广义的相交算法确定标注的位置。
多段数据文件 *cross.txt* 中定义了三条曲线，
在这三条曲线与等值线交点位置处放置了标注，

```{eval-rst}
.. gmtplot:: contour-anno5.sh

   通过指定 **-GX** 选项的参数(多段数据文件 *cross.txt* )，确定了标注的位置
```

## 标注属性实例

本节通过实例说明标注属性的作用，
采用 `plot` 绘制了大地水准面极值点之间的大圆弧，
并且沿着该大圆弧从ETOPO5数据集中提取了高程数据。
高程数据文件(transect.txt)中包括
了 *经度、纬度、距离、大地水准面、高程* 数据。

### 按照沿大圆弧距离放置标注-不透明文本框

在本实例中将标注的走向从沿大圆弧改变为跨大圆弧，并指定了不透明的文本框
和轮廓线，增加了标注的可读性。
沿大圆弧每1000km放置一个标注，使用距离值作为标注的内容。
标注的方向与大圆弧垂直：

```{eval-rst}
.. gmtplot:: contour-anno6.sh

   通过指定 **-Sq** 选项的参数控制标注属性.
```

图中显示了上述命令的综合效果。
值得注意的是，大圆弧的起点和终点没有与表示极值点的"-"和"+"符号完全重合。
造成这个现象的原因是，极值点符号"-"和"+"的坐标是等值线的平均值，
而不是全局或局部极值的位置。

### 按照沿大圆弧距离放置标注-反色圆角矩阵

与上一个实例不同的是，
本实例中标注与大圆弧平行，以度指定标注位置，并添加度单位。
文本框的形状为圆角矩形，且标注内容与文本框的底色呈反色显示。

```{eval-rst}
.. gmtplot:: contour-anno7.sh

   另一个标注属性实例
```

### 使用不同数据集定义标注的内容和位置

本实例中采用沿大圆弧的海底地形数据作为标注的内容，
按照沿大圆弧的距离，每1500km放置一个标注。
因此需要使用 **awk** 程序从 *transect.txt* 文件中抽取距离为1500km倍数的记录，
并创建一个新文件，指定标注的位置和内容：

```{eval-rst}
.. gmtplot:: contour-anno8.sh

   标注的位置和内容来自不同的数据集
```

## 综合实例

最后，采用之前章节中论述的多个标注位置确定方法和属性设置，
绘制了一幅比较复杂的综合性图件。
假设在Canary Islands发生了灾难性滑坡，
图件显示了所引发的的海啸的走时(以小时为单位)。
根据海啸走时和海底地形绘制了彩图，
对等值线和线条进行了标注。
完整的脚本如下：

```{eval-rst}
.. gmtplot:: contour-anno9.sh

   Canary Islands到大西洋沿岸的海啸走时图，特别是纽约。当发生灾难性滑坡时，纽约将在8小时后遭遇大海啸。
```
