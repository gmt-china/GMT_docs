.. index:: ! docs
.. include:: common_SYN_OPTs.rst_

docs
====

:官方文档: :doc:`gmt:docs`
:简介: 打开指定模块的GMT官方HTML文档

**docs** 用系统默认浏览器打开指定模块的HTML文档。若本地存在HTML文档，
则优先使用本地文档；否则则打开GMT文档网站。除了可以指定模块外，
还支持打开一些常用的文档页面（下面会详细列出）。

语法
----

**gmt docs**
[ |-Q| ]
[ |-S| ]
[ |SYN_OPT-V| ]
*module-name*
[*-option*]

必须参数
--------

*module-name*
    要查看文档的模块名。

    除了模块名之外，还支持几个特殊的页面:

    - **gmt**: 打开GMT命令的说明文档
    - **api**: 打开GMT API手册
    - **colors**: 打开GMT颜色列表文档
    - **cookbook**: 打开GMT参考手册
    - **data**: 打开GMT数据集页面
    - **gallery**: 打开GMT图库
    - **home**: 打开GMT文档手册
    - **settings**: 打开GMT配置参数文档
    - **tutorial**: 打开GMT入门教程
    - **forum**: 打开GMT官方论坛网站
    - **website**: 打开GMT官方网站

可选选项
--------

.. _-Q:

**-Q**
    仅显示文档的网页链接而不打开文档，适用于没有安装图形界面的服务器。
    若使用该选项，则其必须是 **docs** 的第一个选项。

.. _-S:

**-S**
    **docs** 默认优先打开本地文档，若本地文档不存在，则打开GMT文档网站。
    该选项强制 **docs** 使用浏览器打开GMT文档网站上的网页。

**-**\ *option*
    指定选项（例如 **-R**\ ），则 **docs** 会打开模块文档并定位到模块文档的该选项处。

    注意，该功能对本地文档无效，因而当使用该功能时GMT会默认添加 **-S** 选项以打开
    远程文档。

.. include:: explain_-V.rst_

.. include:: explain_help_nopar.rst_

示例
----

查看 :doc:`grdimage` 的文档::

    gmt docs grdimage

查看 :doc:`grdimage` 的文档链接::

    gmt docs -Q grdimage

查看 :doc:`grdimage` 在GMT文档网站上的链接::

    gmt docs -Q -S grdimage

查看 :doc:`coast` 的 **-B** 选项::

    gmt docs coast -B

查看GMT配置参数列表::

    gmt docs settings

查看图库::

    gmt docs gallery

相关模块
--------

:doc:`begin`,
:doc:`clear`,
:doc:`end`,
:doc:`figure`,
:doc:`inset`,
:doc:`subplot`,
:doc:`gmt`
