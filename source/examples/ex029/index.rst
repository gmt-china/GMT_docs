:orphan:

绘制三维地形图
==============

:示例贡献者: 刘珠妹（作者）、陈箫翰（修订）
:视频讲解: https://www.bilibili.com/video/BV1Xh411e7fi/

----

绘制三维地形图的核心是 :doc:`/module/grdview` 模块以及 **-JZ** 选项。
使用 **-JZ** 选项设置 Z 方向上的缩放比例，同时也必须在 **-R** 选项中设置 Z 方向上的最小值和最大值。
此外，**-p** 选项用于设置三维观察的视角。

本例将展示如何绘制三维起伏地形图，并叠加卫星图像图层与地震断层图层，用于对比研究。
请点击观看视频学习代码的详细讲解。


示例中使用到的数据包括：

- :file:`@earth_relief_06m`：:doc:`/dataset/earth-relief`
- :file:`@earth_day_06m`：:doc:`/dataset/earth-images`
- :file:`CN-faults.gmt`：:doc:`/dataset-CN/CN-faults`

下面的绘图脚本将三维地形、卫星图片以及断层线绘制在不同高度：

.. gmtplot:: ex029_1.sh
    :width: 75%
    :show-code: true

下面的脚本将卫星图片和断层线直接绘制在三维地形上:

.. gmtplot:: ex029_2.sh
    :width: 75%
    :show-code: true

除了 GMT 自带的卫星图像数据以外，读者还可以使用开源工具导出精度更高的谷歌卫星图像，并用于 GMT 绘图。
导出方法可以参考 :doc:`/examples/ex004/index` 。
在下面的例子中，:doc:`/module/grdview` 模块将合肥地区卫星图像 :file:`Hefei.tiff` 叠加在三维地形图上，
绘制出了清晰度更高的图片。卫星图像适用于作图范围较小的情况。

.. literalinclude:: Hefei.sh

.. image:: https://user-images.githubusercontent.com/26203721/185333355-a57cdc9b-8327-4721-9304-5867ab3b629a.jpg
   :width: 100%
   :align: center
