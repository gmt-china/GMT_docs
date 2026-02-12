FONT参数
========

这一节列出所有字体相关的参数，参数的默认值在中括号内列出。

.. _FONT:

FONT
    同时设置所有FONT类参数（\ ``FONT_LOGO`` 除外）的字体

.. _FONT_ANNOT:

FONT_ANNOT
    同时设置 ``FONT_ANNOT_PRIMARY`` 和 ``FONT_ANNOT_SECONDARY`` 的值。

.. _FONT_ANNOT_PRIMARY:

FONT_ANNOT_PRIMARY
    一级（Primary）标注的字体 [``12p,Helvetica,black``]

    若在该参数的值前加上 ``+``\ ，则其它字体、偏移量、刻度长度等参数值会
    相对于 ``FONT_ANNOT_PRIMARY`` 成比例缩放。

.. _FONT_ANNOT_SECONDARY:

FONT_ANNOT_SECONDARY
    二级（Secondary）标注的字体 [``14p,Helvetica,black``]

.. _FONT_LABEL:

FONT_LABEL
    轴标签的字体 [``16p,Helvetica,black``]

.. _FONT_TITLE:

FONT_TITLE
    图上方标题的字体 [``24p,Helvetica,black``]

.. _FONT_LOGO:

FONT_LOGO
    GMT时间戳中字符串的字体 [``8p,Helvetica,black``]

    该参数中仅字体ID有效，字号及颜色均无效。
