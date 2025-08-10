# -J+proj=spilhaus: Spilhaus World Ocean Map Projection

维基链接：<https://en.wikipedia.org/wiki/Athelstan_Spilhaus>

Spilhaus投影是一种以海洋为主视角的投影，以南极洲为中心进行展开，将世界海洋呈现为一体，适合在海洋学研究领域进行展示洋流的绘图等等。

从 GMT6 开始，GMT 支持使用 PROJ 库来实现坐标和基准面的转换。从 GMT6.6 和 PROJ 9.6.0 版本开始，GMT 实现了对Spilhaus投影的支持。

投影需要的参数如下：

**-J+proj=spilhaus+width=***width*

- *width* 地图宽度

```{eval-rst}
.. gmtplot:: Jspilhaus/spilhaus.sh
    :width: 85%
    :show-code: true
```