GMT命令行
=========

命令风格
--------

现代模式
~~~~~~~~

GMT在绘图时总是以 ``gmt begin`` 开头，并以 ``gmt end`` 结尾，中间则是用于绘图的
GMT命令。其一般形式如下::

   gmt begin figurename pdf,png  # 生成PDF和PNG格式的名为figurename的图片
   gmt set ...                   # 配置GMT参数
   gmt ...                       # GMT绘图命令及其他数据处理命令
   gmt ...                       # GMT绘图命令及其他数据处理命令
   gmt end                       # 结束绘图

也可以使用::

   gmt begin 
   gmt figure figurename pdf,png # 生成PDF和PNG格式的名为figurename的图片
   gmt set ...                   # 配置GMT参数
   gmt ...                       # GMT绘图命令及其他数据处理命令
   gmt ...                       # GMT绘图命令及其他数据处理命令
   gmt end                       # 结束绘图

现代模式: 单行模式
~~~~~~~~~~~~~~~~~~

有些图只需要一个命令就可以画出来，比如::

    gmt begin map pdf
    gmt coast -Rd -JN4.5i -Bg -Dc -A10000 -Ggoldenrod -Ssnow2
    gmt end

对于这种一个命令就可以成图的情况，可以使用更加简洁的单行模式::

    gmt coast -Rd -JN4.5i -Bg -Dc -A10000 -Ggoldenrod -Ssnow2 -pdf map

其中 ``-pdf map`` 指定了生成的图片的格式和文件名，即 ``map.pdf``\ 。

现代模式: 子图模式
~~~~~~~~~~~~~~~~~~

有些时候，需要在一张图中绘制多张子图（多个panel）。在一般模式下，可以使用 
``-X`` 和 ``-Y`` 选项（后面会介绍到）调整每个子图的底图原点，即可实现多子图的图件。

对于某些比较规律的多子图图件，可以使用GMT提供的子图模式 ``gmt subplot`` 功能。
例如：

.. code-block:: bash

   gmt begin panels ps
     gmt subplot begin 2x2 -Fs3i -M5p -A -SCb -SRl -Bwstr
       gmt psbasemap -R0/80/0/10 -c1,1
       gmt psbasemap -c1,2
       gmt psbasemap -c2,1
       gmt psbasemap -c2,2
       gmt subplot end
   gmt end

现代模式: 多图模式
~~~~~~~~~~~~~~~~~~

如果想在GMT中指定

命令格式
--------

GMT提供了名为 ``gmt`` 的二进制文件，所有绘图及数据处理操作都是通过调用 ``gmt`` 
命令来完成的。

一个GMT命令由“\ ``gmt`` + ``模块`` + ``选项`` + ``参数``\ ”构成。其一般形式如下::

    gmt module -Axx+bxxxx -Bxx+axxxx

其中，

- ``gmt`` 是GMT中“唯一”的一个二进制文件，所有GMT命令必须以 ``gmt`` 开头
- ``module`` 是用于完成某个特定操作的模块的名字
- ``-A`` 是模块 ``module`` 提供的选项，\ ``xx`` 为选项 ``-A`` 的参数
- ``+b`` 是选项 ``-A`` 的子选项，\ ``xxxx`` 为该子选项的参数

一个完整的示例::

    gmt coast -R0/20/0/20 -JM6i -Ggray -Wthin -B5 -B+t"Title with spaces" -pdf map

其中，

- 命令以 ``gmt`` 开头
- ``coast`` 是用于绘制海岸线的模块
- ``-R``\ 、\ ``-J``\ 、\ ``-G`` 等都是 ``coast`` 模块的选项
- ``-B+t"Title with spaces"`` 中 ``+t`` 是选项 ``-B`` 的子选项，
  ``"Title with spaces"`` 是子选项 ``+t`` 的参数

几点说明：

- 若模块名以 ``gmt`` 开头，则模块名中的 ``gmt`` 可省略。比如 ``gmt gmtconvert xxx xxx``
  可以简写为 ``gmt convert xxx xxx``
- 模块名、选项等均区分大小写
- 每个模块可以使用哪些选项由模块自己定义，具体参考每个模块的语法说明
- 选项以 ``-`` 开头，后接\ **单个字符**\ 表示某个选项，字符后接选项的参数以及子选项
- 不以 ``-`` 开头的参数，都会被当做文件，GMT会尝试去读取
- 子选项以 ``+`` 开头，后接\ **单个字符**\ 以及子选项的参数
- 官方文档中子选项称为modifier，可以译为“修饰符”，本文档中统一使用“子选项”
- 各选项间以空格分隔，选项内部不能有空格
- 选项内部的字符串，若存在空格，应用单引号或双引号括起来
- 注意 ``-A``\ 、\ ``—A`` 以及 ``－A`` 的细微区别，这通常是由于标点符号的全角和
  半角导致的。GMT中只能使用第一种。GMT4官方文档以及某些介绍GMT的博客，都有此问题。
  GMT5、6的官方文档以及本文档不存在该问题。

模块分类
--------

GMT的所有绘图操作都是通过调用不同的模块来完成的，但GMT除了绘图之外，还有数据
处理以及格式转换等功能。根据功能的不同，大致将GMT的众多模块分为如下几类：

- 参数设定类：如 ``gmtset``
- 绘图操作类：如 ``plot``\ 、\ ``grdimage``
- 数据处理类：如 ``gmtmath``\ 、\ ``grdmath``
- 格式转换类：如 ``xyz2grd``\ 、\ ``psconvert``
