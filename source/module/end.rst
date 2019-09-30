.. index:: ! end
.. include:: common_SYN_OPTs.rst_

end
===

:官方文档: :doc:`gmt:end`
:简介: 结束现代模式会话，生成并显示图片

**end** 模块用于结束由 **begin** 模块创建的GMT当前会话，并在当前目录生成
指定格式的图片文件，还支持使用系统默认图片阅读器自动打开生成的图片。

语法
----

**gmt end**
[ **show** ]
[ |SYN_OPT-V| ]

可选参数
--------

**show**
    用系统默认图片阅读器自动打开所有当前会话生成的图片文件

.. include:: explain_-V.rst_

.. include:: explain_help_nopar.rst_

示例
----

用 **begin** 创建一个会话，绘图，并用 **end** 结束当前会话::

    gmt begin
    gmt basemap -R0/10/0/10 -JX10c -Baf
    gmt end show

相关模块
--------

:doc:`begin`,
:doc:`clear`,
:doc:`docs`,
:doc:`figure`,
:doc:`inset`,
:doc:`subplot`
