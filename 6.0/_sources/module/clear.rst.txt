.. index:: ! clear
.. include:: common_SYN_OPTs.rst_

clear
=====

:官方文档: :doc:`gmt:clear`
:简介: 删除缓存目录、数据目录或会话目录，以及当前配置文件

语法
----

**gmt clear**
**all** | **cache** | **data** | **sessions** | **settings**
[ |SYN_OPT-V| ]

可选选项
--------

**all**
    删除所有项目，包括缓存目录（\ **~/.gmt/cache**\ ）、数据目录（\ **~/.gmt/server**\ ）、会话目录（\ **~/.gmt/sessions**\ ）以及当前配置文件

**cache**
    删除GMT缓存目录（默认为\ **~/.gmt/cache**\ ）及其内容

**data**
    删除GMT数据目录（默认为\ **~/.gmt/server**\ ）及其内容

**sessions**
    删除GMT会话目录（默认为\ **~/.gmt/sessions**\ ）及其内容

**settings**
    现代模式下删除当前会话的GMT配置参数文件（即 gmt.conf），
    使得所有参数回到GMT系统默认值。

.. include:: explain_-V.rst_

.. include:: explain_help_nopar.rst_

示例
----

清空GMT缓存目录::

    gmt clear cache

删除现代模式会话下的当前配置参数文件::

    gmt clear settings

相关模块
--------

:doc:`begin`,
:doc:`docs`,
:doc:`end`,
:doc:`figure`,
:doc:`inset`,
:doc:`subplot`,
:doc:`gmt`
