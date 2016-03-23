.. _FONT:
.. _FONT_ANNOT_PRIMARY:
.. _FONT_ANNOT_SECONDARY:
.. _FONT_LABEL:
.. _FONT_TITLE:
.. _FONT_LOGO:

FONT参数
========

本页面列出所有字体相关参数，参数的默认值在中括号内列出。

**FONT**
    一次性设置所有FONT类参数（ ``FONT_LOGO`` 除外）的默认字体，该参数不在 ``gmt.conf`` 中。

**FONT_ANNOT_PRIMARY**
    一级（Primary）标注的字体 [``12p,Helvetica,black``]

    若在该参数的值前加上 ``+`` ，则其他字体、偏移量、刻度长度等参数值会相对于 ``FONT_ANNOT_PRIMARY`` 成比例缩放。

**FONT_ANNOT_SECONDARY**
    二级（Secondary）标注所使用的字体 [``14p,Helvetica,black``]

**FONT_LABEL**
    轴标签所使用的字体 [``16p,Helvetica,black``]

**FONT_TITLE**
    图上方标题所使用的字体 [``24p,Helvetica,black``]

**FONT_LOGO**
    GMT时间戳中字符串所使用的字体 [``8p,Helvetica,black``]

    该参数中仅字体ID有效，字号及颜色均无效。
