.. index:: ! contour


*********
contour
*********

:官方文档: :doc:`gmt:contour`
:简介: 使用直接三角化法对数据进行等值线绘制

语法
--------

.. include:: common_SYN_OPTs.rst_

**gmt contour** [ *table* ] |-J|\ *parameters*
|SYN_OPT-Rz|
[ |-A|\ [**n**\|\ *contours*][*labelinfo*] ]
[ |SYN_OPT-B| ]
[ |-C|\ *contours* ]
[ |-D|\ [*template*] ] [ |-E|\ *indexfile* ]
[ |-G|\ [**d**\|\ **f**\|\ **n**\|\ **l**\|\ **L**\|\ **x**\|\ **X**]\ *params* ]
[ |-I| ] [ |-J|\ **z**\|\ **Z**\ *parameters* ]
[ |-L|\ *pen* ] [ |-N| ]
[ |-Q|\ [*cut*][**+z**] ]
[ |-S|\ [*p*\|\ *t*] ]
[ |-T|\ [**h**\|\ **l**][**+a**][**+d**\ *gap*\ [/*length*]][**+l**\ [*labels*]] ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*type*]\ *pen*\ [**+c**\ [**l**\|\ **f**]] ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-l| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

描述
-----------

读取一个ASCII或二进制格式的输入数据文件 *table* 并绘制出等值线。

必选选项
------------------

.. |Add_intables| unicode:: 0x20 .. just an invisible code
.. include:: explain_intables.rst_

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. |Add_-Rz| unicode:: 0x20 .. just an invisible code
.. include:: explain_-Rz.rst_

可选选项
------------------

.. _-A:

**-A**\ [**n**\|\ *contours*][*labelinfo*]
    **-A**\ *contours* 设置标注间隔，如果在 **-C** 选项中指定标注间隔的话，
    这里的设置会被覆盖。**-An** 则为不进行标注。也可以用 ``-A20,80,100`` 类似的用法，对指定的
    等值线进行标注。如果只想要标注一条等值线，需要在末尾加上逗号，例如 ``-A20,`` ，这样 ``20`` 就不会被认为是标注间隔。
    *labelinfo* 代表可以在最后追加下列额外选项:

.. include:: explain_clabelinfo.rst_

.. include:: explain_-B.rst_

.. _-C:

**-C**\ *contours*
    指定绘制等值线的形式，具体说明如下:

    (1) 如果 *contours* 是一个以 ".cpt" 结尾的文件名，GMT会查找对应的CPT文件，
        把CPT文件中的颜色块的边界绘制为等值线，并进行标注。如果使用了 ``-An`` 选项则只绘制等值线不标注。

    (2) 如果 *contours* 是一个不以 ".cpt" 结尾的文件名，GMT会读取其中的内容作为等值线设置。
        每行为一条等值线的设置，以如下格式给出：
        *contour-level* [*angle*] **C**\|\ **c**\|\ **A**\|\ **a** [*pen*]，中括号表示可选项。
        **C** 或 **c** 表示绘制等值线但不标注，而 **A** 或 **a** 表示绘制等值线并进行标注。
        *angle* 设置标注的旋转角。 *pen* 设置等值线的线型。

    (3) 如果 *contours* 是一串用逗号隔开的数字，例如 ``-C20,80,100`` ，则绘制对应的等值线。
        如果只想要绘制一条等值线，需要在末尾加上逗号，例如 ``-C20,`` 。

    (4) 如果没有指定 *contours* ，则默认使用当前CPT文件。

    (5) 如果 *contours* 是一个常数，则以这个常数为间隔绘制等值线。

    如果 **-C** 和 **-A** 都没有指定的话，则自动计算合适的间隔绘制标注等值线。

.. _-W:

**-W**\ [*type*]\ *pen*\ [**+c**\ [**l**\|\ **f**]] :ref:`(more ...) <set-pens>`
    设置等值线的线型。默认情况下，有标注的等值线线型 *pen* 为 ``0.75p,black`` ，
    无标注的等值线线型 *pen* 为 ``0.25p,black`` 。如果要设置有标注的等值线线型，*type* 应该设置为 **a** ，
    例如 ``-Wa1.75p,red`` 。无标注的等值线线型，*type* 应该设置为 **c** ，例如 ``-Wc1.25p,red`` 。
    如果加上 **+cl** ，则使用 **-C** 选项所指定的CPT文件为不同的等值线设置颜色;
    如果使用 **+cf** ，则为标注设置颜色;
    使用 **+c** 则同时为等值线和标注设置颜色。

示例
--------

使用数据文件Table_5.11.txt，以25为间隔绘制等值线，以50为间隔标注：

   ::

    gmt contour Table_5_11.txt -Wthin -C25 -A50 -B

只绘制并标注750和800两条等值线：

   ::

    gmt contour Table_5_11.txt -A750,800 -W0.5p -B

使用CPT文件temp.cpt定义的间隔绘制等值线

   ::

    gmt contour temp.xyz -R0/150/0/100 -Jx0.1i -Ctemp.cpt -W0.25p
