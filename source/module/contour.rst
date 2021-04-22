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

.. include:: contour_common.rst_

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
