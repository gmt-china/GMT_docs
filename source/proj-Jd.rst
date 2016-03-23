-Jd：Equidistant conic projection
=================================

The equidistant conic projection was described by the Greek philosopher
Claudius Ptolemy about A.D. 150. It is neither conformal or equal-area,
but serves as a compromise between them. The scale is true along all
meridians and the standard parallels. To select this projection in
GMT you must provide the same information as for the other conic
projection, i.e.,

-  Longitude and latitude of the projection center.

-  Two standard parallels.

-  Map scale in inch/degree or 1:xxxxx notation (**-Jd**), or map width (**-JD**).

The equidistant conic projection is often used for atlases with maps of
small countries. As an example, we generate a map of Cuba:

   ::

    gmt set FORMAT_GEO_MAP ddd:mm:ssF MAP_GRID_CROSS_SIZE_PRIMARY 0.05i
    gmt pscoast -R-88/-70/18/24 -JD-79/21/19/23/4.5i -Bag -Di -N1/thick,red \
                -Glightgreen -Wthinnest -P > GMT_equidistant_conic.ps

.. figure:: /images/GMT_equidistant_conic.*
   :width: 500 px
   :align: center

   Equidistant conic map projection.
