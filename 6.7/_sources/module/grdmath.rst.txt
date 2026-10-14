:author: Caesar（自然资源部第一海洋研究所）, 周茂
:date: 2026-01-05

.. index:: ! grdmath
.. program:: grdmath

grdmath
=======

:官方文档: :doc:`gmt:grdmath`
:简介: 网格数据的逆波兰表示法（RPN）计算

**grdmath** 使用逆波兰表示法对网格文件或常量进行逐元素运算，最终结果写入到新的网格文件。
若不给定网格文件，则必须使用 :option:`-R` 与 :option:`-I` 选项生成网格文件。 **= outgrid** 可在计算
中多次使用以保存中间结果。复杂的或频繁使用的运算可赋值给变量或使用宏。

语法
----

**gmt grdmath**
[ :option:`-A`\ *min\_area*\ [/*min\_level*/*max\_level*][**+a**\ [**g**\|\ **i**][**s**\|\ **S**]][**+l**\|\ **r**][**+p**\ *percent*] ]
[ :option:`-D`\ *resolution*\ [**+f**] ]
[ :option:`-I`\ *increment* ]
[ :option:`-M` ] [ :option:`-N` ]
[ :option:`-R`\ *region* ]
[ :option:`-S` ]
[ :option:`-V`\ [*level*] ]
[ :option:`-a`\ *flags* ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-n`\ *flags* ]
[ :option:`-r`\ *reg* ]
[ :option:`-x`\ [[-]n] ]
[ :doc:`--PAR=value </conf/overview>` ]
*operand* [ *operand* ] **OPERATOR** [ *operand* ]
**OPERATOR** ... **=** *outgrid*

输入输出数据
------------------------

*operand*
    如果 *operand* 是一个文件，GMT 将试着以网格文件的形式读取该文件。如果非文件，
    将被解析为 `其他符号`_ 或数字常量。

*= outgrid*
    输出网格文件名

可选选项
--------

.. include:: explain_-A.rst_

.. note::

    该选项仅适用于 **LDISTG** 运算符

.. option:: -D

**-D**\ *resolution*\ [**+f**]
    设置 **LDISTG** 运算符使用的数据集的分辨率:
    (**f**)ull，(**h**)igh，(**i**)ntermediate，(**l**)ow 和 (**c**)rude。
    默认的 **l** 选项将数据集缩减为原本的 20%。如果请求的分辨率不存在，使用 **+f** 选项
    会自动选择一个较低的分辨率。

.. note::

    该选项仅适用于 **LDISTG** 运算符。

.. include:: explain_-I.rst_

.. option:: -M

**-M**
    默认的导数计算单位为 z_units/x(或 y )\_units。使用该选项，可以将 dx 和 dy 的单位从度变为
    平地球近似下的米，因此最终单位变为 z_units/meter

.. option:: -N

**-N**
    操作多个网格时，关闭严格的范围匹配检查 [默认情况下，要求每个网格的范围和第一个网格的范围
    不能超过阈值，该阈值为第一个网格间隔的 10^-4]

.. include:: explain_-R.rst_

.. option:: -S

**-S**
    将下一个运算应用到所有的网格中，使最终结果为一个网格。必须在列出所有网格后才能使用该选项。
    **注** ：仅能在改选项后使用 reduce 运算符，包括
    ADD，AND，MAD，LMSSCL，MAX，MEAN，MEDIAN，MIN，MODE，MUL，RMS，STD，SUB，VAR 或 XOR

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-n.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_core.rst_

.. include:: explain_help.rst_

运算符
------

**Operator** 为运算符名称； **args** 分别表示输入参数和输出参数个数；
**Returns** 中的 A B C ... 等字符表示输入参数。

.. list-table:: 运算符列表
   :widths: 15 10 55 20
   :header-rows: 1
   :class: fixed-width-table

   * - 操作符 (Operator)
     - 参数 (Args)
     - 返回值 (Returns)
     - 函数类型 (Type)
   * - ``ABS``
     - 1 1
     - A 的绝对值
     - 算术运算
   * - ``ACOS``
     - 1 1
     - 反余弦（结果为弧度）
     - 微积分
   * - ``ACOSD``
     - 1 1
     - 反余弦（结果为度）
     - 微积分
   * - ``ACOSH``
     - 1 1
     - 反双曲余弦
     - 微积分
   * - ``ACOT``
     - 1 1
     - 反余切（结果为弧度）
     - 微积分
   * - ``ACOTD``
     - 1 1
     - 反余切（结果为度）
     - 微积分
   * - ``ACSC``
     - 1 1
     - 反余割（结果为弧度）
     - 微积分
   * - ``ACSCD``
     - 1 1
     - 反余割（结果为度）
     - 微积分
   * - ``ADD``
     - 2 1
     - A + B（加法）
     - 算术运算
   * - ``AND``
     - 2 1
     - 如果 A 等于 NaN 则返回 B，否则返回 A
     - 逻辑运算
   * - ``ARC``
     - 2 1
     - 返回 [0, pi] 上的圆弧 (A,B)
     - 算术运算
   * - ``AREA``
     - 0 1
     - 每个网格单元的面积（如果是地理坐标，单位为 km\ :sup:`2`\ ）
     - 特殊操作符
   * - ``ASEC``
     - 1 1
     - 反正割（结果为弧度）
     - 微积分
   * - ``ASECD``
     - 1 1
     - 反正割（结果为度）
     - 微积分
   * - ``ASIN``
     - 1 1
     - 反正弦（结果为弧度）
     - 微积分
   * - ``ASIND``
     - 1 1
     - 反正弦（结果为度）
     - 微积分
   * - ``ASINH``
     - 1 1
     - 反双曲正弦
     - 微积分
   * - ``ATAN``
     - 1 1
     - 反正切（结果为弧度）
     - 微积分
   * - ``ATAND``
     - 1 1
     - 反正切（结果为度）
     - 微积分
   * - ``ATAN2``
     - 2 1
     - A/B 的反正切（结果为弧度）
     - 微积分
   * - ``ATAN2D``
     - 2 1
     - A/B 的反正切（结果为度）
     - 微积分
   * - ``ATANH``
     - 1 1
     - 反双曲正切
     - 微积分
   * - ``BCDF``
     - 3 1
     - 二项分布累积分布函数 (p = A, n = B, x = C)
     - 概率统计
   * - ``BPDF``
     - 3 1
     - 二项分布概率密度函数 (p = A, n = B, x = C)
     - 概率统计
   * - ``BEI``
     - 1 1
     - 开尔文函数 bei (A)
     - 特殊函数
   * - ``BER``
     - 1 1
     - 开尔文函数 ber (A)
     - 特殊函数
   * - ``BITAND``
     - 2 1
     - A & B (按位与运算)
     - 逻辑运算
   * - ``BITLEFT``
     - 2 1
     - A << B (按位左移)
     - 算术运算
   * - ``BITNOT``
     - 1 1
     - ~A (按位非运算，即返回补码)
     - 逻辑运算
   * - ``BITOR``
     - 2 1
     - A | B (按位或运算)
     - 逻辑运算
   * - ``BITRIGHT``
     - 2 1
     - A >> B (按位右移)
     - 算术运算
   * - ``BITTEST``
     - 2 1
     - 如果 A 的第 B 位被设置则返回 1，否则为 0 (按位测试)
     - 逻辑运算
   * - ``BITXOR``
     - 2 1
     - A ^ B (按位异或运算)
     - 逻辑运算
   * - ``BLEND``
     - 3 1
     - 使用权重 C (0-1 范围) 混合 A 和 B，计算方式为 A*C + B*(1-C)
     - 特殊操作符
   * - ``CAZ``
     - 2 1
     - 从网格节点到栈中 (*x, y*)（即 A, B）的笛卡尔方位角
     - 特殊操作符
   * - ``CBAZ``
     - 2 1
     - 从网格节点到栈中 (*x, y*)（即 A, B）的笛卡尔反方位角
     - 特殊操作符
   * - ``CDIST``
     - 2 1
     - 网格节点与栈中 (*x, y*)（即 A, B）之间的笛卡尔距离
     - 特殊操作符
   * - ``CDIST2``
     - 2 1
     - 同 CDIST，但仅计算到非零节点的距离
     - 特殊操作符
   * - ``CEIL``
     - 1 1
     - ceil (A) (大于或等于 A 的最小整数)
     - 逻辑运算
   * - ``CHICRIT``
     - 2 1
     - 卡方分布临界值 (alpha = A, nu = B)
     - 概率统计
   * - ``CHICDF``
     - 2 1
     - 卡方累积分布函数 (chi2 = A, nu = B)
     - 概率统计
   * - ``CHIPDF``
     - 2 1
     - 卡方概率密度函数 (chi2 = A, nu = B)
     - 概率统计
   * - ``COMB``
     - 2 1
     - 组合数 nCr (n = A, r = B)
     - 概率统计
   * - ``CORRCOEFF``
     - 2 1
     - 相关系数 r(A, B)
     - 概率统计
   * - ``COS``
     - 1 1
     - A 的余弦（A 为弧度）
     - 微积分
   * - ``COSD``
     - 1 1
     - A 的余弦（A 为度）
     - 微积分
   * - ``COSH``
     - 1 1
     - A 的双曲余弦
     - 微积分
   * - ``COT``
     - 1 1
     - A 的余切（A 为弧度）
     - 微积分
   * - ``COTD``
     - 1 1
     - A 的余切（A 为度）
     - 微积分
   * - ``CSC``
     - 1 1
     - A 的余割（A 为弧度）
     - 微积分
   * - ``CSCD``
     - 1 1
     - A 的余割（A 为度）
     - 微积分
   * - ``CUMSUM``
     - 2 1
     - 每一行 (B=±1|3) 或每一列 (B=±2|4) 的累加和。B 的符号决定求和方向
     - 算术运算
   * - ``CURV``
     - 1 1
     - A 的曲率（拉普拉斯算子 :math:`\nabla^2`）
     - 微积分
   * - ``D2DX2``
     - 1 1
     - d\ :sup:`2`\ (A)/dx\ :sup:`2` 二阶导数
     - 微积分
   * - ``D2DY2``
     - 1 1
     - d\ :sup:`2`\ (A)/dy\ :sup:`2` 二阶导数
     - 微积分
   * - ``D2DXY``
     - 1 1
     - d\ :sup:`2`\ (A)/dxdy 二阶偏导数
     - 微积分
   * - ``D2R``
     - 1 1
     - 度转换为弧度
     - 特殊操作符
   * - ``DDX``
     - 1 1
     - d(A)/dx 中央一阶导数
     - 微积分
   * - ``DAYNIGHT``
     - 3 1
     - 太阳在 (A, B) 照射处为 1，其余为 0，C 为过渡宽度
     - 特殊操作符
   * - ``DDY``
     - 1 1
     - d(A)/dy 中央一阶导数
     - 微积分
   * - ``DEG2KM``
     - 1 1
     - 球面度转换为公里
     - 特殊操作符
   * - ``DENAN``
     - 2 1
     - 用 B 中的值替换 A 中的 NaN
     - 逻辑运算
   * - ``DILOG``
     - 1 1
     - 双对数 (Spence's) 函数
     - 特殊函数
   * - ``DIV``
     - 2 1
     - A / B (除法)
     - 算术运算
   * - ``DOT``
     - 2 1
     - 节点与栈中单位向量 (A, B) 之间的二维(笛卡尔)或三维(地理)点积
     - 特殊操作符
   * - ``DUP``
     - 1 2
     - 在栈中复制一份 A
     - 特殊操作符
   * - ``ECDF``
     - 2 1
     - 指数累积分布函数 (x = A, lambda = B)
     - 概率统计
   * - ``ECRIT``
     - 2 1
     - 指数分布临界值 (alpha = A, lambda = B)
     - 概率统计
   * - ``EPDF``
     - 2 1
     - 指数概率密度函数 (x = A, lambda = B)
     - 概率统计
   * - ``ERF``
     - 1 1
     - 误差函数 erf (A)
     - 概率统计
   * - ``ERFC``
     - 1 1
     - 互补误差函数 erfc (A)
     - 概率统计
   * - ``EQ``
     - 2 1
     - 如果 A 等于 B 则返回 1，否则为 0
     - 逻辑运算
   * - ``ERFINV``
     - 1 1
     - A 的反误差函数
     - 概率统计
   * - ``EXCH``
     - 2 2
     - 交换栈中的 A 和 B
     - 特殊操作符
   * - ``EXP``
     - 1 1
     - e 的次幂
     - 算术运算
   * - ``FACT``
     - 1 1
     - A! (A 的阶乘)
     - 算术运算
   * - ``EXTREMA``
     - 1 1
     - 局部极值：-1 为极小值，+1 为极大值，其余为 0
     - 微积分
   * - ``FCDF``
     - 3 1
     - F 累积分布函数 (F = A, nu1 = B, nu2 = C)
     - 概率统计
   * - ``FCRIT``
     - 3 1
     - F 分布临界值 (alpha = A, nu1 = B, nu2 = C)
     - 概率统计
   * - ``FISHER``
     - 3 1
     - 位于中心经度 A、纬度 B，且浓度参数为 C 的 Fisher 概率密度函数
     - 概率统计
   * - ``FLIPLR``
     - 1 1
     - 反转每一行中的值顺序
     - 特殊操作符
   * - ``FLIPUD``
     - 1 1
     - 反转每一列的顺序
     - 特殊操作符
   * - ``FLOOR``
     - 1 1
     - 小于或等于 A 的最大整数
     - 逻辑运算
   * - ``FMOD``
     - 2 1
     - A % B (截断除法的余数)
     - 算术运算
   * - ``FPDF``
     - 3 1
     - F 概率密度函数 (F = A, nu1 = B, nu2 = C)
     - 概率统计
   * - ``GE``
     - 2 1
     - 如果 A >= B 则返回 1，否则为 0
     - 逻辑运算
   * - ``GT``
     - 2 1
     - 如果 A > B 则返回 1，否则为 0
     - 逻辑运算
   * - ``HSV2LAB``
     - 3 3
     - 将 *h,s,v* 转换为 *l,a,b* (h=A[0-360], s=B, v=C[0-1])
     - 特殊操作符
   * - ``HSV2RGB``
     - 3 3
     - 将 *h,s,v* 转换为 *r,g,b* (h=A[0-360], s=B, v=C[0-1])
     - 特殊操作符
   * - ``HSV2XYZ``
     - 3 3
     - 将 *h,s,v* 转换为 *x,t,z* (h=A[0-360], s=B, v=C[0-1])
     - 特殊操作符
   * - ``HYPOT``
     - 2 1
     - 直角三角形的斜边长度 (= sqrt (A\ :sup:`2`\ + B\ :sup:`2`\ ))
     - 微积分
   * - ``I0``
     - 1 1
     - A 的修正贝塞尔函数 (第一类, 0阶)
     - 特殊函数
   * - ``I1``
     - 1 1
     - A 的修正贝塞尔函数 (第一类, 1阶)
     - 特殊函数
   * - ``IFELSE``
     - 3 1
     - 如果 A 不等于 0 则返回 B，否则返回 C
     - 逻辑运算
   * - ``IN``
     - 2 1
     - A 的修正贝塞尔函数 (第一类, B阶)
     - 特殊函数
   * - ``INRANGE``
     - 3 1
     - 如果 B <= A <= C 则返回 1，否则为 0
     - 逻辑运算
   * - ``INSIDE``
     - 1 1
     - 当位于 A 中的多边形内或其边界上时返回 1，否则为 0
     - 特殊操作符
   * - ``INV``
     - 1 1
     - A 的反误差函数
     - 概率统计
   * - ``ISFINITE``
     - 1 1
     - 如果 A 是有限值则返回 1，否则为 0
     - 逻辑运算
   * - ``ISNAN``
     - 1 1
     - 如果 A 等于 NaN 则返回 1，否则为 0
     - 逻辑运算
   * - ``J0``
     - 1 1
     - A 的贝塞尔函数 (第一类, 0阶)
     - 特殊函数
   * - ``J1``
     - 1 1
     - A 的贝塞尔函数 (第一类, 1阶)
     - 特殊函数
   * - ``JN``
     - 2 1
     - A 的贝塞尔函数 (第一类, B阶)
     - 特殊函数
   * - ``K0``
     - 1 1
     - A 的修正开尔文函数 (第二类, 0阶)
     - 特殊函数
   * - ``K1``
     - 1 1
     - A 的修正贝塞尔函数 (第二类, 1阶)
     - 特殊函数
   * - ``KEI``
     - 1 1
     - 开尔文函数 kei (A)
     - 特殊函数
   * - ``KER``
     - 1 1
     - 开尔文函数 ker (A)
     - 特殊函数
   * - ``KM2DEG``
     - 1 1
     - 公里转换为球面度
     - 特殊操作符
   * - ``KN``
     - 2 1
     - A 的修正贝塞尔函数 (第二类, B阶)
     - 特殊函数
   * - ``KURT``
     - 1 1
     - A 的峰度
     - 概率统计
   * - ``LAB2HSV``
     - 3 3
     - 将 *l,a,b* 三元组转换为 *h,s,v* 三元组
     - 特殊操作符
   * - ``LAB2RGB``
     - 3 3
     - 将 *l,a,b* 三元组转换为 *r,g,b* 三元组
     - 特殊操作符
   * - ``LAB2XYZ``
     - 3 3
     - 将 *l,a,b* 三元组转换为 *x,y,z* 三元组
     - 特殊操作符
   * - ``LCDF``
     - 1 1
     - 拉普拉斯累积分布函数 (z = A)
     - 概率统计
   * - ``LCRIT``
     - 1 1
     - 拉普拉斯分布临界值 (alpha = A)
     - 概率统计
   * - ``LDIST``
     - 1 1
     - 计算到多段 ASCII 文件 A 中各条线的最小距离（如果使用 -fg 则单位为 km）
     - 特殊操作符
   * - ``LDIST2``
     - 2 1
     - 同 LDIST，计算到文件 B 中各线的距离，但仅针对 A 非零的节点
     - 特殊操作符
   * - ``LDISTG``
     - 0 1
     - 同 LDIST，但操作对象为 GSHHG 数据集（参见 -A, -D 选项）
     - 特殊操作符
   * - ``LE``
     - 2 1
     - 如果 A <= B 则返回 1，否则为 0
     - 逻辑运算
   * - ``LOG``
     - 1 1
     - 双对数 (Spence's) 函数
     - 特殊函数
   * - ``LOG10``
     - 1 1
     - :math:`\log_{10}` (A) (以 10 为底的对数)
     - 算术运算
   * - ``LOG1P``
     - 1 1
     - log (1+A) (自然对数，对极小值 A 更精确)
     - 算术运算
   * - ``LOG2``
     - 1 1
     - :math:`\log_2` (A) (以 2 为底的对数)
     - 算术运算
   * - ``LMSSCL``
     - 1 1
     - A 的 LMS (最小中位数平方) 尺度估计 (LMS STD)
     - 概率统计
   * - ``LMSSCLW``
     - 2 1
     - A 基于权重 B 的加权 LMS 尺度估计 (LMS STD)
     - 概率统计
   * - ``LOWER``
     - 1 1
     - A 的最低值 (最小值)
     - 算术运算
   * - ``LPDF``
     - 1 1
     - 拉普拉斯概率密度函数 (z = A)
     - 概率统计
   * - ``LRAND``
     - 2 1
     - 均值为 A，标准差为 B 的拉普拉斯随机噪声
     - 概率统计
   * - ``LT``
     - 2 1
     - 如果 A < B 则返回 1，否则为 0
     - 逻辑运算
   * - ``MAD``
     - 1 1
     - A 的中位数绝对偏差 (L1 STD)
     - 概率统计
   * - ``MAX``
     - 2 1
     - A 和 B 的最大值
     - 概率统计
   * - ``MEAN``
     - 1 1
     - A 的平均值
     - 概率统计
   * - ``MEANW``
     - 2 1
     - A 基于权重 B 的加权平均值
     - 概率统计
   * - ``MEDIAN``
     - 1 1
     - A 的中位数
     - 概率统计
   * - ``MEDIANW``
     - 2 1
     - A 基于权重 B 的加权中位数
     - 概率统计
   * - ``MIN``
     - 2 1
     - A 和 B 的最小值
     - 概率统计
   * - ``MOD``
     - 2 1
     - A % B (向下取整除法的余数)
     - 算术运算
   * - ``MODE``
     - 1 1
     - A 的众数 (最小中位数平方估计)
     - 概率统计
   * - ``MODEW``
     - 2 1
     - A 基于权重 B 的加权众数 (最小中位数平方估计)
     - 概率统计
   * - ``MUL``
     - 2 1
     - A x B (乘法)
     - 算术运算
   * - ``NAN``
     - 2 1
     - 如果 A 等于 B 则返回 NaN，否则返回 A
     - 逻辑运算
   * - ``NEG``
     - 1 1
     - 负值 (-A)
     - 算术运算
   * - ``NEQ``
     - 2 1
     - 如果 A 不等于 B 则返回 1，否则为 0
     - 逻辑运算
   * - ``NORM``
     - 1 1
     - 归一化 (A) 使得 min(A) = 0 且 max(A) = 1
     - 概率统计
   * - ``NOT``
     - 1 1
     - ~A (按位非运算，即返回补码)
     - 逻辑运算
   * - ``NRAND``
     - 2 1
     - 均值为 A，标准差为 B 的正态分布随机值
     - 概率统计
   * - ``OR``
     - 2 1
     - 如果 B 等于 NaN 则返回 NaN，否则返回 A
     - 逻辑运算
   * - ``PCDF``
     - 2 1
     - 泊松累积分布函数 (x = A, lambda = B)
     - 概率统计
   * - ``PDIST``
     - 1 1
     - 计算到 ASCII 文件 A 中各点的最小距离（如果使用 -fg 则单位为 km）
     - 特殊操作符
   * - ``PDIST2``
     - 2 1
     - 同 PDIST，计算到文件 B 中各点的距离，但仅针对 A 非零的节点
     - 特殊操作符
   * - ``PERM``
     - 2 1
     - 排列数 nPr (n = A, r = B)
     - 概率统计
   * - ``PLM``
     - 3 1
     - 伴随勒让德多项式 P(A)，次数为 B，阶数为 C
     - 特殊函数
   * - ``PLMg``
     - 3 1
     - 归一化伴随勒让德多项式 P(A)，次数为 B，阶数为 C (地球物理规范)
     - 特殊函数
   * - ``POINT``
     - 1 2
     - 从 ASCII 文件 A 中计算平均 x 和 y 并压入栈中
     - 特殊操作符
   * - ``POP``
     - 1 0
     - 从栈中删除顶端元素
     - 特殊操作符
   * - ``POW``
     - 2 1
     - A 的 B 次幂
     - 算术运算
   * - ``PPDF``
     - 2 1
     - 泊松分布 P(x, lambda) (x = A, lambda = B)
     - 概率统计
   * - ``PQUANT``
     - 2 1
     - A 的第 B 个分位数 (0-100%)
     - 概率统计
   * - ``PQUANTW``
     - 3 1
     - A 基于权重 B 的第 C 个加权分位数 (0-100%)
     - 概率统计
   * - ``PSI``
     - 1 1
     - A 的 Psi (或 Digamma) 函数
     - 特殊函数
   * - ``PV``
     - 3 1
     - 勒让德函数 Pv(A)，次数为 v = real(B) + imag(C)
     - 特殊函数
   * - ``QV``
     - 3 1
     - 勒让德函数 Qv(A)，次数为 v = real(B) + imag(C)
     - 特殊函数
   * - ``R2``
     - 2 1
     - 斜边的平方 (= A\ :sup:`2`\ + B\ :sup:`2`\ )
     - 微积分
   * - ``R2D``
     - 1 1
     - 弧度转换为度
     - 特殊操作符
   * - ``RAND``
     - 2 1
     - 均值为 A，标准差为 B 的拉普拉斯随机噪声
     - 概率统计
   * - ``RCDF``
     - 1 1
     - 瑞利累积分布函数 (z = A)
     - 概率统计
   * - ``RCRIT``
     - 1 1
     - 瑞利分布临界值 (alpha = A)
     - 概率统计
   * - ``RGB2HSV``
     - 3 3
     - 将 *r,g,b* 转换为 *h,s,v* (r,g,b 范围为 0-255)
     - 特殊操作符
   * - ``RGB2LAB``
     - 3 3
     - 将 *r,g,b* 转换为 *l,a,b* (r,g,b 范围为 0-255)
     - 特殊操作符
   * - ``RGB2XYZ``
     - 3 3
     - 将 *r,g,b* 转换为 *x,y,z* (r,g,b 范围为 0-255)
     - 特殊操作符
   * - ``RINT``
     - 1 1
     - rint (A) (舍入到最接近 A 的整数)
     - 算术运算
   * - ``RMS``
     - 1 1
     - A 的均方根 (Root-mean-square)
     - 算术运算
   * - ``RMSW``
     - 1 1
     - A 基于权重 B 的加权均方根
     - 算术运算
   * - ``RPDF``
     - 1 1
     - 瑞利概率密度函数 (z = A)
     - 概率统计
   * - ``ROLL``
     - 2 0
     - 将栈顶 A 个元素循环平移 B 个位置
     - 特殊操作符
   * - ``ROTX``
     - 2 1
     - 将 A 在 x 方向上按常数 B 进行旋转平移
     - 算术运算
   * - ``ROTY``
     - 2 1
     - 将 A 在 y 方向上按常数 B 进行旋转平移
     - 算术运算
   * - ``SADDLE``
     - 1 1
     - 鞍点 (±)：x 方向为局部极小值(-1)或极大值(+1)，其余为 0
     - 微积分
   * - ``SDIST``
     - 2 1
     - 计算网格节点与栈中 (*lon, lat*) (即 A, B) 之间的球面(大圆/测地线)距离（单位为 km）
     - 特殊操作符
   * - ``SDIST2``
     - 2 1
     - 同 SDIST，但仅计算到非零节点的距离
     - 特殊操作符
   * - ``SAZ``
     - 2 1
     - 从网格节点到栈中 (*lon, lat*) (即 A, B) 的球面方位角
     - 特殊操作符
   * - ``SBAZ``
     - 2 1
     - 从网格节点到栈中 (*lon, lat*) (即 A, B) 的球面反方位角
     - 特殊操作符
   * - ``SEC``
     - 1 1
     - 反正割（结果为弧度）
     - 微积分
   * - ``SECD``
     - 1 1
     - 反正割（结果为度）
     - 微积分
   * - ``SIGN``
     - 1 1
     - A 的符号 (+1 或 -1)
     - 逻辑运算
   * - ``SIN``
     - 1 1
     - A 的正弦（A 为弧度）
     - 微积分
   * - ``SINC``
     - 1 1
     - 归一化 Sinc 函数
     - 特殊函数
   * - ``SIND``
     - 1 1
     - A 的正弦（A 为度）
     - 微积分
   * - ``SINH``
     - 1 1
     - A 的双曲正弦
     - 微积分
   * - ``SKEW``
     - 1 1
     - A 的偏度
     - 概率统计
   * - ``SQR``
     - 1 1
     - 平方 (2次幂)
     - 算术运算
   * - ``SQRT``
     - 1 1
     - 平方根
     - 算术运算
   * - ``STD``
     - 1 1
     - A 的标准差
     - 概率统计
   * - ``STDW``
     - 2 1
     - A 基于权重 B 的加权标准差
     - 概率统计
   * - ``STEP``
     - 1 1
     - 赫维赛德阶跃函数 H(A)
     - 特殊函数
   * - ``STEPX``
     - 1 1
     - x 方向的赫维赛德阶跃函数: H(x-A)
     - 特殊函数
   * - ``STEPY``
     - 1 1
     - y 方向的赫维赛德阶跃函数: H(y-A)
     - 特殊函数
   * - ``SUB``
     - 2 1
     - A - B (减法)
     - 算术运算
   * - ``SUM``
     - 1 1
     - A 的累加和 (Cumulative sum)
     - 算术运算
   * - ``TAN``
     - 1 1
     - A 的正切（A 为弧度）
     - 微积分
   * - ``TAND``
     - 1 1
     - A 的正切（A 为度）
     - 微积分
   * - ``TANH``
     - 1 1
     - A 的双曲正切
     - 微积分
   * - ``TAPER``
     - 2 1
     - 在末端 A 范围内余弦渐变到 0 的单位权重
     - 特殊操作符
   * - ``TCDF``
     - 2 1
     - 学生 t 累积分布函数 (t = A, nu = B)
     - 概率统计
   * - ``TCRIT``
     - 2 1
     - 学生 t 分布临界值 (alpha = A, nu = B)
     - 概率统计
   * - ``TN``
     - 2 1
     - ~A (按位非运算，即返回补码)
     - 逻辑运算
   * - ``TPDF``
     - 2 1
     - 学生 t 概率密度函数 (t = A, nu = B)
     - 概率统计
   * - ``TRIM``
     - 3 1
     - Alpha 截断：如果 C 的值落在 A 和 B (百分比) 指定的尾部，则设为 NaN
     - 特殊操作符
   * - ``UPPER``
     - 1 1
     - A 的最高值 (最大值)
     - 算术运算
   * - ``VAR``
     - 1 1
     - A 的方差
     - 概率统计
   * - ``VARW``
     - 2 1
     - A 基于权重 B 的加权方差
     - 概率统计
   * - ``VPDF``
     - 3 1
     - Von Mises 密度分布 V(x,mu,kappa) (角度=A, mu=B, kappa=C)
     - 概率统计
   * - ``WCDF``
     - 3 1
     - 威布尔累积分布函数 (x=A, scale=B, shape=C)
     - 概率统计
   * - ``WCRIT``
     - 3 1
     - 威布尔分布临界值 (alpha=A, scale=B, shape=C)
     - 概率统计
   * - ``WPDF``
     - 3 1
     - 威布尔密度分布 P(x,scale,shape) (x=A, scale=B, shape=C)
     - 概率统计
   * - ``WRAP``
     - 1 1
     - 将弧度 A 转换到 [-pi, pi] 范围内
     - 特殊操作符
   * - ``XOR``
     - 2 1
     - A ^ B (按位异或运算)
     - 逻辑运算
   * - ``XYZ2HSV``
     - 3 3
     - 将 *x,y,z* 三元组转换为 *h,s,v* 三元组
     - 特殊操作符
   * - ``XYZ2LAB``
     - 3 3
     - 将 *x,y,z* 三元组转换为 *l,a,b* 三元组
     - 特殊操作符
   * - ``XYZ2RGB``
     - 3 3
     - 将 *x,y,z* 三元组转换为 *r,g,b* 三元组
     - 特殊操作符
   * - ``Y0``
     - 1 1
     - A 的贝塞尔函数 (第二类, 0阶)
     - 特殊函数
   * - ``Y1``
     - 1 1
     - A 的贝塞尔函数 (第二类, 1阶)
     - 特殊函数
   * - ``YLM``
     - 2 2
     - 次数为 A、阶数为 B 的实部和虚部正交归一化球谐函数
     - 特殊函数
   * - ``YLMg``
     - 2 2
     - 次数为 A、阶数为 B 的余弦和正弦归一化球谐函数（地球物理规范）
     - 特殊函数
   * - ``YN``
     - 2 1
     - A 的贝塞尔函数 (第二类, B阶)
     - 特殊函数
   * - ``ZCDF``
     - 1 1
     - 正态累积分布函数 (z = A)
     - 概率统计
   * - ``ZCRIT``
     - 1 1
     - 正态分布临界值 (alpha = A)
     - 概率统计
   * - ``ZPDF``
     - 1 1
     - 正态概率密度函数 (z = A)
     - 概率统计

其他符号
--------

以下符号都具有特殊意义：

.. list-table:: 数学常量与网格变量
   :widths: 20 80
   :header-rows: 1

   * - 标识符
     - 描述 / 数值
   * - ``PI``
     - 圆周率 (3.1415926...)
   * - ``E``
     - 自然常数 (2.7182818...)
   * - ``EULER``
     - 欧拉常数 (0.5772156...)
   * - ``PHI``
     - 黄金分割率 (1.6180339...)
   * - ``EPS_F``
     - 单精度浮点数机器精度 (1.192092896e-07)
   * - ``XMIN``
     - *x* 值的最小值
   * - ``XMAX``
     - *x* 值的最大值
   * - ``XRANGE``
     - *x* 值的范围
   * - ``XINC``
     - *x* 的增量
   * - ``NX``
     - *x* 方向的节点数
   * - ``YMIN``
     - *y* 值的最小值
   * - ``YMAX``
     - *y* 值的最大值
   * - ``YRANGE``
     - *y* 值的范围
   * - ``YINC``
     - *y* 的增量
   * - ``NY``
     - *y* 方向的节点数
   * - ``X``
     - 包含 *x* 坐标的网格
   * - ``Y``
     - 包含 *y* 坐标的网格
   * - ``XNORM``
     - 包含归一化 [-1 到 +1] *x* 坐标的网格
   * - ``YNORM``
     - 包含归一化 [-1 到 +1] *y* 坐标的网格
   * - ``XCOL``
     - 包含列号 (0, 1, ..., NX-1) 的网格
   * - ``YROW``
     - 包含行号 (0, 1, ..., NY-1) 的网格
   * - ``NODE``
     - 包含节点号 (0, 1, ..., (NX*NY)-1) 的网格
   * - ``NODEP``
     - 包含补边 (pad) 时的节点号网格

上述符号均可以作为变量使用，当其为多个数时，逐元素操作。

运算符注意事项
--------------

#. 对于笛卡尔坐标，运算符 **MEAN**，**MEDIAN**，**MODE**，**LMSSCL**，**MAD**，
   **PQUANT**，**RMS**，**STD** 和 **VAR** 将返回基于给定网格的值。对于地理
   坐标，GMT 将施行球面加权运算，其中每个节点的值都由该点代表的地理区域加权得到。

#. **SDIST** 计算堆栈上的点 (lon,lat) 与所有网格点的球面距离，单位为 km。网格范围
   和点的坐标单位均为度。类似地，**SAZ** 和 **SBAZ** 分别用来球面方位角以及球面
   反方位角，单位也为度。如果设置了 **-fg** 或隐含该选项，**LDIST** 和 **PDIST**
   以 km 为单位计算球面距离，否则返回笛卡尔距离。**注** : 如果 :term:`PROJ_ELLIPSOID`
   为椭球，则计算结果为大地线（测地线）的长度。这可能导致计算比较慢，但可以通过
   :term:`PROJ_GEODESIC` 中设置使用其他算法以平衡精度和效率。

   **LDISTG** 和 **LDIST** 作用类似，但是 **LDISTG** 使用 GSHHG 数据运算。其中
   GSHHG 数据来自 :option:`-D` 和 :option:`-A` 选项。

#. **POINT** 读取一个 ASCII 文件，计算 x 和 y 的平均值并放在堆栈中。如果输入数据
   为地理坐标，使用平均 3D 向量来确定平均位置。

#. **PLM** 和 **PLMg** 运算符用来计算 L 阶 M 次的缔合勒让德函数；M 参数
   的范围应该满足 0 <= M <= L，参数为纬度的正弦值。 **PLM** 运算符没有经过标准化，
   并且乘以 phase (-1)^M。 **PLMg** 使用大地测量/地球物理常见的标准化。使用
   *-M* 参数可以附加球谐系数 C 和 S。 **PLM** 在较高的阶次就会出现溢出，具
   体和纬度相关， **PLMg** 则可以保证在 3000 阶以下都不会溢

#. **YLM** 和 **YLGM** 用于计算网格所有位置的 L 阶 M 次标准化后的球谐函数，
   0 <= M <= L。结果返回两个网格，一个为球谐函数的实部网格，一个为虚部网格。使用
   **POP** 可保存其中的任意一个，也可以使用两个连续的 *= file.nc* 同时保存。

   正交归一化的复数谐函数主要用于物理学和地震学，**YLM** 的平方在球面上的积分为
   1。在大地测量学中，**YLMG** 积分后的结果为 4pi。相位 (-1)^M 不包含在 **YLM**
   和 **YLMg** 中。

#. 所有导数都基于 central finite differences 和 natural boundary conditionsi，
   并且为笛卡尔坐标下的导数

#. 不同参数文件名相同时，应给定相对路径或绝对路径以区分不同文件

#. 不允许使用管道

#. 该模块计算过程保存在堆栈中，栈中保存结果最大为 100，即不能叠加太多的操作
   以防溢出

#. 所有需要半径的运算符为保证其为正值，均自动取了绝对值后计算

#. 当使用 OpenMP 后，某些运算符将使用该能力。目前包括 **LDIST**，**LDIST2**，
   **PDIST**，**PDIST2**，**SAZ**，**SBAZ**，**SDIST**，**YLM**，和 **grd_YLMg**

#. **DEG2KM** 和 **KM2DEG** 只有当设置 :term:`PROJ_ELLIPSOID` 为球形时才准确

#. **DOT** 在点积计算之前对二维向量进行归一化，对于三维向量，则不需要。

#. 颜色转换函数，例如 **RGB2HSV** 等，不仅包括 rgb 到 hsv 等三元数的转换，
   还包括 lab 到 sRGB 等四元数的转换

#. **DAYNIGHT** 返回一个网格，在给定太阳位置为 (A,B) 时，面向太阳的网格点为 1，
   其他为 0，如果过渡宽度 C 为 0，则结果为 0 和 1 两种，如果 C 不为 0，则使用
   atan 函数近似求解，因此值不为 0 或 1。

#. **VPDF** 运算符的输入数据单位为角

#. **CUMSUM** 运算符通常在行或者列结束时重置累计的值，使用 ±3 或 ±4 可以使累积
   的值在下一行或者列继续

#. 位运算符 **BITAND**，**BITLEFT**，**BITNOT**，**BITOR**，**BITRIGHT**，
   **BITTEST** 和 **BITXOR** 会将网格数据中的单精度数转换为无符号的 32 位整数，
   然后按位运算。因此，可储存在双精度数中的最大整数为 2^24 ，更大的数都会被
   截断。如果被比较的数中包括 NaN ，则最终结果也为 NaN

.. include:: explain_float.rst_

储存、调用和清除
----------------

用户可以将中间计算结果储存到一个变量中，并在后续计算中调用该变量。这在需要
对某部分进行多次重复计算时可以提高效率和可读性。保存结果需要使用特殊的运算符
**STO**\ @\ *label* ， 其中 *label* 是变量的名称。调用该变量时，使用
[**RCL**]@\ *label* ， **RCL** 是可选的。使用后要清除该变量，可以使用
**CLR**\ @\ *label* ， **STO** 和 **CLR** 均不影响计算中的堆栈。

.. include:: explain_gshhg.rst_

.. include:: explain_inside.rst_

宏
--

用户可以将特定的运算符组合保存为宏文件 *gmtmath.macros* 。文件中可以包含任意
数量的宏， # 开头的行为注释。宏的格式为 ::

    name = arg1 arg2 ... arg2[ : comment]

其中，*name* 是宏名，当此运算符出现在命令中时，则将其简单替换为参数列表。宏
不可以互相调用。下面给出一个宏例子：**INCIRCLE** 宏需要三个参数：半径，x0 和 y0，
并将在圆内的点设置为 1，外部设置为 0 ::

    INCIRCLE = CDIST EXCH DIV 1 LE : usage: r x y INCIRCLE to return 1 inside circl

由于在宏中可能使用地理或时间常数，因此可使用 ``:`` 后加一个空格的形式作为注释的开端。

示例
----

计算网格点到北极的距离 ::

    gmt grdmath -Rg -I1 0 90 SDIST = dist_to_NP.nc

求两个文件的均值以及结果的 log10 函数值 ::

    gmt grdmath file1.nc file2.nc ADD 0.5 MUL LOG10 = file3.nc

给定含有海底地形年代（单位 m.y.）和深度（单位 m）网格文件 :file:`agrs.nc` ，使用
公式 depth(单位为 m) = 2500 + 350 \* sqrt (age) 估计正常深度 ::

    gmt grdmath ages.nc SQRT 350 MUL 2500 ADD = depths.nc

从 :file:`s_xx.nc`，:file:`s_yy.nc` 和 :file:`s_xy.nc` 三个文件包含的应力张量中，根据
tan (2\*a) = 2 \* s_xy / (s_xx - s_yy) 求出最大主应力的角度，单位为度 ::

    gmt grdmath 2 s_xy.nc MUL s_xx.nc s_yy.nc SUB DIV ATAN 2 DIV = direction.nc

计算 1 度分辨率的网格上完全正则化的 8 阶 4 次球谐函数，实数和虚数的振幅分别为
0.4 和 1.1 ::

    gmt grdmath -R0/360/-90/90 -I1 8 4 YLM 1.1 MUL EXCH 0.4 MUL ADD = harm.nc

提取文件:file:`faa.nc` 中超过 100 mgal 的局部最大值的位置 ::

    gmt grdmath faa.nc DUP EXTREMA 2 EQ MUL DUP 100 GT MUL 0 NAN = z.nc
    gmt grd2xyz z.nc -s > max.xyz

变量的使用: consider this radial wave where we store and recall the normalized
radial arguments in radians ::

    gmt grdmath -R0/10/0/10 -I0.25 5 5 CDIST 2 MUL PI MUL 5 DIV STO@r COS @r SIN MUL = wave.nc

创建一个保存 32 位浮点型 GeoTiff 文件 ::

    gmt grdmath -Rd -I10 X Y MUL = lixo.tiff=gd:GTiff

计算地理网格 :file:`data.grd` 中网格点到 :file:`trace.txt` 的距离，单位为 km ::

    gmt grdmath -Rdata.grd trace.txt LDIST = dist_from_line.grd

**-S** 选项的使用：计算所有以 model_*.grd 为名的网格对应节点的标准差 ::

    gmt grdmath model_*.grd -S STD = std_of_models.grd

创建 0.5 度分辨率的 geotiff 网格文件，网格值为离海岸线的距离，单位为 km ::

    gmt grdmath -RNO,IS -Dc -I.5 LDISTG = distance.tif=gd:GTIFF

参考文献
--------

Abramowitz, M., and I. A. Stegun, 1964, *Handbook of Mathematical
Functions*, Applied Mathematics Series, vol. 55, Dover, New York.

Holmes, S. A., and W. E. Featherstone, 2002, A unified approach to the
Clenshaw summation and the recursive computation of very high degree and
order normalized associated Legendre functions. *Journal of Geodesy*,
76, 279-299.

Press, W. H., S. A. Teukolsky, W. T. Vetterling, and B. P. Flannery,
1992, *Numerical Recipes*, 2nd edition, Cambridge Univ., New York.

Spanier, J., and K. B. Oldman, 1987, *An Atlas of Functions*, Hemisphere
Publishing Corp.

相关模块
--------

:doc:`math`,
:doc:`grd2xyz`,
:doc:`grdedit`,
:doc:`grdinfo`,
:doc:`xyz2grd`
