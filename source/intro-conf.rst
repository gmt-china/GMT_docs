GMT配置简介
===========

简介
----

GMT的每个模块都有众多选项，除此之外，GMT还有100多个参数，用于控制图像的外观和数据的处理方式。

所有GMT参数都有一个系统默认值，这些默认值位于GMT全局配置文件 :file:`${GMTHOME}/share/conf/gmt.conf` 中。

当执行一个GMT程序时，首先读取GMT全局配置文件，将所有参数初始化为系统默认值，然后去搜索 :file:`gmt.conf` 文件。若找到该文件，则会读取该文件中的参数值并覆盖系统默认值。

:file:`gmt.conf` 文件的搜索路径按优先级排序为： :file:`./gmt.conf` > :file:`~/.gmt/gmt.conf` > :file:`~/gmt.conf` 。即GMT程序首先会在当前目录寻找配置文件；若未找到，则到 :file:`~/.gmt` 目录下寻找；若仍为找到，则在家目录下寻找。

设计思路
--------

GMT将这100多个参数单独放置在配置文件 :file:`gmt.conf` 中，主要是基于两方面的考虑：

#. 让每个模块的命令行语法中都涵盖如此多的参数是不实际的，这些参数有些很少或几乎不需要改变（比如地图投影过程中使用的地球椭率）
#. 针对不同的应用环境，设置不同的GMT配置文件，保存到不同的 :file:`gmt.conf` 文件中，当需要使用一组特定的GMT配置时，可以在GMT命令行中使用 ``+<defaultfile>`` 来指定要使用的配置文件。比如，不同的期刊可能要求不同的字体和字号，你可以使用同样的脚本加上不同的配置文件来满足不同期刊的要求；又比如，用于出版的图件和用于PowerPoint演示的图件通常需要用不同的颜色和字号。将这些参数保存到单独的 :file:`gmt.conf` 配置文件中，可以尽可能的避免由于环境不同而导致的图片微调。

修改GMT配置
-----------

GMT系统自带的 :file:`gmt.conf` 文件中对每个参数都给了一个合理的默认值，但有时用户需要修改这些参数值，GMT提供了多种方法来实现修改。

#. 在单个GMT命令中使用 ``+<defaultfile>`` 的语法，来指定使用配置文件 ``<defaultfile>``\ ，该方法仅对单个命令有效::

      gmt psxy ... +custom_gmt.conf > test.ps

#. 在脚本开始执行之前，将要使用的配置文件 :file:`gmt.conf` 复制到当前目录，待脚本执行完毕后，删除该配置文件。该方法要求写脚本时要非常小心，因为若脚本因为错误出现中断，会影响到配置文件的删除，进而可能导致反效果的出现。

   .. code-block:: bash

      cp ~/somewhere/gmt.conf ./gmt.conf
      gmt psxy ...
      gmt pscoast ...
      gmt psxy ...
      rm gmt.conf

#. 用 ``gmtset`` 模块在脚本执行的过程中显式地修改GMT参数值

   比如，需要设置主标注的字体为 ``12p,Times-Bold,red`` ::

      gmt gmtset FONT_ANNOT_PRIMARY 12p,Times-Bold,red

   ``gmtset`` 会修改当前目录下的 :file:`gmt.conf` 文件中的相应参数值，进而影响到接下来其它GMT程序的执行。若当前目录没有 :file:`gmt.conf` 文件，则 ``gmtset`` 会先复制系统自带的 :file:`gmt.conf` 文件，再修改之。该命令修改的参数将一直生效，直到被新值覆盖。

#. 若你需要修改某些参数值，使得其在执行单个命令时有效，而不影响其他命令的执行效果，可以考虑在该命令行上使用 ``--PAR=value`` 语法。

   比如，针对某个GMT命令，为了临时设置浮点数的输出格式包含更多的小数位，而不影响其他命令的浮点数输出格式，可以在该命令中加上 ``--FORMAT_FLOAT_OUT=%.16lg`` 。

#. GMT提供了“隔离”模式，使得仅在单个脚本执行的过程中修改配置，当脚本执行完毕后自动恢复到原始配置，见附录 :doc:`isolation-mode` 一节

一般情况下，仅推荐使用方法三和方法四。

在使用方法三的时候，需要注意一个潜在的问题。假如一个脚本中，只有三个命令，首先执行了GMT命令A，然后使用 ``gmtset`` 将字体由默认字体a修改为字体b，然后又执行了GMT命令B。则命令A使用的是字体a，命令B使用的是字体b，这是自己想要的效果，到此为止都是没有问题的。若再次执行该脚本，由于当前目录下已经有了上一次执行生成的 :file:`gmt.conf` 文件，且文件中使用的是字体b，则命令A受到该参数文件的影响使用了字体b， ``gmtset`` 将字体b修改为字体b，命令B使用字体b。这导致了执行同一个脚本出现了不同的结果，经常会浪费很多的时间用来调试和排错。最好的做法是在脚本结束时删除当前目录下的参数文件，甚至删除其他一些中间文件。

.. code-block:: bash

   gmt psxy ...
   gmt pscoast ..
   gmt gmtset ...
   gmt grdimage ...
   gmt psxy ...

   rm gmt.conf gmt.history # 要养成删除临时文件的习惯

删除配置文件
------------

GMT 从5.4.0版本开始新增了 ``gmt clear conf`` 命令，可以用于删除配置文件 ``gmt.conf``，
其等效于 ``rm gmt.conf`` 命令。

GMT配置示例
-----------

下面列出部分会影响到绘图效果的GMT参数。

.. figure:: /images/GMT_Defaults_1.*
   :width: 600px
   :align: center

   GMT配置参数示例1

.. figure:: /images/GMT_Defaults_2.*
   :width: 600px
   :align: center

   GMT配置参数示例2

.. figure:: /images/GMT_Defaults_3.*
   :width: 600px
   :align: center

   GMT配置参数示例3
