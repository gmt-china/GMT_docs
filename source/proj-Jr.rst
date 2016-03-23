-Jr：Winkel Tripel projection
=============================

In 1921, the German mathematician Oswald Winkel a projection that was to
strike a compromise between the properties of three elements (area,
angle and distance). The German word "tripel" refers to this junction of
where each of these elements are least distorted when plotting global
maps. The projection was popularized when Bartholomew and Son started to
use it in its world-renowned "The Times Atlas of the World" in the mid
20th century. In 1998, the National Geographic Society made the Winkel
Tripel as its map projection of choice for global maps.

Naturally, this projection is neither conformal, nor equal-area. Central
meridian and equator are straight lines; other parallels and meridians
are curved. The projection is obtained by averaging the coordinates of
the Equidistant Cylindrical and Aitoff (not Hammer-Aitoff) projections.
The poles map into straight lines 0.4 times the length of equator. To
use it you must enter

-  The central meridian [Middle of your map].

-  Scale along equator in inch/degree or 1:xxxxx (**-Jr**), or map width (**-JR**).

Centered on Greenwich, the example in Figure :ref:`Winkel Tripel projection
<GMT_winkel>` was created by this command:

   ::

    gmt pscoast -Rd -JR4.5i -Bg -Dc -A10000 -Gburlywood4 -Swheat1 -P > GMT_winkel.ps

.. _GMT_winkel:

.. figure:: /images/GMT_winkel.*
   :width: 500 px
   :align: center

   World map using the Winkel Tripel projection.
