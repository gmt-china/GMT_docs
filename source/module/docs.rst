.. index:: ! docs
.. include:: common_SYN_OPTs.rst_

docs
====

:官方文档: :doc:`gmt:docs`
:简介: 打开指定模块的HTML文档

**docs** 用系统默认的浏览器打开指定模块的HTML文档。
若本地存在HTML文档，则优先使用本地文档。

语法
----

**gmt docs**
[ |-Q| ]
[ |SYN_OPT-V| ]
*module-name*
[*-option*]

必须参数
--------

*module-name*
    要查看文档的模块名。

    除了模块名之外，还支持几个特殊的名字:

    - **cookbook**: 打开GMT参考手册
    - **tutorial**: 打开GMT入门教程
    - **api**: 打开GMT API手册
    - **defaults**: 打开GMT配置参数文档
    - **gallery**: 打开GMT图库

可选选项
--------

.. _-Q:

**-Q**
    仅显示文档的网页链接而不打开文档。适合没有安装图形界面的服务器。
    若使用该选项，则其必须是 **docs** 的第一个选项。

**-**\ *option*
    指定选项（例如 **-R**\ ），则 **docs** 会打开模块文档并定位到模块文档的该选项处。

.. include:: explain_-V.rst_

.. include:: explain_help_nopar.rst_

示例
----

查看 :doc:`grdimage` 的文档::

    gmt docs grdimage

查看 :doc:`grdimage` 的文档链接::

    gmt docs -Q grdimage

查看 :doc:`coast` 的 **-B** 选项::

    gmt docs coast -B

查看GMT配置参数列表::

    gmt docs defaults

查看图库::

    gmt docs gallery
