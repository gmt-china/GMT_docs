GMT 中文效果演示
================

中文文字
--------

本例中展示了如何在绘图时使用中文标签和中文标题，以及如何打印横排和竖排的中文。

- 左图中 Y 轴标签与纵轴平行
- 中图中 Y 轴标签与 X 轴平行
- 右图中 Y 轴标签单独绘制并使用了竖排中文字体。

.. gmtplot:: chinese-texts.sh
    :show-code: true
    :width: 80%

中文月份
--------

GMT 可以绘制中文的月份。

Linux 和 macOS 用户需要先修改 GMT 中文语言文件的字符编码（Windows 用户不需要）::

    # 进入 GMT 语言定义文件所在目录
    cd `gmt --show-sharedir`/localization

    # 备份中文语言文件
    cp gmt_cn1.locale gmt_cn1.locale_old
    
    # 将中文编码方式从默认的 GB2312 修改为 UTF8 编码，这样才能正常显示中文月份，星期，指南针等
    iconv -f GBK -t UTF8 gmt_cn1.locale_old > gmt_cn1.locale

设置 :term:`GMT_LANGUAGE` 为中文（即 ``cn1``），并设置标注字体为中文。

.. gmtplot:: chinese-months.sh
   :show-code: true
   :width: 80%

中文星期
--------

GMT 支持中文的星期。要想使用中文表示星期几，需要设置 :term:`GMT_LANGUAGE` 为中文，
即 ``cn1``，并设置标注的字体为中文。

.. gmtplot:: chinese-weeks.sh
   :show-code: true
   :width: 80%

中文玫瑰图
----------

GMT 绘制的玫瑰图同样支持中文，但除设置 :term:`GMT_LANGUAGE` 为中文，即 ``cn1`` 外，
由于 GMT 自带的 gmt_cn1.locale 文件中没有给出方向的汉化，因此用户需手动修改上述转换
编码后的文件（见 `中文月份`_ ），将其最后四行替换为如下四行::

    C	1	West		W	西
    C	2	East		E	东
    C	3	South		S	南
    C	4	North		N	北

.. literalinclude:: chinese-compass.sh

.. figure:: chinese-compass.*
   :width: 80%
   :align: center
