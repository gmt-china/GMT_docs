.. index:: ! grdraster

grdraster
=========

:官方文档: :doc:`gmt:grdraster`
:简介: 从二进制数据中提取子区域并保存为GMT网格文件

该命令会读取根据 ``grdraster.info`` 的内容，读取指定的二进制数据，从中提取出
一个区域里的数据，并保存为网格文件。

GMT会依次在当前目录、环境变量 ``$GMT_USERDIR`` 和 ``$GMT_DATADIR`` 指定的目录、
``$GMT_SHAREDIR/dbase`` 目录下寻找 ``grdraster.info`` 文件。

.. note::

   使用该模块的前提是用户已经自行备好了二进制数据文件，对于一般用户而言相对
   复杂，不建议使用该模块。

grdraster.info
--------------

``grdraster.info`` 定义了一个数据库，其作用在于指定了本地二进制文件的基本信息，
使得GMT可以精确地知道二进制数据的格式，进而可以准确读取二进制文件的内容。

文件内容的格式为::

    文件号 文件标题 Z值单位 -R范围 -I间隔 配准方式 数据格式 scale offset NaN 文件名

必选选项
--------

``<filenumber>``
    ``grdraster.info`` 中某文件所对应的文件号。

    也可以使用 ``text pattern`` 找到 ``grdraster.info`` 中数据描述中匹配的行。

可选选项
--------

``-G<grdfile>``
    默认会直接将数据以XYZ格式输出到标准输出流。使用该选项，则会将数据写到网格
    文件中。

.. include:: explain_-I.rst_

示例
----

从1号数据文件中提取数据，数据分辨率为30弧分。为了方便后面进行网格滤波，此处
区域范围左右各增加了4度::

    gmt grdraster 1 -R-4/364/-62/62 -I30m -Gdata.nc
