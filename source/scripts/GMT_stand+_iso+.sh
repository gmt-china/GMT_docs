#!/bin/bash
#
#	ISO和Standar八进制表
#
# 一个PS文件中不能同时使用不同的字符集，因而需要生成两个PS文件再合并

# ISO
gmt begin text_iso+ png
gmt set MAP_FRAME_PEN thick FONT_TITLE 14p

# First col is row number, the remaining cols are col number in table
# that has a printable character
cat << EOF > tt.txt
3       1   2   3   4   5   6   7
4   0   1   2   3   4   5   6   7
5   0   1   2   3   4   5   6   7
6   0   1   2   3   4   5   6   7
7   0   1   2   3   4   5   6   7
8   0   1   2   3   4   5   6   7
9   0   1   2   3   4   5   6   7
10  0   1   2   3   4   5   6   7
11  0   1   2   3   4   5   6   7
12  0   1   2   3   4   5   6   7
13  0   1   2   3   4   5   6   7
14  0   1   2   3   4   5   6   7
15  0   1   2   3   4   5   6   7
16  0   1   2   3   4   5   6   7
17  0   1   2   3   4   5   6   7
18  0   1   2   3   4   5   6   7
19  0   1   2   3   4   5   6   7
20      1   2   3   4   5   6   7
21  0   1   2   3   4   5   6   7
22  0   1   2   3   4   5   6   7
23  0   1   2   3   4   5   6   7
24  0   1   2   3   4   5   6   7
25  0   1   2   3   4   5   6   7
26  0   1   2   3   4   5   6   7
27  0   1   2   3   4   5   6   7
28  0   1   2   3   4   5   6   7
29  0   1   2   3   4   5   6   7
30  0   1   2   3   4   5   6   7
31  0   1   2   3   4   5   6   7
EOF

# Use the row, col values to generate the octal code needed and
# plot it with gmt text, including the header row and left column
cat << EOF > tt.awk
BEGIN {
    printf "0.5 2.5 10p,4 octal\n"
    for (i = 0; i < 8; i++)
    {
        printf "%g 2.5 10p,4 %d\n", i + 1.5, i
    }
}
{
    printf "0.5 %g 10p,4 \\\\\\\%02ox\n", \$1+0.5, \$1
    for (i = 2; i <= NF; i++)
    {
        printf "%g %g 10p,4 \\\\%02o%o\n", \$i+1.5, \$1+0.5, \$1, \$i
    }
}
EOF
awk -f tt.awk tt.txt > tt.d

# Chart ISOLatin1+ font
gmt set PS_CHAR_ENCODING ISOLatin1+

# First the uncoded ones
gmt plot -R0/9/2/32 -Jx0.345i/-0.21i -BN+tISOLatin1++ -Glightred -Y0.0 << EOF
>
1   4
2   4
2   3
1   3
>
1   21
2   21
2   20
1   20
EOF
# Then highlight ISOLatin1+ enhancements
gmt plot -Glightgreen << EOF
>
2   4
9   4
9   3
2   3
>
8   16
9   16
9   15
8   15
>
1   18
9   18
9   16
1   16
>
2   20
3   20
3   19
2   19
>
5   20
6   20
6   19
5   19
EOF
gmt text tt.d -F+f
gmt plot -Bg1 -Wthick << EOF
>
0   3
9   3
>
1   2
1   32
EOF
rm tt.*
gmt end

# Standard
gmt begin text_stand+ png
gmt set MAP_FRAME_PEN thick FONT_TITLE 14p

# First col is row number, the remaining cols are col number in table
# that has a printable character
cat << EOF > tt.txt
3       1   2   3   4   5   6   7
4   0   1   2   3   4   5   6   7
5   0   1   2   3   4   5   6   7
6   0   1   2   3   4   5   6   7
7   0   1   2   3   4   5   6   7
8   0   1   2   3   4   5   6   7
9   0   1   2   3   4   5   6   7
10  0   1   2   3   4   5   6   7
11  0   1   2   3   4   5   6   7
12  0   1   2   3   4   5   6   7
13  0   1   2   3   4   5   6   7
14  0   1   2   3   4   5   6   7
15  0   1   2   3   4   5   6   7
16  0   1   2   3   4   5   6   7
17  0   1   2   3   4   5   6   7
18  0   1   2   3   4   5   6   7
19  0   1   2   3   4   5   6   7
20      1   2   3   4   5   6   7
21  0   1   2   3   4   5   6   7
22  0   1   2   3   4   5   6   7
23  0   1   2   3   4   5   6   7
24  0   1   2   3   4   5   6   7
25  0   1   2   3   4   5   6   7
26  0   1   2   3   4   5   6   7
27  0   1   2   3   4   5   6   7
28  0   1   2   3   4   5   6   7
29  0   1   2   3   4   5   6   7
30  0   1   2   3   4   5   6   7
31  0   1   2   3   4   5   6   7
EOF

# Use the row, col values to generate the octal code needed and
# plot it with gmt text, including the header row and left column
cat << EOF > tt.awk
BEGIN {
    printf "0.5 2.5 10p,4 octal\n"
    for (i = 0; i < 8; i++)
    {
        printf "%g 2.5 10p,4 %d\n", i + 1.5, i
    }
}
{
    printf "0.5 %g 10p,4 \\\\\\\%02ox\n", \$1+0.5, \$1
    for (i = 2; i <= NF; i++)
    {
        printf "%g %g 10p,4 \\\\%02o%o\n", \$i+1.5, \$1+0.5, \$1, \$i
    }
}
EOF
awk -f tt.awk tt.txt > tt.d

# Chart for Standard+ font
gmt set PS_CHAR_ENCODING Standard+

# First mark uncoded entries
gmt plot -R0/9/2/32 -Jx0.345i/-0.21i -BN+tStandard++ -Glightred -Y0.0 << EOF
>
1   4
2   4
2   3
1   3
>
1   21
2   21
2   20
1   20
EOF
#Then highlight Standard+ enhancements
gmt plot -Glightgreen << EOF
>
2   4
9   4
9   3
2   3
>
8   16
9   16
9   15
8   15
>
1   20
9   20
9   16
1   16
>
1   23
2   23
2   22
1   22
>
6   23
7   23
7   22
6   22
>
7   24
8   24
8   23
7   23
>
1   25
2   25
2   24
1   24
>
2   26
3   26
3   25
2   25
>
5   26
6   26
6   25
5   25
>
2   27
9   27
9   26
2   26
>
1   28
9   28
9   27
1   27
>
1   29
2   29
2   28
1   28
>
3   29
4   29
4   28
3   28
>
5   29
9   29
9   28
5   28
>
1   30
2   30
2   29
1   29
>
5   30
9   30
9   29
5   29
>
1   31
2   31
2   30
1   30
>
3   31
6   31
6   30
3   30
>
7   31
9   31
9   30
7   30
>
1   32
2   32
2   31
1   31
>
5   32
9   32
9   31
5   31
EOF
gmt text tt.d -F+f
gmt plot -Bg1 -Wthick << EOF
>
0   3
9   3
>
1   2
1   32
EOF
rm tt.*
gmt end

# Merge
gmt begin text_stand+_iso+ pdf,png
gmt image text_stand+.png -Dx0/0+r600
#gmt image text_iso+.png -Dx0/0+r600 -X3.2i
gmt image text_iso+.png -Dx0/0+r600 -X1.6i
gmt end
rm text_stand+.png text_iso+.png
