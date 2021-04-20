维护指南
========

欢迎GMT中文用户参与到GMT中文手册的维护与更新中。

维护与更新
----------

手册的维护主要包括几个方面：

- 修正错别字、语句不通等
- 修正文档中的错误或不清晰的描述
- 修正reST文件语法错误导致的显示问题
- 调整章节结构，使得文档条理更清晰
- 翻译整理更多模块的文档
- 增加示例与入门教程

可以通过如下几种方式参与文档的维护：

1. 通过 GitHub 修改文档源码并提交 `Pull Request <https://github.com/gmt-china/GMT_docs/pulls>`__
2. 在 GitHub 上提交 `Issue <https://github.com/gmt-china/GMT_docs/issues>`__
3. 在网页底部评论区留言
4. 发送相关建议或投稿至 admin@gmt-china.org

分支模型
--------

项目中存在如下长期分支：

- ``master``: 主分支，对应 GMT6 最新版本的文档，所有绘图命令均使用现代模式
- ``5.4``: 对应 GMT5 版本的文档，所有绘图命令均使用经典模式 (该分支已不再维护)
- ``gh-pages``: 用户存放网页的分支，自动更新，无需人工修改

其它分支均属于短期分支，在合并到 ``master`` 分支后会删除。

文档风格
--------

新增章节
++++++++

每个源文件都会被转换成一个单独的网页。因而，确定文件名时应慎重，一旦确定，尽量不要再改动。
由于 Windows 不区分文件名大小写，故而 :file:`option-B.rst` 和 :file:`option-b.rst`
在 Windows 下会出现冲突。

新增示例
++++++++

示例脚本尽量使用Bash。除非必须，请勿使用 Perl、Python 等。
如果可能，图片尽量扁平（比如横纵比为 2:1），以避免插入图片后左右两边有太多空白。

文档使用 Sphinx 扩展 `sphinx_gmt <https://github.com/GenericMappingTools/sphinx_gmt>`__
自动执行脚本生成图片并将图片插入到文档中，其用法有两种：行内模式和脚本模式。

行内模式，即直接在文档中写绘图代码::

    .. gmtplot::
        :caption: 图片标题
        :width: 80%

        gmt begin map png,pdf
        gmt basemap -JX10c/10c -R0/10/0/10 -Baf
        gmt end show

脚本模式，即将绘图代码写在脚本中::

    .. gmtplot:: /scripts/psmeca_ex1.sh
        :width: 80%

        图片标题


``gmtplot`` 指令有很多选项，常用的包括：

- ``show-code``\ :\ ``true`` 或 ``false`` 表示是否显示代码
- ``width``\ : 图片在网页中的宽度，建议使用百分比表示，比如 ``100%``

注意事项：

- ``master`` 分支中所有脚本均使用现代模式
- 所有脚本至少需要生成 PNG 格式的图片，建议使用 ``png,pdf`` 生成两种格式的图片，分别供
  网页版和 PDF 版使用
- 所有脚本以 ``gmt end show`` 结尾
