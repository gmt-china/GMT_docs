获取 GMT 开发版
===============

从 GMT 官方网站下载页面下载得到的 GMT 源码是发布版源码，即面向用户的源码。
而 GMT 维护者在开发时所使用的源码是开发版源码。GMT 开发版源码通过 ``svn`` 管理。

想要安装 GMT 开发版源码，可以通过如下方式获取开发版源码并依照常规的编译流程
进行安装。

通过 svn 获取
-------------

要先安装 ``svn``\ ，然后执行如下命令即可获取 GMT 当前最新的开发源码（约400 MB）::

    svn checkout svn://gmtserver.soest.hawaii.edu/gmt/trunk gmt-dev

以后可以通过 ``svn update`` 命令将源码更新至最新版本。

也可以使用如下命令获取 GMT 的开发版的全部源码（包括所有分支，共计约4.6 GB）::

    svn checkout svn://gmtserver.soest.hawaii.edu/gmt/ gmt-dev-full

其中 ``tags`` 目录包含了每个已发布的版本，\ ``trunk`` 目录包含 GMT 最新源码。

通过 git 获取
-------------

Git 用户先安装 git 提供的 svn 插件::

    sudo yum install git-svn

然后使用如下命令获取源码::

    git svn clone svn://gmtserver.soest.hawaii.edu/gmt/trunk gmt-dev

以后可以通过 ``git svn rebase`` 命令将源码更新至最新版本。

不推荐用 git 获取 GMT 开发版源码，速度比较慢。
