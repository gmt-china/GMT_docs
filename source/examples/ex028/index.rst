GMT制作GIF动画
====================

:示例贡献者: 杨磊（作者）、刘珠妹（修订）、陈箫翰（修订）
:初次发布: 2021-05-12
:最近更新日期: 2021-05-27
:原文链接: http://assz0a.coding-pages.com/2020/06/07/anni/

----

本示例展示如何使用 GMT 制作 GIF 动画。这里以 GNSS 浮标观测的海面波动为例，
希望展示波浪的时间变化规律。动画设置每一帧显示一个小时的波浪功率谱图像，
不同帧使用不同的颜色表达。示例数据下载 :download:`gnss_b1_hlf_allppk.txt`\ 。

请注意，GMT 的动画功能需要另外安装 GraphicsMagick 组件。由于这个组件是非必须可选安装项目，
建议参阅 GMT 安装指南的相关章节，确认本机是否已经安装。

制作动画有两种方法，一种是利用 Bash 脚本语言的 for 循环，首先先绘制出每一帧的图像，
然后再利用 GraphicsMagick 合成为 GIF 动画：

.. literalinclude:: ex028_GraphicsMagick.sh

另一种则是利用 GMT 的 ``movie`` 模块，语法更为简洁：

.. literalinclude:: ex028_movie.sh

.. image:: https://user-images.githubusercontent.com/26203721/119760695-68cd3800-bee5-11eb-846e-e7a544d263b0.gif
    :width: 80%
    :align: center