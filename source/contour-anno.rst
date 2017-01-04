等值线标注和“线段引用”
=======================

对于2维网格数据和3维表数据，GMT分别采用 :doc:`grdcontour` 
和 :doc:`pscontour` 模块来绘制等值线。
在需要为等值线附加标签的时候，如何优化标签的位置是一个很困难的主题。
GMT提供了不同的算法确定标签的位置，并且可以自由的指定标签的属性。
由于选择比较多，本章总结了不同的选项，并给出了一些应用实例。

标签的位置
---------------

在不同版本的GMT当中，确定标签位置的算法个数不同，GMT1--3中只提供了1种
算法，GMT4中则提供了5种算法。
另外，在 :doc:`psxy` 和 :doc:`psxyz` 模块中增加了一个新的符号选项
(**-Sq** "线段引用") 也可以采用这些算法来确定线段标签的位置。
等值线绘制模块中，需要在 **-G** 选项中以不同字符来指定标签位置的算法，
线段绘制模块中，则需要在 **-Sq**  选项中指定标签位置的算法。
附加给这两个选项的信息是完全相同的，采用 [**字符**]\ *参数*\ 的格式，
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

Label Attributes
----------------

Determining where to place labels is half the battle. The other half is
to specify exactly what are the attributes of the labels. It turns out
that there are quite a few possible attributes that we may want to
control, hence understanding how to specify these attributes becomes
important. In the contouring programs, one or more attributes may be
appended to the **-A** option using the format +\ *code*\ [*args*\ ] for
each attribute, whereas for the line plotting programs these attributes
are appended to the **-Sq** option following a colon (:) that separates
the label codes from the placement algorithm. Several of the attributes
do not apply to contours so we start off with listing those that apply
universally. These codes are:

+a:
    Controls the angle of the label relative to the angle of the line.
    Append **n** for normal to the line, give a fixed *angle* measured
    counter-clockwise relative to the horizontal. or append **p** for
    parallel to the line [Default]. If using
    :doc:`grdcontour` the latter option
    you may further append **u** or **d** to get annotations whose upper
    edge always face the next higher or lower contour line.

+c:
    Surrounding each label is an imaginary label "textbox" which defines
    a region in which no segment lines should be visible. The initial
    box provides an exact fit to the enclosed text but clearance may be
    extended in both the horizontal and vertical directions (relative to
    the label baseline) by the given amounts. If these should be
    different amounts please separate them by a slash; otherwise the
    single value applies to both directions. Append the distance units
    of your choice (**c\ \|\ i\ \|\ m\ \|\ p**), or
    give % to indicate that the clearance should be this fixed
    percentage of the label font size in use. The default is 15%.

+d:
    Debug mode. This is useful when testing contour placement as it will
    draw the normally invisible helper lines and points in the label
    placement algorithms above.

+d:
    Delayed mode, to delay the plotting of the text as text clipping is set instead.

+f:
    Specifies the desired label font, including size or color. See
    :doc:`pstext` for font names or numbers.
    The default font is given by :ref:`FONT_ANNOT_PRIMARY <FONT_ANNOT_PRIMARY>`.

+g:
    Selects opaque rather than the default transparent text boxes. You
    may optionally append the color you want to fill the label boxes;
    the default is the same as :ref:`PS_PAGE_COLOR <PS_PAGE_COLOR>`.

+j:
    Selects the justification of the label relative to the placement
    points determined above. Normally this is center/mid justified
    (**CM** in :doc:`pstext` justification
    parlance) and this is indeed the default setting. Override by using
    this option and append another justification key code from
    [**L\ \|\ C\ \|\ R**\ ][**B\ \|\ M\ \|\ T**\ ].
    Note for curved text (**+v**) only vertical justification will be
    affected.

+o:
    Request a rounded, rectangular label box shape; the default is
    rectangular. This is only manifested if the box is filled or
    outlined, neither of which is implied by this option alone (see
    **+g** and **+p**). As this option only applies to straight text, it
    is ignored if **+v** is given.

+p:
    Selects the drawing of the label box outline; append your preferred
    *pen* unless you want the default GMT pen [0.25p,black].

+r:
    Do not place labels at points along the line whose local radius of
    curvature falls below the given threshold value. Append the radius
    unit of your choice (**c\ \|\ i\ \|\ p**) [Default is 0].

+u:
    Append the chosen *unit* to the label. Normally a space will
    separate the label and the unit. If you want to close this gap,
    append a *unit* that begins with a hyphen (-). If you are contouring
    with :doc:`grdcontour` and you specify
    this option without appending a unit, the unit will be taken from
    the *z*-unit attribute of the grid header.

+v:
    Place curved labels that follow the wiggles of the line segments.
    This is especially useful if the labels are long relative to the
    length-scale of the wiggles. The default places labels on an
    invisible straight line at the angle determined.

+w:
    The angle of the line at the point of straight label placement is
    calculated by a least-squares fit to the *width* closest points. If
    not specified, *width* defaults to 10.

+=:
    Similar in most regards to **+u** but applies instead to a label
    *prefix* which you must append.

For contours, the label will be the value of the contour (possibly
modified by **+u** or **+=**). However, for quoted lines other options apply:

+l:
    Append a fixed *label* that will be placed at all label locations.
    If the label contains spaces you must place it inside matching
    quotes.

+L:
    Append a code *flag* that will determine the label. Available codes
    are:

    +Lh:
        Take the label from the current multi-segment header (hence it
        is assumed that the input line segments are given in the
        multi-segment file format; if not we pick the single label from
        the file's header record). We first scan the header for an
        embedded **-L**\ *label* option; if none is found we instead use
        the first word following the segment marker [>].

    +Ld:
        Take the Cartesian plot distances along the line as the label;
        append **c\ \|\ i\ \|\ p** as the unit [Default is
        :ref:`PROJ_LENGTH_UNIT <PROJ_LENGTH_UNIT>`]. The label will be formatted according
        to the :ref:`FORMAT_FLOAT_OUT <FORMAT_FLOAT_OUT>` string, *unless* label placement
        was determined from map distances along the segment lines, in
        which case we determine the appropriate format from the distance
        value itself.

    +LD:
        Calculate actual Earth surface distances and use the distance at
        the label placement point as the label; append
        **d\ \|\ e\ \|\ f\ \|\ k\ \|\ m\ \|\ M\ \|\ n\ \|\ s**
        to specify the unit [If not given we default to **d**\ egrees,
        *unless* label placement was determined from map distances along
        the segment lines, in which case we use the same unit specified
        for that algorithm]. Requires a map projection to be used.

    +Lf:
        Use all text after the 2nd column in the fixed label location
        file *fix.txt* as labels. This choice obviously requires the
        fixed label location algorithm (code **f**) to be in effect.

    +Ln:
        Use the running number of the current multi-segment as label.

    +LN:
        Use a slash-separated combination of the current file number and
        the current multi-segment number as label.

    +Lx:
        As **h** but use the multi-segment headers in the *cross.d* file
        instead. This choice obviously requires the crossing segments
        location algorithm (code **x\ \|\ X**) to be in effect.

Examples of Contour Label Placement
-----------------------------------

We will demonstrate the use of these options with a few simple examples.
First, we will contour a subset of the global geoid data used in
Example :ref:`example_01`; the region selected encompasses the world's strongest
"geoid dipole": the Indian Low and the New Guinea High.

Equidistant labels
~~~~~~~~~~~~~~~~~~

Our first example uses the default placement algorithm. Because of the
size of the map we request contour labels every 1.5 inches along the
lines:

    ::

     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_1.ps
     gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+f8p -Gd1.5i -S10 -T+lLH >> GMT_App_O_1.ps

As seen in Figure :ref:`Contour label 1 <Contour_label_1>`, the contours are
placed rather arbitrary. The string of contours for -40 to
60 align well but that is a fortuitous consequence of reaching
the 1.5 inch distance from the start at the bottom of the map.

.. _Contour_label_1:

.. figure:: /_images/GMT_App_O_1.*
   :width: 500 px
   :align: center

   Equidistant contour label placement with **-Gd**, the only algorithm
   available in previous GMT versions.


Fixed number of labels
~~~~~~~~~~~~~~~~~~~~~~

We now exercise the option for specifying exactly how many labels each
contour line should have:

    ::

     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_2.ps
     gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+f8p -Gn1/1i -S10 -T+lLH >> GMT_App_O_2.ps

By selecting only one label per contour and requiring that labels only
be placed on contour lines whose length exceed 1 inch, we achieve the
effect shown in Figure :ref:`Contour label 2 <Contour_label_2>`.

.. _Contour_label_2:

.. figure:: /_images/GMT_App_O_2.*
   :width: 500 px
   :align: center

   Placing one label per contour that exceed 1 inch in length, centered on the segment with **-Gn**.


Prescribed label placements
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Here, we specify four points where we would like contour labels to be
placed. Our points are not exactly on the contour lines so we give a
nonzero "slop" to be used in the distance calculations: The point on the
contour closest to our fixed points and within the given maximum
distance will host the label.

    ::

     cat << EOF > fix.txt
     80      -8.5
     55      -7.5
     102     0
     130     10.5
     EOF
     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_3.ps
     gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+d+f8p -Gffix.txt/0.1i -S10 -T+lLH >> GMT_App_O_3.ps

The angle of the label is evaluated from the contour line geometry, and
the final result is shown in Figure :ref:`Contour label 3 <Contour_label_3>`.
To aid in understanding the algorithm we chose to specify "debug" mode
(**+d**) which placed a small circle at each of the fixed points.

.. _Contour_label_3:

.. figure:: /_images/GMT_App_O_3.*
   :width: 500 px
   :align: center

   Four labels are positioned on the points along the contours that are
   closest to the locations given in the file fix.txt in the **-Gf** option.


Label placement at simple line intersections
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Often, it will suffice to place contours at the imaginary intersections
between the contour lines and a well-placed straight line segment. The
**-Gl** or **-GL** algorithms work well in those cases:

    ::

      gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_4.ps
      gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+d+f8p -GLZ-/Z+ -S10 -T+lLH >> GMT_App_O_4.ps

The obvious choice in this example is to specify a great circle between
the high and the low, thus placing all labels between these extrema.

.. _Contour_label_4:

.. figure:: /_images/GMT_App_O_4.*
   :width: 500 px
   :align: center

   Labels are placed at the intersections between contours and the great circle specified in the **-GL** option.


The thin debug line in Figure :ref:`Contour label 4 <Contour_label_4>` shows
the great circle and the intersections where labels are plotted. Note
that any number of such lines could be specified; here we are content
with just one.

Label placement at general line intersections
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If (1) the number of intersecting straight line segments needed to pick
the desired label positions becomes too large to be given conveniently
on the command line, or (2) we have another data set or lines whose
intersections we wish to use, the general crossing algorithm makes more
sense:

    ::

     gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_App_O_5.ps
     gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+d+f8p -GXcross.txt -S10 -T+lLH >> GMT_App_O_5.ps

.. _Contour_label_5:

.. figure:: /_images/GMT_App_O_5.*
   :width: 500 px
   :align: center

   Labels are placed at the intersections between contours and the
   multi-segment lines specified in the **-GX** option.


In this case, we have created three strands of lines whose intersections
with the contours define the label placements, presented in
Figure :ref:`Contour label 5 <Contour_label_5>`.

Examples of Label Attributes
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


Special Operations
==================

.. _Isolation mode:

Running GMT in *isolation mode*
-------------------------------

In Chapter `General features`_ it is described how GMT creates
several (temporary) files to communicate between the different commands
that make up the script that finally creates a plot. Among those files
are:

