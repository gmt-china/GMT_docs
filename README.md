# GMT参考手册

欢迎来到 GMT(Generic Mapping Tools) 的世界。

本项目是由GMT中文社区维护的GMT中文参考手册，既可以作为入门读物，也可以作为日常参考。希望通过阅读本手册，能够让用户尽快掌握GMT的用法。

## 相关链接

- GMT中文社区主页：http://gmt-china.org
- GMT参考手册项目主页：http://docs.gmt-china.org
- GMT参考手册项目源码：https://github.com/gmt-china/GMT_Docs
- GMT官方网站：http://gmt.soest.hawaii.edu/
- GMT官方文档：http://gmt.soest.hawaii.edu/doc/latest/index.html

## 版本说明

本手册目前与GMT 5.2.1同步。手册有正式发布(release)版和维护开发(dev)版。

### release版

本项目会针对每个GMT版本，发布与之对应的release版文档，版本号与GMT版本相同。release版包括HTML和PDF等格式的文档，供用户离线阅读。目前尚未发布release版。

正式发布版可以从社区主页的 [下载页面](http://gmt-china.org/download/) 或项目主页的 [Release页面](https://github.com/gmt-china/GMT_Docs/releases) 中获取。

### dev版

文档发布release版之后，即进入日常维护模式，即dev版。dev版的版本号格式为 `当前GMT版本号-dev` 。

dev版只提供在线阅读，地址为 http://docs.gmt-china.org/ 。

需要离线阅读dev版的用户，请自行编译：

~~~bash
# Clone至本机
$ git clone https://github.com/gmt-china/GMT_Docs.git GMT_Docs
$ cd GMT_Docs
# 安装Python第三方模块
$ pip install -r requirements.txt
# 编译生成HTML
$ make html
$ firefox build/html/index.html&
# 编译生成PDF（需要安装TeXLive 2015）
$ make xelatexpdf
$ evince build/latex/GMT_Docs.pdf&
~~~

## 文档维护

本文档尚有很多不完善之处，因而需要GMT用户一起完善。主要的维护包括如下几个方面：

1. 错字、语句不通
2. 语法错误导致的显示问题
3. 翻译尚未完成的部分，见[任务列表](https://github.com/gmt-china/GMT_Docs/wiki/%E4%BB%BB%E5%8A%A1%E5%88%97%E8%A1%A8)
4. 优化文档结构，使得文档条理更清晰
5. 增加索引，辅助查找
6. 随着GMT版本的更新而不断更新文档内容

文档的维护可以通过如下几个方式：

1. 在项目主页提交Issue
2. 修改文档源码并提交Pull Request

关于维护的具体细节，见项目[Wiki](https://github.com/gmt-china/GMT_Docs/wiki)
