-Jb：Albers conic equal-area projection
=======================================

This projection, developed by Albers in 1805, is predominantly used to
map regions of large east-west extent, in particular the United States.
It is a conic, equal-area projection, in which parallels are unequally
spaced arcs of concentric circles, more closely spaced at the north and
south edges of the map. Meridians, on the other hand, are equally spaced
radii about a common center, and cut the parallels at right angles.
Distortion in scale and shape vanishes along the two standard parallels.
Between them, the scale along parallels is too small; beyond them it is
too large. The opposite is true for the scale along meridians. To define
the projection in GMT you need to provide the following information:

-  Longitude and latitude of the projection center.

-  Two standard parallels.

-  Map scale in inch/degree or 1:xxxxx notation (**-Jb**), or map width (**-JB**).

Note that you must include the "1:" if you choose to specify the scale
that way. E.g., you can say 0.5 which means 0.5 inch/degree or 1:200000
which means 1 inch on the map equals 200,000 inches along the standard
parallels. The projection center defines the origin of the rectangular
map coordinates. As an example we will make a map of the region near
Taiwan. We choose the center of the projection to be at 125ºE/20ºN and
25ºN and 45ºN as our two standard parallels. We desire a map that is 5
inches wide. The complete command needed to generate the map below is
therefore given by:

   ::

    gmt set MAP_GRID_CROSS_SIZE_PRIMARY 0
    gmt pscoast -R110/140/20/35 -JB125/20/25/45/5i -Bag -Dl -Ggreen -Wthinnest \
                -A250 -P > GMT_albers.ps

.. figure:: /images/GMT_albers.*
   :width: 500 px
   :align: center

   Albers equal-area conic map projection.
