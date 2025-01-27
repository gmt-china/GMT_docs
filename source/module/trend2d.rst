.. index:: ! trend1d
.. include:: common_SYN_OPTs.rst_

trend1d
=======

:贡献者: |周茂|
:最近更新日期: 2022-11-01

----

:官方文档: :doc:`gmt:trend1d`
:简介: 网格重力的谱计算，均衡，导纳，以及相干性计算

**gravfft** 包括 3 种模式。

语法
----


必选选项
--------


可选选项
--------


.. include:: explain_-V.rst_

|SYN_OPT-f|
    地理坐标网格将会在平地球近似下将坐标单位转换为 m

.. include:: explain_help.rst_


注意事项
--------

NetCDF COARDS 网格将会被自动识别为地理网格。对于其他格式的地理网格，可使用
|SYN_OPT-f| 将单位转换为 m。如果地理网格接近两级，则应考虑使用
:doc:`grdproject` 投影后计算。


示例
----

参考文献
--------


相关模块
--------

:doc:`gmt:grdfft`,
:doc:`gmtflexure`,
:doc:`grdflexure`,
:doc:`gmtgravmag3d`,
:doc:`grdgravmag3d`,
:doc:`grdseamount`,
:doc:`talwani2d`,
:doc:`talwani3d`
