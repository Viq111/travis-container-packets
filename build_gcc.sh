#!/bin/sh
set -e
# Get sources
echo "Getting sources..."
wget http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2
echo "Untarring..."
tar -xjf gcc-4.8.2.tar.bz2
rm gcc-4.8.2.tar.bz2
cd gcc-4.8.2/

# Build library
echo "Downloading prerequisites..."
./contrib/download_prerequisites
mkdir build
cd build
echo "Configuring..."
export LIBRARY_PATH=/usr/lib/$(gcc -print-multiarch)
export C_INCLUDE_PATH=/usr/include/$(gcc -print-multiarch)
export CPLUS_INCLUDE_PATH=/usr/include/$(gcc -print-multiarch)
mkdir -p gcc-4.8.2/gcc
../configure --enable-languages=c,c++ --disable-multilib --enable-shared --enable-threads=posix --prefix=$(pwd)/gcc-4.8.2/gcc
echo "Building..."
make -j 4 | awk '{printf "."}'
echo ""
make install
# Tar library
echo "Build done, tarring..."
cd gcc-4.8.2
tar -jc --file=gcc.tar.bz2 gcc
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./gcc.tar.bz2 https://transfer.sh/gcc.tar.bz2
echo "########################################################################"