:author: 田冬冬, 陈箫翰
:date: 2025-12-30

.. index:: ! defaults
.. program:: defaults

defaults
===========

:官方文档: :doc:`gmt:gmtdefaults`
:简介: 列出所有GMT配置参数的当前值或系统默认值

语法
----

**gmt defaults**
[ :option:`-D`\ [**u**\|\ **s**] ]

可选选项
--------

.. option:: -D

**-D**\ [**u**\|\ **s**]
    打印系统默认参数值

    - 不使用 :option:`-D` 选项：打印GMT参数当前值
    - :option:`-D`：列出GMT系统默认参数值
    - **-Du**：列出GMT的US单位制下的默认参数值
    - **-Ds**：列出GMT的SI单位制下的默认参数值

.. include:: explain_help.rst_

示例
----

在当前目录生成一份 GMT 系统默认配置::

    gmt defaults -D > gmt.conf

搜索与 LABEL 有关的参数的值::

    gmt defaults -D | grep LABEL

相关模块
--------

:doc:`get`,
:doc:`set`
