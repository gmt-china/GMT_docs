:author: 何星辰, 周茂
:date: 2025-10-21

.. index:: ! batch
.. program:: batch
    
batch
=====

:官方文档: :doc:`gmt:batch`  
:简介: 自动化批处理作业处理

**batch** 模块可以使用单个主脚本生成 GMT 处理作业，并针对所有作业重复执行，
同时利用特定作业变量进行一些变化。该模块简化（并隐藏）了通常需要设置完整处理序列的大部分步骤。
用户可以专注于编写主处理脚本，并让作业的并行执行自动完成。
我们可以通过可选的 *preflight* 脚本设置所需数据集并进行一次性计算。
完成后，我们可以通过 *postflight* 脚本可选地汇总数据输出并生成摘要图或类似操作。

.. note::

    该模块适用于对脚本语言循环等用法不熟悉的用户，更熟练的用户可自行使用脚本语言代替本模块以实现更高自由度。

语法
----

.. list-table::
    :stub-columns: 1

    * - 模块
      - **gmt batch**
    * - 输入数据
      - *mainscript* 
    * - 必须选项
      - :option:`-N`  :option:`-N`
    * - 可选选项
      - :option:`-D`  :option:`-F`  :option:`-I`  :option:`-M`  :option:`-Q`  :option:`-Sb`  :option:`-Sf`  :option:`-W`  :option:`-Z`  
    * - 可选的通用标准选项
      - :doc:`GMT 标准选项列表 </option/index>`
    * - :doc:`配置参数临时设置 </conf/overview>`
      - **--PAR**\ =\ *value*

输入数据
--------

*mainscript*
    独立的 GMT 现代模式处理脚本的名称，用于执行参数相关的计算。
    脚本可以访问作业变量，如作业编号和下面定义的其他变量，
    并且可以使用 Bourne shell (.sh)、Bourne again shell (.bash)、
    C shell (.csh) 或 DOS batch (.bat) 编写。脚本语言由文件扩展名推断，
    并且我们使用相同语言构建隐藏的批处理脚本。可以访问的参数将在下文讨论。

必选选项
--------

.. option:: -N

**-N**\ *prefix*
    决定批处理文件产品的前缀以及执行后可找到中间作业产品的最终子目录。

.. option:: -T

**-T**\ *njobs*\|\ *min*/*max*/*inc*\ [**+n**]\|\ *timefile*\ [**+p**\ *width*]\ [**+s**\ *first*]\ [**+w**\ [*str*]\|\ **W**]
    指定要生成的作业数量，创建从 *min* 到 *max* 以 *inc* 为间隔的一列数据集，
    或提供包含参数集的文件，每行对应一个作业。列中的值将作为命名变量
    **BATCH_COL0**， **BATCH_COL1** 等可用于 *mainscript*，
    任何尾随文本可通过 **BATCH_TEXT** 访问。记录数量等于作业数量。
    注意，如果只给出 *njobs*，则仅可使用 **BATCH_JOB**，因为没有数据文件。
    有关数组创建的详细信息，请参见 `生成一维数组`_。还提供几个修饰符：
    - **+n** 指示 *inc* 为所需作业数而非增量。
    - **+p** 可设置作业编号格式的宽度，例如 name_000010.grd 宽度为 6。默认情况下自动设置宽度，但如果通过 **+s** 在多台计算机间分割作业，则必须保证所有帧名称宽度一致。
    - **+s** 从 *first* 而非 0 开始编号输出作业。注意：所有作业仍包含，修饰符仅影响输出编号。
    - **+w** 将尾随文本拆分为单词，通过变量 **BATCH_WORD0**、**BATCH_WORD1** 等访问。默认以制表符或空格分隔，可附加 *str* 指定其他分隔符。仅使用制表符可使用 **+W**。


可选选项
--------

.. option:: -D

**-D**
    如果主脚本没有生成使用前缀 **BATCH_NAME** 的产品，
    或者主脚本将直接处理这些产品文件位置，请选择此选项。

.. option:: -F

**-F**\ *template*
    不使用 **BATCH_NAME** 前缀的单一流水号构建产品文件名，
    而是使用 `C格式 <https://en.wikipedia.org/wiki/Printf_format_string>`_ *template* 
    根据 *timefile* 数据列创建唯一名称。限制如下：
    (1) 如果 *timefile* 有尾随文本，
    可用单个 %s 在模板最后格式化；如果无 %s，则尾随文本不会使用。
    (2) 前 N 个格式语句用于转换 *timefile* 的前 N 列；不能跳过列或指定列顺序
    （可用 |SYN_OPT-i| 重排输入顺序）。
    (3) 可使用最多五个数值语句（前提 *timefile* 有足够列）。
    例如 **-F**\ my_data_%05.2lf_%07.0lf_%s 使用 *timefile* 的前两列和尾随文本生成唯一前缀。
    注意：GMT 数据集内部使用双精度变量，即使列为整数也应使用浮点格式。
    若格式语句和尾随文本包含空格或制表符，将自动替换为下划线。

.. option:: -I

**-I**\ *includefile*
    将 *includefile* 的内容插入 batch_init.sh 脚本，
    供所有批处理脚本访问。通常用于添加主脚本和可选 :option:`-S` 脚本可依赖的常量变量。

.. option:: -M

**-M**\ [*job*]
    不生成和启动完整处理序列，仅选择一个主作业 [0] 测试。
    主作业将在 *workdir* 中运行，其产品会生成。任何 *preflight* 脚本会在主作业前运行，
    但 *postflight* 脚本不会执行（但会创建）。

.. option:: -Q

**-Q**\ [**s**]
    调试：保留所有创建的文件和目录以供检查。或附加 **s** 仅生成批处理脚本但不执行。
    唯一例外是可选 *preflight* 脚本（ :option:`-Sb` ），始终执行，
    因为可能产生构建主批处理脚本所需的数据。

.. option:: -Sb

**-Sb**\ *preflight*
    可选 GMT 现代模式 *preflight* 脚本（与 *mainscript* 同语言），
    可下载或复制数据文件，或创建 *mainscript* 所需的文件（如 *timefile*）。
    总是在主批处理序列之前执行。

.. option:: -Sf

**-Sf**\ *postflight*
    可选 *postflight* 脚本（与 *mainscript* 同语言），可在所有作业完成后执行最终处理，
    如汇总产品、生成报告或图示。注意：*postflight* 脚本不必为 GMT 脚本。

.. option:: -W

**-W**\ [*dir*]
    默认情况下，所有临时文件和作业产品创建在 :option:`-N` 设置的 *prefix* 子目录中。
    可通过 *dir* 覆盖路径。若未提供路径，将在系统临时目录中创建名为 *prefix* 的工作目录。
    工作目录的好处是避免 DropBox 或 TimeMachine 的无限同步，或主目录空间不足问题。
    产品文件仍放置在 *prefix* 目录中。除非 :option:`-Q` 指定调试，否则工作目录在完成后会被删除。

.. option:: -Z

**-Z**
    完成后删除 *mainscript* 以及通过 :option:`-I` 和 :option:`-S` 提供的所有输入脚本。不兼容 :option:`-Q` 。

参数
----

多个参数会自动分配，可用于 *mainscript* 和可选 *preflight*/*postflight* 脚本。
参数分为常量和随作业编号变化的变量。常量对所有脚本可用：**BATCH_PREFIX**：
批处理作业通用前缀（由 :option:`-N` 设置）；**BATCH_NJOBS**：作业总数（由 :option:`-T` 给出或推断）。
若使用 :option:`-I` ，其中列出的静态参数也可用于所有脚本。此外，*mainscript* 可访问随作业编号变化的参数：
**BATCH_JOB**：当前作业编号（整数，例如 136）， **BATCH_ITEM**：
根据宽度格式化的作业编号字符串（例如 000136），**BATCH_NAME**：
当前作业唯一前缀（即 *prefix*\ _\ **BATCH_ITEM**）。若提供 *timefile*，
则 **BATCH_COL0**、**BATCH_COL1** 等变量分别对应列。
尾随文本可通过 **BATCH_TEXT** 访问，若启用 **+w** 分词，
则还可通过 **BATCH_WORD0**、 **BATCH_WORD1** 等访问。注意：
处理脚本生成的产品应使用 **BATCH_NAME** 作为前缀，
以便自动移动到起始目录（除非使用 :option:`-D` ）。使用 :option:`-F` 可基于 :option:`-T` 输入参数生成更灵活的产品名称。

数据文件
--------

批处理脚本可访问 **batch** 启动时存在的起始目录中的任何文件，
以及 *mainscript* 或通过 :option:`-S` 设置的可选脚本生成的新文件。
无需指定路径。其他文件可能需要完整路径，除非其目录已包含在 :term:`DIR_DATA` 设置中。

自定义 gmt.conf 文件
--------------------

如果在运行 **batch** 前主脚本所在目录有 gmt.conf 文件，
则该文件将被所有创建和执行的脚本共享，除非脚本在启动现代模式时使用 :option:`-C` 覆盖。
修改 GMT 默认值的推荐方式是通过 :doc:`set` 在输入脚本中调用。
注意：每个脚本独立运行（现代模式），因此通过 *preflight* 创建 gmt.conf 文件无法被其他脚本使用。

构建主脚本
----------

如果调用间没有变化，批处理序列没有意义。为了实现变化， *mainscript* 需要访问不同的数据集、
数据子集，或作业参数不同，或以上组合。策略如下：

- 通过 :option:`-T` 提供的 *timefile* 列出特定数据文件， *mainscript* 
  使用 **BATCH_TEXT** 或 **BATCH_WORD?** 访问特定作业文件名。

- 对于 3D 网格（或 2D 网格堆叠），沿垂直于切片的轴（时间或深度）插值，
  可使用 :doc:`grdinterpolate` 获取临时切片网格进行处理。

- 可使用 :doc:`math` 或 :doc:`grdmath` 动态生成数据，
  或每个作业稍作不同处理（使用 *timefile* 参数）。

- 利用 *timefile* 传递任何所需参数。

技术细节
--------

**batch** 模块会创建多个隐藏脚本：

- *batch_init*  
  初始化变量并包含可选 *includefile* 内容。
- *batch_preflight* （可选，来自 :option:`-Sb` ）  
  准备所需数据文件。
- *batch_postflight* （可选，来自 :option:`-Sf` ）  
  在所有作业完成后处理文件。
- *batch_job*  
  接受作业编号并处理数据。
- *batch_cleanup*  
  结束时删除临时文件。

每个作业有单独的 *batch_params_######* 脚本，用于提供作业特定变量。

*preflight* 和 *postflight* 可访问 *batch_init* 信息，  
*batch_job* 还可访问作业特定参数文件。

使用 :option:`-Q` 可仅生成这些脚本以供检查。

注意：*mainscript* 会为每个作业复制以上所需文件，多个作业可同时在所有可用核心上运行。  
多线程 GMT 模块将限制为单核心调用。  
每个作业都会确保创建唯一文件，以便 **batch** 判断作业完成并启动下一个。


Shell 脚本局限
--------------

由于无法控制 shell（如 bash 或 csh）在两个进程间管道的实现（通常涉及子 shell），
建议避免在主脚本中使用 GMT 模块间管道（例如 `gmt blockmean ... | gmt surface ...`）。
批处理同时运行多个实例时，子 shell 可能导致 GMT 历史文件损坏，出现错误信息。
建议将管道拆分为使用临时文件的两步。
非 GMT 模块与 GMT 模块间的管道不受影响（如 `echo ... | gmt convert ...`）。

使用该模块建议
--------------

编写批处理作业相对简单，但需以变量为思路。先编写单个 *mainscript*，确定哪些随作业编号变化，
创建变量。如果只需作业编号，可直接使用自动生成变量。
否则，需制作 :option:`-T` 文件，每行对应一个作业，列包含所需值。
固定变量可通过 :option:`-I` 指向 *includefile* 赋值。测试脚本时，
使用 :option:`-Q`  :option:`-M` 确保主作业结果正确，调整变量和选项，最终移除 :option:`-Q` 。建议初期使用小批次作业快速验证。

示例
-----

提取几内亚湾的 2x2 弧分分辨率地球 DEM 子集，并计算高斯滤波高通网格，
滤波宽度从 10 到 200 km，步长 10 km。所有网格完成后，计算标准差。示例操作::

    cat << EOF > pre.sh
    gmt begin
        gmt math -o0 -T10/200/10 T = widths.txt
        gmt grdcut -R-10/20/-10/20 @earth_relief_02m -Gdata.grd
    gmt end
    EOF
    cat << 'EOF' > main.sh
    gmt begin
        gmt grdfilter data.grd -Fg${BATCH_COL0}+h -G${BATCH_NAME}.grd -D2
    gmt end
    EOF
    cat << 'EOF' > post.sh
    gmt begin ${BATCH_PREFIX} pdf
        gmt grdmath ${BATCH_PREFIX}_*.grd -S STD = ${BATCH_PREFIX}_std.grd
        gmt grdimage ${BATCH_PREFIX}_std.grd -B -B+t"STD of Gaussians residuals" -Chot
        gmt coast -Wthin,white
    gmt end show
    EOF
    gmt batch main.sh -Sbpre.sh -Sfpost.sh -Twidths.txt -Nfilter -V -Z

当然，变量的使用语法会根据脚本语言而有所不同。在这里，
我们实际上是动态生成 pre.sh、main.sh 和 post.sh 脚本，
因此需要对任何变量进行转义（因为它们以美元符号开头，需要按原样书写）。
通过将 EOF 用引号包围，重定向不会替换变量，而是将其保留为原文文本。
执行结束后，我们会得到 20 个网格文件（例如 filter_07.grd），
以及通过堆叠所有单独脚本并计算标准差生成的 filter_std.grd 文件。
完成这些操作所需的信息对用户是隐藏的；实际执行的批处理脚本是基于用户提供的 main.sh 脚本生成的，
而 **batch** 提供了额外的机制。**batch** 模块会自动管理所有作业的并行执行循环，
使用所有可用核心，并在前一个作业完成后启动新的作业。

另一个示例，我们获取所有欧洲国家的列表，并为每个国家制作一个简单的海岸线图，
将国家名称放在标题中，将两字符 ISO 代码放在左上角，
然后在 postflight 中将所有单独的 PDF 合并为一个 PDF 文件，并删除单独的文件。
在这里，我们将 EOF 标签用引号包围，以防止未转义的变量被解释::

    cat << EOF > pre.sh
    gmt begin
        gmt coast -E=EU+l > countries.txt
    gmt end
    EOF
    cat << 'EOF' > main.sh
    gmt begin ${BATCH_NAME} pdf
        gmt coast -R${BATCH_WORD0}+r2 -JQ10c -Glightgray -Slightblue -B -B+t"${BATCH_WORD1}" -E${BATCH_WORD0}+gred+p0.5p
        echo ${BATCH_WORD0} | gmt text -F+f16p+jTL+cTL -Gwhite -W1p
    gmt end
    EOF
    cat << 'EOF' > post.sh
    gmt psconvert -TF -F${BATCH_PREFIX} ${BATCH_PREFIX}_*.pdf
    rm -f ${BATCH_PREFIX}_*.pdf
    EOF
    gmt batch main.sh -Sbpre.sh -Sfpost.sh -Tcountries.txt+w"\t" -Ncountries -V -W -Z

macOS 问题
----------

默认同时打开的文件数在 macOS 上相对较小，执行大量作业时可能出现 "Too many open files" 错误。可参考
`链接 <https://superuser.com/questions/433746/is-there-a-fix-for-the-too-many-open-files-in-system-error-on-os-x-10-7-1>`_ 解决。

相关模块
--------

:doc:`gmt`,
:doc:`math`,
:doc:`grdinterpolate`,
:doc:`grdmath`
