``-x`` 选项
===========

GMT中的某些模块支持OpenMP多线程并行。默认情况下，GMT会尝试使用所有可用的核。使用 ``-x`` 选项可以限制GMT所使用的核数，其语法为::

    -x[[-]<n>]

- ``<n>`` 表示仅使用 ``<n>`` 个核（若 ``<n>`` 太大，则设置 ``<n>`` 为计算机的最大核数）
- ``-<n>`` 表示使用 ``all - <n>`` 个核（若 ``<n>`` 太小，则设置 ``<n>`` 为1）

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
