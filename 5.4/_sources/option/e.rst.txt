-e 选项
=======

GMT命令在读入数据时默认会处理读入的所有数据记录。\ ``-e`` 选项的作用是筛选或
排除匹配某个字符串或者正则表达式的数据记录。

``-e`` 选项的用法有两种：

#.  匹配某个字符串：\ ``-e[~]"<pattern>"``
#.  匹配某个正则表达式：\ ``-e[~]/<regexp>/[i]``

在匹配字符串或正则表达式前加上 ``~`` 表示取反，即排除匹配字符串或正则表达式的数据记录。
如果数据记录中本身就包括字符 ``~``\ ，则需要使用 ``\~`` 对其进行转义。
对于匹配正则表达式而言，还可以加上 ``i`` 表示忽略大小写。

以一个常见的应用场景举例。假如文件 ``input.dat`` 中有一堆数据点，每个数据都对应
某个分类，文件内容如下::

    1 1 type1
    2 2 type1
    3 3 type1
    4 4 type2
    5 5 type2
    6 6 type2
    7 7 type3
    8 8 type10
    9 9 type10
    10 10 null

可以使用 ``-e`` 选项筛选出自己需要的数据记录。

筛选出所有匹配 ``type`` 的记录::

    $ gmt select input.dat -e'type'
    1	1	type1
    2	2	type1
    3	3	type1
    4	4	type2
    5	5	type2
    6	6	type2
    7	7	type3
    8	8	type10
    9	9	type10

排除所有匹配 ``null`` 的记录::

    $ gmt select input.dat -e~'null'
    1	1	type1
    2	2	type1
    3	3	type1
    4	4	type2
    5	5	type2
    6	6	type2
    7	7	type3
    8	8	type10
    9	9	type10

筛选所有匹配 ``type2`` 的记录::

    $ gmt select input.dat -e'type2'
    4	4	type2
    5	5	type2
    6	6	type2

筛选所有匹配 ``type1`` 的记录::

    # 错误写法，因为 type1 也包含在字符串 type10 中
    $ gmt select input.dat -e'type1'
    1	1	type1
    2	2	type1
    3	3	type1
    8	8	type10
    9	9	type10

    # 正确写法
    # 此处使用了正则表达式，\ ``$`` 表示行末匹配
    $ gmt select input.dat -e/type1$/
    1	1	type1
    2	2	type1
    3	3	type1

正则表达式的具体用法不在本手册的范围之内，用户请自行搜索“正则表示式”。
