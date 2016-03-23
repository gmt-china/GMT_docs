-Jm：Mercator projection
========================

Probably the most famous of the various map projections, the Mercator
projection takes its name from the Flemish cartographer Gheert Cremer,
better known as Gerardus Mercator, who presented it in 1569. The
projection is a cylindrical and conformal, with no distortion along the
equator. A major navigational feature of the projection is that a line
of constant azimuth is straight. Such a line is called a rhumb line or
*loxodrome*. Thus, to sail from one point to another one only had to
connect the points with a straight line, determine the azimuth of the
line, and keep this constant course for the entire voyage . The
Mercator projection has been used extensively for world maps in which
the distortion towards the polar regions grows rather large, thus
incorrectly giving the impression that, for example, Greenland is larger
than South America. In reality, the latter is about eight times the size
of Greenland. Also, the Former Soviet Union looks much bigger than
Africa or South America. One may wonder whether this illusion has had
any influence on U.S. foreign policy.

In the regular Mercator projection, the cylinder touches the globe along
the equator. Other orientations like vertical and oblique give rise to
the Transverse and Oblique Mercator projections, respectively. We will
discuss these generalizations following the regular Mercator projection.

The regular Mercator projection requires a minimum of parameters. To use
it in GMT programs you supply this information (the first two items
are optional and have defaults):

-  Central meridian [Middle of your map].

-  Standard parallel for true scale [Equator]. When supplied, central
   meridian must be supplied as well.

-  Scale along the equator in inch/degree or 1:xxxxx (**-Jm**), or map
   width (**-JM**).

Our example presents a world map at a scale of 0.012 inch pr degree
which will give a map 4.32 inch wide. It was created with the command:

   ::

    gmt set MAP_FRAME_TYPE fancy
    gmt pscoast -R0/360/-70/70 -Jm1.2e-2i -Bxa60f15 -Bya30f15 -Dc -A5000 -Gred \
                -P > GMT_mercator.ps

.. figure:: /images/GMT_mercator.*
   :width: 500 px
   :align: center

   Simple Mercator map.


While this example is centered on the Dateline, one can easily choose
another configuration with the **-R** option. A map centered on
Greenwich would specify the region with **-R**-180/180/-70/70.
