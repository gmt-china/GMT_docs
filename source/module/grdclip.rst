.. index:: !grdclip

grdclip
========

:官方文档: :doc:`gmt:grdclip`
:简介: 对网格文件的Z值范围做裁剪

必选选项
--------

``<ingrid>``
    输入网格文件名

``-G<outgrid>``
    输出网格文件名

可选选项
--------

``-R<west>/<east>/<south>/<north>[+r][+u<unit>]``
    指定要截取的网格区域。若该选项指定的范围超过了网格文件的边界，则仅提取二者
    公共的区域。

``-S``
    裁剪参数，该选项可以多次使用。

    - ``-Sa<high>/<above>`` 将所有大于 ``<high>`` 的值设置为 ``<above>``
    - ``-Sb<low>/<below>`` 将所有小于 ``<low>`` 的值设置为 ``<below>``
    - ``-Si<low>/<high>/<between>`` 将所有在 ``<low>`` 和 ``<high>`` 范围内的
      值设置为 ``<between>`` ，该选项可多次使用
    - ``-Sr<old>/<new>`` 将所有等于 ``<old>`` 的值设置为 ``<new>``  ，该选项可以多次使用

示例
----

将所有大于70的值设置为NaN，并将小于0的值设置为0::

    gmt grdclip data.nc -Gnew_data.nc -Sa70/NaN -Sb0/0 -V

将所有25到30范围内的值设置为99，35到39范围内的值设置为55，将17换成11，将所有
小于10的值设置为0::

    gmt grdclip classes.nc -Gnew_classes.nc -Si25/30/99 -Si35/39/55 -Sr17/11 -Sb10/0 -V
