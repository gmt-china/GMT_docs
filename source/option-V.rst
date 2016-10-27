``-V`` 选项
===========

``-V`` 选项使得命令进入 verbose 模式，即会输出进程报告到 :ref:`标准错误流 <STDERR>` ，例如正在读取的数据文件名、读入的数据点数等等。使用 ``-V`` 选项可以看到更多命令执行的细节，以帮助用户判断命令是否正确执行。

verbose 模式有6个等级，等级越高输出的信息越多，高等级会在低等级的基础上加上更多的输出信息。6个等级从低到高分别为：

- ``-Vq`` ：quiet 模式，该模式下不输出任何错误和警告
- ``-Vn`` ：nomral 模式，即不使用 ``-V`` 选项时的默认模式，该模式下仅输出致命错误信息和经过信息
- ``-Vc`` ：compatibility 模式，该模式下会额外输出兼容性相关的警告信息，当 GMT 在编译时打开了兼容选项时默认为该模式
- ``-Vv`` 或 ``-V`` ：verbose，即输出错误、警告以及数据处理的基本信息
- ``-Vl`` ：long 模式，会额外输出详细的进程报告
- ``-Vd`` ：debug 模式，会输出大量调试信息

``-V`` 选项仅对当前命令有效，若希望所有命令都具有某个 verbose 级别，可以修改 GMT 参数 :ref:`GMT_VERBOSE <GMT_VERBOSE>` 。

.. source: http://gmt.soest.hawaii.edu/doc/latest/GMT_Docs.html#verbose-feedback-the-v-option
.. source: http://gmt.soest.hawaii.edu/doc/latest/GMT_Docs.html#verbose-operation
