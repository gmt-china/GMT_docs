# 标准选项

GMT 有 100 多个模块，每个模块的具体功能由模块的众多选项决定。
模块的选项都是以 {kbd}`-` 加一个字符的形式构成。
这些字符是经过精心挑选的，用户很容易根据字符记住该选项的作用。

GMT 的众多模块有不同的选项，也有标准选项。
标准选项在所有模块中具有完全相同的意义，故而本章将单独介绍这些通用的标准选项的用法。
在{doc}`/module/index`中，将不再详细介绍标准选项，而主要介绍每个模块特有的选项。

:::{table} GMT 标准选项列表
:align: center

| **选项**            | 说明                                     |
| ------------------- | ---------------------------------------- |
| {doc}`-B <B>`       | 定义底图边框和轴的刻度、标注、标签等属性 |
| {doc}`-J <J>`       | 选择地图投影方式或坐标变换               |
| {doc}`-R <R>`       | 指定区域范围                             |
| {doc}`-U <U>`       | 在图上绘制时间戳                         |
| {doc}`-V <V>`       | 详细报告模式                             |
| {doc}`-X <XY>`      | 移动 X 方向上的绘图原点                  |
| {doc}`-Y <XY>`      | 移动 Y 方向上的绘图原点                  |
| {doc}`-a <a>`       | 将非空间数据与某些列联系在一起           |
| {doc}`-b <binary>`  | 控制二进制的输入或输出                   |
| {doc}`-c <c>`       | 选择特定的子图                           |
| {doc}`-d <d>`       | 将输入或输出中的 *nodata* 替换成 NaN     |
| {doc}`-e <e>`       | 仅处理与指定 pattern 匹配的数据          |
| {doc}`-f <f>`       | 设置 ASCII 输入或输出的格式              |
| {doc}`-g <g>`       | 根据数据间断对数据进行分段               |
| {doc}`-h <h>`       | 跳过数据的文件头段记录                   |
| {doc}`-i <io>`      | 选择输入列                               |
| {doc}`-j <distcal>` | 确定球面距离的计算方式                   |
| {doc}`-l <l>`       | 为当前绘制的符号或线条添加图例记录       |
| {doc}`-n <n>`       | 设置网格插值方式                         |
| {doc}`-o <io>`      | 选择输出列                               |
| {doc}`-p <p>`       | 控制 3D 视角图                           |
| {doc}`-q <q>`       | 对输入/输出数据做行选择或数据范围选择    |
| {doc}`-r <nodereg>` | 设置网格配准方式                         |
| {doc}`-s <s>`       | 控制 NaN 记录的处理方式                  |
| {doc}`-t <t>`       | 设置图层透明度                           |
| {doc}`-w <w>`       | 将输入坐标转换为循环坐标                 |
| {doc}`-x <x>`       | 设置并行的核数（仅限于支持并行的模块）   |
| {doc}`-: <colon>`   | 输入数据是 *y*/*x* 而不是 *x*/*y*        |
:::

```{toctree}
:hidden: true
:maxdepth: 1

R
J
B
U
V
XY
a
binary
c
d
e
f
g
h
io
distcal
l
n
p
q
nodereg
s
t
w
x
colon
```
