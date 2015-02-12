#!/bin/sh
set -e
mkdir clang
cd clang
echo "Getting LLVM..."
svn co http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_351/final llvm -q
echo "Getting Clang..."
cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_351/final clang -q
cd ../..
echo "Getting extras..."
cd llvm/tools/clang/tools
svn co http://llvm.org/svn/llvm-project/clang-tools-extra/tags/RELEASE_351/final extra -q
cd ../../../..
echo "Getting RT..."
cd llvm/projects
svn co http://llvm.org/svn/llvm-project/compiler-rt/tags/RELEASE_351/final compiler-rt -q
cd ../..
echo "Configuring..."
mkdir build
cd build
mkdir binaries
#../llvm/configure --prefix=$(pwd)/binaries
cmake -DCMAKE_INSTALL_PREFIX=$(pwd)/binaries  ../llvm
make -j4
make install
# Tar library
echo "Build done, tarring..."
cd build
tar -jc --file=clang.tar.bz2 binaries
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./clang.tar.bz2 https://transfer.sh/clang.tar.bz2
echo "########################################################################"
cd ..
rm -rf build