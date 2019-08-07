多子图
======

GMT6中绘制多子图有两种方式：

- 常规方式：即利用 :doc:`/option/XY` 移动每个子图的原点
- 现代方式：即利用 :doc:`/module/subplot` 提供的子图模式

两种方法各有利弊，现代方式更加简洁，但通常只适用于所有子图的底图类似的情况；
常规方式更加灵活，但使用起来相对比较繁琐。

常规方式
--------

常规方式下使用 :doc:`/option/XY` 移动每个子图的原点，并使用 :doc:`/module/text`
为子图添加编号。

下面的命令展示了如何绘制四个子图，并给每个子图进行编号。需要注意，绘图时通常
从左下角开始画起，因而这里绘制子图的顺序是 c => d => a => b。

.. gmtplot::

   #!/bin/bash
   J=X5c/3c
   R=0/5/0/3

   gmt begin subplot pdf,png

   # 绘制子图 c
   gmt basemap -J$J -R$R -Ba -BWSen
   # 此处可以放置一堆子图A内的绘制命令
   # 给子图编号
   echo "(c)" | gmt text -F+cTL+f15p,1 -Dj-1c/-0.75c -N

   # 绘制子图 d 并编号
   gmt basemap -J$J -R$R -Ba -BWSen -X7c
   echo "(d)" | gmt text -F+cTL+f15p,1 -Dj-1c/-0.75c -N

   # 绘制子图 a 并编号
   gmt basemap -J$J -R$R -Ba -BWSen -X-7c -Y5c
   echo "(a)" | gmt text -F+cTL+f15p,1 -Dj-1c/-0.75c -N

   # 绘制子图 b 并编号
   gmt basemap -J$J -R$R -Ba -BWSen -X7c
   echo "(b)" | gmt text -F+cTL+f15p,1 -Dj-1c/-0.75c -N

   gmt end

几点说明:

1. ``+cTL`` 的作用从 ``-R`` 选项中提取底图的左上角（**T**\ op **L**\ eft）
   作为当前字符串的坐标；
2. 由于使用了 ``+cTL``\ ，因而 :doc:`/module/text` 不再需要 XY 坐标信息，
   只需要给出字符串 ``(a)``\ 、\ ``(b)`` 即可；
3. ``+f15p,1`` 将编号字号设置为 ``5p``\ ，1号字体（即粗体）
4. 将编号放在左上角还不够，还需要使用 ``-Dj-1c/-0.75c`` 对编号的位置进行微调，
   此处表示将编号向左边移动 1 cm 向上移动 0.75 cm
5. 由于编号位于子图的外部，故而需要加上 ``-N`` 选项使得 :doc:`/module/text`
   绘制子图外部的字符串

现代方式
--------

现代方式使用 :doc:`/module/subplot` 绘制多子图。

- ``subplot begin`` 将整个绘图区域分为2x2的网格并设置子图的大小及其它属性
- ``subplot set`` 通过指定行和列以激活指定的子图

.. gmtplot::

   #!/bin/bash
   R=0/5/0/3

   gmt begin subplot pdf,png
   gmt set FONT_TAG 15p,1

   gmt subplot begin 2x2 -Fs5c/3c -A'(a)'+JTL+o0.2c/0.4c -M0.5c/0.2c
   gmt subplot set 0,0
   gmt basemap -R$R -Ba -BWSen

   gmt subplot set 0,1
   gmt basemap -R$R -Ba -BWSen

   gmt subplot set 1,0
   gmt basemap -R$R -Ba -BWSen

   gmt subplot set 1,1
   gmt basemap -R$R -Ba -BWSen

   gmt subplot end
   gmt end

若 ``subplot set`` 不指定子图行和列，则GMT自动依次激活下一个子图。因而下面的
示例也可以实现相同的效果，但更加简洁：

.. code-block:: bash

   #!/bin/bash
   R=0/5/0/3

   gmt begin subplot pdf,png
   gmt set FONT_TAG 15p,1

   gmt subplot begin 2x2 -Fs5c/3c -A'(a)'+JTL+o0.2c/0.4c -M0.5c/0.2c
   gmt subplot set
   gmt basemap -R$R -Ba -BWSen

   gmt subplot set
   gmt basemap -R$R -Ba -BWSen

   gmt subplot set
   gmt basemap -R$R -Ba -BWSen

   gmt subplot set
   gmt basemap -R$R -Ba -BWSen

   gmt subplot end
   gmt end

:doc:`/option/c` 也可以用于激活指定的子图，但其功能没有 ``subplot set`` 丰富。
但通常已经足够使用。下面的代码使用 ``-c`` 进一步简化了上面的示例:

.. code-block:: bash

   #!/bin/bash
   R=0/5/0/3

   gmt begin subplot pdf,png
   gmt set FONT_TAG 15p,1

   gmt subplot begin 2x2 -Fs5c/3c -A'(a)'+JTL+o0.2c/0.4c -M0.5c/0.2c
   gmt basemap -R$R -Ba -BWSen -c
   gmt basemap -R$R -Ba -BWSen -c
   gmt basemap -R$R -Ba -BWSen -c
   gmt basemap -R$R -Ba -BWSen -c
   gmt subplot end
   gmt end
