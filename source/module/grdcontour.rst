.. index:: ! grdcontour


**********
grdcontour
**********

:官方文档: :doc:`gmt:grdcontour`
:简介: 根据网格文件绘制等值线

语法
--------

.. include:: common_SYN_OPTs.rst_

**gmt grdcontour** *grid*
|-J|\ *parameters* [ |-A|\ [**n**\|\ *contours*][*labelinfo*] ]
[ |SYN_OPT-B| ]
[ |-C|\ *contours*\|\ *cpt* ]
[ |-D|\ *template* ]
[ |-F|\ [**l**\|\ **r**] ]
[ |-G|\ [**d**\|\ **f**\|\ **n**\|\ **l**\|\ **L**\|\ **x**\|\ **X**]\ *params* ]
[ |-L|\ *low/high*\|\ **n**\|\ **N**\|\ **P**\|\ **p** ]
[ |-N|\ [*cpt*] ]
[ |-Q|\ [*cut*][**+z**] ]
[ |SYN_OPT-Rz| ]
[ |-S|\ *smoothfactor* ]
[ |-T|\ [**h**\|\ **l**][**+a**][**+d**\ *gap*\ [/*length*]][**+l**\ [*labels*]] ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*type*]\ *pen*\ [**+c**\ [**l**\|\ **f**]] ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |-Z|\ [**+s**\ *factor*][**+o**\ *shift*][**+p**] ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-do| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ **-ho**\ [*n*] ]
[ |SYN_OPT-l| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

.. include:: grdcontour_common.rst_

示例
--------

使用网格文件AK_gulf_grav.nc，以25为间隔绘制等值线，以50为间隔标注，标注文字大小10p::

    gmt grdcontour AK_gulf_grav.nc -JM16c -C25 -A50+f10p -B

只绘制50和150两条等值线，只标注100等值线::

    gmt grdcontour AK_gulf_grav.nc -JM16c -C50,150 -A100,+f10p -B

以10为间隔绘制等值线，以50为间隔标注，设置图标题为"Gravity Anomalies"。
将有标注的等值线设置为粗红线，将无标注的等值线设置为蓝色的细短划线::

    gmt grdcontour AK_gulf_grav.nc -C10 -A50 -B -B+t"Gravity Anomalies" -Wathick,red -Wcthinnest,blue,-

将负值等值线设置为蓝色，正值等值线设置为红色，0等值线设置为黑色::

    gmt begin alaska_grav4
      grdcontour AK_gulf_grav.nc -C10 -A50 -B -B+t"Gravity Anomalies" -Ln -Wathick,blue -Wcthinnest,blue,-
      grdcontour AK_gulf_grav.nc -C10 -A50 -Lp -Wathick,red -Wcthinnest,red,-
      grdcontour AK_gulf_grav.nc -A0,
    gmt end show
