:author: 朱邓达
:date: 2025-10-28

.. index:: ! isf
.. program:: isf

isf
==========

:官方文档: :doc:`gmt:supplements/seis/gmtisf`
:简介: 将 ISF 格式的地震目录数据转换为 GMT 表数据

将 `ISC <https://www.isc.ac.uk/iscbulletin>`_ 发布的
`ISF <https://www.isc.ac.uk/standards/isf/>`_
格式的地震目录文件 *file.isf* 转为 *[lon lat depth mag ...]* 格式的表数据，输出到标准输出。

语法
----

**gmt isf**
*ISFfile*
[ :option:`-R`\ *region* ]
[ :option:`-D`\ *date_start*\ [/*date_end*] ]
[ :option:`-F`\ [**a**] ]
[ :option:`-N` ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

*ISFfile*
    `ISF <https://www.isc.ac.uk/standards/isf/>`_ 格式的地震目录文件

可选选项
--------

.. include:: explain_-R.rst_

.. option:: -D

**-D**\ *date_start*\ [/*date_end*]
    仅处理发震时刻在特定时间范围内的事件，时间格式为 ISO， e.g. 2000-04-25

    + 仅设置 *date_start* 表示仅处理时间范围在 *date >= date_start* 的部分。
    + 设置 *date_start* 和 *date_end* 表示处理时间范围在 *date_start <= date <= date_end* 的部分。

.. option:: -F

**-F**\ [**a**]
    仅处理有震源机制解的事件。

    + 默认输出为 `Global CMT <https://www.globalcmt.org/>`_ 约定的格式，每列分别代表

      + **1**,\ **2** - 震源的经度和纬度 (可使用 **-:** 交换两列)
      + **3** - 震源的深度 (km)
      + **4**,\ **5**,\ **6** - 节面 1 的走向，倾角，滑动角
      + **7**,\ **8**,\ **9** - 节面 2 的走向，倾角，滑动角
      + **10**,\ **11** - 地震矩的尾数和指数 (dyne-cm)

    + 加上 **a** 则输出为 Aki and Richards 约定的格式，每列分别代表

      + **1**,\ **2** - 震源的经度和纬度 (可使用 **-:** 交换两列)
      + **3** - 震源的深度 (km)
      + **4**,\ **5**,\ **6** - 走向，倾角，滑动角
      + **7** - 震级

.. option:: -N

**-N**
    跳过最后 5 列 *[year month day hour minute]* 的时间信息 [默认输出] 。

示例
--------

.. gmtplot::

    # 从 ISC 官网下载 ISF 格式的地震目录
    # wget https://download.isc.ac.uk/isf/catalogue/2020/202001.gz
    # gzip -dkN 202001.gz

    gmt begin testisf
        gmt grdimage @earth_relief_30m -Rd -JQ12c -B60f30g30
        # 限制空间范围、时间范围
        gmt isf 202001.isf -R-60/60/-80/80 -D2020-01-01/2020-01-15 > seismicity.dat
        gmt plot seismicity.dat -Sc0.1c -Gpink -W0.1p
    gmt end show


相关模块
---------

:doc:`meca`,
:doc:`polar`,
:doc:`coupe`,
:doc:`basemap`,
:doc:`plot`
