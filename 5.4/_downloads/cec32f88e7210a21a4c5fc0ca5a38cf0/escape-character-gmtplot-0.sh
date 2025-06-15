#!/bin/bash
PS=GMT_escape_examples.ps
R=0/2/-1/9
J=X18c/-8c

gmt psxy -R$R -J$J -P -K -T > $PS

gmt pstext -R -J -Bg1 -Bwsen -F+f -K -O -N >> $PS << EOF
0.5  -0.5 10p,5,black Input
1.5  -0.5 10p,5,black Output

0.5  0.5 10p,8,black abc@@~def@@~ghi
1.5  0.5 -,-,black abcd@~def@~ghi

0.5  1.5 10p,8,black 2@@~p@@~r@@+2@@+h@@-0@@-
1.5  1.5 -,-,black 2@~p@~r@+2@+h@-0@-

0.5  2.5 10p,8,black S@@#mall@@# C@@#aps@@#
1.5  2.5 -,-,black S@#mall@# C@#aps@#

0.5  3.5 10p,8,black Thi is @@_underline@@_
1.5  3.5 -,-,black This is @_underline@_

0.5  4.5 10p,8,black @@%1%Use@@%% @@%23%different@@%% @@%8%fonts@@%%
1.5  4.5 -,-,black @%1%Use@%% @%23%different@%% @%8%fonts@%%

0.5  5.5 10p,8,black @@:10:Use@@:: @@:20:different@@:: @@:15:size@@::
1.5  5.5 -,-,black @:10:Use@:: @:20:different@:: @:15:size@::

0.5  6.5 10p,8,black @@\;red;Colorful@@;; @@\;blue;text@@;;
1.5  6.5 -,-,black @;red;Colorful@;; @;blue;text@;;

0.5  7.5 10p,8,black @@!CV @@@@
1.5  7.5 -,-,black @!CV @@

0.5  8.5 10p,8,black Stresses are @@~s@@~@@+*@@+@@-xx@@- MPa
1.5  8.5 -,-,black Stresses are @~s@~@+*@+@-xx@- MPa
EOF
gmt psxy -R -J -O -T >> $PS

rm gmt.history
