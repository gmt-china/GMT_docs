:orphan:

绘制缓冲区
===========

:示例贡献者: |周茂|

----

GMT 的 :doc:`/module/gmtspatial` 通过调用 `Geos 库 <https://libgeos.org/>`__ 可实现部分 GIS
分析功能，包括生成缓冲区。下面对笛卡尔坐标多边形/线数据生成缓冲区。

.. gmtplot:: ex008.sh
    :width: 50%
    :show-code: true

从上图看出，在某些生成的缓冲区中，存在一些异常点。经过分析，推测该 bug 生成原因为：GMT 调用 GEOS
生成缓冲区多边形后，又调用取最大外部环函数将其从多边形转换为线数据导致部分点丢失，丢失的部分点即
图中出现的异常点。目前该 bug 还未精确定位和修复。在实际使用中，如果生成缓冲区不是明显的凹多边形，且该
部分丢失的区域不影响显示或后续分析，用户可手动删除位于缓冲区文件尾部的异常点。更加稳健的做法为使用
GEOS 的 julia/python 库实现上述功能，上述封装无需多边形到线数据的转换，因此不存在该 bug。此外，还
可使用 GMT 的 julia 封装 `GMT.jl <https://github.com/GenericMappingTools/GMT.jl>`__ 中的 `buffer`
函数，该函数通过 GDAL 调用 GEOS，同样不存在上述 bug。

目前，缓冲区生成算法是基于笛卡尔坐标实现的，因此会将输入的地理坐标假定为笛卡尔
坐标，这在使用地理坐标时，通常是不合适的。正常的做法是，先将多边形坐标投影，然后计算
缓冲区，最后再将缓冲区做投影逆变换得到地理坐标，其中的投影变换或逆变换可通过
:doc:`/module/mapproject` 实现，选择的投影最好为等面积投影。下面分别展示不使用投影
和使用投影的地理坐标缓冲区计算。

.. gmtplot::
    :caption: 海岸线缓冲区
    :width: 60%
    
    gmt begin coast_buffer

        # 提取边界
        gmt coast -ETW -M -Dc > tw.geo
        # 适当删除面积太小的岛屿等特征，以防生成缓冲区计算太慢
        gmt spatial -Qc1000+h tw.geo -fg > tw_temp.geo
        # 生成缓冲区，宽度为 0.5 度
        gmt spatial tw_temp.geo -Sb0.5 > tw_buffer.geo
        gmt plot -R116/124/20/26 -JQ5i tw.geo -W0.5p,black -B
        gmt plot tw_buffer.geo -W0.5p,red
    
    gmt end show


.. gmtplot::
    :caption: 海岸线缓冲区(使用投影)
    :width: 60%
    
    gmt begin coast_proj_buffer

        gmt coast -ETW -M -Dc > tw.geo
        gmt spatial -Qc1000+h tw.geo -fg > tw_temp.geo
        # 坐标投影
        gmt mapproject -R116/124/20/26 -Jh1:1 -C -F tw_temp.geo > tw_temp.car
        # 生成缓冲区, 0.5 度约为 56 km
        gmt spatial tw_temp.car -Sb56000 > tw_buffer.car
        # 逆投影
        gmt mapproject -R116/124/20/26 -Jh1:1 -C -F -I tw_buffer.car > tw_buffer.geo
        gmt plot -R116/124/20/26 -JQ5i tw.geo -W0.5p,black -B
        gmt plot tw_buffer.geo -W0.5p,red

    gmt end show
