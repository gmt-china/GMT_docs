事件相对台站的震中距方位角分布图
====================================

:示例贡献者: lxrat（作者）、陈箫翰（修订）
:初次发布: 2017-04-11
:最近更新日期: 2021-06-17

----

在以台站为核心的研究中（例如接收函数、S波分裂等），经常需要绘制以台站为中心的地震分布图。
下面的例子展示了地震相对于台站的距离以及方位角分布图的画法：

.. gmtplot::
    :width: 70%
    
    #!/bin/bash
    #!/usr/bin/env bash
    #
    # 事件相对台站的震中距方位角分布图
    #

    # 假定台站位于 105/30 处
    stlo=105
    stla=30
    # 使用-JE投影，其后面的四个参数分别是: 中心经度/中心纬度/最大震中距/图片宽度
    J=E$stlo/$stla/90/10c

    gmt begin map png,pdf
    gmt set FORMAT_GEO_MAP=+D
    gmt coast -J$J -Rg -A10000 -Ggrey
    # 绘制台站位置（三角形）
    echo $stlo $stla | gmt plot -St0.4c -Gblue -Bya180
    # 绘制地震震源位置
    gmt plot -Sa0.4c -Gyellow -W0.1p << EOF
    145 30
    160 40
    60 40
    80 -10
    EOF
    # 绘制30和60度等震中距线
    echo $stlo $stla 6672 | gmt plot -SE- -W1p,red
    echo $stlo $stla 13344 | gmt plot -SE- -W1p,red
    # 在30, 60, 90度处添加文字
    gmt text -D0c/0.3c << EOF
    $stlo 0 30\232
    $stlo -30 60\232
    $stlo -59.9 90\232
    EOF
    gmt end show
