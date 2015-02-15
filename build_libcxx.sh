#!/bin/sh
set -e
export CXXFLAGS="-std=c++0x -stdlib=libc++"
echo "Getting sources..."
export LLVM_VERSION=3.5.1
wget http://llvm.org/releases/$LLVM_VERSION/libcxx-$LLVM_VERSION.src.tar.xz
echo "Untarring..."
tar -xf libcxx-$LLVM_VERSION.src.tar.xz
rm libcxx-$LLVM_VERSION.src.tar.xz
cd libcxx-$LLVM_VERSION.src/lib
# Build library
echo "Building..."
bash buildit
cd ..
# Get Clang
echo "Getting Clang..."
wget https://github.com/Viq111/travis-container-packets/releases/download/clang-$LLVM_VERSION/clang.tar.bz2
echo "Untarring..."
tar -xjf clang.tar.bz2
rm clang.tar.bz2
mv clang clang_libcxx
# Copy libcxx to clang
cp lib/libc++.so.1.0 clang_libcxx/lib/
cp -r include/* clang_libcxx/include/c++/v1/
cp clang_libcxx/lib/libc++.so.1.0 clang_libcxx/lib/libc++.so
cp clang_libcxx/lib/libc++.so.1.0 clang_libcxx/lib/libc++.so.1
# Tar library
echo "Build done, tarring..."
tar -jc --file=clang_libcxx.tar.bz2 clang_libcxx/
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./clang_libcxx.tar.bz2 https://transfer.sh/clang_libcxx.tar.bz2
echo "########################################################################"
