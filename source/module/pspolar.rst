.. index:: ! pspolar

pspolar
=======

:官方文档: :doc:`gmt:supplements/meca/pspolar`
:简介: 将台站的极性信息画在震源球上

一般情况下，需要使用psmeca绘制震源球，再使用pspolar将每个台站的极性信息画在
相应的震源球上。因而，通常psmeca和pspolar需要连在一起使用。

选项
----

``<infile>``
    输入数据的格式为::

        station_code  azimuth  take-off_angle polarity

    - ``station_code`` 通常是台站名
    - ``azimuth`` 震相从源到台站的方位角
    - ``take-off_angle`` 震相从源出发时的出射角
    - ``polarity``

       - 压缩部分（正极性）：可以取 ``c|C|u|U|+``
       - 拉伸部分（负极性）：可以取 ``d|D|r|R|-``
       - 未定义：其他字符

``-C<new_lon>/<new_lat>[W<pen>][P<pointsize>]``
    将震源球放在新的位置，并将新位置与老位置之间连线。

``-D<lon>/<lat>``
    震源球的位置，需要与psmeca输入数据中震源球的位置相同

``-E<color>``
    拉伸象限内台站的符号填充色

``-F<color>``
    设置震源球的背景色，默认不填充。

``-G<color>``
    压缩象限内台站的符号填充色，默认值为黑色

``-M<size>``
    震源球的尺寸，需要与psmeca中 ``-S`` 选项中震源球尺寸相同

``-S<symbol_type><size>``
    类似于psxy的 ``-S`` 选项，控制极性要以什么符号以及多大尺寸绘制到震源球上，可选的符号类型包括 ``a|c|d|h|i|p|s|t|x``

``-N``
    不跳过地图边界外的符号

``-Q<mode><args>``
    设置多个属性，该选项可重复使用。

    - ``-Qe[<pen>]`` 拉伸象限内符号的轮廓属性
    - ``-Qf[<pen>]`` 震源球的轮廓属性
    - ``-Qg[<pen>]`` 压缩象限内符号的轮廓属性
    - ``-Qh`` 使用HYPO71输出的特殊格式
    - ``-Qs<half-size>/[V[<vecpar>]][G<fill>][L]`` 绘制S波偏振方位角，见官方文档
    - ``-Qt[<pen>]`` station_code的字体颜色

``-T<angle>/<form>/<justify>/<fontsize>``
    将 station_code 写到图上，默认值为 ``0.0/0/5/12`` 。 ``<fontsize>`` 的单位为 ``p``

``-W<pen>``
    设置画笔属性

示例
----

.. gmtplot:: /scripts/pspolar_ex1.sh
   :width: 100%
   :align: center

   pspolar示例
