#!/bin/sh
set -e
# Get sources
echo "Getting sources..."
#wget -O base.tar.bz2 http://www.google.com
echo "Untarring..."
#tar -xjf base.tar.bz2
#rm base.tar.bz2
#cd base

# Build library
echo "Building..."

# Tar library
echo "Build done, tarring..."
tar -jc --file=compiled.tar.bz2 build
echo "Uploading..."
echo "########################################################################"
echo "Build URL:"
curl --upload-file ./compiled.tar.bz2 https://transfer.sh/compiled.tar.bz2
echo "########################################################################"