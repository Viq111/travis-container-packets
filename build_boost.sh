#!/bin/sh
set -e
# Get sources
echo "Getting sources..."
wget http://downloads.sourceforge.net/project/boost/boost/1.57.0/boost_1_57_0.tar.bz2
echo "Untarring..."
tar -xjf boost_*.tar.gz
rm boost_*.tar.gz
cd boost_*
# Build library
echo "Building..."
./bootstrap.sh
./b2 -j4 address-model=64 --with-chrono --with-iostreams --with-thread --with-date_time --prefix=build -q install
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