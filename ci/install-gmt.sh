#!/bin/bash
# Install GMT on Travis

# To return a failure if any commands inside fail
set -e

# Basic Information
GMT_INSTALL=${HOME}/GMT-${GMT_VERSION}

# download files
if [[ "${GMT_VERSION}" != '6.0.0' ]]; then
    wget --quiet https://github.com/GenericMappingTools/gmt/archive/${GMT_VERSION}.tar.gz -O gmt-${GMT_VERSION}-src.tar.gz
else
    wget --quiet https://github.com/GenericMappingTools/gmt/archive/master.tar.gz -O gmt-${GMT_VERSION}-src.tar.gz
fi
wget --quiet http://www.soest.hawaii.edu/pwessel/gshhg/gshhg-gmt-${GSHHG_VERSION}.tar.gz
wget --quiet http://www.soest.hawaii.edu/pwessel/dcw/dcw-gmt-${DCW_VERSION}.tar.gz

# Now start to install
mkdir gmt-${GMT_VERSION}
tar xf gmt-${GMT_VERSION}-src.tar.gz -C gmt-${GMT_VERSION} --strip-components=1
tar -xf gshhg-gmt-${GSHHG_VERSION}.tar.gz
tar -xf dcw-gmt-${DCW_VERSION}.tar.gz

mv gshhg-gmt-${GSHHG_VERSION} gmt-${GMT_VERSION}/share/gshhg
mv dcw-gmt-${DCW_VERSION} gmt-${GMT_VERSION}/share/dcw-gmt

cd gmt-${GMT_VERSION}

cat > cmake/ConfigUser.cmake << EOF
set (CMAKE_INSTALL_PREFIX "${GMT_INSTALL}")
set (GMT_INSTALL_MODULE_LINKS FALSE)
set (COPY_GSHHG TRUE)
set (COPY_DCW TRUE)
set (GMT_USE_THREADS TRUE)
EOF

mkdir build
cd build
cmake ..
make -j
make -j install
cd ../..

export PATH=${GMT_INSTALL}/bin:${PATH}
# Turn off exit on failure.
set +e
