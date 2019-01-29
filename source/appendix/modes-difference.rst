现代模式 vs 经典模式
====================

GMT自6.0.0版本开始，引入了一种全新的绘图命令执行模式，称之为现代模式。
而GMT5以及之前的命令风格则称之为经典模式。GMT6既支持经典模式也支持现代模式，
因而GMT6可以完全兼容GMT5的代码。本手册只介绍现代模式，而不介绍经典模式。
对于GMT新用户而言，只需要了解现代模式；而对于GMT老用户，应了解现代模式与
经典模式的区别，并尽快开始使用现代模式进行绘图。

这一节将主要介绍经典模式存在的问题，现代模式的优点，以及如何将经典模式的代码
转换为现代模式。

经典模式的问题
--------------

一个GMT经典模式下的绘图脚本如下所示::

    #!/bin/bash
    R=65/18/117/45+r
    J=B90/0/40/30/6.5i
    PS=GMT_tutor3.ps
    D=earth_relief_03m.grd

    gmt gmtset FONT_ANNOT_PRIMARY 10p
    gmt grdcut $D -R55/120/10/50 -GTibet.grd
    gmt grdgradient Tibet.grd -A0 -Nt -Gint.grad

    gmt psbasemap -R$R -J$J -B10g10 -BwSEN -K -P > $PS
    gmt grdimage -R$R -J$J -Bg10 Tibet.grd -Iint.grad -CTibet.cpt -K -O >> $PS
    gmt pscoast -R$R -J$J -N1/0.5p,white -Ia/0.15p,177/178/183 -I1/0.5p,61/99/172 -C81/174/254 -Lg86/18+c30+w1000+u+f -K -O >> $PS
    gmt psscale -Dx-0.3i/1.4i+w2.5i/0.15i+ma -CTibet.cpt -G1600/9000 -By+lm -Bxa1000f200 -K -O >> $PS
    gmt psscale -Dx-0.3i/0+w1.3i/0.15i+ma -CTibet.cpt -G-3500/0 -L -O >> $PS
    gmt psconvert -A -P -Tf $PS
    rm gmt.* Tibet.grd int.grad

从上面的示例脚本中以及实际使用经验中会发现GMT经典模式存在的一些明显的缺点或问题：

#. 大部分命令需要使用 ``-K`` 和 ``-O`` 选项，而且极其容易出错
#. 需要使用 ``-P`` 选项决定画布的摆放方式
#. 每个绘图命令都需要使用重定向符号 ``>`` 或 ``>>``
#. 每个绘图命令中都需要给定PS文件的名字
#. 大部分命令都需要重复使用 ``-J`` 和 ``-R`` 选项，尽管具体数值可以省略
#. 需要调用单独的命令将生成的PS文件转换为PDF、JPG、PNG等格式

现代模式的优点
--------------

上面的示例在现代模式下可以改写为::

    #!/bin/bash
    D=@earth_relief_03m.grd

    gmt grdcut $D -R55/120/10/50 -GTibet.grd
    gmt grdgradient Tibet.grd -A0 -Nt -Gint.grad

    gmt begin tutor3 pdf,png
    gmt set FONT_ANNOT_PRIMARY 10p
    gmt basemap -JB90/0/40/30/6.5i -R65/18/117/45+r -B10g10 -BwSEN
    gmt grdimage -Bg10 Tibet.grd -Iint.grad -CTibet.cpt
    gmt coast -N1/0.5p,white -Ia/0.15p,177/178/183 -I1/0.5p,61/99/172 -C81/174/254 -Lg86/18+c30+w1000+u+f
    gmt colorbar -Dx-0.3i/1.4i+w2.5i/0.15i+ma -CTibet.cpt -G1600/9000 -By+lm -Bxa1000f200
    gmt colorbar -Dx-0.3i/0+w1.3i/0.15i+ma -CTibet.cpt -G-3500/0 -L
    rm Tibet.grd int.grad
    gmt end

现代模式下的GMT绘图命令更加简洁，具有如下优点：

#. 不再需要考虑 ``-K``\ 、``-O`` 和 ``-P`` 选项
#. 不再需要使用 ``>`` 或 ``>>`` 重定向，也无需为每个命令都指定PS文件名
#. 用户完全不需要意识到 PS 文件的存在
#. 不再需要为每个命令都是用 ``-R`` 和 ``-J`` 选项
#. 最终可生成PDF、PNG等多种格式的图片文件，无需再转换
#. 自动确定纸张大小并进行裁剪
#. 整个脚本在独立的临时文件夹下执行，因而可以同时执行多个脚本而不互相干扰
#. 不再需要手动清理 ``gmt.conf`` 和 ``gmt.history`` 等临时文件

除此之外，现代模式还提供了更方便的子图模式和插图模式：

- :doc:`/module/subplot`: 子图模式
- :doc:`/module/inset`: 插图模式

从经典到现代
------------

将一个经典模式的脚本改成现代模式下的脚本也很简单，基本遵循如下几点：

#. 绘图脚本以 ``gmt begin figname pdf`` 开头，以 ``gmt end`` 结束
#. 去掉 ``-K``\ 、``-O``\ 、``-P``\ 、重定向符号以及PS文件名
#. 去掉多余的 ``-R`` 和 ``-J`` 选项
#. 某些模块重新命名了。经典模式下以 ``ps`` 开头的模块省略了 ``ps``\ ，
   比如 ``pscoast => coast``\ 、\ ``psbasemap => basemap``\ 。
   几个例外包括 ``psxy => plot``\ ，``psxyz => plot3d``\ ，``psscale => colorbar``\ 。
