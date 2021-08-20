FONT参数
========

这一节列出所有字体相关的参数，参数的默认值在中括号内列出。

.. glossary::

    **FONT**
        同时设置所有FONT类参数（:term:`FONT_LOGO` 除外）的字体

    **FONT_ANNOT**
        同时设置 :term:`FONT_ANNOT_PRIMARY` 和 :term:`FONT_ANNOT_SECONDARY` 的值。

    **FONT_ANNOT_PRIMARY**
        一级（Primary）标注的字体 [**12p,Helvetica,black**]

        若在该参数的值前加上 **+**，则其它元素（如标题）的字体大小、偏移量、
        刻度长度等参数值会 相对于 :term:`FONT_ANNOT_PRIMARY` 的成比例缩放。

    **FONT_ANNOT_SECONDARY**
        二级（Secondary）标注的字体 [**14p,Helvetica,black**]

    **FONT_HEADING**
        子图模式下总标题的字体 [**32p,Helvetica,black**]

    **FONT_LABEL**
        轴标签的字体 [**16p,Helvetica,black**]

    **FONT_LOGO**
        GMT时间戳中字符串的字体 [**8p,Helvetica,black**]

        该参数中仅字体ID有效，字号及颜色均无效。

    **FONT_TITLE**
        图上方标题的字体 [**24p,Helvetica,black**]

    **FONT_TAG**
        子图模式下每个子图编号（如 ``a)``、``ii)`` 等）的字体 [**20p,Helvetica,black**]

