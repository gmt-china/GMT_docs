.. index:: ! gmt-config

gmt-config
==========

**gmt-config** 是GMT 的 bin 目录下的一个 bash 脚本，主要用于返回 GMT
编译安装过程中的相关信息，以供其他开发者使用。

语法
----

**gmt-config** [ *options* ]

可选选项
--------

**--help**
    显示此帮助信息并退出

**--all**
    显示全部选项的值

**--bits**
    库文件是32位还是64位

**--cc**
    编译过程中使用的C编译器

**--cflags**
    C预处理器和编译器的CFLAGS，例如 ``-I/opt/GMT/include/gmt``

**--datadir**
    GMT 数据目录，默认为空

**--dataserver**
    GMT数据服务器网址

**--dcw**
    DCW 数据的位置（可能为空）

**--dep-libs**
    GMT 函数库依赖的其它函数库

**--gshhg**
    GSHHG 数据的位置

**--has-fftw**
    编译过程中是否链接了 FFTW

**--has-gdal**
    编译过程中是否链接了 GDAL

**--has-pcre**
    编译过程中是否链接了 PCRE

**--has-lapack**
    编译过程中是否链接了 LAPACK

**--has-openmp**
    编译过程中是否开启了 OpenMP 支持

**--includedir**
    include 目录所在位置

**--libdir**
    library 目录所在位置

**--libs**
    链接GMT函数库所需的信息，例如 ``-L/opt/GMT/lib64 -lgmt``

**--plugindir**
    GMT 插件目录

**--prefix**
    GMT 安装目录

**--version**
    GMT 版本
