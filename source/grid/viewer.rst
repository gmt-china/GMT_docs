查看 netCDF 文件
================

使用 NetCDF 库自带的 ``ncdump`` 命令可以很方便地查看 NetCDF 文件内容。
由于 NetCDF 库为 GMT 必需依赖库，因此安装好 GMT 后，通常已成功安装
该库及 ncdump 等命令，如果无法直接执行该命令，可尝试通过添加环境
变量解决。

此外，某些带图形界面的软件也可以直接用于查看 netCDF 文件的内容，甚至
做简单图示：

- `ncview <https://cirrus.ucsd.edu/~pierce/software/ncview/index.html>`__
- `Panoply <http://www.giss.nasa.gov/tools/panoply/>`__

更多相关工具，见 `netCDF网站上的列表 <http://www.unidata.ucar.edu/software/netcdf/software.html>`__。

.. note::

   尽管大多数程序都可以读取 netCDF 文件，但某些不支持 netCDF4 格式。
