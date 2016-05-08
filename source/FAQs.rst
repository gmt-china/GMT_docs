FAQ
===

#. 使用psxy或其他类似命令时，出现::

       psxy: Mismatch between actual (1) and expected (2) fields near line 10 (skipped)

   出现该错误的原因是当前命令需要两列数据，而在第10行左右数据只有一列。此时需要人工检查一下第10行附近的数据。需要注意，这里的第10行不一定是准备数字。

#. 在使用地图投影时，为何无法给坐标轴加标签？命令如下::

       gmt psbasemap -R0/10/0/10 -JM10c -B1 -Bx+l"Latitude" -By+"Longtitude" > a.ps

   从绘图效果中可以看出，“Latitude”和“Longtitude”是没有加进去的。这不是Bug，而是一个Feature。因为对于使用地图投影绘制的地图，从“火车道”边框或标注上的“度”符号都可以直观的知道这是一个地图投影而不是笛卡尔投影。而对于地图投影来说，X方向是经度、Y方向是纬度，是基本常识，给坐标轴加label反而是多此一举，故而对于地图投影来说，坐标轴是不能加label的。

   如果执意要给坐标轴加label，只能用pstext手动添加。

#. 在Windows下写了bat脚本，执行bat脚本时黑屏一闪而过，看不到出错信息。

   解决办法：在脚本的最后加上 ``pause`` 。

#. 出现如下错误::

       Long input record (xxx bytes) was truncated to first xx bytes!

   出现该错误的原因是输入数据的一行超过特定的长度（一般是512字符），此时GMT会对输入数据做截断。出现该错误的常见原因是在将多个记录通过管道传递给命令时，记录末尾的换行符丢失，导致多个记录连成一行传递给命令。

#. 安装GMT后用 ``pscoast`` 绘图时出现如下错误::

    pscoast: GSHHG version 2.2.0 or newer is needed to use coastlines with GMT.
    Get and install GSHHG from ftp://ftp.soest.hawaii.edu/gshhg/.
    pscoast: Could not find file [GSHHG crude resolution shorelines]
    pscoast: No GSHHG databases available - must abort

   ``pscoast`` 能够正常运行的前提是：

   1. 在 ``$GMTHOME/share/coast`` 目录下能够找到GSHHG数据文件（一堆以.nc结尾的文件）
   2. GSHHG数据文件有可读权限
   3. GSHHG数据文件的版本号大于2.2.0
   4. 系统的netCDF软件在编译时支持netCDF4格式

   针对以上几点，如果出现了题中所说的错误，可以通过如下方式逐一排除：

   1. 检查 ``$GMTHOME/share/coast`` 目录下是否有GSHHG数据文件
   2. 在 ``share/coast`` 目录下执行 ``ls -l`` 检查数据文件是否有可读权限
   3. 打开 ``README.TXT`` 里，版本号是否大于2.2.0
   4. 终端执行 ``nc-config --has-nc4`` 以检查netCDF软件是否支持netCDF4格式，若为 ``yes`` 则表示支持
