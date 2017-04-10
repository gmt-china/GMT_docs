GMT的Matlab接口
===============

简介
----

GMT的Matlab接口，顾名思义，提供了在Matlab中调用GMT命令的功能。通过该接口，GMT的所有模块命令都可以在Matlab脚本中嵌入执行。GMT命令生成的结果（grid格网数据、table表格数据、CPT颜色表、文本文件、图片等）都可以作为Matlab变量进行运算；Matlab中的矩阵变量也可以直接作为GMT的输入，执行GMT的命令。

安装
----

Windows平台
+++++++++++

GMT5.3用户在GMT执行路径（默认为 ``C:\programs\gmt5\bin`` ）下已经存在 ``gmt.m`` 和 ``gmtmex.mexw64|32`` 两个文件，只要确保如下两点即可在Windows下使用该接口了。

- GMT的执行路径已经加入了系统环境变量path中，保证系统可调用GMT命令；
- GMT的执行路径已经加入Matlab的搜索路径下，保证Matlab可调用GMT命令，如下图所示。

.. figure:: /images/Matlab_path.png
   :width: 500 px
   :align: center

   Matlab PATH 设置

- 测试安装是否正确：在Matlab的命令行窗口直接敲入 ``gmt``，若出现GMT的版本及使用方法介绍，则安装成功。

OS X 平台
+++++++++

在OS X上按照如下流程可以成功编译GMT的Matlab接口。但由于Matlab处理动态链接库的方式很特别，因而该接口可能不太稳定。GMT开发者正试图与MathWorks合作以解决这个问题，将来以下编译方法可能会修改：

#. 安装OS X平台下最新版本的GMT；
#. 运行安装目录下 ``share/tools`` 下的 ``gmt_prepmex.sh`` 文件。此操作会复制GMT的已安装文件到 ``/opt/gmt`` 目录下，并且会重新检查所有的共享库；
#. 使用 ``gmtswitch`` 切换当前使用的GMT版本，确保 ``/opt/gmt`` 下的GMT为当前激活版本；
#. 使用svn获取 ``gmt-mex`` 项目文件到本地::

    svn checkout svn://gmtserver.soest.hawaii.edu/gmt-mex gmt-mex

#. 进入 ``get-mex`` 目录并编译生成 ``gmtmex.mexmaci64`` ::

    cd gmt-mex/trunk/
    autoconf
    ./configure --enable-matlab
    make

#. 将 ``gmt.m`` 和 ``gmtmex.mexmaci64`` 所在目录添加到MTATLAB路径中
#. 确保 ``gmt.conf`` 文件中包含选项： ``GMT_CUSTOM_LIBS=/opt/gmt/lib/gmt/plugins/supplements.so``

经测试，该项目在2015a，b的MATLAB版本中可使用，对于更老版本的MATLAB，还未进行测试。

Unix/Linux平台
++++++++++++++

正在努力开发中，还望有志之士加入...

使用方法
--------

GMT接口完全模仿了传统的matlab命令，可以在命令行、m文件或IDE中使用。形式是::

    返回参数 = gmt('<module> <module-options>', 输入数据)

其中 **输入数据** 可以为Matlab的矩阵、结构体或数组等； **返回参数** 可直接在Matlab中参与后续的计算。调用GMT完毕后，清空缓存::

    gmt('destroy')

入门级示例
++++++++++

在matlab环境中调用 ``pscoast`` 绘制地图::

    gmt('pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P > GMT_lambert_az_hemi.ps')

上例中，并不存在输入数据，也就是不存在与Matlab变量的交互，生成的ps文件在Matlab当前路径下。


进阶级示例
++++++++++

在Matlab环境中，绘制文字::

    %创建字符串数组
    lines = {'5 6 Some label', '6 7 Another label'};
    % 绘制
    gmt('pstext -R0/10/0/10 -JX6i -Bafg -F+f18p -P > text.ps ', lines);
    gmt('destroy');

上例中，字符串数组 ``lines`` 可以直接作为 ``pstext`` 的输入参数。

以上为单个输入参数，若需要多个输入参数，如何确定参数的先后顺序？

高手级示例
++++++++++

对一个矩阵数组进行格网化并绘图：

.. code-block:: matlab

    % 创建一个100*3矩阵，xyz值均为0~150之间的随机数
    t= rand(100,3)*150
    % 利用GMT的surface命令对t进行格网化，输出为结构体G，数组结构见附录
    G = gmt('surface -R0/150/0/150 -I1', t );
    % 利用grd2cpt创建颜色表文件，输出为颜色表结构体cpt
    cpt = gmt('grd2cpt -Cjet', G);
    % 利用grdimage绘制格网化结果
    gmt('grdimage -JX8c -Ba -P -C -G > crap_img.ps', G, cpt);
    gmt('destroy');

上例中， ``grdimage`` 命令需要两个输入参数：颜色表 ``cpt`` 和格网数据 ``G`` ，两者先后顺序不可交换。强制性输入参数（本例中的``G``）要在所有可选参数（本例中的``cpt``）之前。若有多个选项参数，强制性输入参数写在最前，然后按顺序给出可选参数。

大神级示例
++++++++++

另一个多参数的例子：

.. code-block:: matlab

    x = linspace(-pi, pi)';            % 创建x值
    seno = sin(x);                     % 创建y值
    xyz  = [x seno seno];              % 创建xyz三列数据，其中y=z
    cpt  = gmt('makecpt -T-1/1/0.1');  % 创建rainbow颜色表
    %绘制函数曲线，以z值赋颜色。cpt和xyz先后顺序不可交换。
    gmt('psxy -R-3.2/3.2/-1.1/1.1 -JX12c -Sc0.1c -C -P -Ba > seno.ps', xyz, cpt);
    gmt('destroy');

敲黑板，上例``psxy``一句中，``-C``为可选参数，因此引号外``cpt``要在强制性输入数据``xyz``之后。

常见问题
--------

- 使用完GMT接口后要记得 ``gmt('destroy')`` 释放内存，不然有可能出现不可预知错误。
- gmt括号内直接写module名，看似GMT4语句，实际只支持GMT5的语法。
- 绘制地理投影时，经纬度标注可能会出现 ``%s`` 乱码（即使设置为不显示任何度分秒符号），目前已知Matlab2016存在该问题，其他版本还未有此类反馈。

附录
----

网格数据结构体
++++++++++++++

::

    proj4          % Proj4 语法的投影方式 (可选)
    wkt            % WKT 语法的投影方式 (可选)
    range          % 1x6 向量, 表示数值范围： [x_min x_max y_min y_max z_min z_max]
    inc            % 1x2 向量, 表示采样间隔： [x_inc y_inc]
    registration   % 格网表达方式: 0 -> Grid registration; 1 -> Pixel registration
    nodata         % 空值对应的数值
    title          % 标题 (可选)
    comment        % Remark (可选)
    command        % 生成网格所使用的命令 (可选)
    datatype       % 数据格式 'float' 或 'double'
    x              % [1 x n_columns] 向量, 表示X坐标值
    y              % [1 x n_rows] 向量, 表示Y坐标值
    z              % [n_rows x n_columns] 网格数组
    x_units        % X轴单位 (可选)
    y_units        % Y轴单位 (可选)
    z_units        % Z单位 (可选)
    layout         % 一个三字符的字符串，用于描述 image memory layout

图像结构体
++++++++++

::

    proj4          % Proj4 语法的投影方式 (可选)
    wkt            % WKT 语法的投影方式 (可选)
    range          % 1x6 向量, 表示数值范围： [x_min x_max y_min y_max z_min z_max]
    inc            % 1x2 向量, 表示采样间隔： [x_inc y_inc]
    registration   % 格网表达方式: 0 -> Grid registration; 1 -> Pixel registration (默认值)
    nodata         % 空值对应的数值
    title          % 标题 (可选)
    comment        % Remark (可选)
    command        % 生成网格所使用的命令 (可选)
    datatype       % 数据格式 'uint8' 或 'int8'
    x              % [1 x n_columns] 向量, 表示X坐标值
    y              % [1 x n_rows] 向量, 表示Y坐标值
    image          % [n_rows x n_columns] 图像数组
    x_units        % X轴单位 (可选)
    y_units        % Y轴单位 (可选)
    z_units        % Z单位 (可选)
    colormap       % CPT 结构体
    alpha          % [n_rows x n_columns] alpha 数组
    layout         % 一个四字符的字符串，用于描述 image memory layout

CPT 结构体
+++++++++++

::

    colormap       % [ncolors x 3] 矩阵，保存了 [0-1] 范围内的颜色值
    alpha          % [ncolors x 1] 矢量，包含了 [0-1] 范围内的透明度值 (可选)
    range          % [ncolors x 2] 矩阵，对于每个颜色而言包含了 z_low 和 z_high 两个值
    minmax         % [z_min z_max]
    bnf            % [3 x 3] 矩阵，包含了 [0-1] 范围内的前景色、背景色和NaN色
    depth          % CPT 颜色深度，取值 (1, 8, 24)
    hinge          % hinge 值
    cpt
    model          % RGB 或 CMYK
    comment        % remark (可选)

PostScript 结构体
++++++++++++++++++

::

    postscript     % 包含了全部 PostScript 代码的字符串
    length         % 字符串的长度（即字节数）
    mode           % 1 表示仅包含文件头，2表示只包含文件尾，3表示完整为文件
    comment

.. source: http://gmt.soest.hawaii.edu/doc/latest/matlab_wrapper.html
