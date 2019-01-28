.. index:: ! docs

docs
====

:官方文档: :doc:`gmt:docs`
:简介: 打开指定模块的HTML文档

``docs`` 模块可以用默认的浏览器打开指定模块的网页版文档，
还可以用于打开本地文件（如PDF或其他图片文件）以及网页链接。

语法
----

    gmt docs <module-name> [<options>]

可选选项
--------

``<module-name>``
    模块名。除此之外，还可以打开 cookbook、tutorial、api、gmt.conf 等文档。

``<-option>``
    指定选项（例如 ``-R``\ ）以直接跳转到模块文档的该选项处。

示例
----

查看 :doc:`grdimage` 的文档::

    gmt docs grdimage

查看 :doc:`coast` 的 ``-B`` 选项::

    gmt docs coast -B

查看图库::

    gmt docs gallery

查看本地创建的PDF文件::

    gmt docs my_beautiful_figure.pdf
