# -h 选项

**-h** 选项用于在读/写数据时跳过文件开头的若干个记录。其语法为：

> **-h**\[**i**|**o**\]\[*n*\]\[**+c**\]\[**+d**\]\[**+m***segheader*\]\[**+r***remark*\]\[**+t***title*\]

- *n* 表示要跳过的记录数 \[若不指定，则默认值为 {term}`IO_N_HEADER_RECS`\]
- **i** 和 **o** 分别表示仅对读数据或写数据时有效

对于输出数据，默认会将输入文件中的头段信息原样输出。使用如下子选项可以修改这一行为：

- **+c** 将列名写到输出的头段记录中
- **+d** 删除之前的头段信息
- **+m***segheader* 在输出的头段记录的后面加上一个新的段记录 *segheader*
- **+r***remark* 加一个remarke注释语句到输出文件的开头
- **+t***title* 加一个title语句到输出文件的开头

几点注意事项：

1. 输入文件中的空行以及以“#”开头的行都会被自动当做头段记录，因而会被自动跳过。
   但当使用 **-h** 选项时，这些行也会被算在 *n* 行之内。
2. 对于二进制输入文件，*n* 表示输入数据中要跳过的字节数，或输出数据中用
   空白字符补充的字节数。

几种常见的用法：

- **-h**：使用GMT参数 {term}`IO_N_HEADER_RECS` 的值作为
  头段记录数（默认值为0）
- **-h3**：表示跳过3个头段记录