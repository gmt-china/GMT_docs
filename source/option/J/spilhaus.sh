gmt begin spilhaus
    gmt grdimage @earth_relief_10m_p -Rd -J+proj=spilhaus+width=10c -I+d -Cgeo
    gmt coast -BWbet -B45g -A10000 -Wthinnest
gmt end show