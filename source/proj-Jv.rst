-Jv：Van der Grinten projection
===============================

The Van der Grinten projection, presented by Alphons J. van der Grinten
in 1904, is neither equal-area nor conformal. Central meridian and
Equator are straight lines; other meridians are arcs of circles. The
scale is true along the Equator only. Its main use is to show the entire
world enclosed in a circle. To use it you must enter

-  The central meridian [Middle of your map].

-  Scale along equator in inch/degree or 1:xxxxx (**-Jv**), or map width (**-JV**).

Centered on the Dateline, the example below was created by this command:

    ::

      gmt pscoast -Rg -JV4i -Bxg30 -Byg15 -Dc -Glightgray -A10000 \
                  -Wthinnest -P > GMT_grinten.ps

.. figure:: /images/GMT_grinten.*
   :width: 400 px
   :align: center

   World map using the Van der Grinten projection.
