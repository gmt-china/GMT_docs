-Jq：Cylindrical equidistant projection
=======================================

This simple cylindrical projection is really a linear scaling of
longitudes and latitudes. The most common form is the Plate Carrée
projection, where the scaling of longitudes and latitudes is the same.
All meridians and parallels are straight lines. The projection can be
defined by:

-  The central meridian [Middle of your map].

-  Standard parallel [Equator].

-  Scale in inch/degree or as 1:xxxxx (**-Jq**), or map width (**-JQ**).

The first two of these are optional and have defaults. When the standard
parallel is defined, the central meridian must be supplied as well.

A world map centered on the dateline using this projection can be
obtained by running the command:

   ::

    gmt pscoast -Rg -JQ4.5i -B60f30g30 -Dc -A5000 -Gtan4 -Slightcyan -P > GMT_equi_cyl.ps

.. figure:: /images/GMT_equi_cyl.*
   :width: 500 px
   :align: center

   World map using the Plate Carrée projection.


Different relative scalings of longitudes and latitudes can be obtained
by selecting a standard parallel different from the equator. Some
selections for standard parallels have practical properties as shown in
Table :ref:`JQ <tbl-JQ>`.

.. _tbl-JQ:

.. table::

   +-----------------------------------------------------+--------+
   +=====================================================+========+
   | Grafarend and Niermann, minimum linear distortion   | 61.7º  |
   +-----------------------------------------------------+--------+
   | Ronald Miller Equirectangular                       | 50.5º  |
   +-----------------------------------------------------+--------+
   | Ronald Miller, minimum continental distortion       | 43.5º  |
   +-----------------------------------------------------+--------+
   | Grafarend and Niermann                              | 42º    |
   +-----------------------------------------------------+--------+
   | Ronald Miller, minimum overall distortion           | 37.5º  |
   +-----------------------------------------------------+--------+
   | Plate Carrée, Simple Cylindrical, Plain/Plane       | 0º     |
   +-----------------------------------------------------+--------+
