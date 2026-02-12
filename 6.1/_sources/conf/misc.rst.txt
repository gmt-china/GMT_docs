其他参数
========

本节介绍GMT中的其他参数，参数的默认值在中括号内列出。

数据下载相关参数
----------------

.. glossary::

    **GMT_AUTO_DOWNLOAD**
        是否允许自动从GMT服务器（由 :term:`GMT_DATA_SERVER` 控制）下载数据文件到用户目录 :file:`~/.gmt` 下。
        可以取 **on** 或者 **off** [**on**]

    **GMT_DATA_SERVER**
        GMT数据服务器地址，默认使用SOEST官方镜像 [https://oceania.generic-mapping-tools.org/]

        GMT数据服务器目前在全球范围内有多个镜像。详细的镜像列表见
        https://www.generic-mapping-tools.org/mirrors 页面。

        对于国内用户，建议直接使用中科大LUG提供的国内镜像。修改方式为::

            gmt set GMT_DATA_SERVER http://china.generic-mapping-tools.org

        然后将生成的 ``gmt.conf`` 文件复制到GMT用户目录 ``~/.gmt`` (Linux/macOS)
        或 ``C:\Users\XXX\.gmt`` (Windows) 下。

    **GMT_DATA_SERVER_LIMIT**
        从GMT服务器上下载的单个文件的大小上限，默认无限制。
        可以给定文件大小上限的字节数，也可以加上 **k**\ 、\ **m**\ 或 **g** 表示
        KB、MB 或 GB。

    **GMT_DATA_UPDATE_INTERVAL**
        指定远程数据目录文件的更新频率，默认为1天 [1d]。
        时间单位可以取 **d** （天)、\ **w** （周）或 **o**\ （月）。

算法选择相关参数
----------------

.. glossary::

    **GMT_TRIANGULATE**
        设置 :doc:`gmt:triangulate` 模块中算法代码的来源 [Watson]

        :doc:`gmt:triangulate` 模块的核心源码有两个版本，
        Watson 的版本遵循GPL，Shewchuk 的版本不遵循GPL。
        该选项用于控制要使用哪个版本，Shewchuk 版本拥有更多功能。

    **GMT_FFT**
        要使用的FFT算法 [auto]

        可以取：

        - **auto**\ ：自动选择合适的算法
        - **fftw**\ [,\ *planner_flag*]\ ：FFTW算法，其中 *planner_flag* 可以取 **measure**\|\ **patient**\|\ **exhaustive**
        - **accelerate** ：macOS下使用系统自带的Accelerate Framework（该算法要求采样点数必须为2的n次方）
        - **kiss**\ ：kiss FFT
        - **brenner**\ ：Brenner Legacy FFT

    **GMT_INTERPOLANT**
        程序中一维插值所使用的算法 [**akima**]

        - **linear**\ ：线性插值
        - **akima**\ ：akima's spline
        - **cubic**\ ：natural cubic spline
        - **none**\ ：不插值

    **GMT_EXTRAPOLATE_VAL**
        外插时超过数据区时如何处理 [NaN]

        可选值包括：

        - **NaN**\ ：区域范围外的值一律为NaN
        - **extrap**\ ： 使用外插算法计算的区域外的值
        - **extrapval**\,\ *val*\ ：设置区域外的值为 *val*

其它参数
--------

.. glossary::

    **GMT_EXPORT_TYPE**
        控制表数据的数据类型，仅被外部接口使用 [**double**]

        可以取 **double**\ 、\ **single**\ 、\ **[u]long**\ 、\ **[u]int**\ 、
        **[u]short**\ 、\ **[u]char**\ 。

    **GMT_CUSTOM_LIBS**
        要链接的自定义GMT库文件，默认值为空

        GMT支持自定义模块。用户可以写一个GMT模块，并将其编译成动态函数库。通过设置
        该参数告知GMT该函数库的位置，即可通过 **gmt xxx** 的语法调用自定义模块，以
        实现扩充GMT功能的目的。

        该参数用于指定自定义动态库函数的路径，多个路径之间用逗号分隔。
        路径可以是共享库文件的绝对路径，也可以是其所在的目录。若路径是一个目录名，
        该目录必须需斜杠或反斜杠结尾，表明使用该目录下的全部共享库文件。
        在Windows下，若目录名是 **/**\ ，则表示在GMT的bin目录下的 **gmt_plugins**
        子目录下寻找库文件。

    **GMT_LANGUAGE**
        设置GMT绘图时使用的语言 [**us**]

        不同的语言中，月份、星期几、东西南北的表达方法是不同的。
        该参数用于设置GMT绘图时所使用的语言。GMT支持多种语言，各语言的定义文件
        位于GMT安装目录中 :file:`share/localization` 目录下的文件。

        此处仅列举几个常见语言如下：

        - **cn1**\ 简体中文
        - **cn2**\ 繁体中文
        - **uk**\ 英式英语
        - **us**\ 美式英语
        - **jp**\ 日语
        - **kr**\ 韩语
        - ...

        实际使用时，除了需要修改该参数外，可能还需要修改相应的字符编码和字体。

        若设置语言为 **cn1** 即简体中文并正确设置中文字体，则GMT在绘制时可以显式
        “一月”、“星期一”、“周一”等中文。相关示例见
        :doc:`/chinese/showcase`\ 。

    **GMT_COMPATIBILITY**
        是否开启兼容模式 [4]

        - 若值为4，表示兼容GMT4语法并给出警告
        - 若值为5，则表示不兼容GMT4语法，严格遵守GMT5语法，遇到GMT4语法时直接报错
        - 若值为6，表示不兼容GMT5语法

    **GMT_VERBOSE**
        控制GMT命令的verbose级别 [warning]

        可选值包括

        - **quiet**
        - **error**
        - **warning**
        - **timings**
        - **information**
        - **compatibility**
        - **debug**

        也可以直接使用每个级别的第一个字母。每个级别的具体含义见 :doc:`/option/V` 一节。

    **GMT_HISTORY**
        GMT历史文件 **gmt.history** 的处理方式 [true]

        - **true** 可以读写
        - **readonly** 只能读不能写
        - **false** 不显示历史文件

    **GMT_GRAPHICS_FORMAT**
        现代模式下默认的图片文件格式 [pdf]

    **GMT_MAX_CORE**
        多进程并行程序所最多能使用的核数 [0]

        默认值0表示尽可能使用所有核
