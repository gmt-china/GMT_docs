地学数据集
##########

使用 GMT 绘图时，经常用到一些特定的地学数据，如国界线、地形起伏数据等。
这些数据一般不需要任何改动即可用在多种图件中。根据使用方法的不同，分为三类：

1. GMT 内置数据：GMT 官方整理的内置于 GMT 软件包中的数据
2. GMT 远程数据：GMT 官方整理的保存在远程 GMT 数据服务器中的数据
3. 自定义数据：用户自行准备的数据

.. toctree::   
   :maxdepth: 1
   :hidden:
 
   usage

GMT 内置数据
------------

GMT 内置数据是指在安装 GMT 时就已经安装了的数据，因而可以直接使用。
目前，GMT 提供了如下内置数据：

.. toctree::
   :maxdepth: 1

   gshhg
   dcw/index

GMT 远程数据
------------

GMT 远程数据是指保存在 GMT 数据服务器的数据。使用某个远程数据时，GMT 会自动下载到本地。
目前，GMT 提供了如下远程数据：

.. toctree::
   :maxdepth: 1

   earth-relief
   earth-age
   earth-images
   earth-mask

自定义数据
----------

除了 GMT 官方提供的内置数据和远程数据外，用户还可以自行准备数据，建立 GMT 数据库，供 GMT 使用。
GMT 中文社区整理了一些自定义数据，供用户选用：

.. toctree::
   :maxdepth: 1

   gadm/index
   PB2002/index
   /dataset-CN/index
