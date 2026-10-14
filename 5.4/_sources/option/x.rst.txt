-x 选项
=======

在编译GMT时若打开了 OpenMP 选项，则GMT中某些模块在运行时可以通过 OpenMP 加快计算速度。
默认情况下，这些模块会尝试使用所有可用的核。\ ``-x`` 选项用于限制所使用的核数，
其语法为::

    -x[[-]<n>]

例如：

- ``-x8`` 表示仅使用8个核，若计算机的最大核数小于8，则使用计算机的全部核
- ``-x-4`` 表示使用 all-4 个核，也就是说给其他程序留下四个核。若 all-4<1，则使用1个核

支持该选项的模块包括：
:doc:`gmt:grdfilter`\ 、
:doc:`gmt:grdlandmask`\ 、
:doc:`gmt:grdmask`\ 、
:doc:`gmt:grdmath`\ 、
:doc:`gmt:grdsample`\ 、
:doc:`gmt:greenspline`\ 、
:doc:`gmt:sph2grd`\ 、
:doc:`gmt:supplements/potential/gpsgridder`\ 、
:doc:`gmt:supplements/potential/talwani2d`\ 、
:doc:`gmt:supplements/potential/talwani3d`\ 、
:doc:`gmt:surface`\ 、
:doc:`gmt:supplements/x2sys/x2sys_solve`\ 。
