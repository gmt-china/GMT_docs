bash简明教程
============

bash 是什么
-----------

bash 是类 UNIX 系统下最常见的 shell。bash 是一个程序也是一种编程语言。

bash 的创建
-----------

新建一个文本文件，后缀名任意，通常用 ``.sh``\ 。

bash脚本可以直接用 ``bash script.sh`` 的形式执行，也可以通过如下命令给脚本
执行权限，然后使用 ``./script.sh`` 的方式执行::

    chmod +x ./script.sh
    # 赋予脚本文件可执行权限
    ./script.sh

常用命令
--------

echo 命令
~~~~~~~~~

echo，顾名思义，就是回显的意思，在屏幕上输出 hello world::

    echo hello world

重定向符号
~~~~~~~~~~

常见的重定向符号有 ``>`` 和 ``>>``\ 。

默认情况下，命令执行结果是输出到终端窗口。使用重定向后，将改成输出到另一个位置（文件）。
``>`` 和 ``>>`` 的区别在于 ``>`` 会先将文件内容清空然后再将命令执行结果输入，
而 ``>>`` 会将命令执行结果直接追加到文件末尾::

    echo 第一行 > newfile.txt
    echo 第二行 >> newfile.txo

管道符号
~~~~~~~~

管道符号 ``|`` 会将其左侧命令的输出结果作为输入传递给其右侧语句::

    echo 5 5 | gmt psxy -R0/10/0/10 -JX10c -Ba -Sa0.5c -Gred > map.ps

删除文件
~~~~~~~~

``rm`` 命令用来删除文件。
使用 GMT 命令绘图后通常会在文件夹下产生一些临时文件，这时可以使用 ``rm`` 命令进行删除::

    echo 1 2 > tmp1.txt
    echo 3 4 >> tmp1.txt
    echo 5 6 > tmp2.txt
    gmt psxy tmp1.txt -R0/10/0/10 -JX10c -Ba -Sa1c -Gred -K > map.ps
    gmt plot tmp2.txt -R -J -Sc0.5c -Gyellow -O >> map.ps
    rm tmp* gmt.*

定义变量
--------

bash 定义变量不需要申明变量的类型::

    VAR="some"
    # = 号的前后不能加空格
    echo $VAR
    # 在使用变量时，必须加上美元符号

添加注释
--------

在行首添加 #，即可注释该行。


循环
----

多种循环结构::

    while cmd1; do
        cmd2;
    done

    until cmd1; do
        cmd2;
    done

    for name in words; do
        cmd;
    done

    for ((exp1; exp2; exp3)); do
        cmd;
    done

    case word in
        pat1) cmd1;;
        pat2) cmd2;;
        pat3) cmd3;;
    esac

一个实际的例子::

    a="1 2 3 4 5 a b c"
    for i in $a; do
        echo $i
    done
    a=(1 2 3 4 5 a b c)
    for ((i=0;i<10;++i)); do
        echo $i
        echo ${a[i]}
    done
