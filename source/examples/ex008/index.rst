:orphan:

绘制缓冲区
===========

:示例贡献者: 周茂

----

GMT 的 :doc:`source/module/gmtspatial` 通过调用 `Geos 库<https://libgeos.org/>`__ 可实现部分 GIS
分析功能，包括生成缓冲区。下面为一个笛卡尔坐标多边形生成缓冲区。

.. gmtplot::
    :caption: 简单多边形的缓冲区
    :width: 100%

    gmt begin poly_buffer
        # 创建多边形
        cat > poly <<EOF
        0 0
        0 1
        1 0
        0 0
    EOF
        # 计算缓冲区，宽度为0.5，单位与多边形文件相同
        gmt spatial poly -Sb0.5 > poly_buffer
        # 绘制多边形
        gmt plot -R-1/2/-1/2 -JX5i poly -W0.5p,black -B
        # 绘制缓冲区
        gmt plot poly_buffer -W0.5p,red

    gmt end show

对于复杂的多边形，生成的缓冲区可能存在一些问题，以下图为例，生成的缓冲中有许多异常点，
用户可手动删除生成的 ``tw_buffer.geo`` 中位于文件尾部的异常点，再绘图或进行其他分析。
还需要注意的是，缓冲区生成算法是基于笛卡尔坐标实现的，因此会将输入的地理坐标假定为笛卡尔
坐标，这在使用地理坐标时，通常是不合适的。正常的做法是，先将多边形坐标投影，然后计算
缓冲区，最后再将缓冲区做投影逆变换得到地理坐标，其中的投影变换或逆变换可通过
:doc:`source/module/mapproject` 实现，选择的投影最好为等面积投影。

.. gmtplot::
    :caption: 海岸线缓冲区
    :width: 100%
    
    gmt begin coast_buffer

        # 提取边界
        gmt coast -ETW -M -Dc > tw.geo
        # 适当删除面积太小的岛屿等特征，以防生成缓冲区出问题或计算太慢
        gmt spatial -Qc1000+h tw.geo -fg > tw_temp.geo
        # 生成缓冲区，宽度为 0.5 度
        gmt spatial tw_temp.geo -Sb0.5 > tw_buffer.geo
        gmt plot -R116/124/20/26 -JQ5i tw.geo -W0.5p,black -B
        gmt plot tw_buffer.geo -W0.5p,red
    
    gmt end show
