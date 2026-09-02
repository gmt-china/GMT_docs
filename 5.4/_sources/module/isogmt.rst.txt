.. index:: ! isogmt

isogmt
======

:官方文档: :doc:`gmt:isogmt`
:简介: 在“隔离模式”下运行GMT命令或脚本

用法
----

::

    isogmt command

说明
----

该命令本质上是一个Bash脚本，其脚本内容为::

    export GMT_TMPDIR=`mktemp -d ${TMPDIR:-/tmp}/gmt.XXXXXX`
    gmt $1 =
    if test $? -eq 0; then
        gmt "$@"
    else
        "$@"
    fi
    rm -rf $GMT_TMPDIR
    unset GMT_TMPDIR

该脚本做了如下几件事情：

1. 定义环境变量 ``${GMT_TMPDIR}`` 该环境变量指定了GMT的临时文件目录，接下来
   执行的GMT命令所生成的临时文件都会保存在该临时目录下
2. 检查 `isogmt` 后接的是一个GMT模块名还是一个脚本，并根据不同情况分别执行该模块/脚本
3. 待命令/脚本执行完毕后，再删除临时目录和环境变量

示例
----

隔离模式下运行一个GMT命令::

    isogmt psbasemap -R0/10/0/10 -JX10c/10c -B1 > test.ps

隔离模式下运行一个脚本::

    isogmt sh run.sh

已知BUGS
--------

#. 无法在隔离模式下执行脚本（v5.2.1）
