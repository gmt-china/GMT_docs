#!/usr/bin/env bash

gmt begin velo_ex2
gmt velo -Sw0.4i/1.e7 -W0.75p -Gdarkgray -Elightgray -D2 -Jm2.2i -Ra -Baf -BWeSn << EOF
#lon lat spin(rad/yr) spin_sigma (rad/yr)
241.4806 34.2073 5.65E-08 1.17E-08
241.6024 34.4468 -4.85E-08 1.85E-08
241.0952 34.4079 4.46E-09 3.07E-08
241.2542 34.2581 1.28E-07 1.59E-08
242.0593 34.0773 -6.62E-08 1.74E-08
241.0553 34.5369 -2.38E-07 4.27E-08
241.1993 33.1894 -2.99E-10 7.64E-09
241.1084 34.2565 2.17E-08 3.53E-08
EOF
gmt end show
