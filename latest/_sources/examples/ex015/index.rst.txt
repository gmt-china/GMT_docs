:orphan:

绘制 GPS 速度场
===============

:示例贡献者: 李黎明

----

本示例展示如何使用 :doc:`/module/velo` 模块绘制 GPS 速度场。

示例中所使用的 GPS 数据来自于 `Zhao et al. (2015) <https://doi.org/10.1016/j.geog.2014.12.006>`__
的补充材料，根据 :doc:`/module/velo` 模块的要求做简单修改。

本示例仅用于演示，不保证数据的完整性与可靠性。需要使用相关数据的用户请自行
到文章主页下载相关数据。

**数据下载：**

- :download:`gps_campagin.txt`: Velocities of campagin stations with respective to EURASIA plate from 1999-2014
- :download:`gps_continuous.txt`: Velocities of continuous stations with respective to EURASIA plate from 1999-2014

.. gmtplot:: ex015.sh
   :width: 80%
   :show-code: true
