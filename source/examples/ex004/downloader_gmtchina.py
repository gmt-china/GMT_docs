# -*- coding: utf-8 -*
'''
This code is used to download image from google and amap

@date  : 2020-3-13
@author: Zheng Jie
@E-mail: zhengjie9510@qq.com

Modified by GMT-china.org
'''

import sys
import io
import math
import multiprocessing
import time
import urllib.request as ur
from math import floor, pi, log, tan, atan, exp
from threading import Thread

import PIL.Image as pil
import cv2
import numpy as np
from osgeo import gdal, osr


# ------------------Interchange between WGS-84 and Web Mercator-------------------------
# WGS-84 to Web Mercator
def wgs_to_mercator(x, y):
    y = 85.0511287798 if y > 85.0511287798 else y
    y = -85.0511287798 if y < -85.0511287798 else y

    x2 = x * 20037508.34 / 180
    y2 = log(tan((90 + y) * pi / 360)) / (pi / 180)
    y2 = y2 * 20037508.34 / 180
    return x2, y2


# Web Mercator to WGS-84
def mercator_to_wgs(x, y):
    x2 = x / 20037508.34 * 180
    y2 = y / 20037508.34 * 180
    y2 = 180 / pi * (2 * atan(exp(y2 * pi / 180)) - pi / 2)
    return x2, y2


# --------------------------------------------------------------------------------------

# -----------------Interchange between GCJ-02 to WGS-84---------------------------
# All public geographic data in mainland China need to be encrypted with GCJ-02, introducing random bias
# This part of the code is used to remove the bias
def transformLat(x, y):
    ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * math.sqrt(abs(x))
    ret += (20.0 * math.sin(6.0 * x * math.pi) + 20.0 * math.sin(2.0 * x * math.pi)) * 2.0 / 3.0
    ret += (20.0 * math.sin(y * math.pi) + 40.0 * math.sin(y / 3.0 * math.pi)) * 2.0 / 3.0
    ret += (160.0 * math.sin(y / 12.0 * math.pi) + 320 * math.sin(y * math.pi / 30.0)) * 2.0 / 3.0
    return ret


def transformLon(x, y):
    ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * math.sqrt(abs(x))
    ret += (20.0 * math.sin(6.0 * x * math.pi) + 20.0 * math.sin(2.0 * x * math.pi)) * 2.0 / 3.0
    ret += (20.0 * math.sin(x * math.pi) + 40.0 * math.sin(x / 3.0 * math.pi)) * 2.0 / 3.0
    ret += (150.0 * math.sin(x / 12.0 * math.pi) + 300.0 * math.sin(x / 30.0 * math.pi)) * 2.0 / 3.0
    return ret


def delta(lat, lon):
    ''' 
    Krasovsky 1940
    //
    // a = 6378245.0, 1/f = 298.3
    // b = a * (1 - f)
    // ee = (a^2 - b^2) / a^2;
    '''
    a = 6378245.0  # a: Projection factor of satellite ellipsoidal coordinates projected onto a flat map coordinate system
    ee = 0.00669342162296594323  # ee: Eccentricity of ellipsoid
    dLat = transformLat(lon - 105.0, lat - 35.0)
    dLon = transformLon(lon - 105.0, lat - 35.0)
    radLat = lat / 180.0 * math.pi
    magic = math.sin(radLat)
    magic = 1 - ee * magic * magic
    sqrtMagic = math.sqrt(magic)
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * math.pi)
    dLon = (dLon * 180.0) / (a / sqrtMagic * math.cos(radLat) * math.pi)
    return {'lat': dLat, 'lon': dLon}


def outOfChina(lat, lon):
    if (lon < 72.004 or lon > 137.8347):
        return True
    if (lat < 0.8293 or lat > 55.8271):
        return True
    return False


def gcj_to_wgs(gcjLon, gcjLat):
    if outOfChina(gcjLat, gcjLon):
        return (gcjLon, gcjLat)
    d = delta(gcjLat, gcjLon)
    return (gcjLon - d["lon"], gcjLat - d["lat"])


def wgs_to_gcj(wgsLon, wgsLat):
    if outOfChina(wgsLat, wgsLon):
        return wgsLon, wgsLat
    d = delta(wgsLat, wgsLon)
    return wgsLon + d["lon"], wgsLat + d["lat"]


# --------------------------------------------------------------

# ---------------------------------------------------------
# Get tile coordinates in Google Maps based on latitude and longitude of WGS-84
def wgs_to_tile(j, w, z):
    '''
    Get google-style tile cooridinate from geographical coordinate
    j : Longittude
    w : Latitude
    z : zoom
    '''
    isnum = lambda x: isinstance(x, int) or isinstance(x, float)
    if not (isnum(j) and isnum(w)):
        raise TypeError("j and w must be int or float!")

    if not isinstance(z, int) or z < 0 or z > 22:
        raise TypeError("z must be int and between 0 to 22.")

    if j < 0:
        j = 180 + j
    else:
        j += 180
    j /= 360  # make j to (0,1)

    w = 85.0511287798 if w > 85.0511287798 else w
    w = -85.0511287798 if w < -85.0511287798 else w
    w = log(tan((90 + w) * pi / 360)) / (pi / 180)
    w /= 180  # make w to (-1,1)
    w = 1 - (w + 1) / 2  # make w to (0,1) and left top is 0-point

    num = 2 ** z
    x = floor(j * num)
    y = floor(w * num)
    return x, y


def pixls_to_mercator(zb):
    # Get the web Mercator projection coordinates of the four corners of the area according to the four corner coordinates of the tile
    inx, iny = zb["LT"]  # left top
    inx2, iny2 = zb["RB"]  # right bottom
    length = 20037508.3427892
    sum = 2 ** zb["z"]
    LTx = inx / sum * length * 2 - length
    LTy = -(iny / sum * length * 2) + length

    RBx = (inx2 + 1) / sum * length * 2 - length
    RBy = -((iny2 + 1) / sum * length * 2) + length

    # LT=left top,RB=right buttom
    # Returns the projected coordinates of the four corners
    res = {'LT': (LTx, LTy), 'RB': (RBx, RBy),
           'LB': (LTx, RBy), 'RT': (RBx, LTy)}
    return res


def tile_to_pixls(zb):
    # Tile coordinates are converted to pixel coordinates of the four corners
    out = {}
    width = (zb["RT"][0] - zb["LT"][0] + 1) * 256
    height = (zb["LB"][1] - zb["LT"][1] + 1) * 256
    out["LT"] = (0, 0)
    out["RT"] = (width, 0)
    out["LB"] = (0, -height)
    out["RB"] = (width, -height)
    return out


# -----------------------------------------------------------

# ---------------------------------------------------------
class Downloader(Thread):
    # multiple threads downloader
    def __init__(self, index, count, urls, datas):
        # index represents the number of threads
        # count represents the total number of threads
        # urls represents the list of URLs nedd to be downloaded
        # datas represents the list of data need to be returned.
        super().__init__()
        self.urls = urls
        self.datas = datas
        self.index = index
        self.count = count

    def download(self, url):
        HEADERS = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36 Edg/88.0.705.68'}
        header = ur.Request(url, headers=HEADERS)
        err = 0
        while (err < 3):
            try:
                data = ur.urlopen(header).read()
            except:
                err += 1
            else:
                return data
        raise Exception("Bad network link.")

    def run(self):
        for i, url in enumerate(self.urls):
            if i % self.count != self.index:
                continue
            self.datas[i] = self.download(url)


# ---------------------------------------------------------

# ---------------------------------------------------------
def getExtent(x1, y1, x2, y2, z, source="amap"):
    pos1x, pos1y = wgs_to_tile(x1, y1, z)
    pos2x, pos2y = wgs_to_tile(x2, y2, z)
    Xframe = pixls_to_mercator(
        {"LT": (pos1x, pos1y), "RT": (pos2x, pos1y), "LB": (pos1x, pos2y), "RB": (pos2x, pos2y), "z": z})
    for i in ["LT", "LB", "RT", "RB"]:
        Xframe[i] = mercator_to_wgs(*Xframe[i])
    if  source == "google_sat":
        pass
    elif source == "amap" or source == "amap_sat" or source == "google":
        for i in ["LT", "LB", "RT", "RB"]:
            Xframe[i] = gcj_to_wgs(*Xframe[i])
    else:
        raise Exception("Invalid argument: source.")
    return Xframe


def saveTiff(r, g, b, gt, filePath):
    fname_out = filePath
    driver = gdal.GetDriverByName('GTiff')
    # Create a 3-band dataset
    dset_output = driver.Create(fname_out, r.shape[1], r.shape[0], 3, gdal.GDT_Byte)
    dset_output.SetGeoTransform(gt)
    try:
        proj = osr.SpatialReference()
        proj.ImportFromEPSG(4326)
        dset_output.SetSpatialRef(proj)
    except:
        print("Error: Coordinate system setting failed")
    dset_output.GetRasterBand(1).WriteArray(r)
    dset_output.GetRasterBand(2).WriteArray(g)
    dset_output.GetRasterBand(3).WriteArray(b)
    dset_output.FlushCache()
    dset_output = None
    print("Image Saved")


# ---------------------------------------------------------

# ---------------------------------------------------------
MAP_URLS = {
    "google": "https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}",
    "google_sat": "http://mts0.googleapis.com/vt?lyrs={style}&x={x}&y={y}&z={z}",
    "amap": "https://webrd02.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=1&style=8&x={x}&y={y}&z={z}",
    "amap_sat": "https://webst01.is.autonavi.com/appmaptile?style=6&x={x}&y={y}&z={z}"
    }


def get_url(source, x, y, z, style):  #
    if source == 'amap':
        url = MAP_URLS["amap"].format(x=x, y=y, z=z)
    elif source == 'amap_sat':
        url = MAP_URLS["amap_sat"].format(x=x, y=y, z=z)
    elif source == 'google':
        url = MAP_URLS["google"].format(x=x, y=y, z=z)
    elif source == 'google_sat':
        url = MAP_URLS["google_sat"].format(x=x, y=y, z=z, style=style)
    else:
        raise Exception("Unknown Map Source ! ")
    return url


def get_urls(x1, y1, x2, y2, z, source, style):
    pos1x, pos1y = wgs_to_tile(x1, y1, z)
    pos2x, pos2y = wgs_to_tile(x2, y2, z)
    lenx = pos2x - pos1x + 1
    leny = pos2y - pos1y + 1
    print("Total tiles number：{x} X {y}".format(x=lenx, y=leny))
    urls = [get_url(source, i, j, z, style) for j in range(pos1y, pos1y + leny) for i in range(pos1x, pos1x + lenx)]
    return urls


# ---------------------------------------------------------

# ---------------------------------------------------------
def merge_tiles(datas, x1, y1, x2, y2, z):
    pos1x, pos1y = wgs_to_tile(x1, y1, z)
    pos2x, pos2y = wgs_to_tile(x2, y2, z)
    lenx = pos2x - pos1x + 1
    leny = pos2y - pos1y + 1
    outpic = pil.new('RGBA', (lenx * 256, leny * 256))
    for i, data in enumerate(datas):
        picio = io.BytesIO(data)
        small_pic = pil.open(picio)
        y, x = i // lenx, i % lenx
        outpic.paste(small_pic, (x * 256, y * 256))
    print('Tiles merge completed')
    return outpic


def download_tiles(urls, multi=10):
    url_len = len(urls)
    datas = [None] * url_len
    if multi < 1 or multi > 20 or not isinstance(multi, int):
        raise Exception("multi of Downloader shuold be int and between 1 to 20.")
    tasks = [Downloader(i, multi, urls, datas) for i in range(multi)]
    for i in tasks:
        i.start()
    for i in tasks:
        i.join()
    return datas


# ---------------------------------------------------------

# ---------------------------------------------------------
def main(left, top, right, bottom, zoom, filePath, style='s', server="amap"):
    """
    Download images based on spatial extent.

    East longitude is positive and west longitude is negative.
    North latitude is positive, south latitude is negative.

    Parameters
    ----------
    left, top : left-top coordinate, for example (100.361,38.866)
        
    right, bottom : right-bottom coordinate
        
    z : zoom

    filePath : File path for storing results, TIFF format
        
    style : 
        m for map; 
        s for satellite; 
        y for satellite with label; 
        t for terrain; 
        p for terrain with label; 
        h for label;
    
    source : Google or amap
    """
    # ---------------------------------------------------------
    # Get the urls of all tiles in the extent
    urls = get_urls(left, top, right, bottom, zoom, server, style)

    # Group URLs based on the number of CPU cores to achieve roughly equal amounts of tasks
    urls_group = [urls[i:i + math.ceil(len(urls) / multiprocessing.cpu_count())] for i in
                  range(0, len(urls), math.ceil(len(urls) / multiprocessing.cpu_count()))]

    # Each set of URLs corresponds to a process for downloading tile maps
    print('Tiles downloading......')
    pool = multiprocessing.Pool(multiprocessing.cpu_count())
    results = pool.map(download_tiles, urls_group)
    pool.close()
    pool.join()
    result = [x for j in results for x in j]
    print('Tiles download complete')

    # Combine downloaded tile maps into one map
    outpic = merge_tiles(result, left, top, right, bottom, zoom)
    outpic = outpic.convert('RGB')
    r, g, b = cv2.split(np.array(outpic))

    # Get the spatial information of the four corners of the merged map and use it for outputting
    extent = getExtent(left, top, right, bottom, zoom, server)
    gt = (extent['LT'][0], (extent['RB'][0] - extent['LT'][0]) / r.shape[1], 0, extent['LT'][1], 0,
          (extent['RB'][1] - extent['LT'][1]) / r.shape[0])
    saveTiff(r, g, b, gt, filePath)


# ---------------------------------------------------------
if __name__ == '__main__':
    start_time = time.time()

    #main(118.055917, 24.559724, 118.244753, 24.399450, 16, r'google_sat.tif', server="google_sat")
    main(float(sys.argv[1]), float(sys.argv[4]), float(sys.argv[2]), float(sys.argv[3]), int(sys.argv[5]), sys.argv[6], server=sys.argv[7])

    end_time = time.time()
    print('lasted a total of {:.2f} seconds'.format(end_time - start_time))
