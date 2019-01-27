GMT模块
#######

GMT提供了大约130多个模块，每个模块可以实现不同的功能，根据模块的名称可以大致
猜出模块的功能。

下面将GMT中最常用的模块按照功能分类，并用一句话简述其功能。

**绘制1D数据**

- basemap ：绘制底图
- plot ：在图上绘制线段、多边形和符号
- text ：在图上写文本
- coast ：在地图上绘制海岸线、河流、国界线
- legend ：绘制图例
- solar ：计算或/和绘制晨昏线以及民用、航海用以及天文用曙暮光区域
- meca ：在地图上绘制震源机制解
- coupe ：绘制震源机制解的剖面图
- histogram ：统计并绘制直方图
- sac ：在地图上绘制 SAC 格式的地震波形数据
- clip ：打开或关闭多边形裁剪路径
- rose ：绘制极坐标下的直方图（sector图、rose图或windrose图）
- polar ：在震源球上绘制台站极性
- velo ：在地图上绘制速度矢量、十字线、楔形图
- ternary ：绘制三角图解

**绘制2D数据**

- logo ：在图上绘制GMT图形logo
- image ：将EPS或光栅图片放在图上
- colorbar ：在图上绘制灰色或彩色色标
- grdvector ：根据两个网格文件绘制矢量场
- grdimage ：在图上绘制网格数据

**参数设置**

- gmtset ：修改单个或多个GMT参数的值
- gmtget ：列出单个或多个GMT参数的当前值
- gmtdefaults ：列出所有GMT参数的当前值

**信息提取**

- grdinfo ：从网格文件中提取基本信息
- gmtinfo ：从表数据中提取信息
- gmtwhich ：返回指定文件的完整路径

**格式转换**

- psconvert ：将GMT生成的PS文件转换为其他图片格式
- grdconvert ：在不同的网格格式之间互相转换
- xyz2grd ：将XYZ数据或Z数据转换成网格文件
- grd2xyz ：将网格文件转换成表数据
- kml2gmt ：将Google Earth的KML文件转换为GMT表数据

**1D 数据处理**

- gmtselect ：根据多个准则筛选数据
- fitcircle ：拟合球面上数据点的平均位置及圆弧
- gmtsimplify ：使用Douglas-Peucker算法对线段做简化
- filter1d ：对1D表数据做时间域滤波
- gmtconnect ：将端点接近的线段连接起来
- project ：将数据点投影到线或大圆路径上，生成测线，坐标转换
- sample1d ：对1D表数据进行重采样
- spectrum1d: 计算一个时间序列的自功率谱，或两个时间序列的互功率谱

**2D 数据处理**

- grdclip ：对网格文件的Z值做裁剪
- grdconvert ：在不同的网格格式之间互相转换
- grdcut ：从一个网格文件中裁剪出一个矩形子区域生成新的网格文件
- grdedit ：修改网格文件的头段或内容
- grdlandmask ：根据海岸线数据创建陆地-海洋的mask网格文件
- grdinfo ：从网格文件中提取基本信息
- grdpaste ：将两个网格沿着其共同边界拼接成一个文件
- grdraster ：从二进制数据中提取子区域并保存为GMT网格文件
- grdsample ：对网格文件做重采样
- grdvolume ：计算网格数据中某个等值线所包围的表面积和体积
- grd2xyz ：将网格文件转换成表数据
- grd2rgb ：将网格文件、原始RGB文件、SUN光栅文件转换成R/G/B三个网格文件
- grdblend ：将多个部分重叠的网格文件合并成一个网格文件
- grdtrend ：拟合网格的趋势面并计算残差
- grdproject ：对网格数据做地图变换和逆变换
- grdmask ：根据多边形数据或点数据创建mask网格文件

.. toctree::

   psxy
