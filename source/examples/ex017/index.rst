:orphan:

绘制矢量场
==========

:贡献者: SeisPider

使用 :doc:`/module/grdvector` 模块绘制矢量场，需要提供矢量场的 X 分量和 Y 分量。

本文所使用的示例数据，包含四列信息::

    X位置   Y位置    矢量X分量   矢量Y分量

示例中使用 :doc:`/module/xyz2grd` 模块分别生成矢量X分量和Y分量的网格文件，
再使用 :doc:`/module/grdvector` 模块进行绘制，最后生成图例。

示例数据下载 :download:`velocity.dat`

.. gmtplot:: ex017.sh
   :width: 75%
