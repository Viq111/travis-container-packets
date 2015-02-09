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
echo "#####"
ls -l /usr/include
echo "#####"
ls -l /usr/include/x86_64-linux-gnu/
echo "#####"
ls -l /usr/include/i386-linux-gnu/

echo "Downloading prerequisites..."
./contrib/download_prerequisites
mkdir build
cd build
echo "Configuring..."
export LIBRARY_PATH=/usr/lib/$(gcc -print-multiarch)
export C_INCLUDE_PATH=/usr/include/$(gcc -print-multiarch)
export CPLUS_INCLUDE_PATH=/usr/include/$(gcc -print-multiarch)
../configure --enable-languages=c++ --prefix=$(pwd)/gcc
echo "Building..."
make -j 4
make install
# Tar library
echo "Build done, tarring..."
tar -jc --file=gcc.tar.bz2 gcc
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./gcc.tar.bz2 https://transfer.sh/gcc.tar.bz2
echo "########################################################################"