# GMT参考手册

本项目是GMT中文社区的一部分，是介绍GMT用法的中文手册，可以作为GMT的入门读物以及日常参考。

## 相关链接

- GMT中文社区主页：http://gmt-china.org
- GMT参考手册项目主页：https://docs.gmt-china.org
- GMT参考手册项目源码：https://github.com/gmt-china/GMT_Docs
- GMT官方网站：http://gmt.soest.hawaii.edu/
- GMT官方文档：http://gmt.soest.hawaii.edu/doc/latest/index.html

## 本地编译

读者可以通过如下方式咋本地编译该文档：

1. Clone项目至本地

   ~~~bash
   $ git clone https://github.com/gmt-china/GMT_Docs.git GMT_Docs
   ~~~

2. 安装依赖

   ~~~bash
   $ cd GMT_Docs
   $ pip install -r requirements.txt
   ~~~

3. 编译生成HTML

   ~~~bash
   $ make html
   $ firefox build/html/index.html&
   ~~~

4. 编译生成PDF（需要安装TeXLive 2015）

   ~~~ bash
   $ make xelatexpdf
   $ evince build/latex/GMT_Docs.pdf&
   ~~~

## 文档维护

本文档尚有很多不完善之处，因而需要GMT用户一起完善。主要的维护包括如下几个方面：

1. 错字、语句不通
2. 语法错误导致的显示问题
3. 翻译尚未完成的部分，见 [任务列表](https://github.com/gmt-china/GMT_Docs/wiki/%E4%BB%BB%E5%8A%A1%E5%88%97%E8%A1%A8)
4. 优化文档结构，使得文档条理更清晰
5. 增加索引，辅助查找
6. 随着GMT版本的更新而不断更新文档内容

文档的维护可以通过如下几个方式：

1. 在项目主页提交Issue
2. 修改文档源码并提交Pull Request