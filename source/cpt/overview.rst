CPT简介
=======

有些程序需要将用户数据用颜色、绘图或图案来表示。比如，在使用2D网格数据绘制彩图
或灰度图时，需要为每个Z值或Z值范围指定要使用的颜色；再比如，有些程序需要根据Z值
决定线条颜色、符号的填充色等。CPT文件的作用就是为每个Z值或Z值范围定义其对应的
颜色。CPT全称是color palette table，也称为调色板或色标文件。

CPT文件可以在 :doc:`/module/grdimage`\ 、:doc:`/module/psxy`\ 、:doc:`/module/psxyz`
等命令中使用。通常，你可以使用 :doc:`/module/makecpt` 或 :doc:`/module/grd2cpt`
对已有的CPT（比如GMT内置的CPT）文件进行重采样，
并适应你目前所使用的数据范围。当然，也可以自己手写CPT文件，或使用 ``awk`` 、
``perl`` 之类的文本处理工具自动生成CPT文件。

由于GMT中可以用多种方式来指定颜色，因而GMT自带的或用户自己的CPT文件中通常含有
如下注释语句::

    # COLOR_MODEL = model

其中 ``model`` 可以取 RGB、hsv、cmyk，其指定了CPT文件中的颜色要如何进行解释。
