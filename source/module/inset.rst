.. index:: ! inset
.. include:: common_SYN_OPTs.rst_

inset
=====

:官方文档: :doc:`gmt:inset`
:简介: 管理和设置图中图模式

**inset** 模块用于管理图中图模式。即在纸张上规划出一小片区域，并限制接下来的绘制
操作均只在该小区域内操作。

**inset** 模块包含两个命令：

- **inset begin** 用于设置图中图模式，其定义了图中图区域的位置和大小
- **inset end** 用于结束图中图模式，所有的操作都会回到原大图中。

在图中图中，用户可以使用任意的投影方式和投影区域。若投影方式中底图宽度或
比例用 ``?`` 表示，则会根据 **-D** 选项设置的小图大小自动确定小图的最佳尺寸。

inset begin语法
---------------

**gmt inset begin**
|-D|\ *inset-box*
[ |-F|\ *box* ]
[ |-M|\ *margins* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必须选项
--------

.. _-D:

**-D**\ *xmin/xmax/ymin/ymax*\ [**+r**][**+u**\ *unit*]
    类似于 :doc:`-R </option/R>` 选项，通过指定大图中的一个矩形区域作为小图的绘图区域。

    - **+r**: 与 :doc:`-R </option/R>` 选项类似，表明坐标为矩形区域的左下角和右上角坐标。
    - **+u**\ *unit*\ : 与 :doc:`-R </option/R>` 选项类似，表明此时的坐标为投影后坐标

**-D**\ [**g**\ \|\ **j**\ \|\ **J**\ \|\ **n**\ \|\ **x**]\ *refpoint*\ **+w**\ *width*\ [/*height*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    指定小图区域的位置和大小。

    - **g**\ \|\ **j**\ \|\ **J**\ \|\ **n**\ \|\ **x**]\ *refpoint*\:
      指定小图区域的参考点，通常用 **j** 比较方便。
      例如 ``jTL`` 表示小图区域位于左上角，\ **jBR** 表示小图区域位于右下角。
      详情见 :doc:`/basis/embellishment` 一节
    - **+w**\ *width*\ [/*height*]: 设置小图区域的宽度和高度
    - **+j**\ *justify*: 控制小图区域的锚点，见 :doc:`/basis/anchor` 一节
    - **+o**\ *dx*\ [/*dy*]: 控制小图区域相对于参考点的额外偏移量，见 :doc:`/basis/embellishment` 一节

可选选项
--------

.. _-F:

**-F**\ [\ **+c**\ *clearances*][\ **+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][\ **+p**\ [*pen*]][\ **+r**\ [*radius*\ ]][\ **+s**\ [[*dx*/*dy*/][*shade*\ ]]]
    设置小图区域的背景面板属性。

    .. include:: explain_-F.rst_

.. _-M:

**-M**\ *margins*
    小图区域内部的额外空白区域，默认值为 0.5c。其可以取三种形式：

    #. 一个值，表示四个边的空白相同
    #. 两个用斜杠分隔的值，分别设置水平和垂直方向的空白
    #. 四个用斜杠分隔的值，分别设置左右下上四条边的空白

.. include:: explain_-V.rst_

.. include:: explain_help_nopar.rst_

示例
----

下面的示例绘制了澳大利亚的地图，并在地图右上角绘制了小图。小图中绘制了全球地图，
并以特殊颜色标注了澳大利亚的位置。

.. gmtplot::

    gmt begin inset-example png,pdf
        gmt coast -R110E/170E/44S/9S -JM6i -B -BWSne -Wfaint -N2/1p -Gbrown -EAU+gbisque
        gmt inset begin -DjTR+w1.5i+o0.15i/0.1i -F+gwhite+p1p+c0.1c -M0
            gmt coast -JG120/30S/? -Rg -Bg -Wfaint -Gbrown -EAU+gbisque -A5000
        gmt inset end
    gmt end

下面的示例绘制了一个日本的区域地图，并在左下角的小图中绘制了日本全图，同时在小图中标出了大图的研究区域。

.. gmtplot::

    gmt begin inset-map png,pdf
        gmt coast -R139.2E/140.5E/34.8N/36N -JM12c -Baf -BWSne -W2p -A1000 -Glightbrown -Sazure1 --FORMAT_GEO_MAP=dddF
        gmt inset begin -DjBL+w3c/3.6c+o0.1c -F+gwhite+p1p -M0
            gmt coast -R129E/146E/30N/46N -JM3c -Df -W0.5p -A1000 -Glightbrown -Sazure1
            # 使用 -Sr+s 绘制矩形区域
            echo 139.2 34.8 140.5 36 | gmt plot -Sr+s -W1p,blue
        gmt inset end
    gmt end
