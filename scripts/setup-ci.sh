#!/usr/bin/env bash
#
# Setup the ~/.gmt directory for CI.
#
# The script makes the following changes to the ~/.gmt directory:
#
# 1. Download the GMT remote datasets used in the docs
# 2. Download the GMT cache files used in the docs
# 3. Download the china-geospatial-data dataset used in docs
# 4. Download plate boundary types data used in docs
# 5. Download Chinese font files for GMT Chinese support
# 6. Create gs fontmap file for GMT Chinese support
# 7. Create font configuration file for GMT Chinese support
# 8. Fix the gmt_cn1.locale file for GMT Chinese support
#

# Create the ~/.gmt directory if not exist
mkdir -p ~/.gmt

# 1. Download the GMT remote datasets used in the docs
gmt which -Ga @earth_relief_30m_g \
            @earth_relief_30m_p \
            @earth_relief_20m_p \
            @earth_relief_20m_g \
            @earth_relief_10m_p \
            @earth_relief_06m_p \
            @earth_relief_05m_p \
            @earth_relief_04m_p \
            @earth_age_06m_p \
            @earth_day_20m_p \
            @earth_day_06m_p \
            @earth_night_20m_p \
            @earth_mask_05m_p \
            @earth_mag4km_20m_p \
            @earth_geoid_20m_p \
            @earth_faa_20m_p
gmt grdcut @earth_relief_01m_p -R118/125/20/26 -G/dev/null

# 2. Download GMT cache files used in the docs
gmt which -Ga @age_chrons_GTS2012_2020.cpt \
            @ternary.txt \
            @mississippi.txt \
            @NY_traffic.txt \
            @Table_5_11.txt \
            @Wessel_GJI_Fig_5.txt \
            @quakes_07.txt \
            @quakes_2018.txt

# 3. Download the china-geospatial-data dataset
git clone --depth 1 https://github.com/gmt-china/china-geospatial-data china-geospatial-data
mv china-geospatial-data/*.gmt ~/.gmt/cache/
rm -rf china-geospatial-data

# 4. Download plate boundary types data used in docs
wget -q https://raw.githubusercontent.com/CovMat/global_tectonics/refs/heads/For_gmt_china_docs/plates%26provinces/gmt/boundaries.gmt
wget -q https://raw.githubusercontent.com/CovMat/global_tectonics/refs/heads/For_gmt_china_docs/plates%26provinces/gmt/plates.gmt
wget -q https://raw.githubusercontent.com/CovMat/global_tectonics/refs/heads/For_gmt_china_docs/plates%26provinces/gmt/global_gprv.gmt
wget -q https://raw.githubusercontent.com/CovMat/global_tectonics/refs/heads/For_gmt_china_docs/plates%26provinces/gmt/oc_boundaries.gmt
mv boundaries.gmt plates.gmt global_gprv.gmt oc_boundaries.gmt ~/.gmt/cache/

# 5. Download Chinese font files for GMT Chinese support
mkdir -p ~/.gmt/winfonts/
git clone --depth 1 https://github.com/ZMAlt/winfonts
mv winfonts/*.ttf winfonts/*.ttc ~/.gmt/winfonts
rm -rf winfonts

# 6. Create gs fontmap file for GMT Chinese support
cat > ~/.gmt/cidfmap << EOF
/STSong-Light <</FileType /TrueType /Path (${HOME}/.gmt/winfonts/simsun.ttc) /SubfontId 0 /CSI [(GB1) 4] >> ;
/STFangsong-Light <</FileType /TrueType /Path (${HOME}/.gmt/winfonts/simfang.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
/STHeiti-Regular <</FileType /TrueType /Path (${HOME}/.gmt/winfonts/simhei.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
/STKaiti-Regular <</FileType /TrueType /Path (${HOME}/.gmt/winfonts/simkai.ttf) /SubfontId 0 /CSI [(GB1) 4] >> ;
EOF

# 7. Create font configuration file for GMT Chinese support
cat > ~/.gmt/PSL_custom_fonts.txt << EOF
STSong-Light--UniGB-UTF8-H  0.700    1
STFangsong-Light--UniGB-UTF8-H  0.700    1
STHeiti-Regular--UniGB-UTF8-H   0.700   1
STKaiti-Regular--UniGB-UTF8-H   0.700   1
STSong-Light--UniGB-UTF8-V  0.700    1
STFangsong-Light--UniGB-UTF8-V  0.700    1
STHeiti-Regular--UniGB-UTF8-V   0.700   1
STKaiti-Regular--UniGB-UTF8-V   0.700   1
EOF

# 8. Fix the gmt_cn1.locale file for GMT Chinese support
mkdir -p ~/.gmt/localization
iconv -f GBK -t UTF-8 $(gmt --show-sharedir)/localization/gmt_cn1.locale > ~/.gmt/localization/gmt_cn1.locale
