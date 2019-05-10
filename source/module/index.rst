模块手册
########

**主程序/脚本**

- :doc:`gmt` ：GMT主程序
- :doc:`isogmt` ：在“隔离模式”下运行GMT命令或脚本
- :doc:`gmt5syntax` ：将旧的GMT脚本修改成新的 ``gmt <module>`` 语法
- :doc:`gmt-config` ：返回 GMT 动态函数库的基本信息

**参数设置**

- :doc:`gmtset` ：修改单个或多个GMT参数的值
- :doc:`gmtget` ：列出单个或多个GMT参数的当前值
- :doc:`gmtdefaults` ：列出所有GMT参数的当前值

**信息提取**

- :doc:`grdinfo` ：从网格文件中提取基本信息
- :doc:`gmtinfo` ：从表数据中提取信息
- :doc:`gmtwhich` ：返回指定文件的完整路径

**格式转换**

- :doc:`psconvert` ：将GMT生成的PS文件转换为其他图片格式
- :doc:`grdconvert` ：在不同的网格格式之间互相转换
- :doc:`xyz2grd` ：将XYZ数据或Z数据转换成网格文件
- :doc:`grd2xyz` ：将网格文件转换成表数据
- :doc:`kml2gmt` ：将Google Earth的KML文件转换为GMT表数据

**绘制 1D 数据**

- :doc:`pssolar` ：计算或/和绘制晨昏线以及民用、航海用以及天文用曙暮光区域
- :doc:`psbasemap` ：绘制底图
- :doc:`psclip` ：打开或关闭多边形裁剪路径
- :doc:`pshistogram` ：统计并绘制直方图
- :doc:`pstext` ：在图上写文本
- :doc:`pscoast` ：在地图上绘制海岸线、河流、国界线
- :doc:`pslegend` ：绘制图例
- :doc:`psrose` ：绘制极坐标下的直方图（sector图、rose图或windrose图）
- :doc:`psxy` ：在图上绘制线段、多边形和符号
- :doc:`pssac` ：在地图上绘制 SAC 格式的地震波形数据
- :doc:`psmeca` ：在地图上绘制震源机制解
- :doc:`pspolar` ：在震源球上绘制台站极性
- :doc:`psvelo` ：在地图上绘制速度矢量、十字线、楔形图
- :doc:`pscoupe` ：绘制震源机制解的剖面图
- :doc:`psternary` ：绘制三角图解

**绘制 2D 数据**

- :doc:`gmtlogo` ：在图上绘制GMT图形logo
- :doc:`psimage` ：将EPS或光栅图片放在图上
- :doc:`psscale` ：在图上绘制灰色或彩色色标
- :doc:`grdvector` ：根据两个网格文件绘制矢量场
- :doc:`grdimage` ：在图上绘制网格数据

**1D 数据处理**

- :doc:`gmtselect` ：根据多个准则筛选数据
- :doc:`fitcircle` ：拟合球面上数据点的平均位置及圆弧
- :doc:`gmtsimplify` ：使用Douglas-Peucker算法对线段做简化
- :doc:`filter1d` ：对1D表数据做时间域滤波
- :doc:`gmtconnect` ：将端点接近的线段连接起来
- :doc:`project` ：将数据点投影到线或大圆路径上，生成测线，坐标转换
- :doc:`sample1d` ：对1D表数据进行重采样
- :doc:`spectrum1d`: 计算一个时间序列的自功率谱，或两个时间序列的互功率谱

**2D 数据处理**

- :doc:`grdclip` ：对网格文件的Z值做裁剪
- :doc:`grdconvert` ：在不同的网格格式之间互相转换
- :doc:`grdcut` ：从一个网格文件中裁剪出一个矩形子区域生成新的网格文件
- :doc:`grdedit` ：修改网格文件的头段或内容
- :doc:`grdlandmask` ：根据海岸线数据创建陆地-海洋的mask网格文件
- :doc:`grdinfo` ：从网格文件中提取基本信息
- :doc:`grdpaste` ：将两个网格沿着其共同边界拼接成一个文件
- :doc:`grdraster` ：从二进制数据中提取子区域并保存为GMT网格文件
- :doc:`grdsample` ：对网格文件做重采样
- :doc:`grdvolume` ：计算网格数据中某个等值线所包围的表面积和体积
- :doc:`grd2xyz` ：将网格文件转换成表数据
- :doc:`grd2rgb` ：将网格文件、原始RGB文件、SUN光栅文件转换成R/G/B三个网格文件
- :doc:`grdblend` ：将多个部分重叠的网格文件合并成一个网格文件
- :doc:`grdtrend` ：拟合网格的趋势面并计算残差
- :doc:`grdproject` ：对网格数据做地图变换和逆变换
- :doc:`grdmask` ：根据多边形数据或点数据创建mask网格文件

**其他**

#. :doc:`grdtrack`
#. :doc:`makecpt`
#. :doc:`grd2cpt`
#. :doc:`gmtconvert`
#. :doc:`trend1d`
#. :doc:`grdcontour`
#. :doc:`psmask`
#. :doc:`grdview`
#. :doc:`grdgradient`
#. :doc:`grdmath`
#. :doc:`gmt2kml`
#. :doc:`trend2d`
#. :doc:`mapproject`
#. :doc:`surface`
#. :doc:`grdfilter`
#. :doc:`grdfft`
#. :doc:`splitxyz`
#. :doc:`gmtmath`
#. :doc:`gmt:blockmean`
#. :doc:`gmt:blockmedian`
#. :doc:`gmt:blockmode`
#. :doc:`gmt:psxyz`
#. :doc:`pscontour`
#. :doc:`gmt:supplements/segy/pssegy`
#. :doc:`gmt:supplements/segy/pssegyz`
#. :doc:`pswiggle`
#. :doc:`gmt:supplements/potential/grdgravmag3d`
#. :doc:`grdhisteq`
#. :doc:`gmt:supplements/spotter/gmtpmodeler`
#. :doc:`gmt:supplements/spotter/grdpmodeler`
#. :doc:`gmt:supplements/potential/grdredpol`
#. :doc:`gmt:supplements/spotter/grdrotater`
#. :doc:`gmt:supplements/misc/dimfilter`
#. :doc:`gmt:triangulate`
#. :doc:`gmt:nearneighbor`
#. :doc:`gmtswitch`
#. :doc:`gmt:supplements/spotter/backtracker`
#. :doc:`gmt:supplements/potential/gmtgravmag3d`
#. :doc:`gmtspatial`
#. :doc:`gmtvector`
#. :doc:`gmt:supplements/potential/gravfft`
#. :doc:`gmt:supplements/potential/grdseamount`
#. :doc:`gmt:supplements/potential/gpsgridder`
#. :doc:`gmt:supplements/spotter/grdspotter`
#. :doc:`greenspline`
#. :doc:`gmt:supplements/gshhg/gshhg`
#. :doc:`gmt:supplements/spotter/hotspotter`
#. :doc:`gmt:supplements/img/img2google`
#. :doc:`gmt:supplements/img/img2grd`
#. :doc:`gmt:supplements/spotter/originator`
#. :doc:`gmt:supplements/spotter/rotconverter`
#. :doc:`gmt:supplements/spotter/rotsmoother`
#. :doc:`gmt:supplements/segy/segy2grd`
#. :doc:`gmt:sph2grd`
#. :doc:`gmt:sphdistance`
#. :doc:`gmt:sphinterpolate`
#. :doc:`gmt:sphtriangulate`

**mgd77相关模块**

- :doc:`gmt:supplements/mgd77/mgd77convert`
- :doc:`gmt:supplements/mgd77/mgd77header`
- :doc:`gmt:supplements/mgd77/mgd77info`
- :doc:`gmt:supplements/mgd77/mgd77list`
- :doc:`gmt:supplements/mgd77/mgd77magref`
- :doc:`gmt:supplements/mgd77/mgd77manage`
- :doc:`gmt:supplements/mgd77/mgd77path`
- :doc:`gmt:supplements/mgd77/mgd77sniffer`
- :doc:`gmt:supplements/mgd77/mgd77track`

**x2sys相关模块**

- :doc:`gmt:supplements/x2sys/x2sys_binlist`
- :doc:`gmt:supplements/x2sys/x2sys_cross`
- :doc:`gmt:supplements/x2sys/x2sys_datalist`
- :doc:`gmt:supplements/x2sys/x2sys_get`
- :doc:`gmt:supplements/x2sys/x2sys_init`
- :doc:`gmt:supplements/x2sys/x2sys_list`
- :doc:`gmt:supplements/x2sys/x2sys_merge`
- :doc:`gmt:supplements/x2sys/x2sys_put`
- :doc:`gmt:supplements/x2sys/x2sys_report`
- :doc:`gmt:supplements/x2sys/x2sys_solve`

.. raw:: latex

   \setcounter{tocdepth}{1}

.. toctree::
   :maxdepth: 1
   :hidden:

   filter1d
   fitcircle
   gmt
   gmt-config
   gmt5syntax
   gmtconnect
   gmtdefaults
   gmtget
   gmtinfo
   gmtlogo
   gmtselect
   gmtset
   gmtsimplify
   gmtwhich
   grd2rgb
   grd2xyz
   grdblend
   grdclip
   grdcut
   grdedit
   grdimage
   grdinfo
   grdlandmask
   grdmask
   grdpaste
   grdproject
   grdraster
   grdconvert
   grdsample
   grdtrack
   grdtrend
   grdvector
   grdvolume
   isogmt
   kml2gmt
   makecpt
   mapproject
   project
   psbasemap
   psclip
   pscoast
   psconvert
   pscoupe
   pshistogram
   psimage
   pslegend
   psmeca
   pspolar
   psrose
   pssac
   psscale
   pssolar
   psternary
   pstext
   psvelo
   psxy
   sample1d
   spectrum1d
   xyz2grd

.. raw:: latex

   \setcounter{tocdepth}{2}
