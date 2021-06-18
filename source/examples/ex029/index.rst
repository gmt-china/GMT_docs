绘制三维地形图
==============

:示例贡献者: 刘珠妹（作者）、陈箫翰（修订）
:发布日期: 2021-05-28
:最近更新日期: 2021-05-28
:视频讲解: https://www.bilibili.com/video/BV1Xh411e7fi/

----

绘制三维地形图的核心是 :doc:`/module/grdview` 模块以及 **-JZ** 选项。
使用 **-JZ** 选项设置 Z 方向上的缩放比例，同时也必须在 **-R** 选项中设置 Z 方向上的最小值和最大值。
此外，\ **-p** 选项用于设置三维观察的视角。

本例将展示如何绘制三维起伏地形图，并叠加卫星图像图层与地震断层图层，用于对比研究。
请点击观看视频学习代码的详细讲解。


示例中使用到的数据包括：

- :file:`@earth_relief_06m`\ ：\ :doc:`/dataset/earth-relief`
- :file:`@earth_day_06m`\ ：\ :doc:`/dataset/earth-images`
- :file:`CN-faults.gmt`\ ：\ :doc:`/dataset-CN/CN-faults`

下面的绘图脚本将三维地形、卫星图片以及断层线绘制在不同高度：

.. gmtplot:: ex029_1.sh
    :width: 75%
    :show-code: true

下面的脚本将卫星图片和断层线直接绘制在三维地形上:
    
.. gmtplot:: ex029_2.sh
    :width: 75%
    :show-code: true
