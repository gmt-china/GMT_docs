-Ji：Sinusoidal projection
===========================

The sinusoidal projection is one of the oldest known projections, is
equal-area, and has been used since the mid-16th century. It has also
been called the "Equal-area Mercator" projection. The central meridian
is a straight line; all other meridians are sinusoidal curves. Parallels
are all equally spaced straight lines, with scale being true along all
parallels (and central meridian). To use it, you need to select:

-  The central meridian [Middle of your map].

-  Scale along equator in inch/degree or 1:xxxxx (**-Ji**), or map width
   (**-JI**).

A simple world map using the sinusoidal projection is therefore obtained by

   ::

     gmt pscoast -Rd -JI4.5i -Bxg30 -Byg15 -Dc -A10000 -Ggray -P > GMT_sinusoidal.ps

.. figure:: /images/GMT_sinusoidal.*
   :width: 500 px
   :align: center

   World map using the Sinusoidal projection.

To reduce distortion of shape the interrupted sinusoidal projection was
introduced in 1927. Here, three symmetrical segments are used to cover
the entire world. Traditionally, the interruptions are at 160ºW, 20ºW, and
60ºE. To make the interrupted map we must call
``pscoast`` for each segment and superpose
the results. To produce an interrupted world map (with the traditional
boundaries just mentioned) that is 5.04 inches wide we use the scale
5.04/360 = 0.014 and offset the subsequent plots horizontally by their
widths (140\ :math:`\cdot`\ 0.014 and 80\ :math:`\cdot`\ 0.014):

   ::

     gmt pscoast -R200/340/-90/90 -Ji0.014i -Bxg30 -Byg15 -A10000 -Dc \
                 -Gblack -K -P > GMT_sinus_int.ps
     gmt pscoast -R-20/60/-90/90 -Ji0.014i -Bxg30 -Byg15 -Dc -A10000 \
                 -Gblack -X1.96i -O -K >> GMT_sinus_int.ps
     gmt pscoast -R60/200/-90/90 -Ji0.014i -Bxg30 -Byg15 -Dc -A10000 \
                 -Gblack -X1.12i -O >> GMT_sinus_int.ps

.. figure:: /images/GMT_sinus_int.*
   :width: 500 px
   :align: center

   World map using the Interrupted Sinusoidal projection.


The usefulness of the interrupted sinusoidal projection is basically
limited to display of global, discontinuous data distributions like
hydrocarbon and mineral resources, etc.
