网格文件
########

GMT 可以读取、处理并绘制 2D 网格数据。通常，2D 网格文件的 X 方向代表经度、Y 方向代表纬度，
Z 值可以表示高程、重力值、温度、速度等。

本章首先会介绍网格文件的格式与基础知识：

.. toctree::
    :maxdepth: 1

    format
    registration
    boundary-condition

然后介绍如何利用 GMT 或其他软件读写和查看 netCDF 网格文件：

.. toctree::
    :maxdepth: 1

    read
    write
    viewer
