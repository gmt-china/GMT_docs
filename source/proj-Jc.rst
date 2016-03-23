-Jc：Cassini cylindrical projection
===================================

This cylindrical projection was developed in 1745 by César-François
Cassini de Thury for the survey of France. It is occasionally called
Cassini-Soldner since the latter provided the more accurate mathematical
analysis that led to the development of the ellipsoidal formulae. The
projection is neither conformal nor equal-area, and behaves as a
compromise between the two end-members. The distortion is zero along the
central meridian. It is best suited for mapping regions of north-south
extent. The central meridian, each meridian 90º away, and equator are
straight lines; all other meridians and parallels are complex curves.
The requirements to define this projection are:

-  Longitude and latitude of central point.

-  Scale in inch/degree or as 1:xxxxx (**-Jc**), or map width (**-JC**).

A detailed map of the island of Sardinia centered on the 8º45'E meridian
using the Cassini projection can be obtained by running the command:

   ::

    gmt pscoast -R7:30/38:30/10:30/41:30r -JC8.75/40/2.5i -Bafg -LjBR+c40+w100+f+o0.15i/0.2i \
        -Gspringgreen  -Dh -Sazure -Wthinnest -Ia/thinner -P --FONT_LABEL=12p > GMT_cassini.ps


.. figure:: /images/GMT_cassini.*
   :width: 400 px
   :align: center

   Cassini map over Sardinia.

As with the previous projections, the user can choose between a
rectangular boundary (used here) or a geographical (WESN) boundary.
