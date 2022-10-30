Bash 编程基础知识
=================

Bash 基础
---------

用文本编辑器创建一个后缀名为 **.sh** 的文件，向其中写入 Bash 命令并保存，即得到一个 Bash 脚本。

打开终端，在终端中输入 ``bash script.sh``\，即可执行 Bash 脚本 :file:`script.sh`。
也可以执行命令 ``chmod +x script.sh`` 给脚本可执行权限，然后即可在终端输入
``./script.sh``\ 运行 “可执行” 的脚本。

下面的 Bash 脚本展示并解释了 Bash 中常用的语法：

.. code-block:: bash

	#!/usr/bin/env bash
	# 脚本的第一行叫 shebang，用来告知系统如何执行该脚本:
	# 参见： http://en.wikipedia.org/wiki/Shebang_(Unix)
	# 以 # 开头的行是注释行，在脚本执行时会被忽略

	# echo 命令用于显示后面的字符
	echo Hello world!

	# 声明一个变量
	# 注意：= 两边不能有空格！projection="X10c/10c"
	region="0/10/0/10"

	# 在变量名前加上 $ 符号即可引用该变量的值
	echo $projection $region

	# 执行 GMT 命令
	gmt begin map
	gmt basemap -J$projection -R$region -Baf

	# 输入数据
	# 有些命令需要读入数据。Bash 中有多种方法可以将数据传递给一个命令：
	# 1. 将数据保存到文件中，并在命令中指定数据文件名
	#    下面的命令会读取文件 input.dat 中的数据
	gmt plot input.dat -W1p

	# 2. 通过管道符号 | 将前一个命令的输出作为后一个命令的输入
	#    下面的命令中，echo 命令输出了 5 5，该输出通过管道被传递给了 GMT 命令作为输入
	echo 5 5 | gmt plot -Sc0.5c

	# 3. 使用 heredoc 将两个 EOF 之间的数据传给命令
	#    下面的命令中，<< EOF 表示将接下来到 EOF 为止的内容传递给命令
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

Linux 常用命令
--------------

Bash 脚本本身功能有限，因而经常需要与 Linux 下的命令结合在一起使用。

- `《地震“学”科研入门教程：Linux 常用命令》 <https://seismo-learn.org/seismology101/computer/commands/>`__
