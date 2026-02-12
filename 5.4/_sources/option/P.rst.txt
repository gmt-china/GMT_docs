-P 选项
=======

``-P`` 选项用于设置纸张方向为 Portrait 模式。

取一张 A4 纸放在桌面上，有两种放置的方式：竖着放和横着放。如图所示：

.. gmtplot:: /scripts/GMT_-P.sh
    :show-code: false
    :caption: 画布方向

图中左边把纸张竖着放的称为Portrait（肖像）模式，右边把纸张横着放的方式称为
Landscape（风景）模式。记起来也很简单，人是瘦长的，所以人的肖像照需要竖着拍，
风景是矮胖的，就需要横着拍。

由于历史原因，GMT中画布的默认放置方式是Landscape模式。使用 ``-P`` 选项可以设置
使用Portrait模式，也可以设置GMT参数 :ref:`PS_PAGE_ORIENTATION <PS_PAGE_ORIENTATION>`
为 ``portrait`` 来修改纸张方向。

.. note::

   ``-P`` 选项设置的是\ **画布的属性**\ ，对于由多个命令绘制而成的图片来说，
   只有第一个命令的 ``-P`` 选项是有效的。因而其他绘图命令中使用或不使用 ``-P``
   选项并不会影响绘图效果。
