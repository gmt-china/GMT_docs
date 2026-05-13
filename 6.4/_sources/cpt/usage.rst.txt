使用CPT
=======

命令行指定CPT文件名后，GMT会依次在当前目录、 :file:`~/.gmt` 和 :file:`${GMTHOME}/share/cpt/`
目录下寻找CPT文件，如果找不到还会加上后缀 ``.cpt`` 寻找。

在文件名后加上后缀 **+u**\|\ **U**\ *unit* 还可以对CPT文件中的Z值进行缩放。

- *filename.cpt*\ **+u**\ *unit* 可以将Z值从 *unit* 变换为以米为单位
- *filename.cpt*\ **+U**\ *unit* 可以将Z值从以米为单位变换成 *unit*
