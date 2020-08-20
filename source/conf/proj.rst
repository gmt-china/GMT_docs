PROJ参数
========

本节列出投影相关参数，参数的默认值在中括号内列出。

.. glossary::

    **PROJ_LENGTH_UNIT**
        长度量的默认单位 [**c**]

        当长度量未显式给定单位时所使用的默认单位，可以取 **c**\|\ **i**\|\ **p**\ 。
        见 :doc:`/basis/unit`\ 。

    **PROJ_ELLIPSOID**
        地图投影中使用的地球椭球 [**WGS-84**]

        GMT支持几十种地球椭球（此处不列举，详见官方文档）。除此之外，GMT还支持
        自定义椭球，用户只需按照固定的格式对椭球命名，GMT会从椭球名字中提取半长轴
        以及扁率。可用的格式如下：

        - *a*\ ：球半径为a，单位为 m\ ，扁率为零。比如 6378137
        - *a*,\ *inv_f* ： *inv_f* 为扁率的倒数，比如 6378137,298.257223563
        - *a*\,\ *b*\ =\ *b* ： *b* 为半短轴长度，单位为 m\ ，比如 6378137,b=6356752.3142
        - *a*,\ **f=**\ *f* ： *f* 为扁率，比如 6378137,f=0.0033528

        需要注意，对于某些全球投影，GMT会对选中的地球椭球做球状近似，将扁率设为零，
        并使用其平均半径。当GMT做此类近似时，会给出警告信息。

    **PROJ_AUX_LATITUDE**
        以大圆弧方式计算球面距离时球体近似的辅助纬线 [**authalic**]

        在使用大圆弧距离计算方式时，需要将真实地球近似为一个半径为
        :term:`PROJ_MEAN_RADIUS` 的球体，在做球体近似时需要
        选择合适的辅助纬线。可选值包括

        - **authalic**
        - **geocentric**
        - **conformal**
        - **meridional**
        - **parametric**
        - **none**

        当设置为除 **none** 外的其他值时，GMT会在计算距离前，将大圆弧距离计算时使用的
        两点中任意一点的纬度转换成辅助纬度。

    **PROJ_MEAN_RADIUS**
        地球/行星的平均半径 [**authalic**]

        在计算两点间的大圆弧距离或区域的表面积时才会被使用。可选值包括

        - **mean (R_1)**
        - **authalic (R_2)**
        - **volumetric (R_3)**
        - **meridional**
        - **quadratic**

    **PROJ_SCALE_FACTOR**
        修改某些投影的地图缩放因子以减小面积失真

        - Polar Stereographic：默认值为0.9996
        - UTM：默认值为0.9996
        - Transverse Mercator：默认值为1

    **PROJ_GEODESIC**
        指定大地测量距离中所使用的算法 [Vincenty]

        可以取：

        - **Vincenty** 默认值，精确到0.5mm
        - **Rudoe** GMT4所使用的计算方式
        - **Andoyer** 精度为10米量级，比 Vincenty 快5倍
