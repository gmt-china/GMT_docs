模块手册
########

**主程序/脚本**

- :doc:`gmt` ：GMT主程序
- :doc:`isogmt` ：在“隔离模式”下运行GMT命令或脚本
- :doc:`gmt5syntax` ：将旧的GMT脚本修改成新的 ``gmt <module>`` 语法
- :doc:`gmt-config` ：返回 GMT 动态函数库的基本信息

**现代模式/会话管理**

- :doc:`begin`: 初始化一个新的GMT现代模式会话
- :doc:`end`: 结束现代模式会话，并生成图片文件
- :doc:`figure`: 设置当前图片的属性
- :doc:`subplot`: 设置子图模式
- :doc:`inset`: 管理和设置图中图模式
- :doc:`docs`: 打开指定模块的HTML文档
- :doc:`clear`: 删除当前的历史文件、配置文件、CPT文件、缓存、数据目录、会话目录

**参数设置**

- :doc:`set` ：修改单个或多个GMT参数的值
- :doc:`get` ：列出单个或多个GMT参数的当前值
- :doc:`defaults` ：列出所有GMT参数的当前值

**信息提取**

- :doc:`grdinfo` ：从网格文件中提取基本信息
- :doc:`info` ：从表数据中提取信息
- :doc:`which` ：返回指定文件的完整路径

**格式转换**

- :doc:`psconvert` ：将GMT生成的PS文件转换为其他图片格式
- :doc:`grdconvert` ：在不同的网格格式之间互相转换
- :doc:`xyz2grd` ：将XYZ数据或Z数据转换成网格文件
- :doc:`grd2xyz` ：将网格文件转换成表数据
- :doc:`kml2gmt` ：将Google Earth的KML文件转换为GMT表数据

**绘制 1D 数据**

- :doc:`solar` ：计算或/和绘制晨昏线以及民用、航海用以及天文用曙暮光区域
- :doc:`basemap` ：绘制底图
- :doc:`clip` ：打开或关闭多边形裁剪路径
- :doc:`histogram` ：统计并绘制直方图
- :doc:`text` ：在图上写文本
- :doc:`coast` ：在地图上绘制海岸线、河流、国界线
- :doc:`legend` ：绘制图例
- :doc:`rose` ：绘制极坐标下的直方图（sector图、rose图或windrose图）
- :doc:`plot` ：在图上绘制线段、多边形和符号
- :doc:`sac` ：在地图上绘制 SAC 格式的地震波形数据
- :doc:`meca` ：在地图上绘制震源机制解
- :doc:`polar` ：在震源球上绘制台站极性
- :doc:`velo` ：在地图上绘制速度矢量、十字线、楔形图
- :doc:`coupe` ：绘制震源机制解的剖面图
- :doc:`ternary` ：绘制三角图解

**绘制 2D 数据**

- :doc:`logo` ：在图上绘制GMT图形logo
- :doc:`image` ：将EPS或光栅图片放在图上
- :doc:`colorbar` ：在图上绘制灰色或彩色色标
- :doc:`grdvector` ：根据两个网格文件绘制矢量场
- :doc:`grdimage` ：在图上绘制网格数据

**1D 数据处理**

- :doc:`select` ：根据多个准则筛选数据
- :doc:`fitcircle` ：拟合球面上数据点的平均位置及圆弧
- :doc:`simplify` ：使用Douglas-Peucker算法对线段做简化
- :doc:`filter1d` ：对1D表数据做时间域滤波
- :doc:`connect` ：将端点接近的线段连接起来
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
- :doc:`grdsample` ：对网格文件做重采样
- :doc:`grdvolume` ：计算网格数据中某个等值线所包围的表面积和体积
- :doc:`grd2xyz` ：将网格文件转换成表数据
- :doc:`grdblend` ：将多个部分重叠的网格文件合并成一个网格文件
- :doc:`grdtrend` ：拟合网格的趋势面并计算残差
- :doc:`grdproject` ：对网格数据做地图变换和逆变换
- :doc:`grdmask` ：根据多边形数据或点数据创建mask网格文件

**其他**

#. :doc:`movie`
#. :doc:`grdtrack`
#. :doc:`makecpt`
#. :doc:`grd2cpt`
#. :doc:`convert`
#. :doc:`trend1d`
#. :doc:`grdcontour`
#. :doc:`mask`
#. :doc:`grdview`
#. :doc:`grdgradient`
#. :doc:`grdmath`
#. :doc:`2kml`
#. :doc:`trend2d`
#. :doc:`mapproject`
#. :doc:`surface`
#. :doc:`grdfilter`
#. :doc:`grdfft`
#. :doc:`splitxyz`
#. :doc:`math`
#. :doc:`blockmean`
#. :doc:`blockmedian`
#. :doc:`blockmode`
#. :doc:`plot3d`
#. :doc:`contour`
#. :doc:`segy`
#. :doc:`segyz`
#. :doc:`wiggle`
#. :doc:`grdgravmag3d`
#. :doc:`grdhisteq`
#. :doc:`pmodeler`
#. :doc:`grdpmodeler`
#. :doc:`grdredpol`
#. :doc:`grdrotater`
#. :doc:`dimfilter`
#. :doc:`triangulate`
#. :doc:`nearneighbor`
#. :doc:`gmtswitch`
#. :doc:`backtracker`
#. :doc:`gravmag3d`
#. :doc:`spatial`
#. :doc:`vector`
#. :doc:`gravfft`
#. :doc:`grdseamount`
#. :doc:`gpsgridder`
#. :doc:`grdspotter`
#. :doc:`greenspline`
#. :doc:`gshhg`
#. :doc:`hotspotter`
#. :doc:`img2google`
#. :doc:`img2grd`
#. :doc:`originater`
#. :doc:`rotconverter`
#. :doc:`rotsmoother`
#. :doc:`segy2grd`
#. :doc:`sph2grd`
#. :doc:`sphdistance`
#. :doc:`sphinterpolate`
#. :doc:`sphtriangulate`

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

   2kml
   backtracker
   basemap
   begin
   blockmean
   blockmedian
   blockmode
   clear
   clip
   coast
   colorbar
   connect
   contour
   convert
   coupe
   defaults
   dimfilter
   docs
   end
   figure
   filter1d
   fitcircle
   flexure
   get
   gmt
   gmt-config
   gmt5syntax
   gmtswitch
   gpsgridder
   gravfft
   gravmag3d
   grd2cpt
   grd2xyz
   grdblend
   grdclip
   grdcontour
   grdconvert
   grdcut
   grdedit
   grdfft
   grdfilter
   grdflexure
   grdgradient
   grdgravmag3d
   grdhisteq
   grdimage
   grdinfo
   grdlandmask
   grdmask
   grdmath
   grdpaste
   grdpmodeler
   grdproject
   grdredpol
   grdrotater
   grdsample
   grdseamount
   grdspotter
   grdtrack
   grdtrend
   grdvector
   grdview
   grdvolume
   greenspline
   gshhg
   histogram
   hotspotter
   image
   img2google
   img2grd
   info
   inset
   isogmt
   kml2gmt
   legend
   logo
   makecpt
   mapproject
   mask
   math
   meca
   movie
   nearneighbor
   originater
   plot
   plot3d
   pmodeler
   polar
   project
   psconvert
   regress
   rose
   rotconverter
   rotsmoother
   sac
   sample1d
   segy
   segy2grd
   segyz
   select
   set
   simplify
   solar
   spatial
   spectrum1d
   sph2grd
   sphdistance
   sphinterpolate
   sphtriangulate
   splitxyz
   subplot
   surface
   talwani2d
   talwani3d
   ternary
   text
   trend1d
   trend2d
   triangulate
   vector
   velo
   which
   wiggle
   xyz2grd

.. raw:: latex

   \setcounter{tocdepth}{2}
