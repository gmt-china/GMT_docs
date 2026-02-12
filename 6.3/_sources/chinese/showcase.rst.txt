GMT中文效果演示
===============

中文文字
--------

本例中展示了如何在绘图时使用中文标签和中文标题，以及如何打印横排和竖排的中文。

- 左图中Y轴标签与纵轴平行
- 中图中Y轴标签与X轴平行
- 右图中Y轴标签单独绘制并使用了竖排中文字体。

.. literalinclude:: chinese-texts.sh

.. figure:: chinese-texts.*
   :align: center
   :width: 80%

中文月份
--------

GMT 可以绘制中文的月份。

Linux 和 macOS 用户需要先修改 GMT 中文语言文件的字符编码（Windows 用户不需要）::

    # 进入 GMT 语言定义文件所在目录
    cd `gmt --show-sharedir`/localization

    # 备份中文语言文件
    cp gmt_cn1.locale gmt_cn1.locale_old
    # 将中文编码方式从默认的 GB2312 修改为 UTF8 编码，这样才能正常显示中文月份
    iconv -f GBK -t UTF8 gmt_cn1.locale

设置 :term:`GMT_LANGUAGE` 为中文（即 ``cn1``），并设置标注字体为中文。

.. literalinclude:: chinese-months.sh

.. figure:: chinese-months.*
   :align: center
   :width: 80%

中文星期
--------

GMT支持中文的星期。要想使用中文表示星期几，需要设置 :term:`GMT_LANGUAGE` 为中文，
即 ``cn1``，并设置标注的字体为中文。

.. literalinclude:: chinese-weeks.sh

.. figure:: chinese-weeks.*
   :align: center
   :width: 80%
