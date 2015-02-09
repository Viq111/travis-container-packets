#!/bin/sh
set -e
mkdir clang
cd clang
echo "Getting LLVM..."
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm -q
echo "Getting Clang..."
cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/trunk clang -q
cd ../..
echo "Getting extras..."
cd llvm/tools/clang/tools
svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra -q
cd ../../../..
echo "Getting RT..."
cd llvm/projects
svn co http://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt -q
cd ../..
echo "Configuring..."
mkdir build
cd build
mkdir binaries
../llvm/configure --prefix=$(pwd)/binaries
make -j4
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