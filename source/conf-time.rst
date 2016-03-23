.. _TIME_IS_INTERVAL:
.. _TIME_REPORT:
.. _TIME_INTERVAL_FRACTION:
.. _TIME_Y2K_OFFSET_YEAR:
.. _TIME_WEEK_START:
.. _TIME_SYSTEM:
.. _TIME_UNIT:
.. _TIME_EPOCH:

TIME参数
========

本节列出所有时间相关参数，参数的默认值在中括号内列出。

**TIME_EPOCH**
    指定所有相对时间的参考时刻 [1970-01-01T00:00:00]

    其格式为 ``yyyy-mm-ddT[hh:mm:ss]`` 或 ``yyyy-Www-ddTT[hh:mm:ss]`` 。

**TIME_UNIT**
    指定相对时间数据相对于参考时间的单位 [s]

    可以取：

    #. y：年；假定一年365.2425天；
    #. o：月；假定所有月是等长的；
    #. d：天；
    #. h：时；
    #. m：分钟；
    #. s：秒；

**TIME_SYSTEM**
    ``TIME_EPOCH`` 和 ``TIME_UNIT`` 的合并版

    即指定 ``TIME_SYSTEM`` 相当于同时指定了 ``TIME_EPOCH`` 和 ``TIME_UNIT`` 。可取如下值：

    #. ``JD`` ：等效于-4713-11-25T12:00:00 d
    #. ``MJD`` ：等效于1858-11-17T00:00:00 d
    #. ``J2000`` ：等效于2000-01-01T12:00:00 d
    #. ``S1985`` ：等效于1985-01-01T00:00:00 s
    #. ``UNIX`` ： 等效于1970-01-01T00:00:00 s
    #. ``RD0001`` ：等效于0001-01-01T00:00:00 s
    #. ``RATA`` ：等效于0000-12-31T00:00:00 d

    该参数并不存在于 ``gmt.conf`` 中，当指定该参数时，其会被自动转换为 ``TIME_EPOCH`` 和 ``TIME_UNIT`` 对应的值。

**TIME_WEEK_START**
    指定周几是一周的第一天，可取值为Monday或Sunday。

**TIME_Y2K_OFFSET_YEAR**
    当用两位数字表示四位数字的年份时，TIME_Y2K_OFFSET_YEAR给定了100年序列的第一年 [1950]

    比如，若TIME_Y2K_OFFSET_YEAR=1729，则数字29到99分别表示1729到1799，而数字00到28则表示1800到1828。默认值为1950，即00到99表示的年份范围为1950到2049。

**TIME_INTERVAL_FRACTION**
    见官方文档中的说明

**TIME_REPORT**
    见官方文档中的说明

**TIME_IS_INTERVAL**
    见官方文档中的说明

.. TODO
