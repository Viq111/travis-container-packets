#!/bin/sh
set -e
wget http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2
tar -xjf gcc-4.8.2.tar.bz2
cd gcc-4.8.2/
./contrib/download_prerequisites
mkdir build
cd build
../configure --enable-languages=c,c++ --enable-multiarch --enable-shared --enable-threads=posix --program-suffix=4.8 --without-included-gettext --with-system-zlib --prefix=$(pwd)/gcc
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