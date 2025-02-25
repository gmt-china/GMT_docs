维护指南
========

读者可以阅读以下维护指南，以便更快、更有效地参与到文档的维护与更新之中。

维护与更新
----------

文档的维护与更新主要包括几个方面：

- 修正错别字、语句不通等
- 修正文档中的错误或不清晰的描述
- 修正 reStructuredText 文件语法错误导致的显示问题
- 调整章节结构，使文档条理更清晰
- 翻译、整理更多模块的文档
- 增加示例与入门教程

可以通过如下几种方式参与文档的维护与更新：

1. 修改文档源码并提交 `Pull Request <https://github.com/gmt-china/GMT_docs/pulls>`__
2. 在 GitHub 上的文档源码仓库下提交 `Issue <https://github.com/gmt-china/GMT_docs/issues>`__
3. 在网页底部评论区留言
4. 在 GitHub 上的文档源码仓库下的 Discussions 上留言（也可以直接点击文档网页左下角的“参与讨论”）
5. 发送相关建议或投稿至 admin@gmt-china.org

分支模型
--------

GitHub 上托管的文档仓库中存在如下长期分支：

- ``master``: 主分支，对应 GMT6 最新版本的文档源码，所有绘图命令均使用现代模式
- ``5.4``: 对应 GMT5 版本的文档，所有绘图命令均使用经典模式 (该分支已不再维护)
- ``gh-pages``: 存放文档网页的分支，自动更新，无需人工修改

其它分支均属于短期分支，在合并到 ``master`` 分支后会删除。

文档风格
--------

文件命名
^^^^^^^^

每个源文件都会被转换成一个单独的网页。因而，确定文件名时应慎重，一旦确定，尽量不要再改动。
由于 Windows 不区分文件名大小写，故而 :file:`option-B.rst` 和 :file:`option-b.rst`
在 Windows 下会出现冲突。我们使用的文件的命名规则是：

- 文件名一律采用小写字母
- 文件名应尽量使用单词全称，避免使用各种形式的简写
- 若文件名中含多个单词，应使用连字符 (hyphen) :kbd:`-` 连接

文件风格
^^^^^^^^

1.  所有教程均采用 `reStructuredText <https://docutils.sourceforge.io/rst.html>`__
    语言编写，可参考 `reStructuredText 备忘单 <https://seismo-learn.org/contributing/restructuredtext/>`__
    学习其常用语法。
2.  reStructuredText 文档的一级标题、二级标题和三级标题，分别用 ``=``、``-`` 和 ``^``
    符号标识
3.  所有 Bash 命令前应加上 Shell 提示符 ``$`` 以表示该命令为 Shell 命令
4.  中文字符与英文字符和数字之间应加上空格，如 ``中文 ABC 中文`` 而非 ``中文ABC中文``，
    ``中文 123 中文`` 而非 ``中文123中文``
5.  标点符号采用全角，如 ``，``、``。``、``：``、``、``、``？`` 等。
    标点符号与中文字符、英文字符以及数字之间不需加空格。
6.  图片应在保证清晰度的前提下尽可能小。可以使用 `squoosh 在线工具 <https://squoosh.app/>`__
    进行压缩。

示例风格
^^^^^^^^

- 示例脚本尽量使用 Bash，非必须请勿使用 Perl、Python 等
- ``master`` 分支中的所有脚本均使用现代模式
- 所有脚本至少需要生成 PNG 格式的图片，建议使用 ``png,pdf`` 生成两种格式的图片，
  别供网页版和 PDF 版使用
- 所有脚本以 ``gmt end show`` 结尾

文档使用 Sphinx 扩展 `sphinx_gmt <https://github.com/GenericMappingTools/sphinx_gmt>`__
提供的 ``gmtplot`` 指令自动执行脚本生成图片，同时将图片插入到文档中。

该指令的常用选项有：

- ``width``\ ： 图片在网页中的宽度（建议使用百分比表示，如 ``100%``\ ）
- ``caption``\ ：图片标题
- ``show-code``\ ：表示是否显示代码（\ ``true`` 或 ``false``\ ）

该指令用法有两种：行内模式和脚本模式。

- 行内模式：直接在文档中写绘图代码
 
  ::

      .. gmtplot::
          :caption: 图片标题
          :width: 80%

          gmt begin map png,pdf
          gmt basemap -JX10c/10c -R0/10/0/10 -Baf
          gmt end show

- 脚本模式：即将绘图代码写在脚本中

  ::

      .. gmtplot:: /scripts/psmeca_ex1.sh
          :width: 80%

          图片标题
