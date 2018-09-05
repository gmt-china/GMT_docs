FONT参数
========

本页面列出所有字体相关参数，参数的默认值在中括号内列出。

.. _FONT:

**FONT**
    一次性设置所有FONT类参数（ ``FONT_LOGO`` 除外）的默认字体，该参数不在 ``gmt.conf`` 中。

.. _FONT_ANNOT:

**FONT_ANNOT**
    同时设置 ``FONT_ANNOT_PRIMARY`` 和 ``FONT_ANNOT_SECONDARY`` 的值。

.. _FONT_ANNOT_PRIMARY:

**FONT_ANNOT_PRIMARY**
    一级（Primary）标注的字体 [``12p,Helvetica,black``]

    若在该参数的值前加上 ``+`` ，则其他字体、偏移量、刻度长度等参数值会相对于 ``FONT_ANNOT_PRIMARY`` 成比例缩放。

.. _FONT_ANNOT_SECONDARY:

**FONT_ANNOT_SECONDARY**
    二级（Secondary）标注所使用的字体 [``14p,Helvetica,black``]

.. _FONT_HEADING:

**FONT_HEADING**
    多子图的总标题的字体 [``32p,Helvetica,black``]

.. _FONT_LABEL:

**FONT_LABEL**
    轴标签所使用的字体 [``16p,Helvetica,black``]

.. _FONT_TITLE:

**FONT_TITLE**
    图上方标题所使用的字体 [``24p,Helvetica,black``]

.. _FONT_LOGO:

**FONT_LOGO**
    GMT时间戳中字符串所使用的字体 [``8p,Helvetica,black``]

    该参数中仅字体ID有效，字号及颜色均无效。

.. _FONT_TAG:

**FONT_TAG**
    子图中每个面板的标签（如 ``a)`` 、 ``ii)`` 等）的字体 [``20p,Helvetica,black``]
