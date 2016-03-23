隔离模式
========

GMT在运行的过程中会生成临时文件，比如 ``gmt.conf`` 和 ``gmt.history`` ，这两个文件用于在同一个图件的多个绘图命令之间交流共同的参数或选项。在使用这两个文件时可能会遇到一些问题，比如 ``gmt.conf`` 在脚本执行的中途被修改所造成的问题，以及在同一个目录下运行多个绘图脚本导致的 ``gmt.history`` 出现冲突等问题。

GMT提供了隔离模式，使得每次脚本的每次运行，都会将临时文件放在不同的目录中，进而避免了可能出现的冲突。下面的脚本展示了格林模式的使用::

    ps=GMT_isolation.ps

    # 创建临时文件夹
    export GMT_TMPDIR=`mktemp -d /tmp/gmt.XXXXXX`

    # 生成的 gmt.conf 位于 $GMT_TMPDIR 目录下
    gmt gmtset COLOR_MODEL rgb FONT_ANNOT_PRIMARY 14p

    # 生成临时文件到 $GMT_TMPDIR 目录
    gmt grdmath -Rd -I1 Y = $GMT_TMPDIR/lat.nc
    gmt makecpt -Crainbow -T-90/90/180 -Z > $GMT_TMPDIR/lat.cpt

    # 生成的 gmt.history 文件位于 $GMT_TMPDIR 目录下
    gmt grdimage $GMT_TMPDIR/lat.nc -JK6.5i -C$GMT_TMPDIR/lat.cpt -P -K -nl > $ps
    gmt pscoast -R -J -O -Dc -A5000 -Gwhite -Bx60g30 -By30g30 >> $ps

    # 清理临时目录
    rm -rf $GMT_TMPDIR
