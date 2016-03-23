-Ja：Lambert Azimuthal Equal-Area
=================================

This projection was developed by Lambert in 1772 and is typically used
for mapping large regions like continents and hemispheres. It is an
azimuthal, equal-area projection, but is not perspective. Distortion is
zero at the center of the projection, and increases radially away from
this point. To define this projection in GMT you must provide the
following information:

-  Longitude and latitude of the projection center.

-  Optionally, the horizon, i.e., the number of degrees from the center
   to the edge (<= 180, default is 90).

-  Scale as 1:xxxxx or as radius/latitude where radius is the projected
   distance on the map from projection center to an oblique latitude where 0
   would be the oblique Equator
   (**-Ja**), or map width (**-JA**).

Two different types of maps can be made with this projection depending
on how the region is specified. We will give examples of both types.

Rectangular map
---------------

In this mode we define our region by specifying the longitude/latitude
of the lower left and upper right corners instead of the usual *west,
east, south, north* boundaries. The reason for specifying our area this
way is that for this and many other projections, lines of equal
longitude and latitude are not straight lines and are thus poor choices
for map boundaries. Instead we require that the map boundaries be
rectangular by defining the corners of a rectangular map boundary. Using
0ºE/40ºS (lower left) and 60ºE/10ºS (upper right) as our corners we try

   ::

    gmt set FORMAT_GEO_MAP ddd:mm:ssF MAP_GRID_CROSS_SIZE_PRIMARY 0
    gmt pscoast -R0/-40/60/-10r -JA30/-30/4.5i -Bag -Dl -A500 -Gp300/10 \
                -Wthinnest -P > GMT_lambert_az_rect.ps

.. figure:: /images/GMT_lambert_az_rect.*
   :width: 500 px
   :align: center

   Rectangular map using the Lambert azimuthal equal-area projection.


Note that an "r" is appended to the **-R** option to inform GMT that
the region has been selected using the rectangle technique, otherwise it
would try to decode the values as *west, east, south, north* and report
an error since *'east'* < *'west'*.

Hemisphere map
--------------

Here, you must specify the world as your region (**-Rg** or
**-Rd**). E.g., to obtain a hemisphere view that shows the Americas, try

   ::

    gmt pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P > GMT_lambert_az_hemi.ps

.. figure:: /images/GMT_lambert_az_hemi.*
   :width: 400 px
   :align: center

   Hemisphere map using the Lambert azimuthal equal-area projection.


To geologists, the Lambert azimuthal equal-area projection (with origin
at 0/0) is known as the *equal-area* (Schmidt) stereonet and used for
plotting fold axes, fault planes, and the like. An *equal-angle* (Wulff)
stereonet can be obtained by using the stereographic projection
(discussed later). The stereonets produced by these two projections appear below.

.. _GMT_stereonets:

.. figure:: /images/GMT_stereonets.*
   :width: 500 px
   :align: center

   Equal-Area (Schmidt) and Equal-Angle (Wulff) stereo nets.
