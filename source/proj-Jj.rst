-Jj：Miller Cylindrical projection
==================================

This cylindrical projection, presented by Osborn Maitland Miller of the
American Geographic Society in 1942, is neither equal nor conformal. All
meridians and parallels are straight lines. The projection was designed
to be a compromise between Mercator and other cylindrical projections.
Specifically, Miller spaced the parallels by using Mercator's formula
with 0.8 times the actual latitude, thus avoiding the singular poles;
the result was then divided by 0.8. There is only a spherical form for
this projection. Specify the projection by:

-  Optionally, the central meridian (default is the middle of your map).

-  Scale in inch/degree or as 1:xxxxx (**-Jj**), or map width (**-JJ**).

For instance, a world map centered on the 90ºE meridian at a map scale of
1:400,000,000 (Figure :ref:`Miller projection <GMT_miller>`) can be obtained as
follows:

   ::

    gmt pscoast -R-90/270/-80/90 -Jj1:400000000 -Bx45g45 -By30g30 -Dc -A10000 \
                -Gkhaki -Wthinnest -P -Sazure > GMT_miller.ps

.. _GMT_miller:

.. figure:: /images/GMT_miller.*
   :width: 500 px
   :align: center

   World map using the Miller cylindrical projection.
