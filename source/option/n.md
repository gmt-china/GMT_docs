# -n 选项

**-n** 选项用于控制网格数据重采样过程中的插值算法。其语法为：

> **-n**\[**b**|**c**|**l**|**n**\]\[**+a**\]\[**+b***BC*\]\[**+c**\]\[**+t***threshold*\]

网格插值的四种算法：

- **b** 表示 [B-sphine平滑算法](https://en.wikipedia.org/wiki/B-spline)
- **c** 表示 [bicubic插值算法](https://en.wikipedia.org/wiki/Bicubic_interpolation) （默认插值方式）
- **l** 表示 [bilinear插值算法](https://en.wikipedia.org/wiki/Bilinear_interpolation)
- **n** 表示最近节点的值

其它子选项:

- **+a**：关闭抗混淆（仅在算法支持的前提下有效），默认打开抗混淆选项
- **+b***BC* 设置网格的 {doc}`边界条件 </grid/boundary-condition>`。
  *BC* 可以取 **g**、**p**、**n**，
  分别代表地理边界条件、周期边界条件和自然边界条件。对于后两种边界条件，可以
  进一步加上 **x** 或 **y** 表示边界条件仅对一个方向有效。比如 **-nb+bnxpy**
  表明X方向使用自然边界条件，Y方向使用周期边界条件
- **+c**：假设原网格的Z值范围为 *zmin* 到 *zmax*，插值后的Z值范围可能会超过这一范围，
  使用 **+c** 则将超过 *zmin* 和 *zmax* 的部分裁剪掉，以保证插值后的网格数据的范围
  不超过输入网格数据的范围
- **+t***threshold* 用于控制值为 NaN 的网格点在插值时的影响范围 [默认值为 0.5]。
  *threshold* 设置为 1.0 时，表示插值中的所有节点（4 或 16 个）都要为非 NaN；
  0.5 表示距非 NaN 值的大约一半处进行插值；0.1 表示距非 NaN 值的大约 90% 处进行插值；
  依此类推。
