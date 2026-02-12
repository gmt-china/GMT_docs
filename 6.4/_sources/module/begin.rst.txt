.. index:: ! begin
.. include:: common_SYN_OPTs.rst_

begin
=====

:官方文档: :doc:`gmt:begin`
:简介: 初始化一个新的GMT现代模式会话

在GMT现代模式下，一个GMT绘图总是以 **gmt begin** 开始，以 **gmt end** 结束。

**begin** 模块告诉GMT要开始一个新的现代模式会话。如果你的脚本只绘制一张图，
那么你可以直接指定要生成的图片的文件名和文件格式。如果你的脚本绘制多张图，
则你需要使用 :doc:`figure` 来分别为每张图指定文件名和文件格式。
现代会话模式下，每个会话互相独立，每个会话负责管理各自的配置参数、
命令历史等，因而可以同时执行多个GMT会话而不会互相干扰。

除了可以指定图片文件名和文件格式之外，还可以通过 *options* 指定生成图片过程
中所使用的 :doc:`psconvert` 选项。

语法
----

**gmt begin**
[ *prefix* ]
[ *formats* ]
[ *options* ]
[ |-C| ]
[ |SYN_OPT-V| ]

可选选项
--------

*prefix*
    图片文件名前缀，默认值为 **gmtsession**。
    图片文件名后缀由 *formats* 自动决定。

    如果一个GMT会话只用于进行计算而不绘图，或者需要绘制多张图，则不需要指定该参数。

    .. note::

        文件名中应尽量避免出现空格。若存在空格，则文件名必须用单引号括起来。

.. _fig-formats:

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

.. _-C:

**-C**
    启动一个“干净”的会话。所有已存在的 gmt.conf 都会被忽略，而不会影响到该会话。

    默认情况下，若当前目录或 :file:`~/.gmt` 等目录下存在 gmt.conf 文件，启动的
    会话会继承 gmt.conf 文件中的设置，使用该选项则忽略所有已存在的设置。

.. include:: explain_-V.rst_

.. include:: explain_help_nopar.rst_

示例
----

开始一个会话，并使用默认值。此时会生成名为 gmtsession.pdf 的图片文件::

    gmt begin
    gmt ...
    gmt end show

开始一个GMT会话，并指定图片名为 *Figure_2*，图片格式为PDF和PNG格式::

    gmt begin Figure_2 pdf,png
    gmt ...
    gmt end show

设置额外的参数以控制生成图片时的额外空白::

    gmt begin map pdf,png I+m1c
    gmt ...
    gmt end show

PS文件注意事项
--------------

如果用户想要输出PS格式的图片，则应额外留意画布尺寸。对于其他图片格式而言，
GMT默认使用无穷大（10米x10米）的画布。而对于PS格式而言，GMT则默认使用A4大小的画布。
若用户绘制的图片超过A4纸张的大小，则可能会造成显示不完全。针对这种情况，
建议用户修改参数 :term:`PS_MEDIA` 以显式指定纸张大小。例如::

    gmt begin map ps
    gmt set PS_MEDIA A3
    gmt ...
    gmt end show

UNIX shell 注意事项
-------------------

现代模式的工作原理是，在使用 **gmt begin** 时利用父进程ID创建唯一的会话目录，
并将很多信息保存到该会话目录中。脚本中接下来的命令拥有共同的父进程ID，因而
接下来的命令可以向唯一会话目录中写入信息或读取信息，以实现多个命令之间的互相
通信。然而，UNIX下某些shell的实现不完全统一，脚本执行过程中父进程ID可能出现变化，
后面执行的命令无法正确获取前面命令的父进程ID，因而导致命令之间的信息交流出现
错误。最常见的情况是在使用UNIX管道时，可能会生成子shell进而导致父进程ID出现变化。

如果你在GMT现代模式脚本中使用了管道，执行过程中出现了类似无法找到目录 ``gmt6.#####``
这样的错误，这极有可能是你所使用的UNIX shell存在此类问题。解决办法是，
在脚本开始的地方设置环境变量 **GMT_SESSION_NAME** 为进程ID。

在Bash shell应该是（其中，``$$`` 是特殊变量，用于表示当前进程ID）::

    export GMT_SESSION_NAME=$$
    gmt begin
    gmt ...
    gmt end show

在C shell中应该是::

    setenv GMT_SESSION_NAME $$
    gmt begin
    gmt ..
    gmt end show

在Batch脚本中应该是（Batch中无法直接获取进程ID，此时可以随便给 **GMT_SESSION_NAME** 一个数字）::

    set GMT_SESSION_NAME=97401
    gmt begin
    gmt ..
    gmt end show


相关模块
--------

:doc:`clear`,
:doc:`docs`,
:doc:`end`,
:doc:`figure`,
:doc:`inset`,
:doc:`subplot`,
:doc:`gmt`
