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
../configure --enable-languages=c,c++ --enable-shared --enable-threads=posix --program-suffix=4.8 --without-included-gettext --with-system-zlib --prefix=$(pwd)/gcc
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