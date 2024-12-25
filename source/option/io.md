# -i 和 -o 选项

**-i** 和 **-o** 选项分别用于对输入和输出的数据进行列选择以及简单的代数运算。

经常遇到的情况是，已有的数据有很多列，而某个命令只需要其中的某几列；
或者某个命令的默认输出有很多列，却只想要输出其中的某几列。

**-i** 选项可以从输入数据中选择任意列，并对其进行四则运算以及取对数操作。其语法为：

> **-i***cols*\[**+l**\]\[**+d***divisor*\]\[**+s***scale*|**d**|**k**\]\[**+o***offset*\]\[,*...*\]\[,**t**\[*word*\]\]

**-o** 选项用于输出指定的列。其基本语法为：

> **-o***cols*\[,...\]\[,**t**\[*word*\]\]

**-i** 和 **-o** 选项后接以逗号分隔的列号（列号从0开始）或列号范围，以指定输入/输出
数据中需要保留的列及其顺序。列号范围的格式为 *start*\[:*inc*\]:*stop*，
若省略 *inc* 则默认其值为 1；若 *stop* 省略则一直读到最后一列。
每一列均可重复多次出现。

若输入数据中既包含数值列也包含文本列，在不使用 **-i** 选项时，默认会读入所有列；
而使用 **-i** 选项时，默认会丢弃所有尾部文本列。可以加上 **t** 以保留文本列，
进一步可以指定 *word* 以指定保留文本列的第几列。

- **-in** 表示只读入数值列，而忽略所有尾部文本列
- **-on** 表示只输出数值列，而忽略所有尾部文本列
- **-ot** 表示只输出文本列，而忽略所有数值列

对于 **-i** 选项而言，每个列号后还可以加上子选项以对每列数据进行简单的代数运算：

- **+l** 表示对当前列取 $\log_{10}$
- **+d***divisor* 表示将当前列除以 *divisor* \[默认为 1\]
- **+s***scale* 表示将当前列乘以比例因子 *scale* \[默认为 1\]。可将 *scale* 替换
  为 **d** 将单位从千米转换为度；替换为 **k** 则使用 {term}`PROJ_MEAN_RADIUS` 将
  度转换为千米。
- **+o***offset* 表示将当前列的值加上 *offset* \[默认为 0\]

:::{note}
1. 上述子选项的执行顺序为：（1）取 log10，（2）缩放，（3）添加偏移 *offset*
2. 如果同时使用了 **-i** 和 **-o** 选项，则 **-o** 选项使用 **-i** 选择后的列
:::

举几个例子：

- **-i3,6,2** 表示读入数据中的第 4、7、3 列
- **-o3,1,3** 表示输出数据中的第 4、2、4 列，即第四列会被输出两次
- **-i1:3,5** 表示读入数据中的 2-4 列和第 6 列
- **-i2+s2+o10,6,3** 表示读入数据的第 3、7、4 列，并对第 3 列数据乘以 2 再加上 10

下面再举几个具体的实例：

取输入的 1-3 列:

```
$ echo 0 1 2 3 4 TEXT0 TEXT1 TEXT2 | gmt convert -i1:3
1   2       3
```

取输入的第 2 列并乘以 10 加上 5，并取第三列之后的所有列:

```
$ echo 0 1 2 3 4 TEXT0 TEXT1 TEXT2 | gmt convert -i1+s10+o5,2:
15  2       3       4
```

在上例基础上，取输入的所有文本列:

```
$ echo 0 1 2 3 4 TEXT0 TEXT1 TEXT2 | gmt convert -i1+s10+o5,2:,t
15  2       3       4       TEXT0 TEXT1 TEXT2
```

在上例基础上，只取文本列的第 2 列:

```
$ echo 0 1 2 3 4 TEXT0 TEXT1 TEXT2 | gmt convert -i1+s10+o5,2:,t1
15  2       3       4       TEXT1
```