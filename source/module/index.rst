GMT 模块
########

**主程序/脚本**

- :doc:`gmt` ：GMT主程序
- :doc:`isogmt` ：在“隔离模式”下运行GMT命令或脚本
- :doc:`gmt5syntax` ：将旧的GMT脚本修改成新的 ``gmt <module>`` 语法
- :doc:`gmt-config` ：返回 GMT 动态函数库的基本信息

**现代模式/会话管理**

- :doc:`begin` : 初始化一个新的GMT现代模式会话
- :doc:`end` : 结束现代模式会话，并生成图片文件
- :doc:`docs` : 打开指定模块的HTML文档
- :doc:`figure` : 设置当前图片的属性
- :doc:`subplot`
- :doc:`clear` : 删除当前的历史文件、配置文件、CPT文件、缓存、数据目录、会话目录

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
#. :doc:`blockmean`
#. :doc:`blockmedian`
#. :doc:`blockmode`
#. :doc:`psxyz`
#. :doc:`pscontour`
#. :doc:`pssegy`
#. :doc:`pssegyz`
#. :doc:`pswiggle`
#. :doc:`grdgravmag3d`
#. :doc:`grdhisteq`
#. :doc:`gmtpmodeler`
#. :doc:`grdpmodeler`
#. :doc:`grdredpol`
#. :doc:`grdrotater`
#. :doc:`dimfilter`
#. :doc:`triangulate`
#. :doc:`nearneighbor`
#. :doc:`mgd77convert`
#. :doc:`mgd77header`
#. :doc:`mgd77info`
#. :doc:`mgd77list`
#. :doc:`mgd77magref`
#. :doc:`mgd77manage`
#. :doc:`mgd77path`
#. :doc:`mgd77sniffer`
#. :doc:`mgd77track`
#. :doc:`x2sys_binlist`
#. :doc:`x2sys_cross`
#. :doc:`x2sys_datalist`
#. :doc:`x2sys_get`
#. :doc:`x2sys_init`
#. :doc:`x2sys_list`
#. :doc:`x2sys_merge`
#. :doc:`x2sys_put`
#. :doc:`x2sys_report`
#. :doc:`x2sys_solve`
#. :doc:`gmtswitch`
#. :doc:`backtracker`
#. :doc:`gmtgravmag3d`
#. :doc:`gmtspatial`
#. :doc:`gmtvector`
#. :doc:`gravfft`
#. :doc:`grdseamount`
#. :doc:`gpsgridder`
#. :doc:`grdspotter`
#. :doc:`greenspline`
#. :doc:`gshhg`
#. :doc:`hotspotter`
#. :doc:`img2google`
#. :doc:`img2grd`
#. :doc:`originator`
#. :doc:`rotconverter`
#. :doc:`rotsmoother`
#. :doc:`segy2grd`
#. :doc:`sph2grd`
#. :doc:`sphdistance`
#. :doc:`sphinterpolate`
#. :doc:`sphtriangulate`


.. toctree::
   :maxdepth: 1
   :hidden:

   backtracker
   blockmean
   blockmedian
   blockmode
   dimfilter
   filter1d
   fitcircle
   gmt
   gmt-config
   gmt2kml
   gmt5syntax
   gmtconnect
   gmtconvert
   gmtdefaults
   gmtflexure
   gmtget
   gmtgravmag3d
   gmtinfo
   gmtlogo
   gmtmath
   gmtpmodeler
   gmtregress
   gmtselect
   gmtset
   gmtsimplify
   gmtspatial
   gmtswitch
   gmtvector
   gmtwhich
   gpsgridder
   gravfft
   grd2cpt
   grd2rgb
   grd2xyz
   grdblend
   grdclip
   grdcontour
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
   grdraster
   grdredpol
   grdconvert
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
   hotspotter
   img2google
   img2grd
   isogmt
   kml2gmt
   makecpt
   mapproject
   mgd77convert
   mgd77header
   mgd77info
   mgd77list
   mgd77magref
   mgd77manage
   mgd77path
   mgd77sniffer
   mgd77track
   nearneighbor
   originator
   project
   psbasemap
   psclip
   pscoast
   pscontour
   psconvert
   pscoupe
   pshistogram
   psimage
   pslegend
   psmask
   psmeca
   pspolar
   psrose
   pssac
   psscale
   pssegy
   pssegyz
   pssolar
   psternary
   pstext
   psvelo
   pswiggle
   psxy
   psxyz
   rotconverter
   rotsmoother
   sample1d
   segy2grd
   spectrum1d
   sph2grd
   sphdistance
   sphinterpolate
   sphtriangulate
   splitxyz
   surface
   talwani2d
   talwani3d
   trend1d
   trend2d
   triangulate
   x2sys_binlist
   x2sys_cross
   x2sys_datalist
   x2sys_get
   x2sys_init
   x2sys_list
   x2sys_merge
   x2sys_put
   x2sys_report
   x2sys_solve
   xyz2grd
