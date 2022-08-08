#!/bin/bash

set -e -o pipefail

cd /opt/docker

git clone --depth=1  https://github.com/beagle-dev/beagle-lib.git
cd beagle-lib

mkdir build
cd build
# ./configure --disable-sse --disable-march-native --prefix=/usr/local
cmake -DBUILD_OPENCL=OFF -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..

make install
make test

ldconfig # LD_LIBRARY_PATH is also set in the Dockerfile to include /usr/local/lib

# examples/synthetictest/synthetictest
# examples/tinytest/tinytest
