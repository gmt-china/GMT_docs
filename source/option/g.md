# -g 选项

在处理多段数据时，GMT提供了三种机制来决定文件中数据的分段情况：

1. 使用数据段头记录来标记一段数据的开始，详见 {doc}`/table/ascii`

2. 若输入数据中，某个记录的某个关键列的值为NaN，则也可以用于将该记录作为数据段的开始标识

   - 当 {term}`IO_NAN_RECORDS` 为 **skip** 时，这些包含NaN值的记录会被自动跳过
   - 当 {term}`IO_NAN_RECORDS` 为 **pass** 时，这些包含NaN值的记录会被当做数据段的开始标识

3. 也可以使用 **-g** 选项，通过判断两个相邻的数据点是否符合某个准则来决定数据分段

**-g** 选项的完整语法为：

> **-g**\[**a**\]**x**|**y**|**d**|**X**|**Y**|**D**|\[*col*\]**z***gap*\[**u**\]\[**+n**|**p**\]

- **-gx** 表示两点的X坐标跳变超过 *gap* 则分段
- **-gy** 表示两点的Y坐标跳变超过 *gap* 则分段
- **-gd** 表示两点的距离超过 *gap* 则分段
- **-gX**、**-gY**、**-gD**类似，表示数据投影到纸上后X坐标、Y坐标和纸上距离的跳变

若想要检查特定列是否满足分段准则，可以用 *col***z**指定具体的列，*col* 的默认值为 2，即第三列。

*u* 用于指定 *gap* 的单位：

- 对于 **-g**__x__|__y__|__d__，*u* 可以取距离单位 \[默认为 m\]
- 对于 **-g**__X__|__Y__|__D__，*u* 可以取长度单位 \[默认为 {term}`PROJ_LENGTH_UNIT`\]
- 对于 **-g**__x__|__y__|__z__，若输入是时间数据，则单位由 {term}`TIME_UNIT` 控制

一般而言，当两点间的X坐标、Y坐标或距离的绝对值超过 *gap* 即分段。可以进一步控制两点的差的计算方式。
_gap_**+n** 表示用前一数据减去当前数据作为 *gap*；
_gap_**+p** 表示用当前数据减去前一数据作为 *gap*。

该选项可重复多次，以指定多个分段准则。默认情况下，若符合任意一个准则则分段，
可以使用 **-ga** 选项，表明仅当所有准则都满足时才分段。