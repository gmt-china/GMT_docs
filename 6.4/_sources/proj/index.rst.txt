地图投影
########

GMT 读取数据的实际坐标，并将其转换或者投影到图片的对应位置。当前，GMT 支持 30 多种坐标变换或投影方式。
这些投影方式可以分为三类，每一类又可以细分为几个小类：

#. 笛卡尔投影：细分为三类（位于下图的 OTHER 分类）

   - 笛卡尔线性投影
   - 笛卡尔对数投影
   - 笛卡尔指数投影

#. 极坐标投影（位于下图的 OTHER 分类）
#. 地图投影：细分为四类

   - 圆柱地图投影（cylindrical projection）
   - 圆锥地图投影（conic projection）
   - 方位地图投影（azimuthal projection）
   - 其它地图投影（miscellaneous projection，即下图的 THEMATIC 分类）

.. gmtplot:: projections.sh
   :width: 75%
   :show-code: false
   :caption: GMT支持的地图投影及坐标变换

:doc:`/option/J` 这一节简要介绍了 GMT 中指定投影方式的三种不同格式。下表列出了 GMT 所支持的全部投影方式。

.. include:: ../option/projection-codes.rst_

.. toctree::
   :maxdepth: 2
   :hidden:

   Jx
   Jp
   Ja
   Jb
   Jc
   Jcyl_stere
   Jd
   Je
   Jf
   Jg
   Jh
   Ji
   Jj
   Jk
   Jl
   Jm
   Jn
   Jo
   Jpoly
   Jq
   Jr
   Js
   Jt
   Ju
   Jv
   Jw
   Jy
