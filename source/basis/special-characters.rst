特殊字符
========

所有的字符在计算机中都是用二进制表示的，不过二进制看起来比长，所以也可以用
等效的八进制或十六进制表示。GMT中用三位的八进制码表示一个字符。

对于任意一个三位的八进制码，可以对应字符 ``a`` ，也可以对应字符 ``f`` ，
具体哪个八进制码对应哪个字符呢？这就由字符编码规范决定。

GMT支持多种字符编码，包括 ``Standard`` 、 ``Standard+`` 、 ``ISOLation1`` 、 
``ISOLatin1+`` 以及 ``ISO-8859-x`` （x可以取1到10以及13到15）。

GMT当前使用的字符编码方式由GMT参数 :ref:`PS_CHAR_ENCODING <PS_CHAR_ENCODING>` 决定。
若安装过程中使用的是国际单位制，则默认编码方式为 ``ISOLatin1+`` ，否则为 ``Standard+`` 。
可以使用::

    gmt get PS_CHAR_ENCODING

查看GMT当前使用的字符编码。

下图给出了 ``Standard+`` 和 ``ISOLatin1+`` 编码下八进制码与字符间的对应关系：

.. figure:: /images/text_stand+_iso+.*
   :width: 100%
   :align: center

   Standard+和ISOLatin1+编码下的八进制码

其中，浅红色区域是保留给控制字符的八进制码，浅绿色区域是扩展字符（扩展字符即 
``Standard+`` 编码相对于 ``Standard`` 编码多出的字符， ``ISOLation1+`` 同理。）。

这张图应该如何读呢？以 ``ISOLation1+`` 编码下的八进制码 ``\144`` 为例， 
``\14x`` 行与 ``4`` 列的交界处就是该八进制码代表的字符，即 ``d`` 。

下面的示例展示了修改GMT的文本编码，以及不同编码下同一八进制码的效果::

    $ gmt set PS_CHAR_ENCODING Standard+
    $ echo 1 1 '\260' | gmt text -JX2c/2c -R0/2/0/2 -B1 -pdf standard
    $ gmt set PS_CHAR_ENCODING ISOLatin1+
    $ echo 1 1 '\260' | gmt text -JX2c/2c -R0/2/0/2 -B1 -pdf isolatin1

其中， ``standard.ps`` 中显示的是类似A的字符，而 ``isolation1.ps`` 中显示的则是弧度 ``°`` 符号。

需要注意，反斜杠在GMT中用于表示八进制码，同时，反斜杠也是大多数脚本语言的转义字符。
因而会存在反斜杠先被脚本语言转义再传递给GMT的情况。故而此处需要用 ``'\260'`` 或 
``\\260`` ，而不能直接用 ``\260`` 。