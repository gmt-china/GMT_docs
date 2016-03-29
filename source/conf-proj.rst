PROJ参数
========

本节列出投影相关参数，参数的默认值在中括号内列出。

.. _PROJ_LENGTH_UNIT:

**PROJ_LENGTH_UNIT**
    长度量的默认单位 [c]

    见 :doc:`unit` 一节。

.. _PROJ_ELLIPSOID:

**PROJ_ELLIPSOID**
    地图投影中使用的地球椭球标准 [WGS-84]

    可取如下值（区分大小写）：

    - *Airy*: Applies to Great Britain (1830)
    - *Airy-Ireland*: Applies to Ireland in 1965 (1830)
    - *Andrae*: Applies to Denmark and Iceland (1876)
    - *APL4.9*: Appl. Physics (1965)
    - *ATS77*: Average Terrestrial System, Canada Maritime provinces (1977)
    - *Australian*: Applies to Australia (1965)
    - *Bessel*: Applies to Central Europe, Chile, Indonesia (1841)
    - *Bessel-Namibia*: Same as Bessel-Schwazeck (1841)
    - *Bessel-NGO1948*: Modified Bessel for NGO 1948 (1841)
    - *Bessel-Schwazeck*: Applies to Namibia (1841)
    - *Clarke-1858*: Clarke's early ellipsoid (1858)
    - *Clarke-1866*: Applies to North America, the Philippines (1866)
    - *Clarke-1866-Michigan*: Modified Clarke-1866 for Michigan (1866)
    - *Clarke-1880*: Applies to most of Africa, France (1880)
    - *Clarke-1880-Arc1950*: Modified Clarke-1880 for Arc 1950 (1880)
    - *Clarke-1880-IGN*: Modified Clarke-1880 for IGN (1880)
    - *Clarke-1880-Jamaica*: Modified Clarke-1880 for Jamaica (1880)
    - *Clarke-1880-Merchich*: Modified Clarke-1880 for Merchich (1880)
    - *Clarke-1880-Palestine*: Modified Clarke-1880 for Palestine (1880)
    - *CPM*: Comm. des Poids et Mesures, France (1799)
    - *Delambre*: Applies to Belgium (1810)
    - *Engelis*: Goddard Earth Models (1985)
    - *Everest-1830*: India, Burma, Pakistan, Afghanistan, Thailand (1830)
    - *Everest-1830-Kalianpur*: Modified Everest for Kalianpur (1956) (1830)
    - *Everest-1830-Kertau*: Modified Everest for Kertau, Malaysia & Singapore (1830)
    - *Everest-1830-Pakistan*: Modified Everest for Pakistan (1830)
    - *Everest-1830-Timbalai*: Modified Everest for Timbalai, Sabah Sarawak (1830)
    - *Fischer-1960*: Used by NASA for Mercury program (1960)
    - *Fischer-1960-SouthAsia*: Same as Modified-Fischer-1960 (1960)
    - *Fischer-1968*: Used by NASA for Mercury program (1968)
    - *FlatEarth*: As Sphere, but implies fast "Flat Earth" distance calculations (1984)
    - *GRS-67*: International Geodetic Reference System (1967)
    - *GRS-80*: International Geodetic Reference System (1980)
    - *Hayford-1909*: Same as the International 1924 (1909)
    - *Helmert-1906*: Applies to Egypt (1906)
    - *Hough*: Applies to the Marshall Islands (1960)
    - *Hughes-1980*: Hughes Aircraft Company for DMSP SSM/I grid products (1980)
    - *IAG-75*: International Association of Geodesy (1975)
    - *Indonesian*: Applies to Indonesia (1974)
    - *International-1924*: Worldwide use (1924)
    - *International-1967*: Worldwide use (1967)
    - *Kaula*: From satellite tracking (1961)
    - *Krassovsky*: Used in the (now former) Soviet Union (1940)
    - *Lerch*: For geoid modelling (1979)
    - *Maupertius*: Really old ellipsoid used in France (1738)
    - *Mercury-1960*: Same as Fischer-1960 (1960)
    - *MERIT-83*: United States Naval Observatory (1983)
    - *Modified-Airy*: Same as Airy-Ireland (1830)
    - *Modified-Fischer-1960*: Applies to Singapore (1960)
    - *Modified-Mercury-1968*: Same as Fischer-1968 (1968)
    - *NWL-10D*: Naval Weapons Lab (Same as WGS-72) (1972)
    - *NWL-9D*: Naval Weapons Lab (Same as WGS-66) (1966)
    - *OSU86F*: Ohio State University (1986)
    - *OSU91A*: Ohio State University (1991)
    - *Plessis*: Old ellipsoid used in France (1817)
    - *SGS-85*: Soviet Geodetic System (1985)
    - *South-American*: Applies to South America (1969)
    - *Sphere*: The mean radius in WGS-84 (for spherical/plate tectonics applications) (1984)
    - *Struve*: Friedrich Georg Wilhelm Struve (1860)
    - *TOPEX*: Used commonly for altimetry (1990)
    - *Walbeck*: First least squares solution by Finnish astronomer (1819)
    - *War-Office*: Developed by G. T. McCaw (1926)
    - *WGS-60*: World Geodetic System (1960)
    - *WGS-66*: World Geodetic System (1966)
    - *WGS-72*: World Geodetic System (1972)
    - *WGS-84*: World Geodetic System [Default] (1984)
    - *Moon*: Moon (IAU2000) (2000)
    - *Mercury*: Mercury (IAU2000) (2000)
    - *Venus*: Venus (IAU2000) (2000)
    - *Mars*: Mars (IAU2000) (2000)
    - *Jupiter*: Jupiter (IAU2000) (2000)
    - *Saturn*: Saturn (IAU2000) (2000)
    - *Uranus*: Uranus (IAU2000) (2000)
    - *Neptune*: Neptune (IAU2000) (2000)
    - *Pluto*: Pluto (IAU2000) (2000)

    GMT还支持自定义椭球，用户只需按照固定的格式对椭球命名，GMT会从椭球名字中提取半长轴以及扁率。可用的格式如下：

    - ``a`` ：球半径为a，单位为 ``m`` ，扁率为零。比如 ``6378137``
    - ``a,inv_f`` ： ``inv_f`` 为扁率的倒数，比如 ``6378137,298.257223563``
    - ``a,b=semi_minor`` ： ``semi_minor`` 为半短轴长度，单位为 ``m`` 。比如 ``6378137,b=6356752.3142``
    - ``a,f=flattening`` ： ``flattening`` 为扁率，比如 ``6378137,f=0.0033528``

    需要注意，对于某些全球投影，GMT会对选中的地球椭球做球状近似，将扁率设为零，并使用其平均半径。当GMT做此类近似时，会给出警告信息。

.. _PROJ_AUX_LATITUDE:

**PROJ_AUX_LATITUDE**
    球体近似时的辅助纬线 [authalic]

    在使用大圆弧距离计算方式时，需要将真实地球近似为一个半径为 :ref:`PROJ_MEAN_RADIUS <PROJ_MEAN_RADIUS>` 的球体，在做球体近似时需要选择合适的辅助纬线。可选值包括

    - ``authalic``
    - ``geocentric``
    - ``conformal``
    - ``meridional``
    - ``parametric``
    - ``none``

    当设置为除 ``none`` 外的其他值时，GMT会在计算距离前，将大圆弧距离计算时使用的两点中任意一点的纬度转换成辅助纬度。

.. _PROJ_MEAN_RADIUS:

**PROJ_MEAN_RADIUS**
    地球/行星的平均半径 [authalic]

    在计算两点间的大圆弧距离或区域的表面积时才会被使用。可选值包括

    - ``mean (R_1)``
    - ``authalic (R_2)``
    - ``volumetric(R_3)``
    - ``meridional``
    - ``quadratic``

.. _PROJ_SCALE_FACTOR:

**PROJ_SCALE_FACTOR**
    修改某些投影的地图缩放因子以减小面积失真

    - Polar Stereographic：默认值为0.9996
    - UTM：默认值为0.9996
    - Transverse Mercator：默认值为1

.. _PROJ_GEODESIC:

**PROJ_GEODESIC**
    指定大地测量距离中所使用的算法 [Vincenty]

    可以取：

    #. ``Vincenty`` 默认值，精确到0.5mm
    #. ``Rudoe`` given for legacy purpose
    #. ``Andoyer`` 精度为10米量级，比 ``Vincenty`` 快5倍
