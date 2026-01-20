gmt begin map
    # 在网页服务器上存在路径查找问题，用户在本机运行时可以直接使用 gmt sac *.z 进行绘图
    first_file=$(gmt which ntkl.z)
    data_dir=$(dirname "$first_file")
    SACfiles=$(echo "$data_dir"/*.z)

    gmt coast -G244/243/239 -S167/194/223 -R-120/-40/35/65 -Baf -JM10c
    gmt sac $SACfiles -M0.5i -S400c
    # 以下坐标数据由 saclst stlo stla f *.z 生成
    gmt plot -St0.4c -Gred -i1,2 <<- END
ntkl.z     -114.592     62.4797
ntkm.z     -114.592     62.4797
nykl.z       -74.53     44.5483
nykm.z       -74.53     44.5483
onkl.z     -93.7022     50.8589
onkm.z     -93.7022     50.8589
sdkl.z     -104.036     44.1204
sdkm.z     -104.036     44.1204
END

    gmt sac $SACfiles -R200/1600/12/45 -JX10c/5c -Bx200+l"T(s)" -By5+lDegree -BWSen -Ed -M1.5c -W0.3p,red -Y8c
gmt end show
