-Jcyl_stere：Cylindrical stereographic projections
==================================================

The cylindrical stereographic projections are certainly not as notable
as other cylindrical projections, but are still used because of their
relative simplicity and their ability to overcome some of the downsides
of other cylindrical projections, like extreme distortions of the higher
latitudes. The stereographic projections are perspective projections,
projecting the sphere onto a cylinder in the direction of the antipodal
point on the equator. The cylinder crosses the sphere at two standard
parallels, equidistant from the equator. The projections are defined by:

-  The central meridian (uses the middle of the map when omitted).

-  The standard parallel (default is the Equator). When used, central
   meridian needs to be given as well.

-  Scale in inch/degree or as 1:xxxxx (**-Jcyl_stere**), or map width
   (**-JCyl_stere**)

Some of the selections of the standard parallel are named for the
cartographer or publication that popularized the projection
(Table :ref:`JCylstere <tbl-JCylstere>`).

.. _tbl-JCylstere:

+---------------------------------------------------------+-------------+
+=========================================================+=============+
| Miller's modified Gall                                  | 66.159467º  |
+---------------------------------------------------------+-------------+
| Kamenetskiy's First                                     | 55º         |
+---------------------------------------------------------+-------------+
| Gall's stereographic                                    | 45º         |
+---------------------------------------------------------+-------------+
| Bolshoi Sovietskii Atlas Mira or Kamenetskiy's Second   | 30º         |
+---------------------------------------------------------+-------------+
| Braun's cylindrical                                     | 0º          |
+---------------------------------------------------------+-------------+

A map of the world, centered on the Greenwich meridian, using the Gall's
stereographic projection (standard parallel is 45º,
Figure :ref:`Gall's stereographic projection <GMT_gall_stereo>`),
is obtained as follows:

   ::

    gmt set FORMAT_GEO_MAP dddA
    gmt pscoast -R-180/180/-60/80 -JCyl_stere/0/45/4.5i -Bxa60f30g30 -Bya30g30 -Dc -A5000 \
                -Wblack -Gseashell4 -Santiquewhite1 -P > GMT_gall_stereo.ps

.. _GMT_gall_stereo:

.. figure:: /images/GMT_gall_stereo.*
   :width: 500 px
   :align: center

   World map using Gall's stereographic projection.
