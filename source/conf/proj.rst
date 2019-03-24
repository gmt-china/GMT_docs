PROJ参数
========

本节列出投影相关参数，参数的默认值在中括号内列出。

.. _PROJ_LENGTH_UNIT:

PROJ_LENGTH_UNIT
    长度量的默认单位 [``c``]

    见 :doc:`/basis/unit` 一节的介绍。

.. _PROJ_ELLIPSOID:

PROJ_ELLIPSOID
    地图投影中使用的地球椭球标准 [``WGS-84``]

    GMT支持几十种地球椭球标准（此处不一一列举，详见官方文档）。除此之外，GMT还支持
    自定义椭球，用户只需按照固定的格式对椭球命名，GMT会从椭球名字中提取半长轴
    以及扁率。可用的格式如下：

    - ``a``\ ：球半径为a，单位为 ``m``\ ，扁率为零。比如 ``6378137``
    - ``a,inv_f``\ ：\ ``inv_f`` 为扁率的倒数，比如 ``6378137,298.257223563``
    - ``a,b=semi_minor``\ ：\ ``semi_minor`` 为半短轴长度，单位为 ``m``\ 。
      比如 ``6378137,b=6356752.3142``
    - ``a,f=flattening``\ ：\ ``flattening`` 为扁率，比如 ``6378137,f=0.0033528``

    需要注意，对于某些全球投影，GMT会对选中的地球椭球做球状近似，将扁率设为零，
    并使用其平均半径。当GMT做此类近似时，会给出警告信息。

.. _PROJ_AUX_LATITUDE:

PROJ_AUX_LATITUDE
    球体近似时的辅助纬线 [authalic]

    在使用大圆弧距离计算方式时，需要将真实地球近似为一个半径为
    :ref:`PROJ_MEAN_RADIUS <PROJ_MEAN_RADIUS>` 的球体，在做球体近似时需要
    选择合适的辅助纬线。可选值包括

    - ``authalic``
    - ``geocentric``
    - ``conformal``
    - ``meridional``
    - ``parametric``
    - ``none``

    当设置为除 ``none`` 外的其他值时，GMT会在计算距离前，将大圆弧距离计算时使用的
    两点中任意一点的纬度转换成辅助纬度。

.. _PROJ_MEAN_RADIUS:

PROJ_MEAN_RADIUS
    地球/行星的平均半径 [authalic]

    在计算两点间的大圆弧距离或区域的表面积时才会被使用。可选值包括

    - ``mean (R_1)``
    - ``authalic (R_2)``
    - ``volumetric(R_3)``
    - ``meridional``
    - ``quadratic``

.. _PROJ_SCALE_FACTOR:

PROJ_SCALE_FACTOR
    修改某些投影的地图缩放因子以减小面积失真

    - Polar Stereographic：默认值为0.9996
    - UTM：默认值为0.9996
    - Transverse Mercator：默认值为1

.. _PROJ_GEODESIC:

PROJ_GEODESIC
    指定大地测量距离中所使用的算法 [Vincenty]

    可以取：

    #. ``Vincenty`` 默认值，精确到0.5mm
    #. ``Rudoe`` given for legacy purpose
    #. ``Andoyer`` 精度为10米量级，比 ``Vincenty`` 快5倍
