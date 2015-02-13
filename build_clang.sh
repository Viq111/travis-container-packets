#!/bin/sh
set -e
export LLVM_VERSION=RELEASE_351
mkdir clang
cd clang
echo "> Compiling Clang $LLVM_VERSION ..."
echo "Getting LLVM..."
svn co http://llvm.org/svn/llvm-project/llvm/tags/$LLVM_VERSION/final llvm -q
echo "Getting Clang..."
cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/tags/$LLVM_VERSION/final clang -q
cd ../..
echo "Getting extras..."
cd llvm/tools/clang/tools
svn co http://llvm.org/svn/llvm-project/clang-tools-extra/tags/$LLVM_VERSION/final extra -q
cd ../../../..
echo "Getting RT..."
cd llvm/projects
svn co http://llvm.org/svn/llvm-project/compiler-rt/tags/$LLVM_VERSION/final compiler-rt -q
cd ../..
echo "Configuring..."
mkdir clang
mkdir build
cd build
#../llvm/configure --prefix=$(pwd)/binaries
cmake -DCMAKE_INSTALL_PREFIX=$(readlink -f $(pwd)/../clang)  ../llvm
make -j4
make install
# Tar library
echo "Build done, tarring..."
cd ..
tar -jc --file=clang.tar.bz2 clang/
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./clang.tar.bz2 https://transfer.sh/clang.tar.bz2
echo "########################################################################"
cd ..
rm -rf clang/
