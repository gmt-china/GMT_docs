``-x`` 选项
===========

GMT中的某些模块支持OpenMP多线程并行，前提是在编译时打开了 OpenMP 选项。

默认情况下，GMT会尝试使用所有可用的核。使用 ``-x`` 选项可以限制GMT所使用的核数，
其语法为::

    -x[[-]<n>]

例如：

- ``-x8`` 表示仅使用8个核，若计算机的最大核数小于8，则使用计算机的全部核
- ``-x-4`` 表示使用 all-4 个核，也就是说给其他程序留下四个核。若 all-4<1，则使用1个核

支持该选项的模块包括：
``greenspline`` 、
``grdmask`` 、
``grdmath`` 、
``grdfilter`` 、
``grdsample`` 、
``sph2grd`` 、
``grdgravmag3d`` 、
``talwani2d`` 、
``talwani3d`` 、
``x2sys_solve`` 。