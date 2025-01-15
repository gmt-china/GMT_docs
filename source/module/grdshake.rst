.. index:: ! grdshake
.. include:: common_SYN_OPTs.rst_

grdshake
==========

:官方文档: :doc:`gmt:supplements/seis/grdshake`
:简介: 使用 Vs30 速度模型计算地表峰值速度、加速度、烈度。

语法
------

**gmt grdshake** *ingrid* |-G|\ *outgrid*
|-L|\ *fault.dat*
|-M|\ *mag*
[ |-C|\ *a,v,i* ]
[ |-F|\ *mecatype* ]
[ |SYN_OPT-R| ]

必选选项
---------

*ingrid*
    Vs30 速度模型网格文件

.. _-G:

**-G**\ *outgrid*
    输出文件名。如果通过 |\-C| 设置了多个分量，
    则 <outgrid> 必须包含 %%s 以格式化分量代码。
    
.. _-L:

**-L**\ *fault.dat*
    断层迹线坐标文件名

.. _-M:

**-M**\ *mag*
    地震事件的震级


可选选项
---------

.. _-C:

**-C**\ *a,v,i*
    以逗号隔开的需要计算的分量 (多个分量要求在 |-G| 有对应设置)。
    可以选择 *a*\ (cceleration，加速度)， *v*\ (elocity，速度)， *i*\ (ntensity，烈度) [默认为 *i*]。

.. _-F:

**-F**\ *1*\|\ *2*\|\ *3*\|\ *4*
    选择震源机制类型 ( **-F**\1 或 **-F**\2 ...)
       - 1 未知 [默认值]
       - 2 走滑
       - 3 正断层
       - 4 逆冲

.. include:: explain_-R.rst_

示例
-----

使用先前计算的 Vs30 速度模型，针对一次发生在断层上的地震事件（震级为7），
计算地表峰值烈度。其断层迹线坐标保存在 *line.dat* 文件中::

    gmt grdshake vs30.grd -Gshake_intensity.grd -Lline.dat -Ci -M7

计算并绘制发生在红河断裂的一个9级地震，在四川省造成的地表峰值烈度：

.. gmtplot::
    :show-code: true
    :width: 100%

     #!/usr/bin/env bash
     gmt begin grdshake-example
         gmt basemap -R95/105/20/35 -JM15c -Baf
         # 使用04m的地形数据，计算 Vs30 估计值，并将克拉通值设为1
         echo 0 0 > fake
         echo 1 0 >> fake
         echo 1 1 >> fake
         gmt grdvs30 @earth_relief_10m_p -R95/105/20/35 -Cfake -Gvs30.grd
         # 提取红河断裂的数据，保存在line.dat文件中
         gmt convert CN-faults.gmt -S"FN_Ch=红河断裂" -o0,1 > line.dat
         # 计算地表峰值烈度
         gmt grdshake vs30.grd -Gintensity.grd -Lline.dat -Ci -M9
         # 绘制地表峰值烈度
         gmt grd2cpt -Cseis -Gintensity.grd -Z -D
         gmt grdimage intensity.grd -C
         rm fake vs30.grd line.dat intensity.grd
     gmt end show


参考
-----

:doc:`grdvs30`
