#!/usr/bin/env bash
gmt begin alaska_grav1
    # @AK_gulf_grav.nc 是 GMT 远程数据服务器自带的网格数据
    gmt grdcontour @AK_gulf_grav.nc -JM16c -C10 -A20+f10p -Baf
gmt end show