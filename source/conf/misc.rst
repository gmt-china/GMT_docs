其他参数
========

本节介绍GMT中的其他参数，参数的默认值在中括号内列出。

.. _GMT_AUTO_DOWNLOAD:

**GMT_AUTO_DOWNLOAD**
    是否自动从GMT服务器下载文件到缓存目录 [on]

.. _GMT_COMPATIBILITY:

**GMT_COMPATIBILITY**
    是否开启兼容模式 [4]

    - 若做值为4，表示兼容GMT4语法并给出警告
    - 若值为5，则表示不兼容GMT4语法，严格遵守GMT5语法，遇到GMT4语法时直接报错

.. _GMT_VERBOSE:

**GMT_VERBOSE**
    控制GMT命令的verbose级别 [c]

    可选值包括:

    - ``quiet``
    - ``normal``
    - ``compat``
    - ``verbose``
    - ``long``
    - ``debug``

    也可以直接使用每个级别的第一个字母。每个级别的具体含义见 :doc:`/option/V` 一节。

.. _GMT_TRIANGULATE:

**GMT_TRIANGULATE**
    选择triangulate命令中源码的来源 [Watson]

    ``triangulate`` 命令有两个版本的源码， ``Watson`` 的版本遵循GPL， ``Shewchuk`` 的版本不遵循GPL。该选项用于控制要使用哪个版本， ``Shewchuk`` 版本拥有更多功能。

.. _GMT_LANGUAGE:

**GMT_LANGUAGE**
    绘制月份、星期几等时所使用的语言 [US]

    该参数的默认值为 ``US`` ，所以在绘图时一月会显示 ``January`` 而不是 ``一月`` 。可以通过修改该参数设置GMT所使用的语言。该参数可以取值包含 CN1、CN2、UK、US等。详细列表见 `GMT官方文档 gmt.conf <http://gmt.soest.hawaii.edu/doc/latest/gmt.conf.html>`_

    每种语言的定义位于 ``$GMTHOME/share/localization`` 中。读者可以自定义自己的语言，并将其放在该目录或 ``~/.gmt`` 目录下。

    实际使用时，还涉及到编码和字体问题，所以想做出中文效果还需要一些特殊处理。

.. _GMT_HISTORY:

**GMT_HISTORY**
    GMT历史文件 ``gmt.history`` 的处理方式 [true]

    - ``true`` 可以读写
    - ``readonly`` 只能读不能写
    - ``false`` 不显示历史文件

.. _GMT_INTERPOLANT:

**GMT_INTERPOLANT**
    程序中一维插值所使用的算法 [akima]

    #. ``linear`` ：线性插值
    #. ``akima`` ：akima's spline
    #. ``cubic`` ：natural cubic spline
    #. ``none`` ：不插值

.. _GMT_EXPORT_TYPE:

**GMT_EXPORT_TYPE**
    控制表数据的数据类型，仅被外部接口使用 [double]

    可以取 ``double`` 、 ``single`` 、 ``[u]long`` 、 ``[u]int`` 、 ``[u]short`` 、 ``[u]char``

.. _GMT_EXTRAPOLATE_VAL:

**GMT_EXTRAPOLATE_VAL**
    外插时超过数据区时如何处理 [NaN]

    可选值包括：

    #. ``NaN`` ：区域范围外的值一律为NaN
    #. ``extrap`` ： 使用外插算法计算的区域外的值
    #. ``extrapval,val`` ：设置区域外的值为 ``val``

.. _GMT_CUSTOM_LIBS:

**GMT_CUSTOM_LIBS**
    自定义的GMT共享库文件，默认值为空

    GMT支持自定义模块。用户可以自己写一个GMT模块，并将其编译成GMT兼容的动态函数库，并告知GMT该函数库的信息，就可以通过 ``gmt xxx`` 的语法调用自定义的模块，以实现扩充GMT功能的目的。

    该参数用于指定自定义动态库函数的路径，多个路径之间用逗号分隔。路径可以是共享库文件的绝对路径，也可以是其所在的目录。若路径是一个目录名，该目录必须需斜杠或反斜杠结尾，表明使用该目录下的全部共享库文件。在Windows下，若目录名是 ``/`` ，则在 ``${GMTHOME}/bin/gmt_plugins`` 目录下寻找库文件。

.. _GMT_FFT:

**GMT_FFT**
    要使用的FFT算法 [auto]

    可以取：

    #. ``auto`` ：自动选择合适的算法
    #. ``fftw[,planner]`` ：FFTW算法，其中 ``planner`` 可以取 ``measure|patient|exhaustive``
    #. ``accelerate`` OS X下使用Accelerate Framework
    #. ``kiss`` ：kiss FFT
    #. ``brenner`` ：Brenner Legacy FFT
