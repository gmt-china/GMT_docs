-s 选项
=======

**-s** 选项用于控制是否输出含有 NaN 的记录。

默认情况下，GMT命令会输出所有记录，包括那些某列值为 NaN 的记录。
使用 **-s** 选项可以控制是否输出含 NaN 的记录。其语法为：

    **-s**\ [*cols*][**+a**][**+r**]

- 只使用 **-s**，则不输出Z值（即第三列）为NaN的记录
- *cols* 用于指定要检查的列，即只有指定的所有列都为NaN时，才输出或不输出该记录。
  *cols* 是一系列用逗号分隔的列号或者列号范围。
  列号范围的格式为 *start*\ [:*inc*]:*stop*。若省略 *inc* 则默认其值为1。
  比如 **2,5,7** 表示检查第3、6、8列（列号从0开始）；
  **0,2:3** 表示检查第1、3、4 列。
- **+a** 表示任意一列有NaN则不输出
- **+r** 表示反操作，即只输出某列有 NaN 的记录

举几个例子。输入数据 *input.dat* 的内容为::

    1 1 1   0
    2 2 NaN 0
    3 3 3   NaN
    4 4 NaN NaN

不使用 **-s** 选项则会输出所有记录::

    $ gmt convert input.dat
    1	1	1	0
    2	2	NaN	0
    3	3	3	NaN
    4   4   NaN NaN

使用 **-s** 选项则会压制第三列为NaN的记录的输出::

    $ gmt convert input.dat -s
    1	1	1	0
    3	3	3	NaN

使用 **-s+a** 选项则只有任意一列有NaN则不输出该记录::

    $ gmt convert input.dat -s+a
    1	1	1	0
    3	3	3	NaN

使用 **-s3** 选项则检查第四列（列号从0开始）是否为NaN::

    $ gmt convert input.dat -s3
    1	1	1	0
    2	2	NaN	0

使用 **-s2,3** 则压制第3和4列均为NaN的记录的输出::

    $ gmt convert input.dat -s2,3
    1	1	1	0
    2	2	NaN	0
    3	3	3	NaN

使用 **-s2,3+a** 压制第3列或第四列为NaN的记录::

    $ gmt convert input.dat -s2,3+a
    1	1	1	0

使用 **-s2,3+a+r** 反向操作输出第三列或第三列为NaN的记录::

    $ gmt convert input.dat -s2,3+a+r
    2	2	NaN	0
    3	3	3	NaN
    4	4	NaN	NaN
