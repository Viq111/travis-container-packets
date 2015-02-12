#!/bin/sh
set -e
export CXXFLAGS="-std=c++0x -stdlib=libc++"
echo "Getting sources..."
wget http://llvm.org/releases/3.4.2/libcxx-3.4.2.src.tar.gz
echo "Untarring..."
tar -xzf libcxx-3.4.2.src.tar.gz
rm libcxx-3.4.2.src.tar.gz
cd libcxx-3.4.2.src/lib
# Build library
echo "Building..."
bash buildit
cd ..
mkdir libcxx
mkdir libcxx/lib
mkdir libcxx/include/
cp lib/libc++.so.1.0 libcxx/lib/
cp -r include/* libcxx/include/
cp libcxx/lib/libc++.so.1.0 libcxx/lib/libc++.so
cp libcxx/lib/libc++.so.1.0 libcxx/lib/libc++.so.1
# Tar library
echo "Build done, tarring..."
tar -jc --file=libcxx.tar.bz2 libcxx/
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./libcxx.tar.bz2 https://transfer.sh/libcxx.tar.bz2
echo "########################################################################"
