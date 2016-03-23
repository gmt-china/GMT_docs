-Jn：Robinson projection
========================

The Robinson projection, presented by the American geographer and
cartographer Arthur H. Robinson in 1963, is a modified cylindrical
projection that is neither conformal nor equal-area. Central meridian
and all parallels are straight lines; other meridians are curved. It
uses lookup tables rather than analytic expressions to make the world
map "look" right . The scale is true along latitudes 38. The
projection was originally developed for use by Rand McNally and is
currently used by the National Geographic Society. To use it you must
enter

-  The central meridian [Middle of your map].

-  Scale along equator in inch/degree or 1:xxxxx (**-Jn**), or map width
   (**-JN**).

Again centered on Greenwich, the example below was created by this command:

   ::

    gmt pscoast -Rd -JN4.5i -Bg -Dc -A10000 -Ggoldenrod -Ssnow2 -P > GMT_robinson.ps

.. figure:: /images/GMT_robinson.*
   :width: 500 px
   :align: center

   World map using the Robinson projection.
