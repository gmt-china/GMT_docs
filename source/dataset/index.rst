地学数据集
##########

在使用GMT绘图时，经常会用到一些特定的地学数据，比如国界线、地形起伏数据等等。
这些数据具有两个特性：

1. 固定性：不需要改动就可以直接使用
2. 复用性：常用于不同的图件

这一章介绍可以在GMT中使用的地学数据。数据分为三类：

1. GMT提供的需要在安装时指定的数据，包括：

   - :doc:`gshhg`
   - :doc:`dcw/index`

2. GMT提供的远程数据，在需要时会自动下载到本地，包括：

   - :doc:`earth-relief`

3. 用户自行整理的其它地学数据。GMT中文社区整理了一些地学数据，包括：

   - :doc:`gadm/index`
   - :doc:`PB2002/index`

这一章的每一节将分别介绍每一种数据的基本情况和用法。
:doc:`remote-data` 一节将介绍GMT提供的远程数据的原理和使用方法。
:doc:`custom-data` 一节将介绍如何构建一个GMT数据库以方便地在GMT绘图中
直接使用这些数据集。


.. toctree::
   :maxdepth: 1
   :hidden:

   gshhg
   dcw/index
   remote-data
   earth-relief
   custom-data
   gadm/index
   PB2002/index
