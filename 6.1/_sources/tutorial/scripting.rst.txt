脚本编程
========

本手册中的所有示例及代码都使用Bash脚本实现，要求读者对Bash脚本语言有最基本的了解。
Windows用户若使用Batch脚本，则需要同时了解Bash和Batch的语法，并了解如何将
本手册中的Bash脚本正确转换为Batch脚本。

这一节介绍本手册中或GMT使用过程中最常用的Bash和Batch语法，而不涉及不常用或更复杂的语法。
本文主要包含四部分内容：

- Bash编程基础知识
- Batch编程基础知识
- 将Bash脚本转换为Batch脚本
- 常用Unix小工具

Bash编程基础知识
----------------

用文本编辑器创建一个后缀名为 **.sh** 的文件，向其中写入Bash命令并保存，即得到一个Bash脚本。

打开终端，在终端中输入 ``bash script.sh``\，即可执行Bash脚本 :file:`script.sh`\ 。
也可以执行命令 ``chmod +x script.sh`` 给脚本可执行权限，然后即可在终端输入
``./script.sh``\ 运行“可执行”的脚本。

下面的Bash脚本展示并解释了Bash中常用的语法：

.. code-block:: bash

	#!/bin/bash
	# 脚本的第一行叫 shebang，用来告知系统如何执行该脚本:
	# 参见： http://en.wikipedia.org/wiki/Shebang_(Unix)
	# 以 # 开头的行是注释行，在脚本执行时会被忽略

	# echo 命令用于显示后面的字符
	echo Hello world!

	# 声明一个变量
	# 注意：= 两边不能有空格!
	projection="X10c/10c"
	region="0/10/0/10"

	# 在变量名前加上 $ 符号即可引用该变量的值
	echo $projection $region

	# 执行GMT命令
	gmt begin map
	gmt basemap -J$projection -R$region -Baf

	# 输入数据
	# 有些命令需要读入数据。Bash中有多种方法可以将数据传递给一个命令：
	# 1. 将数据保存到文件中，并在命令中指定数据文件名
	#    下面的命令会读取文件 input.dat 中的数据
	gmt plot input.dat -W1p

	# 2. 通过管道符号 | 将前一个命令的输出作为后一个命令的输入
	#    下面的命令中，echo 命令输出了 5 5，该输出通过管道被传递给了 GMT 命令作为输入
	echo 5 5 | gmt plot -Sc0.5c

	# 3. 使用 heredoc 将两个 EOF 之间的数据传给命令
	#    下面的命令中，<< EOF 表示将接下来到EOF为止的内容传递给命令
	gmt plot -Sc0.5c << EOF
	1 2
	3 4
	5 6
	EOF

	# 输出数据
	# 很多命令都会输出一些数据或信息。默认情况下，输出会在终端显示。为了将数据保存到文件中，需要使用重定向符号。
	# 常用的重定向符号主要有两个： > 和 >>
	#   > 表示将数据输出到文件中。若文件不存在，则创建该文件；若文件已存在，则覆盖该文件的原内容；
	#  >> 表示将数据追加到文件中。若文件不存在，则创建该文件；若文件已存在，则将数据追加到原内容的后面；
	echo 1 3 Point1 > tmp.txt
	echo 2 5 Point2 >> tmp.txt
	echo 4 2 Point3 >> tmp.txt
	# 此时文件中有三行内容

	# 倒引号
	# 倒引号的作用是将一个命令的输出保存到一个变量中，供后面的命令使用
	# 下面将 gmt info 的输出保存到变量 new_region 中，并在接下来的命令中使用了该变量的值
	new_region=`gmt info input.dat -I1/1`
   	gmt plot input.dat -J$projection $new_region

	# 长命令续行符
	# 当一个命令较长时，可以将命令拆分为多行，每行行末用续行符 \ 表示下一行命令
	# 需要接在当前命令的后面
	gmt coast -A1000 -Dc -ECN -W1/1p \
		-Glightblue -Slightred

	gmt end show

	# rm 命令删除文件
	rm tmp.txt

Batch编程基础知识
-----------------

新建一个文本文件，将后缀改为 **.bat**\ ，向文件中写入Batch命令并保存，即得到一个Batch脚本。

双击该Batch脚本即可直接运行，也可以打开CMD窗口，再输入Batch脚本名以运行脚本。

下面的Batch脚本展示并解释了Batch脚本中常用的语法：

.. code-block:: batch

	REM 以 REM 开头的行是注释行，在脚本执行时会被忽略

	REM echo 命令用于显示后面的字符
	echo Hello world!

	REM 使用 set 命令声明一个变量
	set projection="X10c/10c"
	set region="0/10/0/10"

	REM 在变量名前后加上 % 即可引用该变量的值
	echo %projection% %region%

	REM 执行GMT命令
	gmt begin map
	gmt basemap -J%projection% -R%region% -Baf

	REM 输入数据
	REM 有些命令需要读入数据。Bash中有多种方法可以将数据传递给一个命令：
	REM 1. 将数据保存到文件中，并在命令中指定数据文件名
	REM    下面的命令会读取文件 input.dat 中的数据
	gmt plot input.dat -W1p

	REM 2. 通过管道符号 | 将前一个命令的输出作为后一个命令的输入
	REM    下面的命令中，echo 命令输出了 5 5，该输出通过管道被传递给了 GMT 命令作为输入
	echo 5 5 | gmt plot -Sc0.5c

	REM 输出数据
	REM 很多命令都会输出一些数据或信息。默认情况下，输出会在终端显示。为了将数据保存到文件中，需要使用重定向符号。
	REM 常用的重定向符号主要有两个： > 和 >>
	REM   > 表示将数据输出到文件中。若文件不存在，则创建该文件；若文件已存在，则覆盖该文件的原内容；
	REM  >> 表示将数据追加到文件中。若文件不存在，则创建该文件；若文件已存在，则将数据追加到原内容的后面；
	echo 1 3 Point1 > tmp.txt
	echo 2 5 Point2 >> tmp.txt
	echo 4 2 Point3 >> tmp.txt
	REM 此时文件中有三行内容

	REM 将命令的输出保存到变量中
	REM Batch中可以将命令的输出写到文件中，然后用 set /p var=<file 的方式将文件中的内容作为变量的值
	gmt info input.dat -I1/1 > tmp.dat
   	set /p new_region=<tmp.dat
	gmt plot input.dat -J%projection% %new_region%

	REM 长命令续行符
	REM 当一个命令较长时，可以将命令拆分为多行，每行行末用续行符 ^ 表示下一行命令
	REM 需要接在当前命令的后面
	gmt coast -A1000 -Dc -ECN -W1/1p ^
		-Glightblue -Slightred

	gmt end show

	REM del 命令用于删除文件
	del tmp.txt

	REM pause 命令用于暂停命令的执行
	REM 双击执行Batch脚本，脚本会在结束后自动退出。
	REM 为了查看脚本执行过程中是否报错，通常在Batch文件最后一行加上 pause
	pause

将Bash脚本转换为Batch脚本
-------------------------

Bash语法和Batch语法不同。本手册中所有脚本均使用Bash实现，Batch用户需要根据需求自行将Bash脚本转换为Batch脚本。转换主要注意如下几点：

- 	注释符号： ``#`` 改成 ``REM``
-	定义变量的方式： ``var=value`` 改成 ``set var=value``
- 	引用变量的方式： ``$region`` 改成 ``%region%``
- 	删除文件的命令： ``rm`` 改成 ``del``
- 	Bash中可以使用倒引号 ``var=`cmd1``` 将命令 cmd1 的输出作为变量 var 的值。Batch不支持这一语法，需要使用下面的命令实现类似功能::

		cmd1 > tmp.dat
		set /p var=<tmp.dat

- 	Bash中可以使用 EOF 将多行数据传递给一个命令。例如::

		gmt plot << EOF
		1 2
		3 4
		5 6
		EOF

  	Batch不支持这一语法，只能多次使用 echo 命令将数据输出到同一文件中，再将文件传递给命令使用::

	  	echo 1 2 >  tmp.dat
		echo 3 4 >> tmp.dat
		echo 5 6 >> tmp.dat
		gmt plot tmp.dat

Linux 常用命令
---------------

- `《地震“学”科研入门教程：Linux 常用命令》 <https://seismo-learn.org/seismology101/computer/commands/>`__
