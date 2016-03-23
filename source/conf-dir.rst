.. _DIR_DCW:
.. _DIR_GSHHG:
.. _DIR_DATA:

DIR参数
=======

下面列出所有与目录相关的参数，参数的默认值在中括号内列出。

**DIR_DCW**
    DCW数据文件的路径，默认值为空，GMT会自动猜测合理的路径值。

**DIR_GSHHG**
    海岸线数据所在路径 [``$GMTHOME/_SHAREDIR/coast``]

**DIR_DATA**
    存放数据文件的目录，默认值为空。

    GMT在命令中遇到文件名时，会首先在当前目录下寻找，若找不到，则会到参数 ``DIR_DATA`` 指定的目录中寻找，若找不到，则到环境变量 ``${GMT_DATADIR}`` 所指定的目录中寻找。
