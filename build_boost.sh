#!/bin/sh
set -e
# Get sources
echo "Getting sources..."
wget http://downloads.sourceforge.net/project/boost/boost/1.57.0/boost_1_57_0.tar.bz2
echo "Untarring..."
tar -xjf boost_*.tar.bz2
rm boost_*.tar.bz2
cd boost_*
# Build library
echo "Building..."
./bootstrap.sh
if [ "$CXX" = "g++" ]; then
  ./b2 -j4 address-model=64 --prefix=build -q install | awk '{printf "."}'
fi
if [ "$CXX" = "clang++" ]; then
  ./b2 toolset=clang cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++" address-model=64 --prefix=build -q install | awk '{printf "."}'
fi
echo ""
mv build ../boost
cd ..
# Tar library
echo "Build done, tarring..."
tar -jc --file=boost.tar.bz2 boost/
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./boost.tar.bz2 https://transfer.sh/boost.tar.bz2
echo "########################################################################"
# Clean dir 
rm -r boos*