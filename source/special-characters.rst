特殊字符
========

所有的字符在计算机中都是用二进制表示的，不过二进制看起来比长，所以也可以用等效的八进制或十六进制表示。GMT中用三位的八进制码表示一个字符。

对于任意一个三位的八进制码，可以对应字符 ``a`` ，也可以对应字符 ``f`` ，具体哪个八进制码对应哪个字符呢？这就由字符编码规范决定。

GMT支持多种字符编码，包括 ``Standard`` 、 ``Standard+`` 、 ``ISOLation1`` 、 ``ISOLatin1+`` 以及 ``ISO-8859-x`` （x可以取1到10以及13到15）。

GMT当前使用的字符编码方式由GMT参数 :ref:`PS_CHAR_ENCODING <PS_CHAR_ENCODING>` 决定。若安装过程中使用的是国际单位制，则默认编码方式为 ``ISOLatin1+`` ，否则为 ``Standard+`` 。可以使用::

    gmt get PS_CHAR_ENCODING

查看GMT当前使用的字符编码。

下图给出了 ``Standard+`` 和 ``ISOLatin1+`` 编码下八进制码与字符间的对应关系：

.. figure:: /images/GMT_stand+_iso+.*
   :width: 600px
   :align: center

   Standard+和ISOLatin1+编码下的八进制码

其中，浅红色区域是保留给控制字符的八进制码，浅绿色区域是扩展字符（扩展字符即 ``Standard+`` 编码相对于 ``Standard`` 编码多出的字符， ``ISOLation1+`` 同理。）。

这张图应该如何读呢？以 ``ISOLation1+`` 编码下的八进制码 ``\144`` 为例， ``\14x`` 行与 ``4`` 列的交界处就是该八进制码代表的字符，即 ``d`` 。

下图给出了如何用八进制码来表示常见字符和特殊字符：

.. figure:: /images/GMT_octal_examples.*
   :width: 600 px
   :align: center

   八进制示例
