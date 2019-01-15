bat简明教程
===========

Bat是什么
---------

Bat是Windows/DOS系统下的批处理文件格式，由一系列DOS命令语句组成。
Windows下GMT语句要写成bat格式执行。

Bat的创建
---------

新建一个文本文件，将后缀改为 ``.bat`` 即可。可以由一般的文本编辑器（如记事本）编辑，
然后双击直接运行。

常用命令
--------

echo命令
~~~~~~~~

echo其实是一个开关命令，执行 ``echo off`` 将关闭回显，它后面所有命令都不显示
命令本身，只显示执行后的结果。如果在某一行执行 ``echo on`` 命令将重新打开回显。

echo常见的用法是在屏幕上显示信息，例如 ``echo hello world`` 命令将在屏幕上
显示 ``hello world``\ 。

重定向符号
~~~~~~~~~~

常见的重定向符号有 ``>`` 和 ``>>``\ 。默认情况下，命令执行结果是输出到DOS窗口，
使用重定向后，将改成输出到另一个位置（文件）。\ ``>`` 和 ``>>`` 的区别在于
``>`` 会先将文件内容清空然后再将命令执行结果输入，而 ``>>`` 会将命令执行结果
直接追加到文件末尾::

   echo 第一行 > newfile.txt
   echo 第二行 >> newfile.txt

管道符号
~~~~~~~~

管道符号 ``|`` 会将其左侧命令的输出结果作为输入传递给其右侧语句::

   echo 5 5 | gmt psxy -R0/10/0/10 -JX10c -Ba -Sa0.5c -Gred > map.ps

定义变量
~~~~~~~~

可以使用 ``set`` 命令定义变量，然后用 ``%变量名称%`` 来引用变量::

   set Year=2018
   set Month=12
   set PS=%Year%-%Month%.ps
   echo 文件名为 %PS%

这段代码运行的结果为： ``文件名为 2018-12.ps``\ 。

暂停执行
~~~~~~~~

pause 用来暂停命令的执行，以便查看终端输出的过程。

一般情况下双击执行bat脚本cmd窗口会一闪而过，为了查看中间是否出错，在bat文件
最后一行（或需要暂停的地方）写一个pause。

删除文件
~~~~~~~~

del命令用来删除文件。使用GMT命令绘图后通常会在文件夹下产生一些临时文件，这时
可以使用del命令进行删除::

   echo 1 2 > tmp1.txt
   echo 3 4 >> tmp1.txt
   echo 5 6 > tmp2.txt
   gmt psxy tmp1.txt -R0/10/0/10 -JX10c -Ba -Sa1c -Gred -K > map.ps
   gmt psxy tmp2.txt -R -J -Sc0.5c -Gyellow -O >> map.ps
   del tmp* gmt.*

注释语句
~~~~~~~~

rem命令用来添加注释::

   rem 绘制地图
   echo 2 2 | gmt psxy -R0/5/0/5 -JX5c -B1 -Sc0.5c -Gblack -K > map.ps
   echo 3 3 | gmt psxy -R -J -Sc0.5c -Gred -O >> map.ps

循环语句
~~~~~~~~

bat文件中for命令用法较为复杂，这里只介绍如何利用for命令批量绘图。

命令格式： ``for %%i in (command1) do (command2)``

表示将 ``comand1`` 中的每一个结果赋值给 ``i``\ ，代入到 ``command2`` 中
执行命令，在 ``command2`` 中依然用 ``%%i`` 表示这个值::

   rem 开启变量延迟
   setlocal enabledelayedexpansion
   for /f %%i in ('dir /s/b "*.DAT"') do (
   set file=%%i
   rem 去除文件后缀名，即去除文件最后4个字符
   set file=!file:~0,-4!
   gmt surface %%i -R73/135/17/54 -I5m -Gtmp.grd
   gmt grdimage tmp.grd -R73/135/17/54 -JM12c -Cmycpt.cpt -Ba !file!.pdf
   del gmt.*
	)

上段表示将当前目录下所有DAT文件都进行插值并绘图，生成不同的pdf文件。
由于在循环中，又将 ``i`` 赋值给新的变量 ``file``\ ，为了感知每次循环中 ``i`` 值的
变化，需要在bat脚本开头设置 ``setlocal enabledelayedexpansion``\ ，并且 ``file``
变量的引用用 ``!file!`` 表示。
