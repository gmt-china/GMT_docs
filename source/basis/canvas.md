---
author: 田冬冬
date: 2024-07-13
---

# 画布

要画一张图，首先需要准备一个画布。GMT 默认的画布是一个 PDF 文件。

## 图片格式

GMT 支持多种矢量图片格式和位图图片格式：

- 矢量图片格式包括 PDF [**推荐**]、PS 和 EPS 格式
- 位图图片格式包括 PNG [**推荐**]、JPG [**推荐**]、BMP、PPM 和 TIFF 格式

在使用 GMT 绘图时，默认会生成 PDF 格式的图片，且会自动去除图片四周的白边。例如，下面的示例
使用 {doc}`/module/basemap` 模块绘制了底图，执行该脚本会生成名为 {file}`figname.pdf` 的
图片文件:

```
gmt begin figname
    gmt basemap -R0/10/0/10 -JX10c -Baf
gmt end show
```

可以显式指定生成其他格式的图片。例如，下面的示例会生成 PNG 格式的图片:

```
gmt begin figname png
    gmt basemap -R0/10/0/10 -JX10c -Baf
gmt end show
```

也可以同时指定生成多种图片格式，多种图片格式之间用逗号分隔开。例如，下面的示例指定同时生成
PDF 和 PNG 格式的图片:

```
gmt begin figname
    gmt basemap -R0/10/0/10 -JX10c -Baf
gmt end show
```

:::{tip}
如无特殊需求，不建议使用 PS 图片格式。PS 图片格式具有如下缺点（在后面会提到）：

1. 不支持透明色
2. 默认画布大小为 A4，而其它格式默认画布大小均为 11.6 米x11.6 米（允许的最大尺寸）
3. PS 图片格式不支持裁剪白边，而其它图片格式均支持自动裁剪白边
4. PS 阅读器只有一两款，不如 PDF 或其它图片格式选择性多
:::

## 画布白边

默认情况下，GMT 会对生成的图片进行裁剪以去除四周的白边。如果想要在图片周围保留部分白边，
可以在指定图片格式后额外使用 **I+m***margins* 参数，其中 *margins* 可以取：

- 一个数，表示图片四周有相同的白边区域，如 `I+m0.5c`
- 两个数字，表示图片 X 方向和 Y 方向有不同的白边边距，如 `I+m0.5c/1c`
- 四个数字，表示图片的左右下上四个方向有不同的白边边距，如 `I+m0.5c/0.25c/1.0c/1.5c`

下面的示例在图片四周分别加上了 0.5 厘米的白边区域:

```
gmt begin figname pdf I+m0.5c
    gmt basemap -R0/10/0/10 -JX10c -Baf
gmt end show
```

## 画布大小

GMT 中默认使用宽 11.6 米、高 11.6 米的画布，在最终生成图片文件时会自动将未使用的
白色区域裁减掉，因而用户无需关心画布大小。若需要生成特定尺寸的图片，而不裁剪周边的
白色区域，可以修改 GMT 参数 {term}`PS_MEDIA` 来指定纸张尺寸:

```
gmt begin figname
    gmt set PS_MEDIA A4
    gmt basemap -R0/10/0/10 -JX10c -Baf
gmt end show
```

PS 图片格式是一个例外。若选择 PS 作为图片格式，则默认画布大小为 A4 纸大小。
当用户需要更大的画布时，则必须修改 GMT 参数 {term}`PS_MEDIA` 来修改画布尺寸。

## 画布颜色

默认的画布颜色为白色，可以通过修改 GMT 参数 {term}`PS_PAGE_COLOR` 来修改画布颜色:

```
gmt begin figname
    gmt set PS_PAGE_COLOR lightred
    gmt basemap -R0/10/0/10 -JX10c -Baf
gmt end show
```

## 绘图原点

GMT 在绘图时，默认的绘图原点（即底图边框左下角）位于画布（11.6 米宽、11.6 米高）的
左下角 (40 inch, 40 inch) （约 100 cm, 100 cm） 处（下图中红色圆圈）。因而绘图时，如果需要移动绘图原点，
只能向右和向上移动，而不能向左或向下移动。向左或向下移动绘图原点超过 100 厘米，
均可能使得部分图件超过画布左边界或下边界，导致图件被部分截断。

```{eval-rst}
.. gmtplot:: canvas_plot_origin.sh
   :show-code: false
   :width: 85%
   :align: center

   GMT 绘图原点（红色圆圈）相对于画布的位置
```
