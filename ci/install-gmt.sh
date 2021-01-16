#!/usr/bin/env bash
#
# Install GMT on Travis
#

# To return a failure if any commands inside fail
set -e

mkdir -p /tmp/GMT-build/
cd /tmp/GMT-build

# Download files
wget --quiet http://www.soest.hawaii.edu/pwessel/gshhg/gshhg-gmt-${GSHHG_VERSION}.tar.gz -O gshhg-gmt.tar.gz
wget --quiet http://www.soest.hawaii.edu/pwessel/dcw/dcw-gmt-${DCW_VERSION}.tar.gz -O dcw-gmt.tar.gz
wget --quiet https://github.com/GenericMappingTools/gmt/archive/${GMT_VERSION}.tar.gz -O gmt.tar.gz

# Now start to install
tar -xf gmt.tar.gz --strip-components=1
mkdir share/gmt-gshhg && tar -xf gshhg-gmt.tar.gz -C share/gmt-gshhg --strip-components=1
mkdir share/gmt-dcw && tar -xf dcw-gmt.tar.gz -C share/gmt-dcw --strip-components=1
rm gmt.tar.gz gshhg-gmt.tar.gz dcw-gmt.tar.gz

cat > cmake/ConfigUser.cmake << EOF
set (CMAKE_INSTALL_PREFIX "${GMT_INSTALL_PREFIX}")
EOF

mkdir build
cd build
cmake ..
make -j
make -j install
# Remove documentations to keep caches small
rm -r ${GMT_INSTALL_PREFIX}/share/doc

cd ${TRAVIS_BUILD_DIR}

# Turn off exit on failure.
set +e
