.. index:: ! gmt-config

gmt-config
==========

:官方文档: 无
:说明: 返回 GMT 动态函数库的基本信息

``gmt-config`` 是位于 GMT 的 bin 目录下的一个 bash 脚本，主要用于返回 GMT
动态函数库相关的信息，以供其他程序使用。

其提供了如下选项::

    $ gmt-config

    --help        显示此帮助信息并退出
    --bits        库文件是32位还是64位
    --cflags      GMT 的 CFLAGS: ``-I/opt/GMT/include/gmt``
    --datadir     GMT 数据目录，默认为空
    --dcw         DCW 数据的位置（可能为空）
    --dep-libs    GMT 函数库依赖的其他函数库
    --gshhg       GSHHG 数据的位置
    --has-fftw    编译过程中是否使用了 FFTW
    --has-gdal    编译过程中是否使用了 GDAL
    --has-pcre    编译过程中是否使用了 PCRE
    --has-lapack  编译过程中是否使用了 LAPACK
    --has-openmp  编译过程中是否开启了 OpenMP 支持
    --includedir  include 目录所在位置
    --libs        链接GMT函数库所需的信息 ``-L/opt/GMT/lib64 -lgmt``
    --plugindir   GMT 插件目录
    --prefix      GMT 安装目录
    --version     GMT 版本
