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

.. note::

    GMT中文语言文件是GMT安装目录下的文件 ``share/localization/gmt_cn1.locale``\ 。
    该中文语言文件默认为GB2312编码方式。对于Linux和macOS用户，需要人工将其修改为
    UTF8 编码才能正常显示中文的月份和星期。Windows用户则不需要对其进行处理。

    修改文件编码方式的方式有很多，请自行查找。我使用的是
    `enca <https://github.com/nijel/enca>`_ 的如下命令修改编码::

        enca -L zh_CN -x UTF-8 gmt_cn1.locale

GMT支持中文的月份。要想使用中文表示月份，需要设置 :term:`GMT_LANGUAGE` 为中文，
即 ``cn1``\ ，并设置标注的字体为中文。

.. literalinclude:: chinese-months.sh

.. figure:: chinese-months.*
   :align: center
   :width: 80%

中文星期
--------

GMT支持中文的星期。要想使用中文表示星期几，需要设置 :term:`GMT_LANGUAGE` 为中文，
即 ``cn1``\ ，并设置标注的字体为中文。

.. literalinclude:: chinese-weeks.sh

.. figure:: chinese-weeks.*
   :align: center
   :width: 80%
