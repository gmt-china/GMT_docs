.. index:: ! begin

begin
=====

:官方文档: :doc:`gmt:begin`
:简介: 初始化一个新的GMT现代模式会话

在GMT现代模式下，一个GMT会话总是用 ``gmt begin`` 开始，用 ``gmt end`` 结束。

``begin`` 模块告诉GMT要开始一个新的现代模式会话。如果你的脚本只绘制一张图，
那么你可以直接指定要生成的图片的文件名和文件格式。如果你的脚本绘制多张图，
则你需要使用 :doc:`figure` 来分别为每张图指定文件名和文件格式。

语法
----

::

    gmt begin <prefix> <formats>

可选选项
--------

``<prefix>``
    文件名前缀，默认文件名前缀为 ``gmtsession``\ 。后缀由文件格式自动决定。

.. _fig-formats:

``<formats>``
    图片文件格式。多个格式之间可以用逗号分开。默认为 ``pdf``\ 。

    GMT支持输出如下矢量图片格式：

    - ``pdf``\ ：\ `Portable Document Format <https://zh.wikipedia.org/wiki/可移植文档格式>`_ [默认格式]
    - ``ps``\ ：\  `Plain PostScript <https://zh.wikipedia.org/wiki/PostScript>`_
    - ``eps``\ ：\ `Encapsulated PostScript <https://zh.wikipedia.org/wiki/EPS>`_

    GMT支持输出如下位图图片格式：

    - ``bmp``\ ：\ `Microsoft Bit Map <https://zh.wikipedia.org/wiki/BMP>`_
    - ``jpg``\ ：\ `Joint Photographic Experts Group Format <https://zh.wikipedia.org/wiki/JPEG>`_
    - ``png``\ ：\ `Portable Network Graphics <https://zh.wikipedia.org/wiki/PNG>`_ (不透明)
    - ``PNG``\ ：\ `Portable Network Graphics <https://zh.wikipedia.org/wiki/PNG>`_ (支持透明)
    - ``ppm``\ ：\ `Portable Pixel Map <https://zh.wikipedia.org/wiki/PBM格式>`_
    - ``tif``\ ：\ `Tagged Image Format File <https://zh.wikipedia.org/wiki/TIFF>`_

示例
----

开始一个GMT会话，并指定图片名为 ``Figure_2``\ ，图片格式为PDF和PNG格式::

    gmt begin Figure_2 pdf,png

若想要一个只用于计算而不产生绘图的现代会话，则可以直接使用::

    gmt begin

注意事项
--------

如果用户想要输出PS格式的图片，则应额外留意画布尺寸。对于其他图片格式而言，
GMT默认使用无穷大的画布，而对于PS格式而言，GMT则默认使用A4大小的画布。
若用户绘制的图片超过A4纸张的大小，则可能会造成显示不完全。针对这种情况，
建议用户修改参数 :ref:`PS_MEDIA` 以显式指定纸张大小。例如::

    gmt begin map ps
    gmt set PS_MEDIA A3
    gmt ...
    gmt end
