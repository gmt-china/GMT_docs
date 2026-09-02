---
author: 周茂
date: 2024-11-18
---

# 主题

用户在多次使用 GMT 的过程中，可能会使用同样的配置参数以使所有图件的风格一致。
手动复制配置参数仍稍显麻烦，GMT 提供了主题这一功能可在一定程度简化上述操作。

GMT 内置了 3 个主题，分别为：**classic**，**modern**，以及**minimal**。
**classic** 主题为经典模式的默认主题，**modern** 主题为现代模式的默认主题。
用户可创建并使用自己的主题，将其放置在 GMT 用户主题目录下（通常为 `~/.gmt/themes`），
并将主题命名为 *theme.conf*，*theme* 可以为任何有效字符串。
主题文件中可设置任何用户需要设置的参数。使用 {term}`GMT_THEME` 参数可设置使用
GMT 内置或用户自己的主题。下面列表中显示了上述三个内置主题的默认设置。

| 参数                              | Classic             | Modern                    | Minimal                    |
|-----------------------------------|---------------------|---------------------------|----------------------------|
| {term}`FONT_ANNOT_PRIMARY`        | 12p,Helvetica,black | auto,Helvetica,black      | auto,AvantGarde-Book,black |
| {term}`FONT_ANNOT_SECONDARY`      | 14p,Helvetica,black | auto,Helvetica,black      | auto,AvantGarde-Book,black |
| {term}`FONT_HEADING`              | 32p,Helvetica,black | auto,Helvetica-Bold,black | auto,AvantGarde-Book,black |
| {term}`FONT_LABEL`                | 16p,Helvetica,black | auto,Helvetica,black      | auto,AvantGarde-Book,black |
| {term}`FONT_SUBTITLE`             | 18p,Helvetica,black | auto,Helvetica-Bold,black | auto,AvantGarde-Book,black |
| {term}`FONT_TAG`                  | 20p,Helvetica,black | auto,Helvetica,black      | auto,AvantGarde-Book,black |
| {term}`FONT_TITLE`                | 24p,Helvetica,black | auto,Helvetica-Bold,black | auto,AvantGarde-Book,black |
| {term}`FORMAT_GEO_MAP`            | ddd:mm:ss           | ddd:mm:ssF                | ddd:mm:ss                  |
| {term}`MAP_ANNOT_MIN_SPACING`     | 0p                  | auto                      | auto                       |
| {term}`MAP_ANNOT_OFFSET_PRIMARY`  | 5p                  | auto                      | auto                       |
| {term}`MAP_ANNOT_OFFSET_SECONDARY`| 5p                  | auto                      | auto                       |
| {term}`MAP_EMBELLISHMENT_MODE`    | manual              | auto                      | auto                       |
| {term}`MAP_FRAME_AXES`            | WESNZ               | auto                      | auto                       |
| {term}`MAP_FRAME_PEN`             | thicker,black       | auto                      | auto                       |
| {term}`MAP_FRAME_TYPE`            | fancy               | fancy                     | plain                      |
| {term}`MAP_FRAME_WIDTH`           | 5p                  | auto                      | n/a                        |
| {term}`MAP_GRID_PEN_PRIMARY`      | default,black       | auto                      | thinner,lightgrey          |
| {term}`MAP_GRID_PEN_SECONDARY`    | thinner,black       | auto                      | thinnest,lightgrey         |
| {term}`MAP_HEADING_OFFSET`        | 18p                 | auto                      | auto                       |
| {term}`MAP_LABEL_OFFSET`          | 8p                  | auto                      | auto                       |
| {term}`MAP_POLAR_CAP`             | 85/90               | auto                      | auto                       |
| {term}`MAP_TICK_LENGTH_PRIMARY`   | 5p/2.5p             | auto                      | auto                       |
| {term}`MAP_TICK_LENGTH_SECONDARY` | 15p/3.75p           | auto                      | auto                       |
| {term}`MAP_TICK_PEN_PRIMARY`      | default,black       | auto                      | auto                       |
| {term}`MAP_TICK_PEN_SECONDARY`    | thinner,black       | auto                      | auto                       |
| {term}`MAP_TITLE_OFFSET`          | 14p                 | auto                      | auto                       |
| {term}`MAP_VECTOR_SHAPE`          | 0                   | 0.5                       | 0.5                        |
