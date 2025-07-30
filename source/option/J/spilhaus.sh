gmt begin spilhaus
    gmt grdimage @earth_relief_10m_p -Rd -J+proj=spilhaus+width=15c -I+d -Cgeo
    gmt coast -BWbet -B30g -A10000 -Wthinnest
gmt end show