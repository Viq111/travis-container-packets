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
# Get Clang
echo "Getting Clang..."
wget https://github.com/Viq111/travis-container-packets/releases/download/clang-3.4.2/clang.tar.bz2
echo "Untarring..."
tar -xjf clang.tar.bz2
rm clang.tar.bz2
mv clang clang+libcxx
# Copy libcxx to clang
cp lib/libc++.so.1.0 clang+libcxx/lib/
cp -r include/* clang+libcxx/include/c++/v1/
cp clang+libcxx/lib/libc++.so.1.0 clang+libcxx/lib/libc++.so
cp clang+libcxx/lib/libc++.so.1.0 clang+libcxx/lib/libc++.so.1
# Tar library
echo "Build done, tarring..."
tar -jc --file=clang+libcxx.tar.bz2 clang+libcxx/
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./clang+libcxx.tar.bz2 https://transfer.sh/clang+libcxx.tar.bz2
echo "########################################################################"
