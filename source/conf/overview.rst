配置参数简介
============

除了丰富的命令行选项之外，GMT提供了150多个配置参数，用于控制图像的外观
（如底图边框的画笔粗细、颜色，文字标注的字体、大小和颜色等）和
数据的处理方式（如默认的插值方式、地图投影使用的椭球等）等。

查看配置参数的值
----------------

每个配置参数都有一个系统默认值。使用::

    gmt defaults -D

即可查看所有GMT配置参数及其默认值。

使用::

    gmt get FORMAT_GEO_MAP

可以查看单个配置参数 :term:`FORMAT_GEO_MAP` 的当前值。

修改配置参数的值
----------------

GMT提供了多种方法来控制或修改配置参数的值。

**设置全局参数**
    用 :doc:`/module/gmtset` 模块可以为GMT设置全局参数，此类参数会影响到接下来
    所有GMT命令的执行，直到绘图结束或者被 :doc:`/module/gmtset` 再次修改为
    其他值为止。例如::

        gmt begin map png
        # 设置全局参数 FONT_ANNOT_PRIMARY 的值为 12p,Times-Bold,red
        gmt set FONT_ANNOT_PRIMARY 12p,Times-Bold,red
        gmt basemap ...
        gmt end

**设置临时参数**
    在单个命令上加上 **--KEY**\=\ *value* 可以临时设置配置参数的值。此类参数仅对当前
    命令有效，而不影响接下来其他命令的执行效果。例如::

        gmt begin map png
        # 使用默认参数绘制底图
        gmt basemap ...
        # 该底图的 FONT_ANNOT_PRIMARY 为 12p,Times-Bold,red
        gmt basemap ... --FONT_ANNOT_PRIMARY=12p,Times-Bold,red
        # 使用默认参数绘制底图
        gmt basemap ...
        gmt end

**使用配置文件设置全局参数**
    可以将需要配置的一系列参数值写到GMT配置文件 :file:`gmt.conf` 中。
    当GMT在执行时，会在当前目录->\ ``~/.gmt/``\ 以及家目录下寻找GMT配置文件
    :file:`gmt.conf`\ 。若找到该配置文件，则会读取该配置文件中参数的值作为
    全局参数。

    此种方式通常用于制作某个特定风格的图件（比如黑底白线）或者某个符合某个期刊
    特定要求的图件。可以使用::

        gmt defaults -D > gmt.conf

    生成一个包含所有参数的配置文件，然后手动修改。
