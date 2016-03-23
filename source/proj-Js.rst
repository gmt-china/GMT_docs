-Js：Stereographic Equal-Angle projection
=========================================

This is a conformal, azimuthal projection that dates back to the Greeks.
Its main use is for mapping the polar regions. In the polar aspect all
meridians are straight lines and parallels are arcs of circles. While
this is the most common use it is possible to select any point as the
center of projection. The requirements are

-  Longitude and latitude of the projection center.

-  Optionally, the horizon, i.e., the number of degrees from the center
   to the edge (< 180, default is 90).

-  Scale as 1:xxxxx (true scale at pole), slat/1:xxxxx (true scale at
   standard parallel slat), or radius/latitude where radius is distance
   on map in inches from projection center to a particular
   oblique latitude (**-Js**), or simply map width (**-JS**).

A default map scale factor of 0.9996 will be applied by default
(although you may change this with :ref:`PROJ_SCALE_FACTOR <PROJ_SCALE_FACTOR>`). However,
the setting is ignored when a standard parallel has been specified since
the scale is then implicitly given. We will look at two different types
of maps.

Polar Stereographic Map
-----------------------

In our first example we will let the projection center be at the north
pole. This means we have a polar stereographic projection and the map
boundaries will coincide with lines of constant longitude and latitude.
An example is given by

   ::

    gmt pscoast -R-30/30/60/72 -Js0/90/4.5i/60 -B10g -Dl -A250 -Groyalblue \
                -Sseashell -P > GMT_stereographic_polar.ps

.. figure:: /images/GMT_stereographic_polar.*
   :width: 500 px
   :align: center

   Polar stereographic conformal projection.


Rectangular stereographic map
-----------------------------

As with Lambert's azimuthal equal-area projection we have the option to
use rectangular boundaries rather than the wedge-shape typically
associated with polar projections. This choice is defined by selecting
two points as corners in the rectangle and appending an "r" to the
**-R** option. This command produces a map as presented in
Figure :ref:`Polar stereographic <GMT_stereographic_rect>`:

   ::

    gmt set MAP_ANNOT_OBLIQUE 30
    gmt pscoast -R-25/59/70/72r -JS10/90/11c -B20g -Dl -A250 -Gdarkbrown -Wthinnest \
                -Slightgray -P > GMT_stereographic_rect.ps

.. _GMT_stereographic_rect:

.. figure:: /images/GMT_stereographic_rect.*
   :width: 500 px
   :align: center

   Polar stereographic conformal projection with rectangular borders.


General stereographic map
-------------------------

In terms of usage this projection is identical to the Lambert azimuthal
equal-area projection. Thus, one can make both rectangular and
hemispheric maps. Our example shows Australia using a projection pole at
130ºE/30ºS. The command used was

   ::

    gmt set MAP_ANNOT_OBLIQUE 0
    gmt pscoast -R100/-42/160/-8r -JS130/-30/4i -Bag -Dl -A500 -Ggreen -Slightblue \
                -Wthinnest -P > GMT_stereographic_general.ps

.. figure:: /images/GMT_stereographic_general.*
   :width: 500 px
   :align: center

   General stereographic conformal projection with rectangular borders.


By choosing 0/0 as the pole, we obtain the conformal stereonet presented
next to its equal-area cousin on the Lambert
azimuthal equal-area projection (Figure :ref:`Stereonets <GMT_stereonets>`).