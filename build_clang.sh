#!/bin/sh
set -e
cd install_clang
mkdir -p build/clang

# Build library
echo "Building..."
./install-clang -j 4 -m $(pwd)/build/clang

# Tar library
echo "Build done, tarring..."
cd build
tar -jc --file=clang.tar.bz2 clang
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./clang.tar.bz2 https://transfer.sh/clang.tar.bz2
echo "########################################################################"
cd ..
rm -rf build