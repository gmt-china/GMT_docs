经典模式 → 现代模式
===================

:贡献者: |田冬冬|

----

GMT6 引入了一种全新的绘图命令执行模式，称之为现代模式。
GMT5 及之前版本的命令风格称之为经典模式。
GMT6 既支持传统的经典模式，也支持全新的现代模式。
因而 GMT5 的经典模式脚本不做任何修改即可直接在 GMT6 中执行。

经典模式的问题
--------------

下面给出了一个经典模式下常见的绘图脚本::

    gmt makecpt -Chot -T-1000/1000 > mydata.cpt
    gmt grdimage globe.nc -JQ15c -Rg -Cmydata.cpt -I -P -K > map.ps
    gmt pscoast -J -R -Baf -Gred -K -O >> map.ps
    gmt psxy cities.txt -J -R -Sc0.2c -Gblue -K -O >> map.ps
    gmt pstext labels.txt -J -R -F+f12p -O >> map.ps
    gmt psconvert -A -P -Tf map.ps
    rm gmt.conf gmt.history mydata.cpt

上面的示例脚本以及实际使用中会发现 GMT 经典模式存在一些明显的缺点或问题：

#. 默认纸张大小为 A4 纸。如果不够大，则需要自行设定纸张大小
#. 需要使用 **-P** 选项决定画布的摆放方式（横着放或竖着放）
#. 需要使用 **-K** 和 **-O** 选项，极易出错
#. 每个绘图命令都需要使用重定向符号 **>** 或 **>>**
#. 每个绘图命令中都需要给定 PS 文件的名字
#. 每个绘图命令都需要重复使用 **-J** 和 **-R** 选项
#. 绘图结束时需要使用 **psconvert** 将生成的 PS 文件转换为 PDF、JPG 等格式
#. 绘图结束时要删除 :file:`gmt.conf` 和 :file:`gmt.history` 文件以免影响接下来的绘图结果

现代模式的优点
--------------

上面的经典模式示例可以改成为更简单的现代模式::

    gmt begin map
        gmt makecpt -Chot -T-1000/1000
        gmt grdimage globe.nc -JQ15c -Rg -C -I
        gmt coast -Baf -Gred
        gmt plot cities.txt -Sc0.2c -Gblue
        gmt text labels.txt -F+f12p
    gmt end show

很显然，现代模式下的 GMT 绘图脚本更加简洁。与经典模式相比，现代模式具有如下优点：

#. 默认纸张无穷大，不需要再担心绘图超过纸张范围
#. 不再需要使用 **-P** 选项确定画布的摆放方式（因为纸张无穷大）
#. 不再需要考虑如何使用 **-K** 和 **-O** 选项
#. 不再需要使用重定向符号 **>** 或 **>>**，也无需为每个绘图命令都指定 PS 文件名
#. 不再需要为每个绘图命令都使用 **-R** 和 **-J** 选项
#. 绘图结束时会自动生成 PDF 等格式的图片，无需调用 **psconvert** 做转换
#. 生成的图片会自动进行裁剪去除白边
#. 整个绘图过程在独立的临时文件下，多个脚本可以同时执行而不互相干扰，用户完全
   不需要意识到 PS 文件的存在，不需要再手动清理 :file:`gmt.conf` 和
   :file:`gmt.history` 等临时文件

除了上面列出的优点外，GMT 现代模式还提供了更多的模块/功能以简化代码，包括：

- :doc:`/module/subplot` 模块：极大简化了多子图的绘制
- :doc:`/module/inset` 模块：极大简化了图中图的绘制
- :doc:`gmt:movie` 模块：极大简化了动画的制作
- :doc:`/option/l`：极大简化了图例的设置与绘制
- 提供了\ :doc:`当前 CPT </cpt/current-cpt>` 的功能，多数情况下无须将 CPT 写到文件中

这些更方便的功能会在后面的文档中更详细地介绍。

从经典到现代
------------

将经典模式的脚本改成现代模式的脚本，基本可以遵循如下几点：

#. 绘图脚本以 **gmt begin** *figure* 开头，以 **gmt end show** 结束
#. 去掉 **-K**、**-O**、**-P**，重定向符号以及 PS 文件名
#. 去掉多余的 **-J**、**-R** 选项
#. 某些模块在现代模式下有新的名称。经典模式下以 **ps** 开头的模块省略 **ps**，
   比如 **pscoast**→**coast**、**psbasemap**→**basemap**。
   有三个模块属于例外，**psxy**→**plot**, **psxyz**→**plot3d**,
   **psscale**→**colorbar**
#. 在需要绘制多子图、图中图时，考虑使用 **inset** 和 **subplot** 改写
#. 现代模式下 **makecpt** 和 **grd2cpt** 默认将生成的 CPT 作为当前 CPT，
   而不输出到文件中。这一特性在后面会具体介绍。如果需要生成 CPT 到文件中，
   需要额外使用 **-H** 选项。
