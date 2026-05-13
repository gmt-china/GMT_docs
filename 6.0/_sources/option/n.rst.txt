-n 选项
=======

**-n** 选项用于控制网格数据重采样过程中的插值算法。其语法为：

    **-n**\ [**b**\|\ **c**\|\ **l**\|\ **n**][**+a**][**+b**\ *BC*][**+c**][**+t**\ *threshold*]

网格插值的四种算法：

- **b** 表示B-sphine平滑算法
- **c** 表示使用bicubic插值算法（默认值）
- **l** 表示bilinear插值算法
- **n**  表示nearest-neighbor值

其它子选项:

- **+a**\ ：关闭抗混淆（仅在算法支持的前提下有效），默认打开抗混淆选项
- **+b**\ *BC* 设置网格的 :doc:`边界条件 </grid/boundary-condition>`\ 。
  *BC* 可以取 **g**\ 、\ **p**\ 、\ **n**\ ，
  分别代表地理边界条件、周期边界条件和自然边界条件。对于后两种边界条件，可以
  进一步加上 **x** 或 **y** 表示边界条件仅对一个方向有效。比如 **-nb+bnxpy**
  表明X方向使用自然边界条件，Y方向使用周期边界条件
- **+c**\ ：假设原网格的Z值范围为 *zmin* 到 *zmax*\ ，插值后的网格范围可能为超过这一范围，
  使用 **+c** 则将超过 *zmin* 和 *zmax* 的部分裁剪掉，以保证插值后的网格数据的范围
  不超过输入网格数据的范围
- **+t**\ *threshold* 用于控制NaN网格点的插值行为 [默认值为0.5]
  A *threshold* of 1.0 requires all (4 or 16) nodes involved in
  interpolation to be non-NaN. 0.5 will interpolate about half way
  from a non-NaN value; 0.1 will go about 90% of the way, etc.
