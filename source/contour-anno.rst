等值线标注和“线条标注”
=======================

对于2维网格数据和3维表数据，GMT分别采用 :doc:`grdcontour` 
和 :doc:`pscontour` 模块来绘制等值线。
在需要为等值线附加标签的时候，如何优化标签的位置是一个很困难的主题。
GMT提供了不同的算法确定标签的位置，并且可以自由的指定标签的属性。
本章总结了标签的属性和位置确定方法，并给出了一些应用实例。

标签的位置
---------------

在不同版本的GMT当中，确定标签位置的算法个数不同，GMT1--3中只提供了1种
算法，GMT4中则提供了5种算法。
另外，在线条绘制模块 :doc:`psxy` 和 :doc:`psxyz` 中增加了一个新的符号选项
(**-Sq** "线条标注")，也可以采用这些算法来确定线条标签的位置。
等值线绘制模块中，需要在 **-G** 选项中以不同字符来指定标签位置的算法，
线条绘制模块中，则需要在 **-Sq**  选项中指定标签位置的算法。
这两个选项所需要的信息是完全相同的，采用 [**字符**]\ *参数*\ 的格式，
指定算法和相应参数。 
下述内容给出了不同 [**字符**] 对应的算法和相应的参数：

d:
    完整的语法为
    **d**\ *dist*\ [**c\ \|\ i\ \|\ p**][/\ *frac*]
    根据地图上的投影距离确定标签的位置，可以指定长度单位或采用默认值
    [:ref:`PROJ_LENGTH_UNIT <PROJ_LENGTH_UNIT>`]。 
    从等值线的起始位置开始，以 *dist* 为步长，沿着等值线布置标签。
    为了保证可以标注总长度小于 *dist* 的封闭曲线，可以指定 *frac* 参数，
    将第一个标签放置在距封闭曲线起点 *d = dist* :math:`\times` *frac* 的
    位置上，*frac* 的默认值为0.25。

D:
    完整的语法为
    **D**\ *dist*\ [**d\ \|\ m\ \|\ s\ \|\ e\ \|\ f\ \|\ k\ \|\ M\ \|\ n**][/\ *frac*].
    与字符 **d** 相似，但是其输入数据必须是地理坐标(同时必须选择地图投影)，
    距离为沿等值线的地表真实距离。
    可以附加距离的单位，包括弧度 **d**\ egree、 **m**\ 弧分、  **s**\ 弧秒,
    或 米m\ **e**\ ter [Default]、英尺 **f**\ eet、公里 **k**\ ilometer、英里
    **M**\ iles、 海里 **n**\ autical miles。
    其它参数的意义与字符 **d** 相同。

f:
    完整的语法为
    **f**\ *fix.txt*\ [/*slop*\ [**c\ \|\ i\ \|\ p**]].
    其中，ASCII文件 *fix.txt* 中每条记录的前两列(坐标)指定了标签的位置。
    当文件中的坐标与等值线的距离小于 *slop* 
    (附加单位或使用默认值 :ref:`PROJ_LENGTH_UNIT <PROJ_LENGTH_UNIT>`)时，
    才会显示标签。

l:
    完整的语法为
    **l**\ *line1*\ [,\ *line2*\ [, ...]]. 
    指定一个或多个以逗号分隔的直线段，在这些直线段与等值线的交点位置放置
    标签。
    通过起点 *start* 和终点 *stop* 的坐标来定义每个直线段 *line* 。
    起点和终点的坐标可以是常规坐标，如斜杠分隔的经纬度，或与地图区域
    相关的2个字母组合成的字符。
    这些字母的取值与:doc:`pstext` 中对齐方式的取值相同，即
    [**L\ \|\ C\ \|\ R**][**B\ \|\ M\ \|\ T**]
    第一个字母代表横坐标 *x* ，第二个字母代表纵坐标 *y* ，如 **LB** 代表
    地图的左下角。
    在模块 :doc:`grdcontour` 中还可以使用字符 **Z+** 、 **Z-** 代表
    网格数据中全局最大值点或最小值点的坐标。
    例如，直线段 *line* **LT**/**RB** 代表地图左上角到右下角的对角线，
    **Z-**/135W/15S 代表网格数据中最小值点与 (135ºW, 15ºS)之间的直线段。

L:
    除起点与终点之间的线段为大圆弧外，其余内容与字符 **l** 相同。

n:
    完整的语法为
    **n**\ *number*\ [/*minlength*\ [**c\ \|\ i\ \|\ p**]].
    沿等值线放置 *number* 个标签，即将等值线分割为 *number* 段，
    标签位于每段的中心位置。
    还可以通过指定最小距离 *minlength* 来保证相邻标签之间的距离不小于
     *minlength* 。 


N:
    完整的语法为 
    **N**\ *number*\ [/*minlength*\ [**c\ \|\ i\ \|\ p**]].
    除标签位于每段终点位置外( *number* >=2 )，与字符 **n** 类似。
    当 *number = -1* 时，标签位于等值线的起点；
    当 *number = +1* 时，标签位于等值线的终点。

x:
    完整的语法为 **x**\ *cross.d*. 
    ASCII文件 *cross.d* 内给出了多段数据，这些线段与等值线的交点即是
    标签的位置。

X:
    除了ASCII文件中定义的线段为大圆弧外，与字符 **x** 的类似。

每调用一次等值线绘制模块，只能指定一种确定标签位置的算法。

标签的属性
----------------

确定标签的位置之后，还需要指定标签的属性。
对于等值线绘制模块，在 **-A** 选项后以+\ *字符*\ [*参数*\ ]的形式定义
不同的属性；对于线条绘制模块中，则是在 **-Sq** 选项后，用冒号(:)来分隔
标签的属性和标签的位置。
部分属性只能用于线条绘制模块，因此，首先列出了两个模块通用的属性。
这些属性包括：

+a:
    控制标签方位角和线条方位角的相互关系， **n** 表示二者相互垂直；
    **p** 表示二者之间相互平行，调用 :doc:`grdcontour` 模块时，还可以附加
    **u** 或 **d** 表示标注的上边缘指向更高或更低的等值线；
    给定的角度 *angle* 表示自水平方向开始，沿逆时针方向旋转。

+c:
    每个标签周围存在一个假想的文本框，等值线在这个区域内是不可见的。
    默认的文本框精确的围限了标注，可以指定水平向和竖直向的间隙
    (相对于标签的基线)。
    若水平向和竖直向的间隙值不同，需要以斜杠分隔，可以在间隙值后附加
    长度单位(**c\ \|\ i\ \|\ m\ \|\ p**)，也可以指定间隙与标注所采用字体的
    百分比，默认值为15% 。

+d:
    Debug 模式。 
    标签所在位置也会绘制等值线，用来测试等值线的位置。

+d:
    延迟模式, 延迟标注文字的绘制。

+f:
    指定标注文字的字体、大小和颜色等，可参考 :doc:`pstext` 。
    字体的默认值参见 :ref:`FONT_ANNOT_PRIMARY <FONT_ANNOT_PRIMARY>` 。

+g:
    指定文本框的填充效果，颜色的默认值与
    :ref:`PS_PAGE_COLOR <PS_PAGE_COLOR>` 相同。

+j:
    指定标注内容与标签位置之间的对齐方式，默认值为 **CM** 
    (参见:doc:`pstext` )，指定值可以覆盖默认值，参数值由2个字母组成，
    取值范围分别为
    [**L\ \|\ C\ \|\ R**\ ][**B\ \|\ M\ \|\ T**\ ] 。
    对于弯曲的标注文字 (**+v**)，只有竖直向对齐方式起作用。

+o:
    指定文本框的形状为圆角矩形，只有对文本框进行填充或显示轮廓时才起作用。
    对于弯曲的标注文字 (**+v**)不起作用。

+p:
    指定文本框轮廓线的线条属性，默认值为[0.25p,black] 。

+r:
    当曲率半径低于给定值时，不放置标签，可以指定曲率半径的单位，默认值为0。

+u:
    在标签后加单位 *unit* 。
    通常在单位和标签之间有一个空格，若想去掉这个间隔，
    需要在单位前加连字符(-)。
    调用 :doc:`grdcontour` 模块时，若给出这个属性，却不指定单位时，
    则使用网格头段中 *z* 值的单位。


+v:
    根据线条摆动情况放置弯曲的标签，当标签长度较大时，该属性尤其有用。
    默认值为给定角度的不可见的直线段。


+w:
    The angle of the line at the point of straight label placement is
    calculated by a least-squares fit to the *width* closest points. If
    not specified, *width* defaults to 10.


+=:
    Similar in most regards to **+u** but applies instead to a label
    *prefix* which you must append.

对于等值线绘制模块，
标签的内容为等值线的数值(可以通过 **+u** 或 **+=** 属性来修改)。
对于线条绘制模块来说，还可以指定下述属性：

+l:
    在标签位置放置相同的内容，如果标签内容包含空格，
    则需要用引号括起来。

+L:
    通过附加 *字符* 指定标签的内容，可用的字符包括：

    +Lh:
        采用多段数据的头记录作为标签内容(假设输入为多段数据，
        如果不是多段数据，则采用文件头记录)。
        首先扫描 **-L**\ *字符* 属性，若没有指定该选项，
        则采用数据段头记录首字符(默认为 > )后的第一个单词。

    +Ld:
        采用笛卡尔坐标系内的距离作为标签位置的距离单位，
        可以指定单位，如 **c\ \|\ i\ \|\ p** 默认值为
        [:ref:`PROJ_LENGTH_UNIT <PROJ_LENGTH_UNIT>`]。 
        标签内容的格式参见:ref:`FORMAT_FLOAT_OUT <FORMAT_FLOAT_OUT>` 。

    +LD:
        采用真实地表距离计算标签的位置，可以指定单位，如
        **d\ \|\ e\ \|\ f\ \|\ k\ \|\ m\ \|\ M\ \|\ n\ \|\ s**
        默认值为弧度 **d** 。

    +Lf:
        采用ASCII文件 *fix.txt* 中第2列数据之后的所有文字作为标签
        的内容，显然，该属性需要在指定标签位置
        算法(**f**) 的前提下，才能起作用。


    +Ln:
        采用多段数据中当前数据段的顺序号作为标签内容。

    +LN:
        采用斜杠分隔的文件号--当前数据段顺序号作为标签内容。

    +Lx:
        与属性 **h** 类似，多段数据头记录的来源为 *cross.d* 文件。
        显然，该属性需要在指定标签位置算法(**x\ \|\ X**)的前提下，
        才能起作用。

等值线标签位置实例
-----------------------------------

本节通过一些简单的实例说明等值线标签位置选项的作用。
首先，在实例1中，采用部分全球大地水准面数据(geoid)，绘制了等值线。
所选择的区域包含了大地水准面的两级，Indian Low和New Guinea High。


等距离放置标签
~~~~~~~~~~~~~~~~~~

第1个实例使用标签位置算法的默认值，沿等值线每1.5英寸放置一个标签:

    ::

     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_1.ps
     gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+f8p -Gd1.5i -S10 -T+lLH >> GMT_App_O_1.ps

效果如图:ref:`Contour label 1 <Contour_label_1>` 所示。

.. _Contour_label_1:

.. figure:: /_images/GMT_App_O_1.*
   :width: 500 px
   :align: center

   通过指定 **-Gd** 选项的参数，确定了标签的位置(等值线上相距1.5英寸的点) 


给定标签个数
~~~~~~~~~~~~~~~~~~~~~~

现在指定每条等值线上标签的个数：

    ::

     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_2.ps
     gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+f8p -Gn1/1i -S10 -T+lLH >> GMT_App_O_2.ps

每条等值线上只放置1个标签，并且要求等值线的长度不小于1英寸，
效果如图 :ref:`Contour label 2 <Contour_label_2>` 所示。

.. _Contour_label_2:

.. figure:: /_images/GMT_App_O_2.*
   :width: 500 px
   :align: center

   通过指定 **-Gn** 选项的参数，确定了标签的位置(每条长度超过1英寸的等值线的中心位置)



给定标签位置
~~~~~~~~~~~~~~~~~~~~~~~~~~~

给定标签所在位置的坐标，由于坐标不是严格位于等值线上，
指定了非0距离值，即标签位置与等值线距离的上限。

    ::

     cat << EOF > fix.txt
     80      -8.5
     55      -7.5
     102     0
     130     10.5
     EOF
     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_3.ps
     gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+d+f8p -Gffix.txt/0.1i -S10 -T+lLH >> GMT_App_O_3.ps

根据等值线的几何形状，自动计算标签的角度，
效果如图:ref:`Contour label 3 <Contour_label_3>` 所示。
为了帮助理解，通过指定选项 **-A** 中的 **+d*** 属性，
采用了debug模式，即在每个给定位置上绘制了一个小圆圈。

.. _Contour_label_3:

.. figure:: /_images/GMT_App_O_3.*
   :width: 500 px
   :align: center

   通过指定 **-Gf** 选项的参数，确定了标签的位置(等值线上与给定点距离最小的点)


线段与等值线交点处放置标签
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

通过指定 **-Gl** 或 **-GL** 选项的参数来定义线段，
将标签放置在直线段与等值线的交点。

    ::

      gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_4.ps
      gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+d+f8p -GLZ-/Z+ -S10 -T+lLH >> GMT_App_O_4.ps

图中的标签位于数据极值点连线(**Z-/Z+**)与等值线的交点。

.. _Contour_label_4:

.. figure:: /_images/GMT_App_O_4.*
   :width: 500 px
   :align: center

   通过指定 **-GL** 选项的参数确定了标签的位置(大圆弧与等值线的交点)


图:ref:`Contour label 4 <Contour_label_4>` 中极值点连线为两点之间的大圆弧，
在其与等值线交点位置处放置了标签。
同一幅地图中，可以分别指定多条线段。

广义的线段与等值线相交算法
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

如果需要指定的与等值线相交的线段比较多，或线段数据来自其他数据集，
可以使用广义的相交算法确定标签的位置：

    ::

     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_5.ps
     gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+d+f8p -GXcross.txt -S10 -T+lLH >> GMT_App_O_5.ps

.. _Contour_label_5:

.. figure:: /_images/GMT_App_O_5.*
   :width: 500 px
   :align: center

   通过指定 **-GX** 选项的参数(多段数据文件 *cross.txt* )，确定了标签的位置


多段数据文件 *cross.txt* 中定义了三条曲线，
在这三条曲线与等值线交点位置处放置了标签，
效果如图:ref:`Contour label 5 <Contour_label_5>` 所示。

标签属性实例
----------------------------

We will now demonstrate some of the ways to play with the label
attributes. To do so we will use :doc:`psxy` on
a great-circle line connecting the geoid extrema, along which we have
sampled the ETOPO5 relief data set. The file thus contains *lon, lat,
dist, geoid, relief*, with distances in km.

Label placement by along-track distances, 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example will change the orientation of labels from along-track to
across-track, and surrounds the labels with an opaque, outlined text box
so that the label is more readable. We choose the place the labels every
1000 km along the line and use that distance as the label. The labels
are placed normal to the line:

    ::
     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_6.ps
     gmt grdcontour geoid.nc -J -O -K -B20f10 -BWSne -C10 -A20+d+f8p -Gl50/10S/160/10S -S10 \
     -T+l"-+" >> GMT_App_O_6.ps
     gmt psxy -R -J -O -SqD1000k:+g+LD+an+p -Wthick transect.txt >> GMT_App_O_6.ps

.. _Contour_label_6:

.. figure:: /_images/GMT_App_O_6.*
   :width: 500 px
   :align: center

   Labels attributes are controlled with the arguments to the **-Sq** option.


The composite illustration in Figure :ref:`Contour label 6 <Contour_label_6>`
shows the new effects. Note that the line connecting the extrema does
not end exactly at the ‘-' and ‘+' symbols. This is because the
placements of those symbols are based on the mean coordinates of the
contour and not the locations of the (local or global) extrema.

Label placement by along-track distances, 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A small variation on this theme is to place the labels parallel to the
line, use spherical degrees for placement, append the degree symbol as a
unit for the labels, choose a rounded rectangular text box, and
inverse-video the label:

    ::

     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_7.ps
     gmt grdcontour geoid.nc -J -O -K -B20f10 -BWSne -C10 -A20+d+u" m"+f8p -Gl50/10S/160/10S -S10 \
     -T+l"-+" >> GMT_App_O_7.ps
     gmt psxy -R -J -O -SqD15d:+gblack+fwhite+Ld+o+u\\260 -Wthick transect.txt >> GMT_App_O_7.ps

The output is presented as Figure :ref:`Contour label 7 <Contour_label_7>`.

.. _Contour_label_7:

.. figure:: /_images/GMT_App_O_7.*
   :width: 500 px
   :align: center

   Another label attribute example.


Using a different data set for labels
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the next example we will use the bathymetry values along the transect
as our label, with placement determined by the distance along track. We
choose to place labels every 1500 km. To do this we need to pull out
those records whose distances are multiples of 1500 km and create a
"fixed points" file that can be used to place labels and specify the
labels. This is done with **awk**.

    ::

     gmt convert -i0,1,4 -Em150 transect.txt | $AWK '{print $1,$2,int($3)}' > fix2.txt
     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_8.ps
     gmt grdcontour geoid.nc -J -O -K -B20f10 -BWSne -C10 -A20+d+u" m"+f8p -Gl50/10S/160/10S \
                    -S10 -T+l"-+" >> GMT_App_O_8.ps
     gmt psxy -R -J -O -Sqffix2.txt:+g+an+p+Lf+u" m"+f8p -Wthick transect.txt >> GMT_App_O_8.ps

The output is presented as Figure :ref:`Contour label 8 <Contour_label_8>`.

.. _Contour_label_8:

.. figure:: /_images/GMT_App_O_8.*
   :width: 500 px
   :align: center

   Labels based on another data set (here bathymetry) while the placement is based on distances.


Putting it all together
-----------------------

Finally, we will make a more complex composite illustration that uses
several of the label placement and label attribute settings discussed in
the previous sections. We make a map showing the tsunami travel times
(in hours) from a hypothetical catastrophic landslide in the Canary
Islands [42]_. We lay down a color map based on the travel times and the
shape of the seafloor, and travel time contours with curved labels as
well as a few quoted lines. The final script is

    ::

     R=-R-85/5/10/55
     gmt grdgradient topo5.nc -Nt1 -A45 -Gtopo5_int.nc
     gmt set FORMAT_GEO_MAP ddd:mm:ssF FONT_ANNOT_PRIMARY +9p FONT_TITLE 22p
     gmt project -E-74/41 -C-17/28 -G10 -Q > great_NY_Canaries.txt
     gmt project -E-74/41 -C2.33/48.87 -G100 -Q > great_NY_Paris.txt
     km=`echo -17 28 | gmt mapproject -G-74/41/k -fg --FORMAT_FLOAT_OUT=%.0f -o2`
     cat << EOF > ttt.cpt
     0	lightred	3	lightred
     3	lightyellow	6	lightyellow
     6	lightgreen	100	lightgreen
     EOF
     gmt grdimage ttt_atl.nc -Itopo5_int.nc -Cttt.cpt $R -JM5.3i -P -K -nc+t1 > GMT_App_O_9.ps
     gmt grdcontour ttt_atl.nc -R -J -O -K -C0.5 -A1+u" hour"+v+f8p,Bookman-Demi \
                    -GL80W/31N/17W/26N,17W/28N/17W/50N -S2 >> GMT_App_O_9.ps
     gmt psxy -R -J -Wfatter,white great_NY_Canaries.txt -O -K  >> GMT_App_O_9.ps
     gmt pscoast -R -J -B20f5 -BWSne+t"Tsunami travel times from the Canaries" -N1/thick -O -K \
                 -Glightgray -Wfaint -A500 >> GMT_App_O_9.ps
     gmt convert great_NY_*.txt -E | gmt psxy -R -J -O -K -Sa0.15i -Gred -Wthin >> GMT_App_O_9.ps
     gmt psxy -R -J -Wthick great_NY_Canaries.txt -O -K \
              -Sqn1:+f8p,Times-Italic+l"Distance Canaries to New York = $km km"+ap+v >> GMT_App_O_9.ps
     gmt psxy -R -J great_NY_Paris.txt -O -K -Sc0.08c -Gblack >> GMT_App_O_9.ps
     gmt psxy -R -J -Wthinner great_NY_Paris.txt -SqD1000k:+an+o+gblue+LDk+f7p,Helvetica-Bold,white \
              -O -K >> GMT_App_O_9.ps
     cat << EOF | gmt pstext -R -J -O -K -Gwhite -Wthin -Dj0.1i/0.1i -F+f8p,Bookman-Demi+j \
                             >> GMT_App_O_9.ps
     74W	41N	RT	New York
     2.33E	48.87N	CT	Paris
     17W	28N	CT	Canaries
     EOF
     gmt psxy -R -J -O -T >> GMT_App_O_9.ps

with the complete illustration presented as Figure
:ref:`Contour label 9 <Contour_label_9>`.

.. _Contour_label_9:

.. figure:: /_images/GMT_App_O_9.*
   :width: 500 px
   :align: center

   Tsunami travel times from the Canary Islands to places in the Atlantic,
   in particular New York. Should a catastrophic landslide occur it is possible
   that New York will experience a large tsunami about 8 hours after the event.


