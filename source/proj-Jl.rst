-Jl：Lambert conic conformal projection
=======================================

This conic projection was designed by the Alsatian mathematician Johann
Heinrich Lambert (1772) and has been used extensively for mapping of
regions with predominantly east-west orientation, just like the Albers
projection. Unlike the Albers projection, Lambert's conformal projection
is not equal-area. The parallels are arcs of circles with a common
origin, and meridians are the equally spaced radii of these circles. As
with Albers projection, it is only the two standard parallels that are
distortion-free. To select this projection in GMT you must provide the
same information as for the Albers projection, i.e.,

-  Longitude and latitude of the projection center.

-  Two standard parallels.

-  Map scale in inch/degree or 1:xxxxx notation (**-Jl**), or map width (**-JL**).

The Lambert conformal projection has been used for basemaps for all the
48 contiguous States with the two fixed standard parallels 33ºN and 45ºN.
We will generate a map of the continental USA using these parameters.
Note that with all the projections you have the option of selecting a
rectangular border rather than one defined by meridians and parallels.
Here, we choose the regular WESN region, a "fancy" basemap frame, and
use degrees west for longitudes. The generating commands used were

   ::

    gmt set MAP_FRAME_TYPE FANCY FORMAT_GEO_MAP ddd:mm:ssF MAP_GRID_CROSS_SIZE_PRIMARY 0.05i
    gmt pscoast -R-130/-70/24/52 -Jl-100/35/33/45/1:50000000 -Bag -Dl -N1/thick,red \
                -N2/thinner -A500 -Gtan -Wthinnest,white -Sblue -P > GMT_lambert_conic.ps

.. figure:: /images/GMT_lambert_conic.*
   :width: 500 px
   :align: center

   Lambert conformal conic map projection.


The choice for projection center does not affect the projection but it
indicates which meridian (here 100ºW) will be vertical on the map. The
standard parallels were originally selected by Adams to provide a
maximum scale error between latitudes 30.5ºN and 47.5ºN of 0.5--1%. Some
areas, like Florida, experience scale errors of up to 2.5%.
