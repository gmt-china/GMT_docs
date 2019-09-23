# 维护指南

欢迎GMT中文用户参与到GMT中文手册的维护与更新中。

## 维护与更新

手册的维护主要包括几个方面：

- 修正错别字、语句不通等
- 修正rST文件语法错误导致的显示问题
- 修正文档中的错误描述和不清晰的描述
- 优化文档结构，使得文档条理更清晰
- 为每个文档增加索引关键词，方便用户通过关键词查找文档
- 翻译整理模块的文档
- 增加更多示例

可以通过如下几种方式参与文档的维护：

1. 通过 GitHub 修改文档源码并提交 Pull Request
2. 在项目主页提交 Issue
3. 在网页底部评论区留言
4. 发送相关建议或投稿至 `admin@gmt-china.org`

## 构建文档

本文档使用 [Sphinx](http://www.sphinx-doc.org/) 构建得到。Sphinx 是基于 Python 的
文档生成工具。

1.  安装 [Anaconda](https://www.anaconda.com/distribution/#download-section)

    Anaconda是一个Python发行版。对于Python入门用户，建议直接安装Anaconda。

    下载安装包后执行:

        bash ./Anaconda3-2019.07-Linux-x86_64.sh

2.  下载文档源码

        git clone https://github.com/gmt-china/GMT_docs.git

3.  安装文档所需依赖

        cd GMT_docs/
        pip install -r requirements.txt

4.  编译生成HTML格式的文档

        make html

    生成的文档位于 `build/html/` 目录下。

    - Linux 用户可以执行 `firefox build/html/index.html` 查看网页
    - macOS 用户可以执行 `open build/html/index.html` 查看网页

5.  安装 TeXLive

    如果想要生成PDF格式的文档，则需要安装TeXLive。

    - Linux 用户可以参考 http://blog.seisman.info/texlive-install
    - macOS 用户可以直接执行 `brew cask install mactex-no-gui` 安装 mactex

6.  编译生成PDF版文档

        make latexpdf

    生成的的PDF位于 `build/latex/GMT_docs.pdf`

## 分支模型

项目中存在如下长期分支：

- `master`: 主分支，对应GMT6最新版本的文档，所有绘图命令均使用现代模式
- `5.4`: 对应GMT5版本的文档，所有绘图命令均使用经典模式
- `gh-pages`: 用户存放网页的分支，自动更新，无需人工修改

其它分支均属于短期分支，在合并到 `master` 或 `5.4` 分支后会删除。

## 文档风格

### 新增章节

每个源文件都会被转换成一个单独的网页。因而，确定文件名时应慎重，一旦确定，尽量不要再改动。
由于Windows不区分文件名大小写，故而 option-B.rst 和 option-b.rst 在Windows下会出现冲突。

### 新增示例

示例脚本尽量使用Bash。除非必须，请勿使用Perl、Python等。
如果可能，图片尽量扁平（比如横纵比为2:1），以避免插入图片后左右两边有太多空白。

文档使用 Sphinx 扩展 [sphinx_gmt](https://github.com/GenericMappingTools/sphinx_gmt)
自动执行脚本生成图片并将图片插入到文档中，其用法有两种：行内模式和脚本模式。

行内模式，即直接在文档中写绘图代码:

```
.. gmtplot::
    :caption: 图片标题
    :width: 80%

    gmt begin map png,pdf
    gmt basemap -JX10c/10c -R0/10/0/10 -Baf
    gmt end show
```

脚本模式，即将绘图代码写在脚本中：

```
.. gmtplot:: /scripts/psmeca_ex1.sh
    :width: 80%

    图片标题
```

`gmtplot` 指令有很多选项，常用的包括：

- `show-code`: `true` 或 `false` 表示是否显示代码
- `width`: 图片在网页中的宽度，建议使用百分比表示，比如 `100%`

注意事项：

- `master` 分支中所有脚本均使用现代模式
- 所有脚本至少需要生成PNG格式的图片，建议使用 ``png,pdf`` 生成两种格式的图片
- 所有脚本以 ``gmt end show`` 结尾
