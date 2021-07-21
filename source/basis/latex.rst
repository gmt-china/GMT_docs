LaTeX 表达式
============

GMT 自 6.2 开始支持在文本字符串中嵌入 LaTeX 表达式，
这些文本字符串包括使用 :doc:`/option/B`\ 在标题、子标题或标签中指定的字符串，\
也包括通过 :doc:`/module/text` 模块添加的单行文本。
GMT 中 LaTeX 表达式可以用两种不同的写法表示:

1. 使用一对 @[，例如："Plotting @[\Delta \sigma_{xx}^2@["
2. 使用 <math> </math> ，例如："Plotting <math>\Delta \sigma_{xx}^2</math>"

.. note::

    若要在 GMT 6.2 以前的版本使用 LaTeX，请参考 https://blog.seisman.info/gmt-latex/

下面展示了一个使用 LaTeX 表达式的例子

.. gmtplot:: GMT_latex.sh
    :width: 80%
    :show-code: true

    分别在轴标签、题目以及 text 模块中使用 LaTeX 表达式的实例

GMT 字体和 LaTeX
----------------

LaTeX 是一个庞大且复杂的排版系统，有许多可选包，用户安装的 LaTeX 需包括所有 GMT 必须的包。
通过包管理器安装 LaTeX 的方法请见 
`wiki <https://github.com/GenericMappingTools/gmt/wiki/Install-LaTeX-for-GMT-LaTeX-Integration>`_ 。
其中 GMT 必须的包和字体包括：

- 必需包：fontenc 和 inputenc
- 必需字体：helvet，mathptmx，courier，symbol，avantgar，bookman，newcent，mathpazo，zapfchan 和 zapfding

如果从 LaTeX 表达式到 EPS 文件的转换过程失败，请在终端中手动运行转换脚本以确定可能缺少哪些包或者字体。
上述字体列表中的字体均可以匹配 GMT 中的字体。
因此，如果用户通过 :term:`FONT_TITLE` 修改了标题默认的字体，
GMT 将在后台生成的 LaTeX 脚本中把该字体设置为默认字体。
这种设置可以确保标题最终渲染的字体和用户设置的字体一致。

技术细节
---------

GMT 中显示 LaTeX 表达式的原理为：\
如果 GMT 在文本字符串中发现特殊标识（即 @[ 对或 <math> </math> 对），
GMT 将使用 latex 和 dvips 命令（需提前安装 LaTeX 环境）把整行转换为 EPS 文件。
然后将该 EPS 文件放置在对应的位置。

这里通过一个实例来帮助用户排查 LaTeX 安装中可能存在的问题。假设用户使用 basemap 制作的图的标题为
-B+t"Use @[\Delta g = 2\pi\rho Gh@[" 。
GMT 会为该 LaTeX 表达式创建一个临时目录，其中包含一个名为 :file:`gmt_eq.tex` 的文件::

    \documentclass{article}
    \usepackage[T1]{fontenc} \usepackage[utf8]{inputenc}
    \usepackage{helvet}
    \begin{document}
    \thispagestyle{empty}
    \fontfamily{phv}\selectfont
    Use $\Delta g = 2\pi\rho Gh$
    \end{document}

由于 :term:`FONT_TITLE` 设置为 Helvetica，LaTeX 文件将默认字体修改为
Helvetica（ *helvet* 包, 代码为 *phv* ），该 tex 文件会被转换为 DVI 文件::

    latex -interaction=nonstopmode gmt_eq.tex > /dev/null

接着，进一步将结果转换为 EPS 文件::

    dvips -q -E gmt_eq.dvi -o equation.eps

这两个命令通过 :file:`gmt_eq.sh` 脚本（在 windows 下为 :file:`gmt_eq.bat`\ ）执行。
如果命令成功执行，GMT 将读取 EPS 文件 :file:`equation.eps` 并放置在标题的位置。
如果脚本由于某些原因执行失败，GMT 将报错并指导用户在临时目录中进行进一步排查。
此时，用户可以运行 ``latex`` 命令（但要去除重定向 ``> /dev/null``\ ）来查看报错信息。
通常情况下，报错信息会显示问题出现的原因，即缺少某种字体或其他信息。
如果用户不能独立解决报错，请在 `GMT 官方 GitHub <https://github.com/GenericMappingTools/gmt/issues>`_
上提 issue 并提供 LaTeX 脚本和报错信息。
