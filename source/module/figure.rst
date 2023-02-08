.. index:: ! figure
.. include:: common_SYN_OPTs.rst_

figure
======

:官方文档: :doc:`gmt:figure`
:简介: 设置当前图片的属性

一个GMT现代模式会话下可以绘制一张或多张图件。对于一个会话中绘制多张图件的情况，
**figure** 模块可以指定当前图件的文件名和格式。

该模块必须在你开始向当前图件绘图之前执行，且每次调用 **figure** 模块都会开启一张新的图件。
你也可以再次使用 **figure** 模块在多个图件之间来回切换，但此时不能再指定 *formats*
或 *options* 等选项。一个会话中的每张图都有各自的历史记录和配置参数，因而不同图之间的
**-R** 和 |-J| 选项等信息不会出现错乱。

语法
----

**gmt figure**
*prefix*
[ *formats* ]
[ *options* ]
[ |SYN_OPT-V| ]

必须选项
--------

*prefix*
    图片文件名前缀，默认值为 **gmtsession**。
    图片文件名后缀由 *formats* 自动决定。

    .. note::

        文件名中应尽量避免出现空格。若存在空格，则文件名必须用单引号括起来。

可选选项
--------

*formats*
    图片文件格式。多个格式之间可以用逗号分开。默认图片格式为 **pdf**，由
    参数 :term:`GMT_GRAPHICS_FORMAT` 控制。

    GMT支持输出如下矢量图片格式：

    - ``pdf``：`Portable Document Format <https://zh.wikipedia.org/wiki/可移植文档格式>`_ [默认格式]
    - ``ps``： `Plain PostScript <https://zh.wikipedia.org/wiki/PostScript>`_
    - ``eps``：`Encapsulated PostScript <https://zh.wikipedia.org/wiki/EPS>`_

    GMT支持输出如下位图图片格式：

    - ``bmp``：`Microsoft Bit Map <https://zh.wikipedia.org/wiki/BMP>`_
    - ``jpg``：`Joint Photographic Experts Group Format <https://zh.wikipedia.org/wiki/JPEG>`_
    - ``png``：`Portable Network Graphics <https://zh.wikipedia.org/wiki/PNG>`_ （不透明背景）
    - ``PNG``：`Portable Network Graphics <https://zh.wikipedia.org/wiki/PNG>`_ （透明背景）
    - ``ppm``：`Portable Pixel Map <https://zh.wikipedia.org/wiki/PBM格式>`_
    - ``tif``：`Tagged Image Format File <https://zh.wikipedia.org/wiki/TIFF>`_

*options*
    GMT现代模式本质上是先生成PS文件，再通过调用 :doc:`psconvert` 自动转换成用户
    指定的图片格式。此处可以设置要传递给模块 :doc:`psconvert` 的选项，
    多个选项之间用逗号分隔。

    默认值为 **A**，表示将 |-A| 选项传给 :doc:`psconvert`。

    其他可选的选项包括：

    - **A**\ [*args*]: 裁剪图片
    - **C**\ *args*: 额外传递给Ghostscript的选项
    - **D**\ *dir*: 指定图片的输出目录
    - **E**\ *dpi*: 设置图片分辨率
    - **H**\ *factor*: 对图片做平滑以避免混叠
    - **M**\ *args*: 为当前图片叠加前景图片或背景图片
    - **Q**\ *args*: 设置图像和文本的抗锯齿选项
    - **S** : 把 Ghostscript 命令输出到标准错误输出，且不删除所有中间文件

    详细解释见 :doc:`psconvert` 的说明文档。

.. include:: explain_-V.rst_

.. include:: explain_help_nopar.rst_

PS文件注意事项
--------------

如果用户想要输出PS格式的图片，则应额外留意画布尺寸。对于其他图片格式而言，
GMT默认使用无穷大（10米x10米）的画布。而对于PS格式而言，GMT则默认使用A4大小的画布。
若用户绘制的图片超过A4纸张的大小，则可能会造成显示不完全。针对这种情况，
建议用户修改参数 :term:`PS_MEDIA` 以显式指定纸张大小。例如::

    gmt begin
    gmt figure map ps
    gmt set PS_MEDIA A3
    gmt ...
    gmt end show

示例
----

在当前的现代模式下开启一个新绘图，图片名为 Regional，格式为PDF和EPS格式::

    gmt begin
    gmt figure Regional pdf,eps
    gmt ...
    gmt end show

开启一个新绘图，名为GlobalMap，图片格式为JPEG，并对图片进行裁剪，四边均保留1厘米的空白::

    gmt begin
    gmt figure GlobalMap jpg I+m1c
    gmt ...
    gmt end show

在一个会话中绘制两张图，并在两张图之间来回切换::

    gmt begin

    # 在 Fig1 中绘制
    gmt figure Fig1 png
    gmt ...

    # 在 Fig2 中绘制
    gmt figure Fig2 png
    gmt ...

    # 切换回 Fig1
    gmt figure Fig1
    gmt ...

    # 切换回 Fig2
    gmt figure Fig2
    gmt ...

    gmt end show

技术细节
--------

如果你在为GMT设计外部接口并且你不希望在会话结束时自动转换并生成图片，
你可以指定图片文件名或图片格式为 **-**。

相关模块
--------

:doc:`begin`,
:doc:`clear`,
:doc:`docs`,
:doc:`end`,
:doc:`inset`,
:doc:`subplot`,
:doc:`gmt`
