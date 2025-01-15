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

使用计算好的 Vs30 速度模型，针对一次发生在断层上的地震事件（震级为7），
计算地表峰值烈度。其断层迹线坐标保存在 *line.dat* 文件中::

    gmt grdshake vs30.grd -Gshake_intensity.grd -Lline.dat -Ci -M7

计算并绘制发生在红河断裂的一个9级地震，在四川省造成的地表峰值烈度::

     gmt begin grdshake-example
         gmt basemap -R95/105/20/35 -JM15c -Baf
         # global_vs30.grd是USGS计算好的全球Vs30速度模型网格文件
         # 具体可以参考 https://earthquake.usgs.gov/data/vs30/ 自行下载，并获取更多信息
         gmt grdcut global_vs30.grd -R95/105/20/35 -Gvs30.grd
         # 提取红河断裂的数据，保存在line.dat文件中
         gmt convert CN-faults.gmt -S"FN_Ch=红河断裂" -o0,1 > line.dat
         # 计算地表峰值烈度
         gmt grdshake vs30.grd -Gintensity.grd -Lline.dat -Ci -M9
         # 绘制地表峰值烈度
         gmt grd2cpt -Cseis -Gintensity.grd -Z -D
         gmt grdimage intensity.grd -C
         # 绘制省界，断层
         gmt plot CN-border-La.gmt -W0.5p
         gmt plot CN-faults.gmt -W0.1p,gray
         gmt plot line.dat -W0.2p,red

         rm vs30.grd line.dat intensity.grd
     gmt end show


参考
-----

:doc:`grdvs30`
