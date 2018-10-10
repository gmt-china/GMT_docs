GMT现代模式
===========

自GMT6起，GMT引入了一种全新的命令执行模式，称之为现代模式。
GMT5以及之前的命令风格则称之为经典模式。

.. note::

   GMT6既支持经典模式也支持现代模式，因而GMT6可以完全兼容GMT5的代码。

经典模式存在的问题
------------------

一个GMT经典模式下的绘图脚本如下所示：

.. literalinclude:: /modern/classic_mode_1.sh

.. figure:: /images/classic_mode_1.*
   :width: 100%
   :align: center

从上面的示例脚本中以及实际使用经验中会发现GMT经典模式存在的一些明显的缺点或问题：

#. 大部分命令需要使用 ``-K`` 和 ``-O`` 选项，而且极其容易出错
#. 需要使用 ``-P`` 选项决定画布的摆放方式
#. 每个绘图命令都需要使用重定向符号 ``>`` 或 ``>>``
#. 每个绘图命令中都需要给定PS文件的名字
#. 大部分命令都需要重复使用 ``-J`` 和 ``-R`` 选项，尽管具体数值可以省略
#. 需要调用单独的命令将生成的PS文件转换为PDF、JPG、PNG等格式

现代模式的优点
--------------

上面的示例在现代模式下可以改写为：

.. literalinclude:: /modern/modern_mode_1.sh

.. figure:: /images/modern_mode_1.*
   :width: 100%
   :align: center

现代模式下的GMT命令风格具有如下优点：

#. 不再需要考虑 ``-K``\ 、``-O`` 和 ``-P`` 选项
#. 不再需要进行重定向，也无需为每个命令都指定PS文件名
#. 不再需要为每个命令都是用 ``-R`` 和 ``-J`` 选项
#. 最终可生成PDF、PNG等多种格式的图片文件，无需再转换
#. 自动确定纸张大小并进行裁剪
#. 整个脚本在独立的临时文件夹下执行，因而可以同时执行多个脚本而不互相干扰

从经典到现代
------------

将一个经典模式的脚本改成现代模式下的脚本基本遵循如下几点：

#. 绘图脚本以 ``gmt begin figname pdf`` 开头，以 ``gmt end`` 结束
#. 去掉 ``-K``\ 、``-O``\ 、``-P``\ 、重定向符号以及PS文件名
#. 去掉多余的 ``-R`` 和 ``-J`` 选项
#. 以 ``ps`` 开头的模块改名了，比如 ``pscoast => coast``\ 、``psbasemap => basemap``\ 。
   几个例外包括 ``psxy => plot``\ ，``psxyz => plot3d``\ ，``psscale => colorbar``\ 。

现代模式下提供了几个新的功能（详细用法见模块手册）：

- ``gmt begin`` 开始现代绘图模式
- ``gmt end`` 结束现代绘图模式
- ``gmt figure`` 设置当前图片的基本信息
- ``gmt subplot`` 子图模式及相关设置

现代模式: 子图模式
------------------

GMT6提供了 ``gmt subplot`` 功能引入了子图模式，可以解决绘制多个子图时的如下麻烦：

#. 需要多次使用 ``-X`` 和 ``-Y`` 调整原点位置
#. 需要使用 ``pstext`` 手动为子图添加标签 (a) (b) 等
#. 需要调用 ``pstext`` 为整张图添加标题

经典模式下的一个多子图绘制脚本如下：

.. literalinclude:: /modern/classic_mode_2.sh

.. figure:: /images/classic_mode_2.*
   :width: 100%
   :align: center

使用 ``gmt subplot`` 后的现代模式绘图脚本如下：

.. literalinclude:: /modern/modern_mode_2.sh

.. figure:: /images/modern_mode_2.*
   :width: 100%
   :align: center

详细用法见 ``gmt subplot`` 的模块说明文档。

现代模式: 单行模式
------------------

有些图在经典模式下只需要一个命令就可以画出来，比如::

    gmt psbasemap -R0/10/0/5 -JX10c/3c -Bx1 -By1 > map.ps

改成现代模式就是::

    gmt begin map pdf
    gmt basemap -R0/10/0/5 -JX10c/3c -Bx1 -By1
    gmt end

这样反而变得复杂了。对于这种单个命令即可画出来的图来说，现代模式下提供了更加简洁的写法::

    gmt basemap -R0/10/0/5 -JX10c/3c -Bx1 -By1 -pdf map

其中 ``-pdf map`` 指定了生成的图片的格式和文件名，即 ``map.pdf``\ 。
