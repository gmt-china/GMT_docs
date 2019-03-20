中文图
======

.. note::

    GMT本身不支持中文，若需要在GMT上显示中文，需要进行额外的配置。具体方法见
    :doc:`/install/index` 一章。本文假定用户已经做好了GMT中文支持的配置工作。

.. note::

    GMT中文语言文件是GMT安装目录下的文件 ``share/localization/gmt_cn1.locale``\ 。
    该中文语言文件默认为GB2312编码方式。对于Linux和macOS用户，需要人工将其修改为
    UTF8编码才能正常显示中文的月份和星期。Windows用户则不需要对其进行处理。

    修改文件编码方式的方式有很多，请自行查找。我使用的是
    `enca <https://github.com/nijel/enca>`_\ 的如下命令修改编码::

        enca -L zh_CN -x UTF-8 gmt_cn1.locale

中文文字
--------

本例中展示了如何在绘图时使用中文标签和中文标题，以及如何打印横排和竖排的中文。

.. literalinclude:: chinese-texts-1.sh

.. figure:: chinese-texts-1.*
   :align: center
   :width: 80%

对于纵轴的标注，GMT的默认设定使得文字方向使用与纵轴方向平行，这一点无法修改。
此时可以使用 :doc:`/module/text` 手动为纵轴添加竖排的中文标签。

.. literalinclude:: chinese-texts-2.sh

.. figure:: chinese-texts-2.*
   :align: center
   :width: 80%

中文月份
--------

GMT支持中文的月份。要想使用中文表示月份，需要设置 :ref:`GMT_LANGUAGE <GMT_LANGUAGE>` 为中文，
即 ``cn1``\ ，并设置标注的字体为中文。

.. literalinclude:: chinese-months.sh

.. figure:: chinese-months.*
   :align: center
   :width: 80%

中文星期
--------

GMT支持中文的星期。要想使用中文表示星期几，需要设置 :ref:`GMT_LANGUAGE <GMT_LANGUAGE>` 为中文，
即 ``cn1``\ ，并设置标注的字体为中文。

.. literalinclude:: chinese-weeks.sh

.. figure:: chinese-weeks.*
   :align: center
   :width: 80%
