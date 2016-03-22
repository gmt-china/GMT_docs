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