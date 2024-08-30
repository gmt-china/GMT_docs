命令帮助
========

:撰写: |周茂|
:最近更新日期: 2023-09-21

----

GMT 模块较多，每个模块均包含若干选项，即使经常使用的用户仍难以记忆全部用法。
GMT 提供了便捷的用法帮助系统，以便用户在使用中随时查阅。

**1. 命令行用法帮助**

用户可在命令行中直接敲击命令以获取模块用法，例如 ::

    $ gmt plot
    gmt plot [core] 6.4.0 [64-bit] - Plot lines, polygons, and symbols in 2-D

    usage: gmt plot [<table>] -J<args> -R<west>/<east>/<south>/<north>[/<zmin>/<zmax>][+r] [-V[q|e|w|t|i|c|d]] ...

    REQUIRED ARGUMENTS:

    <table> is one or more data files (in ASCII, binary, netCDF). If no files are given, standard input is read.

    -J Select map proJection (<scale> in cm/degree, <width> in cm). Modifiers:
       +dh Specifying map height.
     Azimuthal projections set -Rg unless polar aspect or -R<...>+r is set.
     -Ja|A<lon0>/<lat0>[/<hor>]/<scl> (or <radius>/<lat>)|<width> (Lambert Azimuthal Equal-area)

    OPTIONAL ARGUMENTS:

    -V[q|e|w|t|i|c|d]
     Change the verbosity level (currently w). Choose among 7 levels; each level adds more detailed messages:
       e: Error messages only.
       w: Warnings [Default when no -V is given].
       t: Timings (time-intensive operations only).

上述示例中给出了 :doc:`/module/plot` 模块的用法，这里仅截取部分内容以做解释。其中

- 第一行给出模块功能的概述，用户可依此初步判断当前模块是否可实现所需功能
- ``usage`` 行展示了本模块选项的用法，其中

    - 尖括号 ``<>`` 表示其中的内容是必须的，用户在使用中需用相应的信息来替换当前内容
    - 方括号 ``[]`` 表示其中的内容是可选的，用户可根据需求选择是否设置该项
    - 竖线 ``|`` 的含义为“或”，用户可选取由单个或多个 ``|`` 分隔的任意子选项

- ``REQUIRED ARGUMENTS`` 表示下面为当前模块必须选项，通常情况下必须设置，
  但也可能受其他选项影响
- ``OPTIONAL ARGUMENTS`` 表示下述的选项为可选选项，用户可自行判断是否需要设置
- 在每个选项的详细解释中，方括号 ``[]`` 中的内容表示其缺省或默认情况

**2. 命令行快速打开 GMT 官方文档**

GMT 提供了完善的网页文档，若用户通过上述命令行用法仍无法明白如何使用，
可快速打开网页文档查看详细解释及示例，用法详见 :doc:`/module/docs`。

网页文档同样采用与上述命令行相似的语法规则，不同之处为，网页文档中使
斜体而不是 ``<>`` 表示必须替换的选项或参数。

**3. 命令行快速打开中文文档**

GMT 中文社区提供了一个与 :doc:`/module/docs` 类似用法的 bash 脚本
`gmtcn <https://github.com/gmt-china/gmtcn>`__，可
用于在命令行下快速打开中文文档相关界面，经过配置后，用户可如下述方法
使用该脚本::

    $ gmtcn docs plot
    $ gmtcn docs -B
    $ gmtcn docs -JX
    $ gmtcn docs setting
    $ gmtcn docs chinese
