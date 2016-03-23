-Jh：Hammer projection
======================

The equal-area Hammer projection, first presented by the German
mathematician Ernst von Hammer in 1892, is also known as Hammer-Aitoff
(the Aitoff projection looks similar, but is not equal-area). The border
is an ellipse, equator and central meridian are straight lines, while
other parallels and meridians are complex curves. The projection is
defined by selecting:

-  The central meridian [Middle of your map].

-  Scale along equator in inch/degree or 1:xxxxx (**-Jh**), or map width (**-JH**).

A view of the Pacific ocean using the Dateline as central meridian is accomplished thus

   ::

    gmt pscoast -Rg -JH4.5i -Bg -Dc -A10000 -Gblack -Scornsilk -P > GMT_hammer.ps

.. figure:: /images/GMT_hammer.*
   :width: 500 px
   :align: center

   World map using the Hammer projection.
