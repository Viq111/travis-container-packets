#!/bin/sh
set -e
cd install_clang
mkdir build
echo "Building..."
./install-clang -j 4 $(pwd)/build
# Tar library
echo "Build done, tarring..."
#tar -jc --file=compiled.tar.bz2 build
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
#curl --upload-file ./compiled.tar.bz2 https://transfer.sh/compiled.tar.bz2
echo "########################################################################"