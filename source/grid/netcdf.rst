netCDF文件格式
==============

分块与压缩
----------

出于性能的考虑，GMT在输出超过16384个网格单元的网格文件时，会打开分块功能。所谓分块，
即数据不是按照一行一行序列存储的，而是将整个网格分成若干个区块，然后依次存储每个区块的数据。

下图描绘了一个分块的netCDF文件的布局。为了读取数据的一部分（比如左下角的四个蓝色区块），
netCDF只需要读取相应的区块即可，不用先读取整个数据。

.. gmt-plot:: /scripts/GMT_grid_chunking.sh
    :show-code: false
    :caption: 网格分块

由于数据的压缩和解压比磁盘IO要快，因而可以对netCDF数据进行压缩，使得磁盘占用更少，
IO负载更少。netCDF的压缩可以分为若干等级，压缩级别越高，文件越小，读写数据越快，
但压缩/解压越耗时。通常，压缩级别取1到3效果比较好。

GMT参数 :ref:`IO_NC4_CHUNK_SIZE <IO_NC4_CHUNK_SIZE>` 可以控制分块的大小，
:ref:`IO_NC4_DEFLATION_LEVEL <IO_NC4_DEFLATION_LEVEL>` 可以控制压缩等级。
