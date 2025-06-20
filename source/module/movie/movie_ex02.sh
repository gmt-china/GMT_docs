#!/bin/bash 

# 绘制旋转地球动画

# 构建主脚本
cat > globe.sh <<EOF
gmt begin
    gmt coast -Rg -JG\${MOVIE_FRAME}/20/\${MOVIE_WIDTH} -Gmaroon -Sturquoise -Bg -X0 -Y0
gmt end
EOF

# 调用 movie 模块
gmt movie globe.sh -Nglobe -T360 -Fgif+l -C3ix3ix100 -Lf -P