版本迁移
########

.. note::

   这一章仅限于 GMT 老用户以及需要将使用老语法编写的脚本转换为新语法的用户阅读。
   纯粹的 GMT 新用户请跳过这一章以节省时间并避免可能出现的混淆。

GMT 在大版本升级时（如 GMT5 升级为 GMT6），语法及用法上会发生一些变化。
但由于 GMT 会尽可能兼容旧版本的语法，用户往往只需要对旧版本 GMT 语法编写的脚本做少量修改，
即可在新版本 GMT 中运行。

这一章将介绍如何实现：

- 将 GMT4 脚本迁移到 GMT5：:doc:`/migrating/4to5`
- 将 GMT5 脚本迁移到 GMT6：:doc:`/migrating/5to6`
- 将经典模式语法迁移到 GMT6 现代模式语法：:doc:`/migrating/classic2modern`

.. toctree::
   :hidden:
   :maxdepth: 2

   4to5
   5to6
   classic2modern
