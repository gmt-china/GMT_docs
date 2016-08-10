
GMT的Matlab接口
===============

简介
----

GMT的Matlab接口，顾名思义，提供了在Matlab中调用GMT命令的功能。通过该接口，GMT的所有模块命令都可以在Matlab脚本中嵌入执行。GMT命令生成的结果（grid格网数据、table表格数据、CPT颜色表、文本文件、图片等）都可以作为Matlab变量进行运算；Matlab中的矩阵变量也可以直接作为GMT的输入，执行GMT的命令。

安装
----

Windows平台
+++++++++++

GMT5.2用户在GMT执行路径（默认为 ``C:\programs\gmt5\bin`` ）下，已经存在 ``gmt.m`` 和 ``gmtmex.mexw64`` 两个文件，只要确保：

- GMT的执行路径已经加入了系统环境变量path中，保证系统可调用GMT命令；
- GMT的执行路径已经加入Matlab的搜索路径下，保证Matlab可调用GMT命令，如下图所示。

.. figure:: /images/Matlab_path.*
   :width: 500 px
   :align: center

就可以使用这个接口了。

OS X 平台
+++++++++
在已发布的OS X平台下的GMT源代码中包含MATLAB的可编译接口。但是，由于MATLAB对共享库的操作是一个复杂的过程，
当要与MathWorks协同工作时，可以采用以下步骤编译出独立的基于GMT的MATLAB接口：

#. 安装最新版本OS X平台下的GMT；
#. 运行安装目录下 ``share/tools`` 下的 ``gmt_prepmex.sh`` 文件。此操作会复制GMT的已安装文件到 ``/opt/gmt`` 目录下，并且会重新检查所有的共享库；
#. 使用 ``gmtswitch`` 切换当前使用的GMT版本，确保 ``/opt/gmt`` 下的GMT为当前激活版本；
#. 使用svn检出 ``gmt-mex`` 项目文件到本地，示例： ``svn checkout svn://gmtserver.soest.hawaii.edu/gmt-mex gmt-mex`` ；
#. 进入 ``get-mex`` 目录，在 ``trunk`` 文件夹下（ ``cd trunk`` ），执行 ``autoconf`` 生成配置文件，然后执行 ``./configure -enable-matlab`` ；
#. 执行 ``make`` 编译整个项目；
#. 设置MTATLAB路径;
#. 确保 ``gmt.conf`` 文件中包含选项： ``GMT\_CUSTOM_LIBS=/opt/gmt/lib/gmt/plugins/supplements.so`` 。

经测试，该项目在2016b和2015a，b的MATLAB版本中可使用，对于更老版本的MATLAB，还未进行测试。

Unix/Linux平台
++++++++++++++

正在努力开发中，还望有志之士加入...

使用方法
--------

GMT接口完全模仿了传统的matlab命令，可以在命令行、m文件或IDE中使用。形式是:

``返回参数 = gmt('<module> <module-options>', 输入参数)``

其中**输入数据**可以为Matlab的矩阵、结构体或数组；**返回变量**可直接在Matlab中参与后续的计算。调用GMT完毕后，清空缓存：

``gmt('destroy')``

入门级示例
++++++++++

在matlab环境中调用 ``pscoast`` 绘制地图：

``gmt('pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P > GMT_lambert_az_hemi.ps')``

绘图效果如下：

.. figure:: /images/Matlab_ex1.jpg
   :width: 500 px
   :align: center

上例中，并不存在输入数据，也就是不存在与Matlab变量的交互，生成的ps文件在Matlab当前路径下。

进阶级示例
++++++++++

在Matlab环境中，绘制文字：
:: 
    %创建字符串数组 
    lines = {'5 6 Some label', '6 7 Another label'}; 
    % 绘制 
    gmt('pstext -R0/10/0/10 -JM6i -Bafg -F+f18p -P > text.ps ', lines); 
    gmt('destroy');

绘图效果如下：

.. figure:: /images/Matlab_ex2.png
   :width: 500 px
   :align: center

上例中，字符串数组 ``lines`` 可以直接作为 ``pstext`` 的输入参数。

以上为单个输入参数，若需要多个输入参数，如何确定参数的先后顺序？

高手级示例
++++++++++

对一个矩阵数组进行格网化并绘图：
:: 
    % 创建一个100*3矩阵，xyz值均为0~150之间的随机数
    t= rand(100,3)*150 
    % 利用GMT的surface命令对t进行格网化，输出为结构体G，数组结构见附1 
    G = gmt('surface -R0/150/0/150 -I1', t ); 
    % 利用Grd2cpt创建颜色表文件，输出为颜色表结构体cpt，结构体构成见附2
    cpt = gmt('grd2cpt -Cjet', G);
    % 利用Grdimage绘制格网话结果
    gmt('grdimage -JX8c -Ba -P -C -G > crap_img.ps', cpt, G);
    gmt('destroy');

绘图效果如下：

.. figure:: /images/Matlab_ex3.jpg
   :width: 500 px
   :align: center

上例中， ``grdimage`` 命令需要两个输入参数：颜色表 ``cpt`` 和格网数据 ``G`` ，两者先后顺序不可交换。 ``cpt`` (选项 ``-C`` 的参数)要先于 ``G`` ( ``grdimage`` 的强制性参数)。若有多个选项参数，则选项的顺序决定参数的先后顺序，强制性输入参数要写在最后。

大神级示例
++++++++++

另一个多参数的例子：
::   
    x = linspace(-pi, pi)';            % 创建x值
    seno = sin(x);                     % 创建y值
    xyz  = [x seno seno];              % 创建xyz三列数据，其中y=z
    cpt  = gmt('makecpt -T-1/1/0.1');  % 创建rainbow颜色表
    %绘制函数曲线，以z值赋颜色。cpt和xyz先后顺序不可交换。
    gmt('psxy -R-3.2/3.2/-1.1/1.1 -JX12c -Sc0.1c -C -P -Ba > seno.ps', cpt, xyz);
    gmt('destroy');

绘图效果如下：

.. figure:: /images/Matlab_ex4.jpg
   :width: 500 px
   :align: center

常见问题
--------

- 使用完GMT接口后要记得 ``destroy`` ，不然有可能出现不可预知错误。
- gmt括号内直接写module名，看似GMT4语句，实际只支持GMT5的语法。

附录
----

**grd结构体说明:**
:: 
    ProjectionRefPROJ4     % Proj4投影 (Optional)
    ProjectionRefWKT       % WKT投影 (Optional)
    range                  % 1x6 向量表示数值范围： [x_min x_max y_min y_max z_min z_max]
    inc                    % 1x2 向量表示采样间隔： [x_inc y_inc]
    n_rows                 % 行数
    n_columns              % 列数
    n_bands                % 波段数（维数）(目前未启用，恒 1)
    registration           % 格网表达方式: 0 -> Grid registration; 1 -> Pixel registration
    NoDataValue            % 空值
    title                  % 标题
    remark                 % Remark (Optional)
    command                % 生成命令 (Optional)
    DataType               % 数据格式'float' or 'double'
    x                      % [1 x n列]表示X坐标值
    y                      % [1 x n行]表示y坐标值
    z                      % [n行x n列]格网点值
    x_units                % x轴单位 (Optional)
    y_units                % y轴单位 (Optional)
