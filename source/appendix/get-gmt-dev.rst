获取GMT开发版
=============

通常，从GMT官方网站下载得到的源码都是发布版源码，即是面向用户的源码。而GMT维护者在开发时所用所使用的源码是开发版源码，相对于发布版源码要多一些内容，比如开发版源码中多了大量的命令测试代码，是了解命令用法的好地方。

GMT开发版源码通过 ``svn`` 管理，因而要先安装 ``svn`` ，然后执行如下命令即可获取GMT当前最新的开发源码::

    svn checkout svn://gmtserver.soest.hawaii.edu/gmt5/trunk gmt5-dev

并可以通过通过 ``svn update`` 命令将其更新至最新版本。

当然，也可以使用如下命令获取GMT的开发版的全部源码（包括所有分支）::

    svn checkout svn://gmtserver.soest.hawaii.edu/gmt5/ gmt5-dev-full

Git用户可以使用git提供的svn插件来获取源码::

    git svn clone svn://gmtserver.soest.hawaii.edu/gmt5/trunk gmt5-dev

并可以通过 ``git svn rebase`` 命令将其更新至最新版本。
