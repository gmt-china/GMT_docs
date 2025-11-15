:author: 陈箫翰
:date: 2025-08-24
# 绘制等值线与带标注线段进阶示例

本例采用 {doc}`/module/grdcontour` 和 {doc}`/module/plot` 中论述的多个标注位置确定方法和属性设置，绘制了一幅比较复杂的综合性图件。
假设在 Canary Islands 发生了灾难性滑坡， 图件显示了所引发的的海啸的走时(以小时为单位)。
根据海啸走时和海底地形绘制了彩图，对等值线和线条进行了标注。完整的脚本如下：

```{eval-rst}
.. gmtplot:: ex016.sh
    :width: 80%
    :show-code: true
```
