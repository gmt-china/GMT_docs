-Jk：Eckert IV and VI projection
================================

The Eckert IV and VI projections, presented by the German cartographer
Max Eckert-Greiffendorff in 1906, are pseudocylindrical equal-area
projections. Central meridian and all parallels are straight lines;
other meridians are equally spaced elliptical arcs (IV) or sinusoids
(VI). The scale is true along latitudes 40º30' (IV) and 49º16' (VI). Their
main use is in thematic world maps. To select Eckert IV you must use
**-JKf** (**f** for "four") while Eckert VI is selected with **-JKs**
(**s** for "six"). If no modifier is given it defaults to Eckert VI. In
addition, you must enter

-  The central meridian [Middle of your map].

-  Scale along equator in inch/degree or 1:xxxxx (**-Jk**), or map width
   (**-JK**).

Centered on the Dateline, the Eckert IV example below was created by
this command:

   ::

    gmt pscoast -Rg -JKf4.5i -Bg -Dc -A10000 -Wthinnest -Givory -Sbisque3 -P > GMT_eckert4.ps

.. figure:: /images/GMT_eckert4.*
   :width: 500 px
   :align: center

   World map using the Eckert IV projection.


The same script, with **s** instead of **f**, yields the Eckert VI map:

.. figure:: /images/GMT_eckert6.*
   :width: 500 px
   :align: center

   World map using the Eckert VI projection.
