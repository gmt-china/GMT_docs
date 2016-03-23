-Jy：Cylindrical equal-area projections
=======================================

This cylindrical projection is actually several projections, depending
on what latitude is selected as the standard parallel. However, they are
all equal area and hence non-conformal. All meridians and parallels are
straight lines. The requirements to define this projection are:

-  The central meridian.

-  The standard parallel.

-  Scale in inch/degree or as 1:xxxxx (**-Jy**), or map width (**-JY**)

While you may choose any value for the standard parallel and obtain your
own personal projection, there are seven choices of standard parallels
that result in known (or named) projections. These are listed in Table :ref:`JY <tbl-JY>`.

.. _tbl-JY:

   +-------------------+---------------------+
   +===================+=====================+
   | Balthasart        | 50º                 |
   +-------------------+---------------------+
   | Gall-Peters       | 45º                 |
   +-------------------+---------------------+
   | Hobo-Dyer         | 37º30' (= 37.5º)    |
   +-------------------+---------------------+
   | Trystan Edwards   | 37º24' (= 37.4º)    |
   +-------------------+---------------------+
   | Caster            | 37º04' (= 37.0666º) |
   +-------------------+---------------------+
   | Behrman           | 30º                 |
   +-------------------+---------------------+
   | Lambert           | 0º                  |
   +-------------------+---------------------+

For instance, a world map centered on the 35ºE meridian using the Behrman
projection (Figure :ref:`Behrman cylindrical projection <GMT_general_cyl>`)
can be obtained by running the command:

   ::

    gmt pscoast -R-145/215/-90/90 -JY35/30/4.5i -B45g45 -Dc -A10000 -Sdodgerblue \
                -Wthinnest -P > GMT_general_cyl.ps

.. _GMT_general_cyl:

.. figure:: /images/GMT_general_cyl.*
   :width: 600 px
   :align: center

   World map using the Behrman cylindrical equal-area projection.


As one can see there is considerable distortion at high latitudes since
the poles map into lines.
