-Jt：Transverse Mercator projection
===================================

The transverse Mercator was invented by Lambert in 1772. In this
projection the cylinder touches a meridian along which there is no
distortion. The distortion increases away from the central meridian and
goes to infinity at 90º from center. The central meridian, each meridian
90º away from the center, and equator are straight lines; other parallels
and meridians are complex curves. The projection is defined by
specifying:

-  The central meridian.

-  Optionally, the latitude of origin (default is the equator).

-  Scale along the equator in inch/degree or 1:xxxxx (**-Jt**), or map
   width (**-JT**).

The optional latitude of origin defaults to Equator if not specified.
Although defaulting to 1, you can change the map scale factor via the
:ref:`PROJ_SCALE_FACTOR <PROJ_SCALE_FACTOR>` parameter. Our example shows a transverse
Mercator map of south-east Europe and the Middle East with 35ºE as the
central meridian:

   ::

    gmt pscoast -R20/30/50/45r -Jt35/0.18i -Bag -Dl -A250 -Glightbrown -Wthinnest \
                -P -Sseashell > GMT_transverse_merc.ps

.. figure:: /images/GMT_transverse_merc.*
   :width: 500 px
   :align: center

   Rectangular Transverse Mercator map.


The transverse Mercator can also be used to generate a global map - the
equivalent of the 360º Mercator map. Using the command

   ::

    gmt pscoast -R0/360/-80/80 -JT330/-45/3.5i -Ba30g -BWSne -Dc -A2000 \
                -Slightblue -G0 -P > GMT_TM.ps

we made the map illustrated in Figure :ref:`Global transverse Mercator
<GMT_TM>`. Note that
when a world map is given (indicated by **-R**\ *0/360/s/n*), the
arguments are interpreted to mean oblique degrees, i.e., the 360º range
is understood to mean the extent of the plot along the central meridian,
while the "south" and "north" values represent how far from the central
longitude we want the plot to extend. These values correspond to
latitudes in the regular Mercator projection and must therefore be less
than 90.

.. _GMT_TM:

.. figure:: /images/GMT_TM.*
   :width: 450 px
   :align: center

   A global transverse Mercator map.
