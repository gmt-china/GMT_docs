---
title: 绘制GPS速度场
date: 2017-09-07
type: post
authors:
    - 李黎明
images:
    - gps.png
commands:
    - psvelo
---

本示例展示了如何利用psvelo模块绘制GPS速度场。

示例中所使用的GPS数据来自于 [Zhao et al., Geod. Geodyn., 2015](https://doi.org/10.1016/j.geog.2014.12.006)
的补充材料。

本示例仅用于演示，不保证数据的完整性与可靠性。需要使用相关数据的用户请自行
到文章主页下载相关数据。

{{% alert info %}}
数据下载：
- [gps_campagin.txt](/example/ex015/gps_campagin.txt): Velocities of campagin stations with respective to EURASIA plate from 1999-2014
- [gps_continuous.txt](/example/ex015/gps_continuous.txt): Velocities of continuous stations with respective to EURASIA plate from 1999-2014
{{% /alert %}}

{{< gmt-code "gps" >}}

{{< figure src="/example/ex015/gps.png" title="GPS速度场" >}}
