.. index:: ! mgd77header
.. include:: common_SYN_OPTs.rst_

mgd77header
===========

:官方文档: :doc:`gmt:supplements/mgd77/mgd77header`
:简介: 由 A77 文件创建 MGD77 头段记录

**mgd77header** 通过读取 A77 文件生成 MGD77 头段记录，以确定时间、空间范围、
存在的数据列以及经过的 10 度大小的网格。也可以使用 |-H| 选项读取一个包含头段
记录的文件。输出头段记录结果为 MGD77 格式或者列表形式。

语法
----

**gmt mgd77header** *GEODAS-id.a77*
[ |-H|\ *headertable* ]
[ |-M|\ **f**\ [*item*]\|\ **r**\|\ **t** ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_ncid.rst_

可选选项
--------

.. _-H:

**-H**\ *headertable*
    从 *headertable* 文件中获取头段记录。输入文件的每一行都应包含一个名称和值，以
    空格分隔。请参见下面的示例头文件中所有的头段可能包含的名称。

.. _-M:

**-Mf**\ [*item*]\|\ **r**\|\ **t**
    列出每个测线的头段信息。**f** 选项用于格式化输出，每行一个条目，后续可使用 Unix
    文本处理命令进行筛选。也可以附加特定参数的名称 *item* ，其中参数的名称不必写全，
    只需最前面或者最后面少数几个连续的字符，其他用 ``-`` 代替就可正确识别出对应的
    参数。若参数名为 ``-`` ，则输出所有参数名称列表。此外，也可以指定参数的编号。
    对于原始的 punchcard-formatted MGD77 格式，需要同时使用 **r** 选项，对于 MGD77T 
    格式，需要同时使用 **t** 选项。

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

所有可能的头段名称
------------------

.. code-block::

    Survey_Identifier
    Format_Acronym
    Data_Center_File_Number
    Parameters_Surveyed_Code
    File_Creation_Year
    File_Creation_Month
    File_Creation_Day
    Source_Institution
    Country
    Platform_Name
    Platform_Type_Code
    Platform_Type
    Chief_Scientist
    Project_Cruise_Leg
    Funding
    Survey_Departure_Year
    Survey_Departure_Month
    Survey_Departure_Day
    Port_of_Departure
    Survey_Arrival_Year
    Survey_Arrival_Month
    Survey_Arrival_Day
    Port_of_Arrival
    Navigation_Instrumentation
    Geodetic_Datum_Position_Determination_Method
    Bathymetry_Instrumentation
    Bathymetry_Add_Forms_of_Data
    Magnetics_Instrumentation
    Magnetics_Add_Forms_of_Data
    Gravity_Instrumentation
    Gravity_Add_Forms_of_Data
    Seismic_Instrumentation
    Seismic_Data_Formats
    Format_Type
    Format_Description
    Topmost_Latitude
    Bottommost_Latitude
    Leftmost_Longitude
    Rightmost_Longitude
    Bathymetry_Digitizing_Rate
    Bathymetry_Sampling_Rate
    Bathymetry_Assumed_Sound_Velocity
    Bathymetry_Datum_Code
    Bathymetry_Interpolation_Scheme
    Magnetics_Digitizing_Rate
    Magnetics_Sampling_Rate
    Magnetics_Sensor_Tow_Distance
    Magnetics_Sensor_Depth
    Magnetics_Sensor_Separation
    Magnetics_Ref_Field_Code
    Magnetics_Ref_Field
    Magnetics_Method_Applying_Res_Field
    Gravity_Digitizing_Rate
    Gravity_Sampling_Rate
    Gravity_Theoretical_Formula_Code
    Gravity_Theoretical_Formula
    Gravity_Reference_System_Code
    Gravity_Reference_System
    Gravity_Corrections_Applied
    Gravity_Departure_Base_Station
    Gravity_Departure_Base_Station_Name
    Gravity_Arrival_Base_Station
    Gravity_Arrival_Base_Station_Name
    Number_of_Ten_Degree_Identifiers
    Ten_Degree_Identifier
    Additional_Documentation_1
    Additional_Documentation_2
    Additional_Documentation_3
    Additional_Documentation_4
    Additional_Documentation_5
    Additional_Documentation_6
    Additional_Documentation_7

示例
----

从 A77 输入中生成 MGD77 头段信息 ::

    gmt mgd77header km0201 -Hkmheaderitems.txt -Mf > km0201.h77

参考
----

MGD77 (Marine Geophysical Data Exchange Format) 格式见
`http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt. <http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt>`__

相关模块
--------

:doc:`mgd77convert`,
:doc:`mgd77list`,
:doc:`mgd77magref`
:doc:`mgd77manage`,
:doc:`mgd77path`,
:doc:`mgd77track`,
:doc:`mgd77sniffer`,
:doc:`mgd77track`
