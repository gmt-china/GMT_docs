#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Python Script to generate inventory file for GMT official documentation
#
# http://pvbookmarks.readthedocs.org/en/master/devel/documentation/doc_generators/sphinx/rest_sphinx/hyperlinks.html
#

import zlib
inventory_header = '''\
# Sphinx inventory version 2
# Project: GMT
# Version: 5.4.5
# The remainder of this file is compressed with zlib.
'''.encode('utf-8')

modules = ['gmt', 'gmt5syntax', 'isogmt', 'gmtwhich',

           'blockmean', 'blockmedian', 'blockmode', 'filter1d', 'fitcircle',
           'gmt2kml', 'gmtconnect', 'gmtconvert', 'gmtdefaults', 'gmtget',
           'gmtinfo', 'gmtlogo', 'gmtmath', 'gmtselect', 'gmtset',
           'gmtsimplify', 'gmtspatial', 'gmtswitch', 'gmtvector',

           'grd2cpt', 'grd2rgb', 'grd2xyz', 'grdblend', 'grdclip',
           'grdcontour', 'grdcut', 'grdedit', 'grdfft', 'grdfilter',
           'grdgradient', 'grdhisteq', 'grdimage', 'grdinfo',
           'grdlandmask', 'grdmask', 'grdmath', 'grdpaste', 'grdproject',
           'grdraster', 'grdconvert', 'gmtregress', 'grdsample',
           'grdtrack', 'grdtrend', 'grdvector', 'grdview', 'grdvolume',

           'greenspline', 'kml2gmt', 'makecpt', 'mapproject', 'nearneighbor',

           'psconvert', 'psbasemap', 'psclip', 'pscoast', 'psternary',
           'pstext', 'psxy', 'project', 'pscontour', 'pshistogram',
           'psimage', 'pslegend', 'psmask', 'psrose', 'psscale',
           'pssolar', 'pswiggle', 'psxyz',

           'sample1d', 'spectrum1d', 'sph2grd', 'sphdistance',
           'sphinterpolate', 'sphtriangulate', 'splitxyz', 'surface',
           'triangulate', 'trend1d', 'trend2d', 'xyz2grd',
           ]

supplements = {
    'gshhg' : ['gshhg'],
    'img'   : ['img2google', 'img2grd'],
    'meca'  : ['pscoupe', 'psmeca', 'pspolar', 'pssac', 'psvelo'],
    'mgd77' : ['mgd77header', 'mgd77info', 'mgd77magref', 'mgd77path',
               'mgd77track', 'mgd77convert', 'mgd77list', 'mgd77manage',
               'mgd77sniffer'],
    'misc'  : ['dimfilter'],
    'potential': ['gmtgravmag3d', 'gpsgridder', 'gravfft', 'grdgravmag3d',
                  'grdredpol', 'grdseamount', 'gmtflexure', 'grdflexure',
                  'talwani2d', 'talwani3d'],
    'segy'  : ['pssegy', 'pssegyz', 'segy2grd'],
    'spotter': ['backtracker', 'gmtpmodeler', 'grdpmodeler', 'grdspotter',
                'originator', 'grdrotater', 'hotspotter', 'rotconverter',
                'rotsmoother'],
    'x2sys' :  ['x2sys_cross', 'x2sys_init', 'x2sys_put', 'x2sys_datalist',
                'x2sys_list', 'x2sys_report', 'x2sys_binlist', 'x2sys_get',
                'x2sys_merge', 'x2sys_solve'],
}

payload_list = []
for item in modules:
    payload_list.append('{0} std:label -1 {0}.html {0}\n'.format(item))

for key, value in supplements.items():
    for item in value:
        payload_list.append('{1} std:label -1 supplements/{0}/{1}.html {1}\n'.format(key, item))

inventory_payload = ''.join(payload_list).encode('utf-8')

# inventory_payload lines spec:
#   name domainname:type priority uri dispname
#
# * `name`     -- fully qualified name
# * `dispname` -- name to display when searching/linking
# * `type`     -- object type, a key in ``self.object_types``
# * `docname`  -- the document where it is to be found
# * `anchor`   -- the anchor name for the object
# * `priority` -- how "important" the object is
#                       (determines placement in search results)
#
#   - 1: default priority (placed before full-text matches)
#   - 0: object is important (placed before default-priority objects)
#   - 2: object is unimportant (placed after full-text matches)
#   - -1: object should not show up in search at all
#

inventory = inventory_header + zlib.compress(inventory_payload)
open('source/gmt.inv', 'wb').write(inventory)
