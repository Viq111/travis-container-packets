#!/bin/sh
set -e
# Get sources
echo "Getting sources..."
wget http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz
echo "Untarring..."
tar -xzf cmake-*.tar.gz
rm cmake-*.tar.gz
cd cmake-*

# Build library
echo "Building..."
./bootstrap
make
# Rearrange folders
make package
mkdir build
mv cmake-*.tar.gz build
cd build
tar -xzf cmake-*.tar.gz
rm cmake-*.tar.gz
mv cmake-* cmake
# Tar library
echo "Build done, tarring..."
tar -jc --file=cmake.tar.bz2 cmake
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./cmake.tar.bz2 https://transfer.sh/cmake.tar.bz2
echo "########################################################################"
# Clean dir 
cd ../..
rm -r cmake-*