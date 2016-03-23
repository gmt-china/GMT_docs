-Ju：Universal Transverse Mercator (UTM) projection
===================================================

A particular subset of the transverse Mercator is the Universal
Transverse Mercator (UTM) which was adopted by the US Army for
large-scale military maps. Here, the globe is divided into 60 zones
between 84ºS and 84ºN, most of which are 6 wide. Each of these UTM zones
have their unique central meridian. Furthermore, each zone is divided
into latitude bands but these are not needed to specify the projection
for most cases. See Figure :ref:`Universal Transverse Mercator
<GMT_utm_zones>` for all zone designations.

.. _GMT_utm_zones:

.. figure:: /images/GMT_utm_zones.*
   :width: 700 px
   :align: center

   Universal Transverse Mercator zone layout.


GMT implements both the transverse Mercator and the UTM projection.
When selecting UTM you must specify:

-  UTM zone (A, B, 1--60, Y, Z). Use negative values for numerical zones
   in the southern hemisphere or append the latitude modifiers C--H, J--N,
   P--X) to specify an exact UTM grid zone.

-  Scale along the equator in inch/degree or 1:xxxxx (**-Ju**), or map
   width (**-JU**).

In order to minimize the distortion in any given zone, a scale factor of
0.9996 has been factored into the formulae. (although a standard, you
can change this with :ref:`PROJ_SCALE_FACTOR <PROJ_SCALE_FACTOR>`). This makes the UTM
projection a *secant* projection and not a *tangent* projection like the
transverse Mercator above. The scale only varies by 1 part in 1,000 from
true scale at equator. The ellipsoidal projection expressions are
accurate for map areas that extend less than 10 away from the central
meridian. For larger regions we use the conformal latitude in the
general spherical formulae instead.
