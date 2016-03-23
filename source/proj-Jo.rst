-Jo：Oblique Mercator projection
================================

Oblique configurations of the cylinder give rise to the oblique Mercator
projection. It is particularly useful when mapping regions of large
lateral extent in an oblique direction. Both parallels and meridians are
complex curves. The projection was developed in the early 1900s by
several workers. Several parameters must be provided to define the
projection. GMT offers three different definitions:

#. Option **-Jo**\ [**a**\ \|\ **A**] or **-JO**\ [**a**\ \|\ **A**]:

   -  Longitude and latitude of projection center.

   -  Azimuth of the oblique equator.

   -  Scale in inch/degree or 1:xxxxx along oblique equator (**-Jo**),
      or map width (**-JO**).

#. Option **-Jo**\ [**b**\ \|\ **B**] or **-JO**\ [**b**\ \|\ **B**]:

   -  Longitude and latitude of projection center.

   -  Longitude and latitude of second point on oblique equator.

   -  Scale in inch/degree or 1:xxxxx along oblique equator (**-Jo**),
      or map width (**-JO**).

#. Option **-Joc**\ \|\ **C** or **-JOc**\ \|\ **C**:

   -  Longitude and latitude of projection center.

   -  Longitude and latitude of projection pole.

   -  Scale in inch/degree or 1:xxxxx along oblique equator (**-Jo**),
      or map width (**-JO**).

For all three definitions, the upper case **A**\ \|\ **B**\ \|\ **C** means we
will allow projection poles in the southern hemisphere [By default we map any such
poles to their antipodes in the north hemisphere].  Our example was produced by the command

   ::

    gmt pscoast -R270/20/305/25r -JOc280/25.5/22/69/4.8i -Bag -Di -A250 -Gburlywood \
                -Wthinnest -P -TdjTR+w0.4i+f2+l+o0.15i -Sazure --FONT_TITLE=8p \
                --MAP_TITLE_OFFSET=0.05i > GMT_obl_merc.ps

.. figure:: /images/GMT_obl_merc.*
   :width: 500 px
   :align: center

   Oblique Mercator map using **-Joc**. We make it clear which direction is North by
   adding a star rose with the **-Td** option.


It uses definition 3 for an oblique view of some Caribbean islands. Note
that we define our region using the rectangular system described
earlier. If we do not append an "r" to the **-R** string then the
information provided with the **-R** option is assumed to be oblique
degrees about the projection center rather than the usual geographic
coordinates. This interpretation is chosen since in general the
parallels and meridians are not very suitable as map boundaries.

When working with oblique projections such as here, it is often much more convenient
to specify the map domain in the projected coordinates relative to the map center.
The figure below shows two views of New Zealand using the oblique Mercator projection
that in both cases specifies the region using **-Rk**\ -1000/1000/-500/500.  The leading
unit **k** means the following bounds are in projected km and we let GMT determine the
geographic coordinates of the two diagonal corners internally.

.. figure:: /images/GMT_obl_nz.*
   :width: 600 px
   :align: center

   (left) Oblique view of New Zealand centered on its geographical center (Nelson)
   indicated by the white circle for an oblique Equator with azimuth 35.  This
   resulted in the argument **-JOa**\ 173:17:02E/41:16:15S/35/3i.
   The map is 2000 km by 1000 km and the Cartesian
   coordinate system in the projected units are indicated by the bold axes.  The blue
   circle is the point (40S,180E) and it has projected coordinates (*x* = 426.2, *y* = -399.7).
   (right) Same dimensions but now specifying an azimuth of 215, yielding a projection
   pole in the southern hemisphere (hence we used **-JOA** to override the restriction,
   i.e., **-JOA**\ 173:17:02E/41:16:15S/215/3i.)
   The projected coordinate system is still aligned as before but the Earth has been rotated
   180 degrees.  The blue point now has projected coordinates (*x* = -426.2, *y* = 399.7).
