#!/usr/bin/env python
import os

with open("cpt.list") as flst:
    lines = flst.readlines()

for i in range(0, len(lines) - 1, 3):
    cpt_left = os.path.splitext(lines[i])[0]
    cpt_middle = os.path.splitext(lines[i+1])[0]
    cpt_right = os.path.splitext(lines[i+2])[0]
    print('+--------------------------------+--------------------------------+--------------------------------+')
    print('| .. figure:: cpt/{}.* {} | .. figure:: cpt/{}.* {} | .. figure:: cpt/{}.* {} |'.format(cpt_left,
                                                                                                   " " * (11 - len(cpt_left)),
                                                                                                   cpt_middle,
                                                                                                   " " * (11 - len(cpt_middle)),
                                                                                                   cpt_right,
                                                                                                   " " * (11 - len(cpt_right))))
    print('|    :align: center              |    :align: center              |    :align: center              |')
    print('|                                |                                |                                |')
    print('|    {} {} |    {} {} |    {} {} |'.format(cpt_left,
                                                      " " * (26 - len(cpt_left)),
                                                      cpt_middle,
                                                      " " * (26 - len(cpt_middle)),
                                                      cpt_right,
                                                      " " * (26 - len(cpt_right))))
# cpt_left = os.path.splitext(lines[-1])[0]
# print('+--------------------------------+--------------------------------+')
# print('| .. figure:: cpt/{}.* {} | {} |'.format(cpt_left, " " * (11 - len(cpt_left)), " " * 30))
# print('|    :align: center              |                                |')
# print('|                                |                                |')
# print('|    {} {} | {} |'.format(cpt_left, " " * (26 - len(cpt_left)), " " * 30))

print('+--------------------------------+--------------------------------+--------------------------------+')
