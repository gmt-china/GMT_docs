命令行补全
==========

.. hint::

   GMT的命令行补全功能仅支持 bash，功能很弱，不用也罢。

GMT为bash提供了基本的命令行补全功能。在终端敲GMT命令时，可以使用 ``Tab`` 键补全部分选项。

使用步骤如下：

#. 安装 `bash-completion <http://bash-completion.alioth.debian.org/>`_

   Ubuntu/Debian下::

       sudo apt-get install bash-completion

   CentOS/Fedora下::

       sudo yum install bash-completion

#. 在 ``~/.bashrc`` 中加入如下语句

   .. code-block:: bash

      # Use bash-completion, if available
      if [ -r /usr/share/bash-completion/bash_completion ]; then
          . /usr/share/bash-completion/bash_completion
      fi

      . ${GMTHOME}/share/tools/gmt_completion.bash

#. 执行 ``source ~/.bashrc`` 使修改生效
#. 在命令行键入即可看到补全效果::

       $ gmt ps[Tab][Tab]
       psbasemap    psconvert    pslegend     psrose       pssegyz      pswiggle
       psclip       pscoupe      psmask       pssac        pssolar      psxy
       pscoast      pshistogram  psmeca       psscale      pstext       psxyz
       pscontour    psimage      pspolar      pssegy       psvelo       

       # 似乎选项的补全无法使用 
       $ gmt psxy -[Tab]
       -^  -?  -A  -B  -C  -E  -g  -h  -I  -K  -N  -p  -R  -S  -T  -V  -X
       -:  -a  -b  -c  -D  -f  -G  -i  -J  -L  -O  -P  -s  -t  -U  -W  -Y
