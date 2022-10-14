.. index:: ! gpsgridder
.. include:: common_SYN_OPTs.rst_

gpsgridder
==========

:贡献者: |周茂|
:最近更新日期: 2022-10-14

----

:官方文档: :doc:`gmt:supplements/geodesy/gpsgridder`
:简介: 使用格林函数内插 GPS 应变以分析弹性形变

**gpsgridder** 使用基于 2—D 弹性的耦合模型来格网化 2—D 向量。

语法
----


**gmt gpsgridder** [ *table* ]
|-G|\ *outgrid*
[ |-C|\ [[**n**\|\ **r**\|\ **v**]\ *value*\ [%]][**+c**][**+f**\ *file*][**+i**][**+n**] ]
[ |-E|\ [*misfitfile*] ]
[ |-F|\ [**d**\|\ **f**]\ *fudge* ]
[ |SYN_OPT-I| ]
[ |-L| ]
[ |-N|\ *nodefile* ]
[ |SYN_OPT-R| ]
[ |-S|\ *nu* ]
[ |-T|\ *maskgrid* ]
[ |SYN_OPT-V| ]
[ |-W|\ [**+s**\|\ **w**] ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------


可选选项
--------

关于 SVD 解
-----------



示例
----

基于文件 :file:`gps.txt` 中的 GPS 数据计算 *u* 和 *v* 方向的应变。*gps.txt*
文件中的数据记录形式为 ``x y u v du dv`` , 计算结果位于加利福尼亚，网格分辨率
为 2 分，计算过程中只使用约 25% 的最大特征值 ::

    gmt gpsgridder gps.txt -R-125/-114/31/41 -I2m -fg -W -r -Cn25% -Ggps_strain_%s.nc -V

废弃用法
--------

- 6.3.0: Use **+n** instead of negative value for |-C| to set dry-run. `#5725 <https://github.com/GenericMappingTools/gmt/pull/5725/>`_

参考
----

Haines, A. J. et al., 2015, *Enhanced Surface Imaging of Crustal Deformation*, SpringerBriefs in Earth Sciences.

Sandwell, D. T. and P. Wessel, 2016, Interpolation of 2-D Vector Data Using Constraints from Elasticity,
*Geophys. Res. Lett., 43*, 10,703-10,709.

相关模块
--------

:doc:`greenspline` 
:doc:`nearneighbor` 
:doc:`surface` 
